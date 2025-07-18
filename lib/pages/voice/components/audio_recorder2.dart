import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tcc_le_app/pages/voice/controllers/audio_recorder_controller.dart';

class AudioRecorder2 extends StatefulWidget {
  const AudioRecorder2({super.key});
  @override
  _AudioRecorder2State createState() => _AudioRecorder2State();
}

class _AudioRecorder2State extends State<AudioRecorder2> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  final controller = Get.find<AudioRecorderController>();

  bool isRecorderReady = false;
  bool isRecording = false;
  bool isPlaying = false;
  String? filePath;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // Pedir permissões
    await Permission.microphone.request();
    await Permission.storage.request();

    if (!_recorder.isRecording) {
      await _recorder.openRecorder();
      print('✅ Recorder aberto');
    }
    if (!_player.isOpen()) {
      _player.openPlayer();
      print('✅ Player aberto');
    }
    final dir = await getTemporaryDirectory();
    filePath = '${dir.path}/audio_gravado.mp4';

    setState(() {
      isRecorderReady = true;
    });
  }

  Future<void> startRecording() async {
    if (!isRecorderReady) return;
    await _recorder.startRecorder(
      toFile: filePath,
      codec: Codec.aacMP4,
      sampleRate: 44100,
      numChannels: 2,
      bitRate: 128000,
    );
    setState(() {
      isRecording = true;
    });
  }

  Future<void> stopRecording() async {
    await _recorder.stopRecorder();
    setState(() {
      isRecording = false;
    });

    if (filePath != null) {
      final file = File(filePath!);
      if (await file.exists()) {
        final length = await file.length();
        print('📁Arquivo salvo em $filePath, tamanho: $length bytes');
        controller.audioFile.value = file;
        controller.filePath.value = filePath;
      } else {
        print('❌ Arquivo não encontrado em $filePath');
      }
    }
  }

  Future<void> play() async {
    if (filePath == null) return;
    if (isPlaying) {
      await _player.stopPlayer();
      setState(() {
        isPlaying = false;
      });
    } else {
      await _player.startPlayer(
        fromURI: filePath,
        codec: Codec.aacMP4,
        whenFinished: () {
          setState(() {
            isPlaying = false;
          });
        },
      );
      setState(() {
        isPlaying = true;
      });
    }
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: isRecording ? stopRecording : startRecording,
            child: Text(isRecording ? 'Parar Gravação' : 'Gravar'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: play,
            child: Text(isPlaying ? 'Parar' : 'Ouvir'),
          ),
        ],
      ),
    );
  }
}
