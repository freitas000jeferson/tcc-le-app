import 'package:flutter/material.dart';
import 'package:tcc_le_app/core/styles/spaces.dart';

class DafaultLayout extends StatelessWidget {
  final Widget child;

  const DafaultLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: CustomSpacing.xs),
        child: child,
      ),
    );
  }
}
