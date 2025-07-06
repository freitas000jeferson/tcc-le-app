import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_le_app/components/layouts/dafault_layout.dart';
import 'package:tcc_le_app/components/ui/button.dart';
import 'package:tcc_le_app/components/ui/input.dart';
import 'package:tcc_le_app/components/ui/text.dart';
import 'package:tcc_le_app/components/ui/title.dart';
import 'package:tcc_le_app/core/routes/route_paths.dart';
import 'package:tcc_le_app/core/styles/styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                    ),
                    SizedBox(height: CustomSpacing.xxs),

                    CustomText("Email", fontWeight: CustomFonts.weightMedium),
                    CustomInput(hintText: "Enter you e-mail", icon: Icons.mail),
                    SizedBox(height: CustomSpacing.xxs),

                    CustomText(
                      "Password",
                      fontWeight: CustomFonts.weightMedium,
                    ),
                    CustomInput(
                      hintText: "Enter you password",
                      icon: Icons.lock_rounded,
                      isPassword: true,
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
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: CustomSpacing.xxs),

            CustomButton(
              variant: ButtonVariant.secondary,

              onPressed: () {},
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
