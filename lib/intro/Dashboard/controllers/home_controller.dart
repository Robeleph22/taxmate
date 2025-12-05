import 'package:get/get.dart';

import '../../../core/controllers/base_controller.dart';

class DashboardStats {
  final int filedOnTime;
  final int upcoming;
  final int overdue;
  final int compliancePercent;

  const DashboardStats({
    required this.filedOnTime,
    required this.upcoming,
    required this.overdue,
    required this.compliancePercent,
  });
}

class DashboardData {
  final String businessName;
  final int unreadNotifications;
  final DashboardStats stats;

  const DashboardData({
    required this.businessName,
    required this.unreadNotifications,
    required this.stats,
  });
}

class HomeController extends BaseController<DashboardData> {
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  Future<void> loadData() async {
    setLoading();
    await Future<void>.delayed(const Duration(milliseconds: 200));

    // TODO: Replace with real data source
    const data = DashboardData(
      businessName: 'Abebe Enterprises',
      unreadNotifications: 3,
      stats: DashboardStats(
        filedOnTime: 12,
        upcoming: 3,
        overdue: 0,
        compliancePercent: 98,
      ),
    );

    setSuccess(data);
  }

  void markNotificationsRead() {
    final current = state.value.data;
    if (current == null) return;
    setSuccess(
      DashboardData(
        businessName: current.businessName,
        unreadNotifications: 0,
        stats: current.stats,
      ),
    );
  }
}

