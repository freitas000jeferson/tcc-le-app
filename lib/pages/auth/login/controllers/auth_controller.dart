import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tcc_le_app/core/domain/user_profile.dart';
import 'package:tcc_le_app/core/http/authorization/bearer_authorization_service.dart';
import 'package:tcc_le_app/core/http/domain/oauth_token.dart';
import 'package:tcc_le_app/core/http/services/get_profile_service.dart';
import 'package:tcc_le_app/core/http/services/login_service.dart';
import 'package:tcc_le_app/core/http/services/logout_service.dart';
import 'package:tcc_le_app/core/utils/failures.dart';
import 'package:tcc_le_app/core/utils/generic_state.dart';
import 'package:tcc_le_app/core/utils/validators.dart';

class AuthController extends GetxController {
  Rxn<UserProfile> profile = Rxn<UserProfile>();
  Rx<GenericState<OAuthToken>> loginStatus =
      GenericState<OAuthToken>.idle().obs;
  Rx<GenericState> logoutStatus = GenericState.idle().obs;

  final BearerAuthorizationService _authorizationService =
      BearerAuthorizationService();

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
    print("profile ${(response as Right).value}");
    profile.value = (response as Right).value;
  }

  Future<bool> logout() async {
    LogoutService logoutService = LogoutService();
    logoutStatus.value = GenericState.loading();
    var response = await logoutService.handle();
    if (response.isLeft()) {
      GenericState.failure((response as Left).value);
      return false;
    }
    logoutStatus.value = GenericState.success((response as Right).value);
    return true;
  }

  Future<bool> hasAuthenticated() async {
    var response = await _authorizationService.getAccessToken();
    // OAuthToken? token =
    bool isAuth = response.isRight();
    if (response.isRight()) {
      await getProfile();
    }

    return isAuth;
  }
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
