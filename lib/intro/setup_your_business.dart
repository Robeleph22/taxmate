import 'package:flutter/material.dart';

import 'main_app_screen.dart';

class TaxSetupWizard extends StatefulWidget {
  const TaxSetupWizard({super.key});

  @override
  State<TaxSetupWizard> createState() => _TaxSetupWizardState();
}

class _TaxSetupWizardState extends State<TaxSetupWizard> {
  int _currentStep = 0;
  final int _totalSteps = 7;

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

  void _nextStep() {
    if (_currentStep < _totalSteps) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
        centerTitle: true,
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
                        _currentStep == _totalSteps - 1 ? "Finish Setup" : "Continue",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_currentStep < _totalSteps - 1)
                    GestureDetector(
                      onTap: _nextStep, // Skip logic could be different
                      child: Text(
                        "Skip for now",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
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
        _buildHeader("Set Up Your Business Profile",
            "Help us understand your business to provide accurate tax reminders"),
        const SizedBox(height: 32),
        _buildLabel("Business Name"),
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
          text: "Different business types have different tax obligations in Ethiopia. This helps us set up the right reminders.",
          bgColor: _infoBgColor,
          iconColor: _primaryColor,
        ),
      ],
    );
  }

  // --- Step 2: Taxpayer Category ---
  Widget _buildStep2Category() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader("Taxpayer Category",
            "Select your taxpayer category as registered with the Ethiopian Ministry of Revenue"),
        const SizedBox(height: 24),
        _buildSelectableCard(
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
        const SizedBox(height: 16),
        _buildSelectableCard(
          isSelected: _selectedCategory == 'B',
          onTap: () => setState(() => _selectedCategory = 'B'),
          title: "Category B",
          content: Text(
            "Medium taxpayers with annual turnover between ETB 1 million and ETB 100 million.",
            style: TextStyle(color: Colors.grey[700], fontSize: 13, height: 1.5),
          ),
        ),
        const SizedBox(height: 24),
        _buildInfoBox(
          icon: Icons.lightbulb_outline,
          title: "Not sure which category?",
          text: "Check your Tax Identification Number (TIN) certificate or contact your local tax office.",
          bgColor: _warningBgColor,
          iconColor: Colors.orange,
        ),
      ],
    );
  }

  // --- Step 3: Annual Turnover ---
  Widget _buildStep3Turnover() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader("Annual Turnover",
            "Provide your estimated annual turnover to help us determine your tax obligations"),
        const SizedBox(height: 32),
        _buildLabel("Estimated Annual Turnover (ETB)"),
        TextField(
          controller: _turnoverController,
          keyboardType: TextInputType.number,
          decoration: _inputDecoration("0.00").copyWith(
            prefixIcon: const Padding(
              padding: EdgeInsets.all(14.0),
              child: Text("ETB", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.info_outline, size: 14, color: _primaryColor),
            const SizedBox(width: 4),
            Text("This is an estimate. You can update it later.",
                style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _infoBgColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Quick Reference:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 12),
              _buildRefRow("Category A (Large)", "> ETB 100M"),
              const SizedBox(height: 8),
              _buildRefRow("Category B (Medium)", "ETB 1M - 100M"),
              const SizedBox(height: 8),
              _buildRefRow("Category C (Small)", "< ETB 1M"),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildInfoBox(
          icon: Icons.shield_outlined,
          title: "Your data is secure",
          text: "We use this information only to calculate your tax deadlines. Your financial data is encrypted.",
          bgColor: Colors.grey[100]!,
          iconColor: _primaryColor,
        ),
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
          icon: Icons.help_outline,
          title: "Need help?",
          text: "If you're unsure about any of these, you can check your tax registration certificate.",
          bgColor: _warningBgColor,
          iconColor: Colors.orange,
        ),
      ],
    );
  }

  // --- Step 5: Fiscal Year ---
  Widget _buildStep5FiscalYear() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader("Fiscal Year End", "When does your business fiscal year end?"),
        const SizedBox(height: 32),
        _buildLabel("Fiscal Year End Date"),
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
          text: "Your fiscal year is the 12-month period used for accounting. Most Ethiopian businesses follow Hamle 30.",
          bgColor: _infoBgColor,
          iconColor: _primaryColor,
        ),
        const SizedBox(height: 16),
        _buildInfoBox(
          icon: Icons.lightbulb_outline,
          title: "Why this matters",
          text: "Your fiscal year end determines when your annual income tax return is due.",
          bgColor: Colors.grey[50]!,
          iconColor: _primaryColor,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _warningBgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange.withOpacity(0.3)),
          ),
          child: Row(
            children: const [
              Icon(Icons.access_time_filled, color: Colors.orange, size: 20),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Annual Income Tax Deadline", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Text("Due 4 months after fiscal year end", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Step 6: Initial Compliance ---
  Widget _buildStep6Compliance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader("Initial Compliance Status", "Help us track your current compliance status"),
        const SizedBox(height: 24),

        // VAT Card
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: _infoBgColor, width: 2),
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundColor: _primaryColor, radius: 14, child: const Icon(Icons.inventory_2, size: 16, color: Colors.white)),
                  const SizedBox(width: 10),
                  const Text("VAT Filing Status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              const SizedBox(height: 16),
              _buildLabel("Last VAT Filing Date"),
              TextField(
                controller: _vatDateController,
                decoration: _inputDecoration("mm/dd/yyyy").copyWith(
                  suffixIcon: const Icon(Icons.calendar_month, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16),
              const Text("When did you last file your VAT return?", style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const Text("Current Status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.green[100], borderRadius: BorderRadius.circular(4)),
                      child: const Text("Up to Date", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Pension Card
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: _infoBgColor, width: 2),
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundColor: _primaryColor, radius: 14, child: const Icon(Icons.groups, size: 16, color: Colors.white)),
                  const SizedBox(width: 10),
                  const Text("Pension Contributions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              const SizedBox(height: 12),
              const Text("Are you currently making pension contributions for your employees?", style: TextStyle(fontSize: 13, color: Colors.grey)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildRadioBtn("Yes", true)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildRadioBtn("No", false)),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: _cardBorderColor),
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
          ),
        ),
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
              Icon(Icons.privacy_tip, color: Colors.orange, size: 20),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Privacy Notice", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    SizedBox(height: 4),
                    Text("This information helps us provide accurate reminders. Your data is kept confidential.", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Step 7: Review ---
  Widget _buildStep7Review() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: Color(0xFF184E56),
          child: Icon(Icons.check, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 16),
        const Text("Review Your Profile", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF184E56))),
        const SizedBox(height: 8),
        Text("Make sure everything looks correct", style: TextStyle(color: Colors.grey[600])),
        const SizedBox(height: 32),

        _buildReviewSection("BUSINESS INFORMATION", [
          _buildReviewRow("Business Name", "Addis Tech Solutions PLC"),
          _buildReviewRow("Business Type", "Private Limited Company"),
        ]),
        const SizedBox(height: 16),
        _buildReviewSection("TAX CATEGORY", [
          _buildReviewRow("Taxpayer Category", "Category A (Large)"),
          _buildReviewRow("Annual Turnover", "ETB 150,000,000"),
        ]),
        const SizedBox(height: 16),
        _buildReviewSection("TAX OBLIGATIONS", [
          Row(children: const [Icon(Icons.check_circle, size: 16, color: Color(0xFF184E56)), SizedBox(width: 8), Text("VAT Registered", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),
          const SizedBox(height: 8),
          Row(children: const [Icon(Icons.check_circle, size: 16, color: Color(0xFF184E56)), SizedBox(width: 8), Text("Has Employees", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),
        ]),
        const SizedBox(height: 16),
        _buildReviewSection("FISCAL YEAR", [
          _buildReviewRow("Year End Date", "Hamle 30 (July 7)"),
        ]),

        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _warningBgColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFFFFCC80),
                child: Icon(Icons.notifications_active, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Your reminders are ready!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.grey[800], fontSize: 12, height: 1.5),
                        children: const [
                          TextSpan(text: "Based on your profile, we've set up "),
                          TextSpan(text: "8 tax deadlines", style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: " with smart reminders to keep you compliant."),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Success Screen ---
  Widget _buildSuccessScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA), // Light teal bg
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xFF184E56),
                      child: Icon(Icons.rocket_launch, color: Colors.white, size: 40),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
                        child: const Icon(Icons.star, color: Colors.white, size: 14),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                const Text("You're All Set!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF184E56))),
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
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))],
                  ),
                  child: Column(
                    children: [
                      _buildSuccessRow(Icons.calendar_month, "8 Deadlines Tracked", "Next: VAT Filing - Dec 15"),
                      const Divider(height: 32),
                      _buildSuccessRow(Icons.info_outline, "Smart Reminders Active", "7, 3, and 1 day alerts"),
                      const Divider(height: 32),
                      _buildSuccessRow(Icons.shield_outlined, "Stay Compliant", "Never miss a deadline again"),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    // In tax_setup_wizard.dart, inside _buildSuccessScreen
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MainAppScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text("Go to Dashboard ->", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 16),
                const Text("Start managing your tax obligations today", style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _primaryColor)),
        const SizedBox(height: 8),
        Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5)),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400]),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _cardBorderColor)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _cardBorderColor)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: _primaryColor, width: 2)),
    );
  }

  Widget _buildInfoBox({required IconData icon, required String title, required String text, required Color bgColor, required Color iconColor}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: bgColor == _warningBgColor ? Colors.orange.withOpacity(0.1) : Colors.transparent),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 4),
                Text(text, style: TextStyle(fontSize: 12, color: Colors.grey[800], height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectableCard({required bool isSelected, required VoidCallback onTap, required String title, String? badgeText, required Widget content}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? _selectedBorderColor : _cardBorderColor, width: isSelected ? 1.5 : 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: isSelected ? _selectedBorderColor : Colors.grey[300]),
                    const SizedBox(width: 12),
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                if (badgeText != null && isSelected)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: _selectedBorderColor, borderRadius: BorderRadius.circular(20)),
                    child: Text(badgeText, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
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
          const Icon(Icons.circle, size: 4, color: Colors.grey),
          const SizedBox(width: 8),
          Text(text, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildCheckboxCard({required String title, required String subtitle, required IconData icon, required bool isSelected, required VoidCallback onTap, required String footer}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? _selectedBorderColor : _cardBorderColor, width: isSelected ? 1.5 : 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: _infoBgColor, borderRadius: BorderRadius.circular(8)),
                  child: Icon(icon, color: _primaryColor, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    ],
                  ),
                ),
                Icon(isSelected ? Icons.check_circle : Icons.circle_outlined, color: isSelected ? _selectedBorderColor : Colors.grey[300]),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_month, size: 12, color: _primaryColor),
                const SizedBox(width: 4),
                Text(footer, style: TextStyle(color: _primaryColor, fontSize: 11, fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRefRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 12)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      ],
    );
  }

  Widget _buildRadioBtn(String label, bool value) {
    bool isSelected = _pensionContributions == value;
    return GestureDetector(
      onTap: () => setState(() => _pensionContributions = value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? _primaryColor : _cardBorderColor),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? _primaryColor.withOpacity(0.05) : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isSelected ? Icons.check_circle : Icons.circle_outlined,
                size: 18, color: isSelected ? _primaryColor : Colors.grey[400]),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? _primaryColor : Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(color: Colors.grey[500], fontSize: 11, fontWeight: FontWeight.bold)),
              const Text("Edit", style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildReviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildSuccessRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
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