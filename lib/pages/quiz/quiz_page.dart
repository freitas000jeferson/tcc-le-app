import 'package:flutter/material.dart';
import 'package:tcc_le_app/components/layouts/dafault_layout.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return DafaultLayout(child: Center(child: Text("Quiz")));
  }
}
