import 'package:flutter/material.dart';
import 'package:tcc_le_app/components/layouts/dafault_layout.dart';

class VoicePage extends StatefulWidget {
  const VoicePage({super.key});

  @override
  State<VoicePage> createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  @override
  Widget build(BuildContext context) {
    return DafaultLayout(child: Center(child: Text("Voice")));
  }
}
