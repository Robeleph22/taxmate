import 'package:get/get.dart';

import '../../intro/Dashboard/ai_chatbot.dart';
import '../../intro/Dashboard/calander_page.dart';
import '../../intro/Dashboard/home_page.dart';
import '../../intro/Dashboard/notfication.dart';
import '../../intro/Dashboard/setting_page.dart';
import '../../intro/Dashboard/controllers/calendar_controller.dart';
import '../../intro/Dashboard/controllers/chatbot_controller.dart';
import '../../intro/Dashboard/controllers/home_controller.dart';
import '../../intro/Dashboard/controllers/notification_controller.dart';
import '../../intro/Dashboard/controllers/settings_controller.dart';
import '../../intro/main_app_screen.dart';
import '../../intro/setup_your_business.dart';
import '../../intro/controllers/setup_controller.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.home,
      page: () => const DashboardScreen(),
      binding: BindingsBuilder(() {
        Get.put(HomeController());
      }),
    ),
    GetPage(
      name: AppRoutes.calendar,
      page: () => const CalendarScreen(),
      binding: BindingsBuilder(() {
        Get.put(CalendarController());
      }),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsScreen(),
      binding: BindingsBuilder(() {
        Get.put(NotificationController());
      }),
    ),
    GetPage(
      name: AppRoutes.chatbot,
      page: () => const TaxMateScreen(),
      binding: BindingsBuilder(() {
        Get.put(ChatbotController());
      }),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsScreen(),
      binding: BindingsBuilder(() {
        Get.put(SettingsController());
      }),
    ),
    GetPage(
      name: AppRoutes.setup,
      page: () => const TaxSetupWizard(),
      binding: BindingsBuilder(() {
        Get.put(SetupController());
      }),
    ),GetPage(
      name: AppRoutes.main,
      page: () => const MainAppScreen(),
      binding: BindingsBuilder(() {
        Get.put(SetupController());
      }),
    ),
  ];
}
