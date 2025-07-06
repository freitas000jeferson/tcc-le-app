import 'package:flutter/material.dart';
import 'package:tcc_le_app/components/layouts/dafault_layout.dart';
import 'package:tcc_le_app/components/ui/button.dart';
import 'package:tcc_le_app/components/ui/input.dart';
import 'package:tcc_le_app/components/ui/text.dart';
import 'package:tcc_le_app/components/ui/title.dart';
import 'package:tcc_le_app/core/styles/styles.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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
                  // spacing: CustomSpacing.xxs,
                  children: [
                    // SizedBox(height: Get.height * 0.30),
                    CustomText("Email", fontWeight: CustomFonts.weightMedium),
                    CustomInput(
                      hintText: "Enter you e-mail",
                      icon: Icons.person,
                    ),
                    SizedBox(height: CustomSpacing.xxs),
                  ],
                ),
              ),
            ),
            SizedBox(height: CustomSpacing.xxs),

            CustomButton(
              variant: ButtonVariant.secondary,
              padding: CustomSpacing.squishMD,
              onPressed: () {},
              child: Text("Continue", style: CustomTextStyles.button),
            ),

            SizedBox(height: CustomSpacing.xs),
          ],
        ),
      ),
    );
  }
}
