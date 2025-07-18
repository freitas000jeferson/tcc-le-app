import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class GetPermissions {
  static Future<void> solicitarPermissaoMicrofone(BuildContext context) async {
    var status = await Permission.microphone.status;

    if (status.isGranted) return;

    if (status.isDenied || status.isRestricted) {
      // Solicita a permissão
      status = await Permission.microphone.request();

      if (status.isPermanentlyDenied) {
        _mostrarDialogoConfiguracoes(context);
      }
    }

    if (status.isPermanentlyDenied) {
      _mostrarDialogoConfiguracoes(context);
    }
  }

  static void _mostrarDialogoConfiguracoes(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Permissão necessária'),
            content: const Text(
              'Para gravar áudio, é necessário permitir o acesso ao microfone nas configurações do sistema.',
            ),
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
