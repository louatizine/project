import 'package:flutter/material.dart';
import 'package:gestionConge/src/features/authentification/screens/splash_screen/splash_screen.dart';
import 'package:gestionConge/src/utils/theme/theme.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      themeMode : ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      transitionDuration: const Duration(milliseconds: 500),
      home:const Splash(),
    );

  }
}


