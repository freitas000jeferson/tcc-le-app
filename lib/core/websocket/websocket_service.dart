import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tcc_le_app/core/constants/api.dart';
import 'package:tcc_le_app/core/http/authorization/bearer_authorization_service.dart';
import 'package:tcc_le_app/core/http/domain/oauth_token.dart';

typedef SocketCallback<T> = void Function(T data);

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  final String _url = API.SOCKET_URL;
  final _reconnectDelay = Duration(seconds: 3);
  late IO.Socket? _socket;
  final BearerAuthorizationService _authorizationService =
      BearerAuthorizationService();

  final Map<String, List<SocketCallback>> _listeners = {};

  bool _connected = false;

  factory WebSocketService() {
    return _instance;
  }
  WebSocketService._internal();

  Future<bool> connect() async {
    try {
      final completer = Completer<bool>();

      if (_connected) return true;

      var response = await _authorizationService.getAccessToken();
      if (response.isLeft()) return false;

      OAuthToken token = (response as Right).value;
      _socket = IO.io(
        _url,
        IO.OptionBuilder()
            .setTransports(['websocket']) // usar apenas websocket
            .disableAutoConnect()
            .setExtraHeaders({
              'Authorization': 'Bearer ${token.accessToken}',
            }) // header auth
            .build(),
      );

      _socket!.onConnect((_) {
        print('🟢 Conectado ao socket.io');
        _connected = true;
        completer.complete(true);
        // if (onConnect != null) {
        //   onConnect!();
        // }
        _listeners.forEach((event, callbacks) {
          _socket!.on(event, (data) {
            print('🟢 [$event]: $data');
            for (var cb in callbacks) {
              cb(data);
            }
          });
        });
      });
      _socket!.onDisconnect((_) {
        print('🔴 Desconectado do socket.io');
        _connected = false;
      });

      _socket!.onConnectError((data) {
        print('🔴 Erro na conexão: $data');
      });

      _socket!.onError((data) {
        print('🔴 Erro: $data');
      });

      _socket!.connect();

      return completer.future;
    } catch (e) {
      return false;
    }
  }

  void on(String event, SocketCallback callback) {
    _listeners.putIfAbsent(event, () => []).add(callback);

    _socket!.on(event, callback);
    print('🟢 [$event]: conectado $_connected');
  }

  void off(String event, SocketCallback callback) {
    _listeners[event]?.remove(callback);

    _socket!.off(event, callback);
  }

  void disconnect() {
    _socket?.disconnect();
  }

  void emit(String event, dynamic data) {
    _socket?.emit(event, data);
  }

  void dispose() {
    if (_connected) {
      _socket?.dispose();
    }
    _listeners.clear();
    _connected = false;
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
