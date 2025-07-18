import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_le_app/components/layouts/dafault_layout.dart';
import 'package:tcc_le_app/components/ui/button.dart';
import 'package:tcc_le_app/components/ui/input.dart';
import 'package:tcc_le_app/components/ui/text.dart';
import 'package:tcc_le_app/components/ui/title.dart';
import 'package:tcc_le_app/core/styles/styles.dart';
import 'package:tcc_le_app/pages/auth/forgot_password/controllers/forgot_password_controller.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});

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
            CustomTitle("Create a new password!", variant: TitleVariant.xs),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: CustomSpacing.sm),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // spacing: CustomSpacing.xxs,
                  children: [
                    // SizedBox(height: Get.height * 0.30),
                    CustomText(
                      "Password",
                      fontWeight: CustomFonts.weightMedium,
                    ),
                    CustomInput(
                      hintText: "Enter new password",
                      icon: Icons.password,
                      onChanged: controller.onNewPasswordChanged,
                      obscure: true,
                      isPassword: true,
                    ),
                    SizedBox(height: CustomSpacing.xxs),
                    CustomText(
                      "Confirm Password",
                      fontWeight: CustomFonts.weightMedium,
                    ),
                    CustomInput(
                      hintText: "Enter password",
                      icon: Icons.password,
                      onChanged: controller.onConfirmPasswordChanged,
                      obscure: true,
                      isPassword: true,
                    ),
                    Obx(
                      () =>
                          controller.validatePasswords().isLeft()
                              ? Container(
                                padding: CustomSpacing.squishXS,
                                margin: EdgeInsets.only(top: CustomSpacing.xxs),
                                decoration: BoxDecoration(
                                  color: CustomColors.neutralLightest,
                                  borderRadius: BorderRadius.circular(
                                    CustomBorders.radiusXS,
                                  ),
                                ),
                                child: Text(
                                  "${(controller.validatePasswords() as Left).value}",
                                  style: CustomTextStyles.error,
                                ),
                              )
                              : Container(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: CustomSpacing.xxs),

            Obx(
              () => CustomButton(
                variant: ButtonVariant.secondary,
                padding: CustomSpacing.squishMD,
                onPressed: () {},
                enable: controller.validatePasswords().isRight(),
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
