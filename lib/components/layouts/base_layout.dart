import 'package:flutter/material.dart';
import 'package:tcc_le_app/core/styles/colors.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;

  const BaseLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: SafeArea(child: child),
    );
  }
}
