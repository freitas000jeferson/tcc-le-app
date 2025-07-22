import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tcc_le_app/core/domain/user_profile.dart';
import 'package:tcc_le_app/core/http/domain/oauth_token.dart';
import 'package:tcc_le_app/core/http/services/get_profile_service.dart';
import 'package:tcc_le_app/core/http/services/login_service.dart';
import 'package:tcc_le_app/core/utils/failures.dart';
import 'package:tcc_le_app/core/utils/generic_state.dart';
import 'package:tcc_le_app/core/utils/validators.dart';

class UserController extends GetxController {
  Rx<UserProfile?> profile = (null).obs;
  Rx<GenericState<OAuthToken>> loginStatus =
      GenericState<OAuthToken>.idle().obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> login({String? username, String? password}) async {
    loginStatus.value = GenericState<OAuthToken>.idle();

    if (username == null ||
        password == null ||
        !Validators.isValidEmail(username)) {
      loginStatus.value = GenericState<OAuthToken>.failure(
        "Fill in the username and password fields",
      );

      return false;
    }
    loginStatus.value = GenericState<OAuthToken>.loading();
    print("🔹 login request ");

    LoginService loginService = LoginService();
    var response = await loginService.handle(
      username: username,
      password: password,
    );
    print("🔹 Response $response");

    if (response.isLeft()) {
      var error = ((response as Left).value as ServerFailure);
      loginStatus.value = GenericState<OAuthToken>.failure(
        error.statusCode == 401
            ? "Invalid username or password. Please check your details and try again."
            : error.toString(),
      );
      print("🔸 Error: ${(response as Left).value}");

      return false;
    }
    await getProfile();

    loginStatus.value = GenericState<OAuthToken>.success(
      (response as Right).value,
    );

    return true;
  }

  Future getProfile() async {
    GetProfileService getProfileService = GetProfileService();
    var response = await getProfileService.handle();
    if (response.isLeft()) {
      return;
    }
    profile.value = (response as Right).value;
  }
}
