import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_le_app/core/routes/route_paths.dart';
import 'package:tcc_le_app/core/styles/styles.dart';
import 'package:tcc_le_app/pages/chat/chat_page.dart';
import 'package:tcc_le_app/pages/dashboard/main_tab_controller.dart';
import 'package:tcc_le_app/pages/quiz/quiz_page.dart';
import 'package:tcc_le_app/pages/voice/voice_page.dart';

class MainTabPage extends StatelessWidget {
  final controler = Get.put(MainTabController());
  final length = 3;
  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  final List<String> initialRoutes = [
    RoutePaths.CHAT_PAGE,
    RoutePaths.QUIZ_PAGE,
    RoutePaths.VOICE_PAGE,
  ];
  final Map<String, dynamic> tabRoutes = {
    RoutePaths.CHAT_PAGE: ChatPage(),
    RoutePaths.QUIZ_PAGE: QuizPage(),
    RoutePaths.VOICE_PAGE: VoicePage(),
  };

  final List<String> tabNames = ["Chat", "Quiz", "Voice"];
  MainTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: length,
        initialIndex: controler.tabIndex.value,
        child: Scaffold(
          backgroundColor: CustomColors.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            title: RichText(
              text: TextSpan(
                text: "Bora",
                style: CustomTextStyles.logo,
                children: [
                  TextSpan(text: "Talk", style: CustomTextStyles.logo2),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(CustomBorders.radiusFull),
                child: Container(
                  height: 30,
                  // padding: EdgeInsets.symmetric(vertical: 2),
                  margin: EdgeInsets.symmetric(
                    horizontal: CustomSpacing.md,
                    vertical: CustomSpacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      CustomBorders.radiusFull,
                    ),
                    color: CustomColors.neutralLightest,
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        CustomBorders.radiusFull,
                      ),
                      color: CustomColors.secondary,
                    ),
                    labelColor: CustomColors.background,
                    unselectedLabelColor: CustomColors.neutralDark,
                    labelStyle: CustomTextStyles.menu,
                    unselectedLabelStyle: CustomTextStyles.menu,
                    labelPadding: CustomSpacing.squishXXS,

                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    onTap: (index) {
                      controler.changeTab(index);
                    },
                    tabs: tabNames.map((name) => Tab(text: name)).toList(),
                  ),
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: IndexedStack(
              index: controler.tabIndex.value,
              children: List.generate(length, (index) {
                return Navigator(
                  key: navigatorKeys[index],
                  onGenerateRoute: (routesettings) {
                    return MaterialPageRoute(
                      builder: (_) {
                        var page = initialRoutes[index];

                        return (tabRoutes.containsKey(page))
                            ? tabRoutes[page]
                            : tabRoutes[RoutePaths.CHAT_PAGE];
                      },
                    );
                  },
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
