import 'dart:async';
import 'dart:io';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorderController extends GetxController {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  RxBool isRecording = false.obs;
  RxBool isPlaying = false.obs;
  Rx<File?> audioFile = Rx<File?>(null);
  Rx<String?> filePath = Rx<String?>(null);

  Rx<Duration> recordDuration = Duration.zero.obs;

  Timer? _recordTimer;
  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
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
    filePath.value = '${dir.path}/audio_gravado.mp4';
  }

  bool fileExists() => audioFile.value != null && audioFile.value!.existsSync();

  Future<void> startRecording() async {
    await _recorder.startRecorder(
      toFile: filePath.value,
      codec: Codec.aacMP4,
      sampleRate: 44100,
      bitRate: 128000,
    );

    audioFile.value = File(filePath.value!);
    isRecording.value = true;

    // iniciar contador
    recordDuration.value = Duration.zero;
    _recordTimer?.cancel();
    _recordTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      recordDuration.value += const Duration(seconds: 1);
    });
  }

  Future<void> stopRecording() async {
    await _recorder.stopRecorder();
    isRecording.value = false;

    _recordTimer?.cancel();
    _recordTimer = null;

    if (audioFile.value != null && await audioFile.value!.exists()) {
      final length = await audioFile.value!.length();
      print('🎤 Gravado: ${audioFile.value!.path}, tamanho: $length bytes');
    }
  }

  Future<void> togglePlayback() async {
    if (audioFile.value == null) return;

    if (isPlaying.value) {
      await _player.stopPlayer();
      isPlaying.value = false;
    } else {
      await _player.startPlayer(
        fromURI: audioFile.value!.path,
        codec: Codec.aacMP4,
        whenFinished: () => isPlaying.value = false,
      );
      isPlaying.value = true;
    }
  }

  @override
  void onClose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    super.onClose();
  }
  //   Future<void> sendAudio() async {
  //     // if (audioFile.value == null) return;

  //     // final formData = FormData.fromMap({
  //     //   'audio': await MultipartFile.fromFile(
  //     //     audioFile.value!.path,
  //     //     filename: 'gravacao.wav',
  //     //   ),
  //     // });

  //     // try {
  //     //   final response = await Dio().post(
  //     //     'https://seu-servidor.com/upload',
  //     //     data: formData,
  //     //     options: Options(headers: {'Content-Type': 'multipart/form-data'}),
  //     //   );
  //     //   Get.snackbar('Sucesso', 'Áudio enviado (${response.statusCode})');
  //     // } catch (e) {
  //     //   Get.snackbar('Erro', 'Falha ao enviar áudio');
  //     // }
  //   }
}
