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
import 'package:tcc_le_app/core/utils/generic_state.dart';
import 'package:tcc_le_app/core/utils/validators.dart';
import 'package:tcc_le_app/pages/auth/login/controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController _controller = Get.find<AuthController>();

  final size = (Get.width - 136) / 8;
  String email = "";
  String password = "";

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
              "Welcome",
              color: CustomColors.primary,
              fontWeight: FontWeight.w800,
            ),
            CustomTitle("Sign in to continue!", variant: TitleVariant.xs),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: CustomSpacing.sm),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // spacing: CustomSpacing.xxs,
                  children: [
                    // SizedBox(height: Get.height * 0.30),
                    CustomText("Email", fontWeight: CustomFonts.weightMedium),
                    CustomInput(
                      hintText: "Enter you e-mail",
                      icon: Icons.person,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SizedBox(height: CustomSpacing.xxs),

                    CustomText(
                      "Password",
                      fontWeight: CustomFonts.weightMedium,
                    ),
                    CustomInput(
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      hintText: "Enter you password",
                      icon: Icons.lock_rounded,
                      isPassword: true,
                      obscure: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.toNamed(RoutePaths.FORGOT_PASSWORD_PAGE);
                          },
                          child: Text(
                            "Forgot password?",
                            style: CustomTextStyles.body,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: CustomSpacing.xs),
                    Obx(
                      () => CustomFeedback(
                        condition:
                            _controller.loginStatus.value.status ==
                            RequestStatus.failure,
                        message: _controller.loginStatus.value.error ?? "",
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
                bool login = await _controller.login(
                  username: email,
                  password: password,
                );
                if (login) {
                  Get.offAndToNamed(RoutePaths.MAIN_TAB_PAGE);
                }
              },
              enable:
                  email != "" &&
                  password != "" &&
                  Validators.isValidEmail(email),
              isLoading: _controller.loginStatus.value.hasLoading(),
              child: Text("Sign In", style: CustomTextStyles.button),
            ),
            SizedBox(height: CustomSpacing.xxs),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Get.toNamed(RoutePaths.REGISTER_PAGE);
                  },
                  child: Text("Sing Up!", style: CustomTextStyles.highlight),
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
