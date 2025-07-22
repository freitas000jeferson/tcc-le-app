import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_le_app/components/layouts/dafault_layout.dart';
import 'package:tcc_le_app/components/ui/button.dart';
import 'package:tcc_le_app/components/ui/input.dart';
import 'package:tcc_le_app/components/ui/text.dart';
import 'package:tcc_le_app/components/ui/title.dart';
import 'package:tcc_le_app/core/routes/route_paths.dart';
import 'package:tcc_le_app/core/styles/styles.dart';
import 'package:tcc_le_app/core/utils/validators.dart';
import 'package:tcc_le_app/pages/auth/forgot_password/controllers/forgot_password_controller.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final ForgotPasswordController controller =
      Get.isRegistered<ForgotPasswordController>()
          ? Get.find()
          : Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DafaultLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTitle(
              "Forgot Password",
              color: CustomColors.primary,
              fontWeight: FontWeight.w800,
            ),
            CustomTitle(
              "Fill in with the email registered in the app!",
              variant: TitleVariant.xs,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: CustomSpacing.sm),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomText("Email", fontWeight: CustomFonts.weightMedium),
                    CustomInput(
                      hintText: "Enter you e-mail",
                      icon: Icons.person,
                      onChanged: controller.onEmailChanged,
                    ),
                    SizedBox(height: CustomSpacing.xxs),
                  ],
                ),
              ),
            ),
            SizedBox(height: CustomSpacing.xxs),

            Obx(
              () => CustomButton(
                variant: ButtonVariant.secondary,
                padding: CustomSpacing.squishMD,
                onPressed: () {
                  Get.toNamed(RoutePaths.CODE_VALIDATION_PAGE);
                },
                enable: Validators.isValidEmail(controller.email.value),
                child: Text("Continue", style: CustomTextStyles.button),
              ),
            ),

            SizedBox(height: CustomSpacing.xs),
          ],
        ),
      ),
    );
  }
}
