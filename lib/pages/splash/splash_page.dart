import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tcc_le_app/components/layouts/dafault_layout.dart';
import 'package:tcc_le_app/components/modules/get_permissions.dart';
import 'package:tcc_le_app/components/ui/text.dart';
import 'package:tcc_le_app/core/routes/route_paths.dart';
import 'package:tcc_le_app/core/styles/colors.dart';
import 'package:tcc_le_app/core/styles/fonts.dart';
import 'package:tcc_le_app/pages/auth/login/controllers/auth_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthController _controller = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    GetPermissions.solicitarPermissaoMicrofone(context);
    GetPermissions.solicitarPermissaoStorage(context);
    nextScreen();
  }

  Future nextScreen() async {
    var duration = Duration(milliseconds: 5750);

    String redirect = RoutePaths.LOGIN_PAGE;
    final hasAuthenticated = await _controller.hasAuthenticated();
    if (hasAuthenticated) {
      redirect = RoutePaths.MAIN_TAB_PAGE;
    }
    return Timer(duration, () {
      Get.offAndToNamed(redirect);
      return;

      // if (storage.hasData("user")) {
      //   Get.offAndToNamed(RouteNames.CHAT_PAGE);
      //   return;
      // }
      // Get.offAndToNamed(RouteNames.TUTORIAL_PAGE);
      // Get.offAndToNamed(RoutePaths.LOGIN_PAGE);
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
