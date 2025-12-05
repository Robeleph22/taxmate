import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/setup_controller.dart';
import 'main_app_screen.dart';

class TaxSetupWizard extends StatefulWidget {
  const TaxSetupWizard({super.key});

  @override
  State<TaxSetupWizard> createState() => _TaxSetupWizardState();
}

class _TaxSetupWizardState extends State<TaxSetupWizard> {
  int _currentStep = 0;
  final int _totalSteps = 7;

  // Remove late init; we’ll resolve the controller lazily with Get.find()
  // late final SetupController _setupController;

  // Controllers for inputs (Simplified for UI demo)
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _turnoverController = TextEditingController();
  final TextEditingController _vatDateController = TextEditingController();

  // State variables for selections
  String _selectedBusinessType = 'Select business type';
  String _selectedCategory = 'A'; // Default A for demo
  final Set<String> _selectedObligations = {'VAT', 'Employees'};
  String _selectedFiscalMonth = 'Select month';
  bool? _pensionContributions; // null, true, false

  // Colors extracted from screenshots
  final Color _primaryColor = const Color(0xFF184E56); // Dark Teal
  final Color _accentColor = const Color(0xFF26A69A); // Lighter Teal
  final Color _backgroundColor = const Color(0xFFF5F7F9); // Light Grey bg
  final Color _cardBorderColor = const Color(0xFFE0E0E0);
  final Color _selectedBorderColor = const Color(0xFF184E56);
  final Color _warningBgColor = const Color(0xFFFFF8E1);
  final Color _infoBgColor = const Color(0xFFE0F7FA);

  @override
  void initState() {
    super.initState();
    // Do not call Get.find here; bindings may not have run yet.
  }

  SetupController get _setupController => Get.find<SetupController>();

  void _nextStep() {
    // When user finishes the last step, save their business profile
    if (_currentStep == _totalSteps - 1) {
      final String businessName = _businessNameController.text.trim();
      final double turnover = double.tryParse(
        _turnoverController.text.replaceAll(',', '').trim(),
      ) ??
          0.0;

      final bool vatRegistered = _selectedObligations.contains('VAT');
      final bool hasEmployees = _selectedObligations.contains('Employees');
      final bool isWithholdingAgent =
          _selectedObligations.contains('Withholding');

      _setupController.completeSetup(
        businessName: businessName,
        businessType: _selectedBusinessType,
        taxpayerCategory: _selectedCategory,
        estimatedTurnover: turnover,
        vatRegistered: vatRegistered,
        hasEmployees: hasEmployees,
        isWithholdingAgent: isWithholdingAgent,
        fiscalYearEnd: _selectedFiscalMonth,
      );

      setState(() {
        _currentStep++;
      });
      _setupController.setStep(_currentStep);
      return;
    }

    if (_currentStep < _totalSteps) {
      setState(() {
        _currentStep++;
      });
      _setupController.setStep(_currentStep);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _setupController.setStep(_currentStep);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ensure controller step is in sync whenever we build
    _setupController.setStep(_currentStep);

    // If we are on the "Success" screen (index 7), show that instead of the wizard scaffold
    if (_currentStep == _totalSteps) {
      return _buildSuccessScreen();
    }

    double progress = (_currentStep + 1) / _totalSteps;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: _prevStep,
        ),
        title: Text(
          "Step ${_currentStep + 1} of $_totalSteps",
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: _cardBorderColor,
                        valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
                        minHeight: 6,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "${(progress * 100).toInt()}%",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Step indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
              child: Row(
                children: [
                  Text(
                    "Set up your business",
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  _buildStepChip(),
                ],
              ),
            ),

            // Main Content Area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: _buildStepContent(_currentStep),
              ),
            ),

