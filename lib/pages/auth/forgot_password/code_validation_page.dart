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

class CodeValidationPage extends StatelessWidget {
  CodeValidationPage({super.key});
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
              "We sent a verification code to your email!",
              variant: TitleVariant.xs,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: CustomSpacing.sm),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // spacing: CustomSpacing.xxs,
                  children: [
                    // SizedBox(height: Get.height * 0.30),
                    CustomText("Code", fontWeight: CustomFonts.weightMedium),
                    CustomInput(
                      hintText: "Enter code validation",
                      icon: Icons.onetwothree_outlined,
                      onChanged: controller.onCodeChanged,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
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
                  Get.toNamed(RoutePaths.RESET_PASSWORD_PAGE);
                },
                enable: Validators.isValidCode(controller.code.value),
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
