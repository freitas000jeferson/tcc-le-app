import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:tcc_le_app/core/constants/api.dart';
import 'package:tcc_le_app/core/domain/message_dto_response.dart';
import 'package:tcc_le_app/core/domain/send_message_dto.dart';
import 'package:tcc_le_app/core/http/authorization/bearer_authorization_service.dart';
import 'package:tcc_le_app/core/http/domain/oauth_token.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketService {
  late IOWebSocketChannel _channel;
  final BearerAuthorizationService _authorizationService;
  final String _url = API.SOCKET_URL;
  StreamSubscription? _subscription;
  final _reconnectDelay = Duration(seconds: 3);

  Function(MessageDtoResponse)? onMessage;
  WebSocketService() : _authorizationService = BearerAuthorizationService();

  Future connect() async {
    OAuthToken? token = await _authorizationService.getAccessToken();
    if (token == null) return;
    try {
      final socket = await WebSocket.connect(
        _url,
        headers: {'Authorization': 'Bearer ${token.accessToken}'},
      );

      _channel = IOWebSocketChannel(socket);
      _subscription = _channel.stream.listen(
        (data) {
          final json = jsonDecode(data);
          if (json['channel'] == 'receive-message') {
            final message = MessageDtoResponse.fromJson(json['data']);
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

    OAuthToken? token = await _authorizationService.refreshAccessToken();
    if (token != null && token.accessToken != null) {
      print('Token renovado, reconectando...');
      await Future.delayed(_reconnectDelay);
      await connect();
    } else {
      print('Falha ao renovar token. Usuário será desconectado.');
    }
  }

  Stream<MessageDtoResponse> get messages => _channel.stream
      .map((data) => jsonDecode(data))
      .where((json) => json['channel'] == 'receive-message')
      .map((json) => MessageDtoResponse.fromJson(json['data']));

  void sendMessage(SendMessageDto message) {
    final payload = {"channel": "send-message", "data": message.toJson()};
    _channel.sink.add(jsonEncode(payload));
  }

  void disconnect() {
    _subscription?.cancel();
    _channel.sink.close();
  }
}
