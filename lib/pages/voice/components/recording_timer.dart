import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tcc_le_app/components/ui/text.dart';
import 'package:tcc_le_app/core/styles/styles.dart';
import 'package:tcc_le_app/pages/voice/controllers/audio_recorder_controller.dart';

class RecordingTimer extends StatelessWidget {
  const RecordingTimer({super.key});

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AudioRecorderController>();
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (controller.isRecording.value) ...[
            SpinKitDoubleBounce(size: 24, color: CustomColors.secondary),
            const SizedBox(width: CustomSpacing.xxs),
          ],
          CustomText(
            controller.isRecording.value || controller.fileExists()
                ? ' ${_formatDuration(controller.recordDuration.value)}'
                : '00:00',
          ),
        ],
      ),
    );
  }
}
