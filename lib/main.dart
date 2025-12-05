import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'models/app_state_controller.dart';
import 'intro/Dashboard/controllers/home_controller.dart';
import 'intro/Dashboard/controllers/calendar_controller.dart';
import 'intro/Dashboard/controllers/notification_controller.dart';
import 'intro/Dashboard/controllers/settings_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(AppStateController(), permanent: true);
  Get.put(HomeController(), permanent: true);
  Get.put(CalendarController(), permanent: true);
  Get.put(NotificationController(), permanent: true);
  Get.put(SettingsController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaxMate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.main,
      getPages: AppPages.pages,
    );
  }
}
