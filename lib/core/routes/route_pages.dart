import 'package:get/get.dart';
import 'package:tcc_le_app/core/routes/route_paths.dart';
import 'package:tcc_le_app/pages/auth/forgot_password/code_validation_page.dart';
import 'package:tcc_le_app/pages/auth/forgot_password/forgot_password_page.dart';
import 'package:tcc_le_app/pages/auth/forgot_password/reset_password_page.dart';
import 'package:tcc_le_app/pages/auth/login/login_page.dart';
import 'package:tcc_le_app/pages/auth/register/register_page.dart';
import 'package:tcc_le_app/pages/dashboard/main_tab_page.dart';
import 'package:tcc_le_app/pages/splash/splash_page.dart';

class RoutePages {
  static final List<GetPage> pages = [
    GetPage(name: RoutePaths.SPLASH_PAGE, page: () => SplashPage()),
    GetPage(name: RoutePaths.LOGIN_PAGE, page: () => LoginPage()),
    GetPage(name: RoutePaths.REGISTER_PAGE, page: () => RegisterPage()),
    GetPage(
      name: RoutePaths.FORGOT_PASSWORD_PAGE,
      page: () => ForgotPasswordPage(),
    ),
    GetPage(name: RoutePaths.MAIN_TAB_PAGE, page: () => MainTabPage()),
    GetPage(
      name: RoutePaths.RESET_PASSWORD_PAGE,
      page: () => ResetPasswordPage(),
    ),
    GetPage(
      name: RoutePaths.CODE_VALIDATION_PAGE,
      page: () => CodeValidationPage(),
    ),
  ];
}
