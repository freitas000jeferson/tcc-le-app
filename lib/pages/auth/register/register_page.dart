import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_le_app/components/layouts/dafault_layout.dart';
import 'package:tcc_le_app/components/ui/button.dart';
import 'package:tcc_le_app/components/ui/feedback.dart';
import 'package:tcc_le_app/components/ui/input.dart';
import 'package:tcc_le_app/components/ui/text.dart';
import 'package:tcc_le_app/components/ui/title.dart';
import 'package:tcc_le_app/core/routes/route_paths.dart';
import 'package:tcc_le_app/core/styles/styles.dart';
import 'package:tcc_le_app/pages/auth/register/controllers/register_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final RegisterController _controller =
      Get.isRegistered<RegisterController>()
          ? Get.find()
          : Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DafaultLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: CustomSpacing.md),
            CustomTitle(
              "Create Account",
              color: CustomColors.primary,
              fontWeight: FontWeight.w800,
            ),
            CustomTitle(
              "Please, Registration with email and sign up to continue using our app.",
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
                    CustomText("Name", fontWeight: CustomFonts.weightMedium),
                    CustomInput(
                      hintText: "Enter you user name",
                      icon: Icons.person,
                      onChanged: _controller.onUsernameChanged,
                    ),
                    SizedBox(height: CustomSpacing.xxs),

                    CustomText("Email", fontWeight: CustomFonts.weightMedium),
                    CustomInput(
                      hintText: "Enter you e-mail",
                      icon: Icons.mail,
                      onChanged: _controller.onEmailChanged,
                    ),
                    SizedBox(height: CustomSpacing.xxs),

                    CustomText(
                      "Password",
                      fontWeight: CustomFonts.weightMedium,
                    ),
                    CustomInput(
                      hintText: "Enter you password",
                      icon: Icons.lock_rounded,
                      isPassword: true,
                      obscure: true,
                      onChanged: _controller.onPasswordChanged,
                    ),
                    SizedBox(height: CustomSpacing.xxs),

                    CustomText(
                      "Confirm Password",
                      fontWeight: CustomFonts.weightMedium,
                    ),
                    CustomInput(
                      hintText: "Confirm password",
                      icon: Icons.lock_rounded,
                      isPassword: true,
                      obscure: true,
                      onChanged: _controller.onConfirmPasswordChanged,
                    ),
                    SizedBox(height: CustomSpacing.xxs),
                    Obx(
                      () => CustomFeedback(
                        condition: _controller.isFailure(),
                        message: _controller.registerStatus.value.error ?? "",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: CustomSpacing.xxs),

            CustomButton(
              variant: ButtonVariant.secondary,

              onPressed: () async {
                FocusScope.of(context).unfocus();
                var response = await _controller.register();
                if (response) {
                  Get.offAndToNamed(RoutePaths.LOGIN_PAGE);
                }
              },
              enable: _controller.allInputsAreValid(),
              isLoading: _controller.registerStatus.value.hasLoading(),
              child: Text("Sign Up", style: CustomTextStyles.button),
            ),
            SizedBox(height: CustomSpacing.xxs),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText("You already have an account?"),
                TextButton(
                  onPressed: () {
                    Get.offAndToNamed(RoutePaths.LOGIN_PAGE);
                  },
                  child: Text("Login!", style: CustomTextStyles.highlight),
                ),
              ],
            ),
            SizedBox(height: CustomSpacing.xs),
          ],
        ),
      ),
    );
  }
}
