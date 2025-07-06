import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcc_le_app/components/ui/input.dart';
import 'package:tcc_le_app/components/ui/text.dart';
import 'package:tcc_le_app/components/ui/title.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            CustomTitle("dasdadasdasds", variant: TitleVariant.lg),
            CustomTitle("dasdadasdasds", variant: TitleVariant.md),
            CustomTitle("dasdadasdasds", variant: TitleVariant.sm),
            CustomTitle("dasdadasdasds", variant: TitleVariant.xs),
            CustomText(
              "Durante as reunioes de negociaçoes foram detectadas dasd asd asd a da d ad a sd",
            ),
            CustomInput(
              hintText: "Digite seu Email",
              isPassword: true,
              icon: Icons.lock_rounded,
            ),
            CustomInput(
              hintText: "Digite seu Email",
              icon: Icons.person_2_rounded,
            ),
            // CustomButton(
            //   onPressed: null,
            //   child: Text('Filled'),
            //   variant: ButtonVariant.primary,
            // ),
            // CustomButton(
            //   onPressed: () {},
            //   child: Text('Filled'),
            //   variant: ButtonVariant.primary,
            // ),

            // CustomButton(
            //   onPressed: null,
            //   child: Text('Filled'),
            //   variant: ButtonVariant.secondary,
            // ),
            // CustomButton(
            //   onPressed: () {},
            //   child: Text('Filled'),
            //   variant: ButtonVariant.secondary,
            // ),

            // CustomButton(
            //   onPressed: null,
            //   child: Text('Filled'),
            //   variant: ButtonVariant.tertiary,
            // ),
            // CustomButton(
            //   onPressed: () {},
            //   child: Text('Filled'),
            //   variant: ButtonVariant.tertiary,
            // ),
            // ButtonTypesGroup(enabled: true),
            // ButtonTypesGroup(enabled: false),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ButtonTypesGroup extends StatelessWidget {
  const ButtonTypesGroup({super.key, required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final VoidCallback? onPressed = enabled ? () {} : null;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(onPressed: onPressed, child: const Text('Elevated')),
          FilledButton(onPressed: onPressed, child: const Text('Filled')),
          FilledButton.tonal(
            onPressed: onPressed,
            child: const Text('Filled Tonal'),
          ),
          OutlinedButton(onPressed: onPressed, child: const Text('Outlined')),
          TextButton(
            onPressed: onPressed,
            child: const Text('Text'),
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(
                CustomColors.neutralLightest,
              ),
              backgroundColor: WidgetStateProperty.resolveWith<Color?>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.disabled)) {
                  return CustomColors.secondary;
                }
                return CustomColors.primary;
              }),
              overlayColor: WidgetStateProperty.resolveWith<Color?>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.hovered) ||
                    states.contains(WidgetState.disabled))
                  return Colors.blue;
                if (states.contains(WidgetState.focused) ||
                    states.contains(WidgetState.pressed))
                  return Colors.blue;
                return null; // Defer to the widget's default.
              }),
            ),
          ),
        ],
      ),
    );
  }
}
