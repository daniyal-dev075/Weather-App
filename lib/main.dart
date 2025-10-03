import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view/home_view.dart';
import 'package:weather_app/view_model/home_view_model.dart';
import 'package:weather_app/view_model/scroll_effect_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ChangeNotifierProvider(create: (_) => ScrollEffectViewModel()),
    ],
        child: ScreenUtilInit(
          designSize: Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context,child){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomeView(),
            );
          },
        )
    );
  }
}
