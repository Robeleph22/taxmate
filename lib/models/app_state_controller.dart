import 'package:get/get.dart';
import '../models/business_profile.dart';
import '../models/deadline.dart';

class AppStateController extends GetxController {
  /// The main business profile of the user
  final businessProfile = Rxn<BusinessProfile>();

  /// All generated tax deadlines for this business
  final deadlines = <Deadline>[].obs;

  /// Unread notifications counter (for your bell icon, etc.)
  final unreadNotifications = 0.obs;

  /// Whether the initial business setup wizard has been completed
  final hasCompletedSetup = false.obs;

  /// Save / update the profile and recalculate deadlines
  void setBusinessProfile(BusinessProfile profile) {
    businessProfile.value = profile;
    _recalculateDeadlines();
  }

  /// Mark setup as completed
  void markSetupCompleted() {
    hasCompletedSetup.value = true;
  }

  /// Mark a deadline as completed
  void markDeadlineDone(String id) {
    final index = deadlines.indexWhere((d) => d.id == id);
    if (index != -1) {
      deadlines[index] = deadlines[index].copyWith(isDone: true);
    }
  }

  /// Central place to regenerate deadlines when profile changes
  void _recalculateDeadlines() {
    if (businessProfile.value == null) return;

    final profile = businessProfile.value!;

    // TODO: replace this with your real tax logic
    final List<Deadline> generated = [];

    // Example: fake income tax deadline 4 months after fiscal year end
    // You will later write a real function using Ethiopian dates.
    generated.add(
      Deadline(
        id: "income-tax-1",
        type: DeadlineType.incomeTax,
        dueDate: DateTime.now().add(const Duration(days: 120)),
        title: "Annual Income Tax Return",
        description:
            "Due 4 months after your fiscal year end (${profile.fiscalYearEnd}).",
      ),
    );

    deadlines.assignAll(generated);
  }
}