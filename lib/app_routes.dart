import 'package:get/get.dart';
import 'package:unlock/home_screen.dart';
import 'package:unlock/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: home, page: () => HomeScreen()),
  ];
}
