import 'package:get/get.dart';

import '../../core/controllers/base_controller.dart';

class SetupState {
  final int currentStep;
  final int totalSteps;

  // Business profile fields
  final String? businessName;
  final String? businessType; // PLC, Sole Proprietor, etc.
  final String? taxpayerCategory; // "A" or "B"
  final double? estimatedTurnover;

  // Obligations
  final bool? vatRegistered;
  final bool? hasEmployees;
  final bool? isWithholdingAgent;

  // Fiscal year
  final String? fiscalYearEnd;

  const SetupState({
    required this.currentStep,
    required this.totalSteps,
    this.businessName,
    this.businessType,
    this.taxpayerCategory,
    this.estimatedTurnover,
    this.vatRegistered,
    this.hasEmployees,
    this.isWithholdingAgent,
    this.fiscalYearEnd,
  });

  SetupState copyWith({
    int? currentStep,
    int? totalSteps,
    String? businessName,
    String? businessType,
    String? taxpayerCategory,
    double? estimatedTurnover,
    bool? vatRegistered,
    bool? hasEmployees,
    bool? isWithholdingAgent,
    String? fiscalYearEnd,
  }) {
    return SetupState(
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
      businessName: businessName ?? this.businessName,
      businessType: businessType ?? this.businessType,
      taxpayerCategory: taxpayerCategory ?? this.taxpayerCategory,
      estimatedTurnover: estimatedTurnover ?? this.estimatedTurnover,
      vatRegistered: vatRegistered ?? this.vatRegistered,
      hasEmployees: hasEmployees ?? this.hasEmployees,
      isWithholdingAgent: isWithholdingAgent ?? this.isWithholdingAgent,
      fiscalYearEnd: fiscalYearEnd ?? this.fiscalYearEnd,
    );
  }
}

class SetupController extends BaseController<SetupState> {
  @override
  void onInit() {
    super.onInit();
    setSuccess(const SetupState(
      currentStep: 0,
      totalSteps: 7,
    ));
  }

  void setStep(int step) {
    final current = state.value.data;
    if (current == null) return;
    setSuccess(current.copyWith(currentStep: step));
  }

  /// Called from the last step of the setup wizard
  /// (your `TaxSetupWizard` / `SetupYourBusiness` screen).
  void completeSetup({
    required String businessName,
    required String businessType,
    required String taxpayerCategory, // "A" or "B"
    required double estimatedTurnover,
    required bool vatRegistered,
    required bool hasEmployees,
    required bool isWithholdingAgent,
    required String fiscalYearEnd,
  }) {
    final current = state.value.data;
    if (current == null) return;

    final updated = current.copyWith(
      businessName: businessName,
      businessType: businessType,
      taxpayerCategory: taxpayerCategory,
      estimatedTurnover: estimatedTurnover,
      vatRegistered: vatRegistered,
      hasEmployees: hasEmployees,
      isWithholdingAgent: isWithholdingAgent,
      fiscalYearEnd: fiscalYearEnd,
    );

    setSuccess(updated);
  }

  // Optional helpers if you want to read this easily in other screens

  SetupState? get setup => state.value.data;

  bool get isCompleted =>
      setup?.businessName != null &&
          setup?.businessType != null &&
          setup?.taxpayerCategory != null;
}