import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcc_le_app/components/layouts/dafault_layout.dart';
import 'package:tcc_le_app/components/ui/text.dart';
import 'package:tcc_le_app/core/routes/route_paths.dart';
import 'package:tcc_le_app/core/styles/colors.dart';
import 'package:tcc_le_app/core/styles/fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final GetStorage storage = GetStorage("user");
  @override
  void initState() {
    super.initState();
    nextScreen();
  }

  Timer nextScreen() {
    var duration = Duration(milliseconds: 5750);
    return Timer(duration, () {
      // if (storage.hasData("user")) {
      //   Get.offAndToNamed(RouteNames.CHAT_PAGE);
      //   return;
      // }
      // Get.offAndToNamed(RouteNames.TUTORIAL_PAGE);
      Get.offAndToNamed(RoutePaths.LOGIN_PAGE);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primary,
      body: DafaultLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomText(
              "BoraTalk",
              family: FontFamily.logo,
              fontSize: CustomFonts.logoSize,
              fontWeight: CustomFonts.weightMedium,
              color: CustomColors.neutralLightest,
              textAlign: TextAlign.center,
            ),
            CustomText(
              "Chatbot to Learn English",
              fontSize: CustomFonts.sm,
              fontWeight: CustomFonts.weightRegular,
              color: CustomColors.neutralLightest,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            SpinKitFoldingCube(size: 42, color: CustomColors.neutralLightest),
          ],
        ),
      ),
    );
  }
}
