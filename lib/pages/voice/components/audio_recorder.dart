import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_le_app/components/ui/button.dart';
import 'package:tcc_le_app/components/ui/icon_button.dart';
import 'package:tcc_le_app/core/styles/styles.dart';
import 'package:tcc_le_app/pages/voice/controllers/audio_recorder_controller.dart';

class AudioRecorder extends StatelessWidget {
  AudioRecorder({super.key});
  final controller = Get.find<AudioRecorderController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconButton(
              onPressed:
                  controller.isRecording.value
                      ? controller.stopRecording
                      : controller.startRecording,
              variant: ButtonVariant.secondary,
              padding: EdgeInsets.all(CustomSpacing.xs),
              child: Icon(
                controller.isRecording.value ? Icons.stop : Icons.mic,
                size: CustomFonts.xxl,
              ),
            ),
            const SizedBox(width: CustomSpacing.xs),
            CustomIconButton(
              onPressed:
                  controller.audioFile.value == null
                      ? null
                      : controller.togglePlayback,
              variant: ButtonVariant.primary,
              padding: EdgeInsets.all(CustomSpacing.xs),
              child: Icon(
                controller.isRecording.value ? Icons.pause : Icons.play_arrow,
                size: CustomFonts.xxl,
              ),
            ),
            // ElevatedButton(
            //   onPressed:
            //       controller.isRecording.value
            //           ? controller.stopRecording
            //           : controller.startRecording,
            //   child: Text(
            //     controller.isRecording.value
            //         ? "Parar Gravação"
            //         : "Iniciar Gravação",
            //   ),
            // ),
            // ElevatedButton(
            //   onPressed:
            //       controller.audioFile.value == null
            //           ? null
            //           : controller.togglePlayback,
            //   child: Text(
            //     controller.isPlaying.value ? "Parar" : "Ouvir Gravação",
            //   ),
            // ),
            // const SizedBox(height: 20), // componente separado
          ],
        ),
      ),
    );
  }
}