            // Bottom Buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentStep == _totalSteps - 1 ? "Finish setup" : "Continue",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (_currentStep < _totalSteps - 1)
                    TextButton(
                      onPressed: _nextStep,
                      child: Text(
                        "Skip for now",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepChip() {
    String label;
    IconData icon;

    switch (_currentStep) {
      case 0:
        label = "Business Profile";
        icon = Icons.business_center_outlined;
        break;
      case 1:
        label = "Taxpayer Category";
        icon = Icons.category_outlined;
        break;
      case 2:
        label = "Turnover & Size";
        icon = Icons.trending_up_outlined;
        break;
      case 3:
        label = "Tax Obligations";
        icon = Icons.receipt_long_outlined;
        break;
      case 4:
        label = "Fiscal Year";
        icon = Icons.calendar_today_outlined;
        break;
      case 5:
        label = "Compliance Check";
        icon = Icons.verified_user_outlined;
        break;
      case 6:
        label = "Review";
        icon = Icons.check_circle_outline;
        break;
      default:
        label = "Setup";
        icon = Icons.settings_outlined;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorderColor),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: _primaryColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent(int step) {
    switch (step) {
      case 0:
        return _buildStep1BusinessProfile();
      case 1:
        return _buildStep2Category();
      case 2:
        return _buildStep3Turnover();
      case 3:
        return _buildStep4Obligations();
      case 4:
        return _buildStep5FiscalYear();
      case 5:
        return _buildStep6Compliance();
      case 6:
        return _buildStep7Review();
      default:
        return const SizedBox.shrink();
    }
  }

  // --- Step 1: Business Profile ---
  Widget _buildStep1BusinessProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(
          "Business Profile",
          "Tell us about your business so we can set up the right tax reminders for you.",
        ),
        const SizedBox(height: 24),
        _buildLabel("Business Name"),
        const SizedBox(height: 8),
        TextField(
          controller: _businessNameController,
          decoration: _inputDecoration("Enter your business name"),
        ),
        const SizedBox(height: 24),
        _buildLabel("Business Type"),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: _cardBorderColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedBusinessType,
              items: ['Select business type', 'Private Limited Company', 'Sole Proprietorship']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedBusinessType = v!),
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildInfoBox(
          icon: Icons.info_outline,
          title: "Why do we need this?",
          text:
          "Different business types have different tax obligations in Ethiopia. This helps us set up the right reminders.",
          bgColor: _infoBgColor,
        ),
      ],
    );
  }

  // --- Step 2: Taxpayer Category ---
  Widget _buildStep2Category() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(
          "Taxpayer Category",
          "Select your taxpayer category as registered with the Ethiopian Ministry of Revenue",
        ),
        const SizedBox(height: 24),
        _buildCategoryCard(
          isSelected: _selectedCategory == 'A',
          onTap: () => setState(() => _selectedCategory = 'A'),
          title: "Category A",
          badgeText: "Selected",
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Large taxpayers with annual turnover above ETB 100 million. Managed by the Large Taxpayers Office.",
                style: TextStyle(color: Colors.grey[700], fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 12),
              _buildBulletPoint("Monthly VAT filing"),
              _buildBulletPoint("Quarterly provisional tax"),
              _buildBulletPoint("Annual income tax return"),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildCategoryCard(
          isSelected: _selectedCategory == 'B',
          onTap: () => setState(() => _selectedCategory = 'B'),
          title: "Category B",
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Medium taxpayers with moderate turnover and standard compliance requirements.",
                style: TextStyle(color: Colors.grey[700], fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 12),
              _buildBulletPoint("Monthly or quarterly VAT"),
              _buildBulletPoint("Annual income tax return"),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildCategoryCard(
          isSelected: _selectedCategory == 'C',
          onTap: () => setState(() => _selectedCategory = 'C'),
          title: "Category C",
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Small taxpayers and micro businesses with simplified obligations.",
                style: TextStyle(color: Colors.grey[700], fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 12),
              _buildBulletPoint("Simplified reporting"),
              _buildBulletPoint("Annual income tax return"),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildInfoBox(
          icon: Icons.lock_outline,
          title: "Your data is secure",
          text:
          "We use this information only to calculate your tax deadlines. Your financial data is encrypted.",
          bgColor: Colors.grey[100]!,
        ),
      ],
    );
  }

  // --- Step 3: Turnover & Size ---
  Widget _buildStep3Turnover() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(
          "Turnover & Business Size",
          "This helps us understand your filing frequency and obligations.",
        ),
        const SizedBox(height: 24),
        _buildLabel("Estimated Annual Turnover (ETB)"),
        const SizedBox(height: 8),
        TextField(
          controller: _turnoverController,
          keyboardType: TextInputType.number,
          decoration: _inputDecoration("e.g. 1,500,000"),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _infoBgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb_outline, size: 20, color: _primaryColor),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "If you're not sure, provide your best estimate. You can update this later in settings.",
                  style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  // --- Step 4: Tax Obligations ---
  Widget _buildStep4Obligations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader("Tax Obligations", "Select all that apply to your business"),
        const SizedBox(height: 24),
        _buildCheckboxCard(
          title: "VAT Registered",
          subtitle: "Your business is registered for Value Added Tax",
          icon: Icons.receipt_long,
          isSelected: _selectedObligations.contains('VAT'),
          onTap: () => setState(() {
            _selectedObligations.contains('VAT')
                ? _selectedObligations.remove('VAT')
                : _selectedObligations.add('VAT');
          }),
          footer: "Monthly filing required",
        ),
        const SizedBox(height: 16),
        _buildCheckboxCard(
          title: "Has Employees",
          subtitle: "Your business has one or more employees",
          icon: Icons.people,
          isSelected: _selectedObligations.contains('Employees'),
          onTap: () => setState(() {
            _selectedObligations.contains('Employees')
                ? _selectedObligations.remove('Employees')
                : _selectedObligations.add('Employees');
          }),
          footer: "Monthly payroll tax filing",
        ),
        const SizedBox(height: 16),
        _buildCheckboxCard(
          title: "Withholding Agent",
          subtitle: "You withhold tax on payments to suppliers/contractors",
          icon: Icons.monetization_on_outlined,
          isSelected: _selectedObligations.contains('Withholding'),
          onTap: () => setState(() {
            _selectedObligations.contains('Withholding')
                ? _selectedObligations.remove('Withholding')
                : _selectedObligations.add('Withholding');
          }),
          footer: "Monthly withholding declaration",
        ),
        const SizedBox(height: 24),
        _buildInfoBox(
          icon: Icons.info_outline,
          title: "Need help?",
          text:
          "If you're unsure about any of these, you can check your tax registration certificate.",
          bgColor: _warningBgColor,
        ),
      ],
    );
  }

  // --- Step 5: Fiscal Year ---
  Widget _buildStep5FiscalYear() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(
          "Fiscal Year End",
          "Choose the month when your fiscal year ends so we can remind you of annual filings.",
        ),
        const SizedBox(height: 24),
        _buildLabel("Fiscal Year End (Month)"),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: _cardBorderColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedFiscalMonth,
              items: ['Select month', 'Hamle 30 (July 7)', 'December 31']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedFiscalMonth = v!),
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildInfoBox(
          icon: Icons.calendar_today,
          title: "What is a fiscal year?",
          text:
          "Your fiscal year is the 12-month period used for accounting. Most Ethiopian businesses follow Hamle 30.",
          bgColor: _infoBgColor,
        ),
        const SizedBox(height: 16),
        _buildInfoBox(
          icon: Icons.lightbulb_outline,
          title: "Why this matters",
          text:
          "Your fiscal year end determines when your annual income tax return is due.",
          bgColor: Colors.grey[50]!,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _warningBgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange.withOpacity(0.2)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(Icons.warning_amber_outlined, color: Colors.orange),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  "If your business uses a special fiscal year, make sure it's correctly registered with the Ministry of Revenue.",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Step 6: Compliance Check ---
  Widget _buildStep6Compliance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(
          "Compliance Check",
          "This helps us understand your current filing status.",
        ),
        const SizedBox(height: 24),
        if (_selectedObligations.contains('VAT')) ...[
          _buildLabel("Last VAT filing date (optional)"),
          const SizedBox(height: 8),
          TextField(
            controller: _vatDateController,
            decoration: _inputDecoration("e.g. 2025-10-30"),
          ),
          const SizedBox(height: 24),
        ],
        if (_selectedObligations.contains('Employees')) ...[
          _buildLabel("Pension Contributions"),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildRadioBtn("Yes", true),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildRadioBtn("No", false),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info, size: 16, color: _primaryColor),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    "Employers are required to contribute 11% of gross salary to the POEPF.",
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _warningBgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange.withOpacity(0.2)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(Icons.announcement_outlined, color: Colors.orange),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Don't worry—your answers here only help us tailor reminders. They are not reported to any authority.",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Step 7: Review & Confirm ---
  Widget _buildStep7Review() {
    final categoryLabel = _selectedCategory == 'A'
        ? "Category A"
        : _selectedCategory == 'B'
        ? "Category B"
        : "Category C";

    final obligations = [
      if (_selectedObligations.contains('VAT')) "VAT Registered",
      if (_selectedObligations.contains('Employees')) "Has Employees",
      if (_selectedObligations.contains('Withholding')) "Withholding Agent",
    ].join(" • ");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(
          "Review your setup",
          "Make sure everything looks correct before we generate your calendar.",
        ),
        const SizedBox(height: 24),
        _buildReviewCard(
          title: "Business Profile",
          subtitle: _businessNameController.text.isEmpty
              ? "No business name entered"
              : _businessNameController.text,
          trailing: _selectedBusinessType,
        ),
        const SizedBox(height: 12),
        _buildReviewCard(
          title: "Taxpayer Category",
          subtitle: categoryLabel,
          trailing: "Based on your selection",
        ),
        const SizedBox(height: 12),
        _buildReviewCard(
          title: "Turnover & Size",
          subtitle: _turnoverController.text.isEmpty
              ? "No turnover entered"
              : "Estimated: ${_turnoverController.text} ETB",
          trailing: "Can be updated later",
        ),
        const SizedBox(height: 12),
        _buildReviewCard(
          title: "Tax Obligations",
          subtitle: obligations.isEmpty ? "None selected" : obligations,
          trailing: "Used for reminders",
        ),
        const SizedBox(height: 12),
        _buildReviewCard(
          title: "Fiscal Year End",
          subtitle: _selectedFiscalMonth,
          trailing: "Determines annual deadlines",
        ),
        const SizedBox(height: 24),
        _buildInfoBox(
          icon: Icons.lock_outline,
          title: "Your information is private",
          text:
          "Only you can see this setup inside TaxMate. We use it solely to power your smart tax calendar.",
          bgColor: Colors.grey[100]!,
        ),
      ],
    );
  }

  // --- Success Screen ---
  Widget _buildSuccessScreen() {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Color(0xFF184E56)),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const MainAppScreen(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.check_circle,
                              size: 80, color: Color(0xFF26A69A)),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                                color: Colors.amber, shape: BoxShape.circle),
                            child: const Icon(Icons.star,
                                color: Colors.white, size: 14),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text("You're All Set!",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF184E56))),
                    const SizedBox(height: 12),
                    Text(
                      "TaxMate is now tracking your tax deadlines and will send you timely reminders.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[700], height: 1.5),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildSuccessRow(Icons.calendar_month,
                              "8 Deadlines Tracked", "Next: VAT Filing - Dec 15"),
                          const SizedBox(height: 12),
                          _buildSuccessRow(Icons.notifications_active,
                              "Smart Reminders Enabled", "You’ll get notified ahead of time"),
                          const SizedBox(height: 12),
                          _buildSuccessRow(Icons.chat_bubble_outline,
                              "AI Tax Assistant Ready", "Ask questions about your obligations"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          final box = GetStorage();
                          box.write('hasCompletedOnboarding', true); // 👈 mark onboarding done

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const MainAppScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Go to my dashboard",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _currentStep = 0;
                        });
                        _setupController.setStep(_currentStep);
                      },
                      child: Text(
                        "Review my setup",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- UI Helpers ---

  Widget _buildHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF184E56))),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(color: Colors.grey[600], fontSize: 13, height: 1.4),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: Color(0xFF184E56),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _cardBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _cardBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _selectedBorderColor, width: 1.5),
      ),
    );
  }

  Widget _buildInfoBox({
    required IconData icon,
    required String title,
    required String text,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: _primaryColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({
    required bool isSelected,
    required VoidCallback onTap,
    required String title,
    String? badgeText,
    required Widget content,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? _selectedBorderColor : _cardBorderColor,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: _selectedBorderColor.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                        isSelected
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: isSelected
                            ? _selectedBorderColor
                            : Colors.grey[300]),
                    const SizedBox(width: 12),
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                if (badgeText != null && isSelected)
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                        color: _selectedBorderColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(badgeText,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: _primaryColor,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.grey[700], fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    String? footer,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? _selectedBorderColor : _cardBorderColor,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? _selectedBorderColor.withOpacity(0.08)
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? _selectedBorderColor : Colors.grey[500],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: isSelected ? _selectedBorderColor : Colors.grey[400],
                ),
              ],
            ),
            if (footer != null) ...[
              const SizedBox(height: 12),
              Text(
                footer,
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildRadioBtn(String label, bool value) {
    final selected = _pensionContributions == value;
    return GestureDetector(
      onTap: () => setState(() => _pensionContributions = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? _selectedBorderColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? _selectedBorderColor : _cardBorderColor,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : Colors.grey[700],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard({
    required String title,
    required String subtitle,
    required String trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[700], fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(trailing,
                  style: TextStyle(color: Colors.grey[600], fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: _infoBgColor, borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: _primaryColor),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
      ],
    );
  }
}

