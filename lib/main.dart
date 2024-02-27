import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jdolh_brands/core/binding/initial_binding.dart';
import 'package:jdolh_brands/core/constants/app_theme.dart';
import 'package:jdolh_brands/core/services/services.dart';
import 'package:jdolh_brands/routes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await initialServices();
  initializeDateFormatting('ar');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          title: 'JDOLH Bands',
          debugShowCheckedModeBanner: false,
          locale: const Locale('ar'),
          theme: themeArabic,
          initialBinding: InitialBindings(),
          getPages: routes,
        );
      },
    );
  }
}
