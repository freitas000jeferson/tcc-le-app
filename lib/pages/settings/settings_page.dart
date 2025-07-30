import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_le_app/components/layouts/dafault_layout.dart';
import 'package:tcc_le_app/core/routes/route_paths.dart';
import 'package:tcc_le_app/core/styles/styles.dart';
import 'package:tcc_le_app/pages/auth/login/controllers/auth_controller.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final AuthController _controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(title: Text("Profile", style: CustomTextStyles.logo)),
      body: DafaultLayout(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${_controller.profile.value?.email}",
                style: CustomTextStyles.body,
              ),

              SizedBox(height: CustomSpacing.sm),
              Text(
                "${_controller.profile.value?.username}",
                style: CustomTextStyles.body,
              ),
              SizedBox(height: CustomSpacing.sm),

              TextButton(
                onPressed: () async {
                  var response = await _controller.logout();
                  if (response) {
                    Get.offAndToNamed(RoutePaths.LOGIN_PAGE);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Log out", style: CustomTextStyles.body),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
