import 'package:get/get.dart';

import '../../../core/controllers/base_controller.dart';

class SettingsData {
  final bool vatRegistered;
  final bool hasEmployees;
  final bool withholdingAgent;
  final bool pushNotifications;
  final bool emailReminders;

  const SettingsData({
    required this.vatRegistered,
    required this.hasEmployees,
    required this.withholdingAgent,
    required this.pushNotifications,
    required this.emailReminders,
  });

  SettingsData copyWith({
    bool? vatRegistered,
    bool? hasEmployees,
    bool? withholdingAgent,
    bool? pushNotifications,
    bool? emailReminders,
  }) {
    return SettingsData(
      vatRegistered: vatRegistered ?? this.vatRegistered,
      hasEmployees: hasEmployees ?? this.hasEmployees,
      withholdingAgent: withholdingAgent ?? this.withholdingAgent,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      emailReminders: emailReminders ?? this.emailReminders,
    );
  }
}

class SettingsController extends BaseController<SettingsData> {
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  Future<void> loadData() async {
    setLoading();
    await Future<void>.delayed(const Duration(milliseconds: 150));

    const data = SettingsData(
      vatRegistered: true,
      hasEmployees: true,
      withholdingAgent: false,
      pushNotifications: true,
      emailReminders: true,
    );

    setSuccess(data);
  }

  void toggleVat(bool value) => _update((d) => d.copyWith(vatRegistered: value));
  void toggleEmployees(bool value) => _update((d) => d.copyWith(hasEmployees: value));
  void toggleWithholding(bool value) => _update((d) => d.copyWith(withholdingAgent: value));
  void togglePushNotifications(bool value) => _update((d) => d.copyWith(pushNotifications: value));
  void toggleEmailReminders(bool value) => _update((d) => d.copyWith(emailReminders: value));

  void _update(SettingsData Function(SettingsData current) builder) {
    final current = state.value.data;
    if (current == null) return;
    setSuccess(builder(current));
  }
}

