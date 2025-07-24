import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tcc_le_app/core/constants/api.dart';
import 'package:tcc_le_app/core/domain/message_dto_response.dart';
import 'package:tcc_le_app/core/domain/send_message_dto.dart';
import 'package:tcc_le_app/core/http/authorization/bearer_authorization_service.dart';
import 'package:tcc_le_app/core/http/domain/oauth_token.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketService {
  late IOWebSocketChannel? _channel;
  final BearerAuthorizationService _authorizationService;
  final String _url = API.SOCKET_URL;
  StreamSubscription? _subscription;
  final _reconnectDelay = Duration(seconds: 3);

  Function(List<MessageDtoResponse>)? onMessage;

  WebSocketService() : _authorizationService = BearerAuthorizationService();

  Future connect() async {
    var response = await _authorizationService.getAccessToken();
    if (response.isLeft()) return;
    try {
      OAuthToken token = (response as Right).value;
      final socket = await WebSocket.connect(
        _url,
        headers: {'Authorization': 'Bearer ${token.accessToken}'},
      );

      _channel = IOWebSocketChannel(socket);
      _subscription = _channel!.stream.listen(
        (data) {
          final json = jsonDecode(data);
          if (json['channel'] == 'receive-message') {
            List<MessageDtoResponse> message;
            if (json['data'] is List) {
              message =
                  (json['data'] as List)
                      .map((item) => MessageDtoResponse.fromJson(item))
                      .toList();
            } else {
              message = [MessageDtoResponse.fromJson(json['data'])];
            }
            onMessage?.call(message);
          }
        },
        onDone: () async {
          print('🔸Conexão encerrada pelo servidor.');
          await _handleReconnection();
        },
        onError: (error) async {
          print('🔸Erro WebSocket: $error');
          await _handleReconnection();
        },
      );
    } catch (e) {
      print('🔸Erro ao conectar WebSocket: $e');
      await _handleReconnection();
    }
  }

  Future<void> _handleReconnection() async {
    _subscription?.cancel();
    _channel?.sink.close();

    var response = await _authorizationService.refreshAccessToken();
    if (response.isRight()) {
      print('Token renovado, reconectando...');
      await Future.delayed(_reconnectDelay);
      await connect();
    } else {
      print('Falha ao renovar token. Usuário será desconectado.');
    }
  }

  Stream<MessageDtoResponse> get messages => _channel!.stream
      .map((data) => jsonDecode(data))
      .where((json) => json['channel'] == 'receive-message')
      .map((json) => MessageDtoResponse.fromJson(json['data']));

  void sendMessage(SendMessageDto message) {
    final payload = {"channel": "send-message", "data": message.toJson()};
    _channel!.sink.add(jsonEncode(payload));
  }

  void disconnect() {
    _subscription?.cancel();
    _channel?.sink.close();
  }
}
