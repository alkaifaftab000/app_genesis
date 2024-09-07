import 'package:app_genesis/components/global/text_button.dart';
import 'package:app_genesis/provider/theme_changer_provider.dart';
import 'package:app_genesis/view/TeacherPanel/teacher.dart';
import 'package:app_genesis/view/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppInfoView extends StatefulWidget {
  const AppInfoView({super.key});
  @override
  State<AppInfoView> createState() => _AppInfoViewState();
}

class _AppInfoViewState extends State<AppInfoView> {
  final buttons = AppButton();

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChangerProvider>(context);
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('AppInfoView_Screen'),
            centerTitle: true,
            actions: [
              buttons.textButtonIcon('Login', Icons.login_rounded, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              }),
              const SizedBox(width: 30),
              buttons.textButtonIcon('Register', Icons.login_rounded, () {}),
              const SizedBox(width: 30),
              buttons.textButtonIcon('Skip', Icons.login_rounded, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Teacher()));
              }),
            ]),
        body: Column(
          children: [
            RadioListTile<ThemeMode>(
                title: const Text('Light Theme'),
                value: ThemeMode.light,
                groupValue: themeChanger.themeMode,
                onChanged: themeChanger.setThemeMode),
            RadioListTile<ThemeMode>(
                title: const Text('Dark Theme'),
                value: ThemeMode.dark,
                groupValue: themeChanger.themeMode,
                onChanged: themeChanger.setThemeMode)
          ],
        ));
  }
}
