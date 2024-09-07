import 'package:app_genesis/app_theme.dart';
import 'package:app_genesis/provider/theme_changer_provider.dart';
import 'package:app_genesis/view/app_info_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeChangerProvider())
        ],
        child: Builder(builder: (BuildContext context) {
          final themeChanger = context.watch<ThemeChangerProvider?>();
          if (themeChanger == null) {
            return const CircularProgressIndicator(); // or some error handling
          }

          return MaterialApp(
              home: const AppInfoView(),
              themeMode: themeChanger.themeMode,
              theme: Apptheme().appLightTheme(context),
              darkTheme: Apptheme().appDarkTheme(context));
        }));
  }
}
