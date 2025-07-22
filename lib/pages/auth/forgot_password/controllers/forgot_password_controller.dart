import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tcc_le_app/core/http/services/forgot_password_service.dart';
import 'package:tcc_le_app/core/http/services/reset_password_service.dart';
import 'package:tcc_le_app/core/utils/failures.dart';
import 'package:tcc_le_app/core/utils/generic_state.dart';
import 'package:tcc_le_app/core/utils/validators.dart';

class ForgotPasswordController extends GetxController {
  RxString email = "".obs;
  RxString code = "".obs;
  RxString newPassword = "".obs;
  RxString confirmPassword = "".obs;

  Rx<GenericState> forgotPasswordStatus = GenericState.idle().obs;
  Rx<GenericState> resetPasswordStatus = GenericState.idle().obs;

  List<Map<String, dynamic>> passwordValidation =
      <Map<String, dynamic>>[
        {
          "text": "At least 8 characters",
          "validator": Validators.isValidLength,
        },
        {
          "text": "At least 1 uppercase letter",
          "validator": Validators.hasUppercase,
        },
        {
          "text": "At least 1 lowercase letter",
          "validator": Validators.hasLowercase,
        },
        {"text": "At least 1 number", "validator": Validators.hasNumber},
        {
          "text": "At least 1 special character",
          "validator": Validators.hasSpecialChar,
        },
      ].obs;

  void onEmailChanged(String value) => email.value = value.trim();
  void onCodeChanged(String value) => code.value = value.trim();
  void onNewPasswordChanged(String value) => newPassword.value = value.trim();
  void onConfirmPasswordChanged(String value) =>
      confirmPassword.value = value.trim();

  Either<String, bool> validatePasswords() {
    if (newPassword.value.isEmpty || confirmPassword.value.isEmpty) {
      return Left("Passwords cannot be empty");
    }
    if (newPassword.value != confirmPassword.value) {
      return Left("Passwords do not match");
    }
    for (var item in passwordValidation) {
      if (!item['validator'](newPassword.value)) {
        return Left(item['text']);
      }
    }

    return Right(true);
  }

  Future<bool> resetPassword({
    required String password,
    required String confirmPassword,
  }) async {
    resetPasswordStatus.value = GenericState.loading();
    ResetPasswordService resetPasswordService = ResetPasswordService();

    var response = await resetPasswordService.handle(
      email: email.value,
      code: code.value,
      password: newPassword.value,
    );
    if (response.isLeft()) {
      var error = ((response as Left).value as ServerFailure);
      resetPasswordStatus.value = GenericState.failure(error.toString());
      return false;
    }
    resetPasswordStatus.value = GenericState.success((response as Right).value);
    return true;
  }

  Future<bool> forgotPassword({required String email}) async {
    ForgotPasswordService forgotPasswordService = ForgotPasswordService();

    forgotPasswordStatus.value = GenericState.loading();
    var response = await forgotPasswordService.handle(email: email);

    if (response.isLeft()) {
      var error = ((response as Left).value as ServerFailure);
      forgotPasswordStatus.value = GenericState.failure(error.toString());
      return false;
    }

    forgotPasswordStatus.value = GenericState.success(
      (response as Right).value,
    );
    return true;
  }
}
