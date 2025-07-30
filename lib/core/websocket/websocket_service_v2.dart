import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tcc_le_app/core/constants/api.dart';
import 'package:tcc_le_app/core/database/tables/message.dart';
import 'package:tcc_le_app/core/domain/send_message_dto.dart';
import 'package:tcc_le_app/core/http/authorization/bearer_authorization_service.dart';
import 'package:tcc_le_app/core/http/domain/oauth_token.dart';

class WebSocketServiceV2 {
  final String _url = API.SOCKET_URL;
  final _reconnectDelay = Duration(seconds: 3);
  IO.Socket? _socket;

  final BearerAuthorizationService _authorizationService;

  Function(List<Message>)? onMessage;
  late Function? onConnect;

  WebSocketServiceV2({required this.onMessage, this.onConnect})
    : _authorizationService = BearerAuthorizationService();

  Future<bool> connect() async {
    try {
      var response = await _authorizationService.getAccessToken();
      if (response.isLeft()) return false;

      OAuthToken token = (response as Right).value;
      _socket = IO.io(
        _url,
        IO.OptionBuilder()
            .setTransports(['websocket']) // usar apenas websocket
            .setExtraHeaders({
              'Authorization': 'Bearer ${token.accessToken}',
            }) // header auth
            .build(),
      );

      _socket!.onConnect((_) {
        print('🟢 Conectado ao socket.io');
        if (onConnect != null) {
          onConnect!();
        }
      });

      _socket!.on('receive-message', (dynamic data) {
        print('🟢 Mensagem recebida: $data');
        //  final json = JsonDecoder(data);

        List<Message> message;
        if (data is List) {
          message =
              (data as List).map((item) => Message.fromChatbot(item)).toList();
        } else {
          message = [Message.fromJson(data)];
        }
        onMessage?.call(message);
        // Aqui você pode fazer o parsing do JSON para seus modelos
      });

      _socket!.onDisconnect((_) {
        print('🔴 Desconectado do socket.io');
      });

      _socket!.onConnectError((data) {
        print('🔴 Erro na conexão: $data');
      });

      _socket!.onError((data) {
        print('🔴 Erro: $data');
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future sendMessage(SendMessageDto message) async {
    _socket?.emit('send-message', message.toJson());
  }

  void disconnect() {
    _socket?.disconnect();
  }

  Future<void> _handleReconnection() async {
    _socket?.disconnect();

    var response = await _authorizationService.refreshAccessToken();
    if (response.isRight()) {
      print('Token renovado, reconectando...');
      await Future.delayed(_reconnectDelay);
      await connect();
    } else {
      print('Falha ao renovar token. Usuário será desconectado.');
    }
  }
}
