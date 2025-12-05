import 'package:get/get.dart';

import '../../../core/controllers/base_controller.dart';

class CalendarTask {
  final String day;
  final String title;
  final String subtitle;
  final String status;
  final int sortOrder;

  CalendarTask({
    required this.day,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.sortOrder,
  });
}

class CalendarData {
  final String monthLabel;
  final int daysInMonth;
  final int today;
  final List<int> dueDays;
  final List<CalendarTask> tasks;

  CalendarData({
    required this.monthLabel,
    required this.daysInMonth,
    required this.today,
    required this.dueDays,
    required this.tasks,
  });
}

class CalendarController extends BaseController<CalendarData> {
  final RxInt selectedMonthOffset = 0.obs; // 0 = current, -1 = prev, +1 = next

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  Future<void> loadData() async {
    setLoading();

    // Fake delay & data to simulate a load
    await Future<void>.delayed(const Duration(milliseconds: 300));

    // You can later plug in real logic based on selectedMonthOffset.
    final data = CalendarData(
      monthLabel: 'Tir 2016 (January 2024)',
      daysInMonth: 31,
      today: 19,
      dueDays: const [7, 30],
      tasks: [
        CalendarTask(
          day: '7',
          title: 'Payroll Tax',
          subtitle: 'Employee income tax',
          status: 'Filed on Tir 7, 2016',
          sortOrder: 1,
        ),
        CalendarTask(
          day: '7',
          title: 'Pension',
          subtitle: 'Monthly contribution',
          status: 'Filed on Tir 7, 2016',
          sortOrder: 2,
        ),
        CalendarTask(
          day: '30',
          title: 'VAT Return',
          subtitle: 'Monthly filing',
          status: 'Due in 5 days',
          sortOrder: 3,
        ),
      ],
    );

    setSuccess(data);
  }

  void goToPreviousMonth() {
    selectedMonthOffset.value--;
    // Later recalc label/data based on offset.
  }

  void goToNextMonth() {
    selectedMonthOffset.value++;
  }
}

