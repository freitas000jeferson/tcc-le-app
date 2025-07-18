import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcc_le_app/core/routes/route_pages.dart';
import 'package:tcc_le_app/core/routes/route_paths.dart';
import 'package:tcc_le_app/core/styles/colors.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: CustomColors.primary),
  );
  await GetStorage.init("user");
  await GetStorage.init("token");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeMode themeMode = ThemeMode.system;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BoraTalk',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [],
      getPages: RoutePages.pages,
      initialRoute: RoutePaths.SPLASH_PAGE,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: CustomColors.primary,
        scaffoldBackgroundColor: CustomColors.background,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      darkTheme: ThemeData(),
    );
  }
}
