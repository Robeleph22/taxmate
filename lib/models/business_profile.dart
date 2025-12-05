class BusinessProfile {
  final String businessName;
  final String businessType;       // PLC, Sole Proprietor, SC, etc.
  final String taxpayerCategory;   // "A" or "B"
  final double estimatedTurnover;
  final bool vatRegistered;
  final bool hasEmployees;
  final bool isWithholdingAgent;
  final String fiscalYearEnd;      // e.g. "Hamle 30 (July 7)"
  final bool usesCashTransactions;

  BusinessProfile({
    required this.businessName,
    required this.businessType,
    required this.taxpayerCategory,
    required this.estimatedTurnover,
    required this.vatRegistered,
    required this.hasEmployees,
    required this.isWithholdingAgent,
    required this.fiscalYearEnd,
    required this.usesCashTransactions,
  });

  BusinessProfile copyWith({
    String? businessName,
    String? businessType,
    String? taxpayerCategory,
    double? estimatedTurnover,
    bool? vatRegistered,
    bool? hasEmployees,
    bool? isWithholdingAgent,
    String? fiscalYearEnd,
    bool? usesCashTransactions,
  }) {
    return BusinessProfile(
      businessName: businessName ?? this.businessName,
      businessType: businessType ?? this.businessType,
      taxpayerCategory: taxpayerCategory ?? this.taxpayerCategory,
      estimatedTurnover: estimatedTurnover ?? this.estimatedTurnover,
      vatRegistered: vatRegistered ?? this.vatRegistered,
      hasEmployees: hasEmployees ?? this.hasEmployees,
      isWithholdingAgent: isWithholdingAgent ?? this.isWithholdingAgent,
      fiscalYearEnd: fiscalYearEnd ?? this.fiscalYearEnd,
      usesCashTransactions:
      usesCashTransactions ?? this.usesCashTransactions,
    );
  }

  Map<String, dynamic> toJson() => {
    "business_name": businessName,
    "business_type": businessType,
    "taxpayer_category": taxpayerCategory,
    "estimated_annual_turnover_etb": estimatedTurnover,
    "vat_registered": vatRegistered,
    "has_employees": hasEmployees,
    "is_withholding_agent": isWithholdingAgent,
    "fiscal_year_end": fiscalYearEnd,
    "uses_cash_transactions": usesCashTransactions,
  };

  factory BusinessProfile.fromJson(Map<String, dynamic> json) {
    return BusinessProfile(
      businessName: json["business_name"] ?? "",
      businessType: json["business_type"] ?? "",
      taxpayerCategory: json["taxpayer_category"] ?? "B",
      estimatedTurnover:
      (json["estimated_annual_turnover_etb"] ?? 0).toDouble(),
      vatRegistered: json["vat_registered"] ?? false,
      hasEmployees: json["has_employees"] ?? false,
      isWithholdingAgent: json["is_withholding_agent"] ?? false,
      fiscalYearEnd: json["fiscal_year_end"] ?? "",
      usesCashTransactions: json["uses_cash_transactions"] ?? false,
    );
  }
}