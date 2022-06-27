import 'package:awake_social/page/page_export.dart';
import 'package:awake_social/routers/route_name.dart';
import 'package:awake_social/utils/screen_util/screen_util_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 820),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => Builder(builder: (context) => MaterialApp(
        title: 'Awake',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFF101010),
            appBarTheme: const AppBarTheme(
                color: Color(0xFF1F1F1F),
                iconTheme: IconThemeData(color: Colors.white)),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Color(0xFF1F1F1F)),
            iconTheme: const IconThemeData(color: Colors.white)),
        onGenerateRoute: RouterSettings.allRoutes,
        initialRoute: NavigationPage.routeName,
      )),
    );
  }
}

