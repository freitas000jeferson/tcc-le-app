import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_le_app/components/layouts/dafault_layout.dart';
import 'package:tcc_le_app/components/ui/button.dart';
import 'package:tcc_le_app/components/ui/text.dart';
import 'package:tcc_le_app/components/ui/title.dart';
import 'package:tcc_le_app/core/styles/styles.dart';
import 'package:tcc_le_app/pages/voice/components/audio_recorder.dart';
import 'package:tcc_le_app/pages/voice/components/recording_timer.dart';
import 'package:tcc_le_app/pages/voice/controllers/audio_recorder_controller.dart';

class VoicePage extends StatefulWidget {
  const VoicePage({super.key});

  @override
  State<VoicePage> createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  final controller = Get.put(AudioRecorderController());
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // ⬇️ Remove o controller da memória (opcional
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DafaultLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: CustomSpacing.xs),
            child: CustomTitle("Pronunciation Test", variant: TitleVariant.sm),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  "lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  textAlign: TextAlign.center,
                  fontSize: CustomFonts.lg,
                  fontWeight: CustomFonts.weightBold,
                ),
                const SizedBox(height: CustomSpacing.xs),
                RecordingTimer(),
                const SizedBox(height: CustomSpacing.xs),
                AudioRecorder(),
              ],
            ),
          ),
          Obx(
            () => Container(
              padding: EdgeInsets.symmetric(vertical: CustomSpacing.xs),
              child: CustomButton(
                fullSize: true,
                variant: ButtonVariant.primary,
                padding: CustomSpacing.squishSM,
                onPressed: () {},
                enable: controller.audioFile.value != null,
                child: Text("Verify", style: CustomTextStyles.button),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
