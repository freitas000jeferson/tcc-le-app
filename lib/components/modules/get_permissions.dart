import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class GetPermissions {
  static Future<void> solicitarPermissaoMicrofone(BuildContext context) async {
    var status = await Permission.microphone.status;
    String title =
        'Para gravar áudio, é necessário permitir o acesso ao microfone nas configurações do sistema.';
    if (status.isGranted) return;

    if (status.isDenied || status.isRestricted) {
      // Solicita a permissão
      status = await Permission.microphone.request();

      if (status.isPermanentlyDenied) {
        _mostrarDialogoConfiguracoes(context, title);
      }
    }

    if (status.isPermanentlyDenied) {
      _mostrarDialogoConfiguracoes(context, title);
    }
  }

  static Future<void> solicitarPermissaoStorage(BuildContext context) async {
    var status = await Permission.storage.status;
    String title =
        'Para gravar áudio, é necessário permitir o acesso ao microfone nas configurações do sistema.';

    if (status.isGranted) return;

    if (status.isDenied || status.isRestricted) {
      // Solicita a permissão
      status = await Permission.storage.request();

      if (status.isPermanentlyDenied) {
        _mostrarDialogoConfiguracoes(context, title);
      }
    }

    if (status.isPermanentlyDenied) {
      _mostrarDialogoConfiguracoes(context, title);
    }
    return;
  }

  static void _mostrarDialogoConfiguracoes(BuildContext context, String title) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Permissão necessária'),
            content: Text(title),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await openAppSettings(); // <- Abre as configurações
                },
                child: const Text('Abrir configurações'),
              ),
            ],
          ),
    );
  }
}
