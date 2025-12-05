import 'package:get/get.dart';

import '../../../core/controllers/base_controller.dart';

class AppNotification {
  final String id;
  final String title;
  final String body;
  final String timeAgo;
  final bool read;

  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.timeAgo,
    required this.read,
  });
}

class NotificationController extends BaseController<List<AppNotification>> {
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  Future<void> loadData() async {
    setLoading();
    await Future<void>.delayed(const Duration(milliseconds: 150));

    final items = <AppNotification>[
      const AppNotification(
        id: '1',
        title: 'VAT Return Due Soon',
        body:
            'Your VAT return for Tir 2016 is due in 5 days. Make sure you have all required documents ready.',
        timeAgo: '2h ago',
        read: false,
      ),
      const AppNotification(
        id: '2',
        title: 'Filing Confirmed',
        body:
            'Your payroll tax payment for Tahsas 2016 has been successfully recorded. Great job!',
        timeAgo: '1d ago',
        read: false,
      ),
      const AppNotification(
        id: '3',
        title: 'New Tax Regulation',
        body:
            'The Ministry of Revenue has updated VAT filing guidelines. Review the changes to ensure compliance.',
        timeAgo: '2d ago',
        read: false,
      ),
      const AppNotification(
        id: '4',
        title: 'Reminder Set',
        body:
            "You'll receive a reminder 7 days before your next pension contribution deadline.",
        timeAgo: '3d ago',
        read: true,
      ),
    ];

    if (items.isEmpty) {
      setEmpty(message: 'You\'re all caught up!');
    } else {
      setSuccess(items);
    }
  }

  void markAllRead() {
    final current = state.value.data;
    if (current == null) return;
    final updated = current
        .map((n) => AppNotification(
              id: n.id,
              title: n.title,
              body: n.body,
              timeAgo: n.timeAgo,
              read: true,
            ))
        .toList();
    setSuccess(updated);
  }
}

