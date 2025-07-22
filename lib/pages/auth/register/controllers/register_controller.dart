import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tcc_le_app/core/http/dto/register_user_dto.dart';
import 'package:tcc_le_app/core/http/services/register_user_service.dart';
import 'package:tcc_le_app/core/utils/failures.dart';
import 'package:tcc_le_app/core/utils/generic_state.dart';
import 'package:tcc_le_app/core/utils/validators.dart';

class RegisterController extends GetxController {
  RxString email = "".obs;
  RxString password = "".obs;
  RxString confirmPassword = "".obs;
  RxString username = "".obs;
  Rx<GenericState> registerStatus = GenericState.idle().obs;

  void onEmailChanged(String value) => email.value = value;
  void onPasswordChanged(String value) => password.value = value;
  void onConfirmPasswordChanged(String value) => confirmPassword.value = value;
  void onUsernameChanged(String value) => username.value = value;

  bool isFailure() => registerStatus.value.status == RequestStatus.failure;

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

  Either<String, bool> validateEmail() {
    if (Validators.isValidEmail(email.value)) {
      return Right(true);
    }
    return Left("Invalid email");
  }

  Either<String, bool> validateUsername() {
    if (email.value.isNotEmpty) {
      return Right(true);
    }
    return Left("Username cannot be empty");
  }

  Either<String, bool> validatePasswords() {
    if (password.value.isEmpty || confirmPassword.value.isEmpty) {
      return Left("Passwords cannot be empty");
    }
    if (password.value != confirmPassword.value) {
      return Left("Passwords do not match");
    }
    for (var item in passwordValidation) {
      if (!item['validator'](password.value)) {
        return Left(item['text']);
      }
    }

    return Right(true);
  }

  bool allInputsAreValid() {
    return validateUsername().isRight() &&
        validateEmail().isRight() &&
        validatePasswords().isRight();
  }

  Future<bool> register() async {
    RegisterUserService registerUserService = RegisterUserService();
    print("🔹 register request ");

    RegisterUserDtoRequest data = RegisterUserDtoRequest(
      email: email.value,
      username: username.value,
      avatar: "",
      password: password.value,
      confirmPassword: confirmPassword.value,
    );
    registerStatus.value = GenericState<RegisterUserDtoResponse>.loading();
    var response = await registerUserService.handle(data);
    print("🔹 Response $response");

    if (response.isLeft()) {
      var error = ((response as Left).value as ServerFailure);
      registerStatus.value = GenericState<RegisterUserDtoResponse>.failure(
        error.toString(),
      );
      print("🔸 Error: ${(response as Left).value}");

      return false;
    }
    registerStatus.value = GenericState<RegisterUserDtoResponse>.success(
      (response as Right).value,
    );
    return true;
  }
}
