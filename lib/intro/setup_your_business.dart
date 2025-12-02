import 'package:flutter/material.dart';

class BusinessSetupScreen extends StatefulWidget {
  const BusinessSetupScreen({Key? key}) : super(key: key);

  @override
  State<BusinessSetupScreen> createState() => _BusinessSetupScreenState();
}

class _BusinessSetupScreenState extends State<BusinessSetupScreen> {
  // State variables for the toggles
  bool _isVatRegistered = true;
  bool _hasEmployees = true;
  bool _isWithholdingAgent = false;

  // State variable for dropdown
  String _fiscalYearEnd = "Hamle 30 (July 7)";

  // Colors based on your design system
  final Color _primaryColor = const Color(0xFF2B7A78); // Teal Green
  final Color _lightTealBackground = const Color(0xFFE0F2F1); // Light Mint
  final Color _textColor = const Color(0xFF172B4D); // Dark Blue/Grey
  final Color _subtitleColor = const Color(0xFF7A869A); // Grey

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: _textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Text(
                "Setup Your Business",
                style: TextStyle(
                  color: _textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Help us customize your tax calendar",
                style: TextStyle(
                  color: _subtitleColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),

              // VAT Registered Card
              _buildToggleCard(
                title: "VAT Registered",
                subtitle: "Value Added Tax",
                description: "If registered, you'll need to file monthly VAT returns by the 30th of each month.",
                icon: Icons.receipt_long_rounded,
                value: _isVatRegistered,
                onChanged: (val) => setState(() => _isVatRegistered = val),
              ),

              const SizedBox(height: 16),

              // Have Employees Card
              _buildToggleCard(
                title: "Have Employees",
                subtitle: "Payroll tax obligations",
                description: "Employee income tax and pension contributions due by the 30th of each month.",
                icon: Icons.groups_rounded,
                value: _hasEmployees,
                onChanged: (val) => setState(() => _hasEmployees = val),
              ),

              const SizedBox(height: 16),

              // Withholding Agent Card
              _buildToggleCard(
                title: "Withholding Agent",
                subtitle: "WHT obligations",
                description: "Withholding tax returns due by the 30th of each month for payments to suppliers and contractors.",
                icon: Icons.front_hand_rounded, // Hand icon
                value: _isWithholdingAgent,
                onChanged: (val) => setState(() => _isWithholdingAgent = val),
              ),

              const SizedBox(height: 16),

              // Fiscal Year End Dropdown Card
              _buildDropdownCard(),

              const SizedBox(height: 24),

              // Pro Tip Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _lightTealBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _primaryColor.withOpacity(0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.lightbulb_outline, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pro Tip",
                            style: TextStyle(
                              color: _textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Based on your selections, we'll create a personalized calendar with all relevant deadlines and send smart reminders 7 days, 3 days, and 1 day before each due date.",
                            style: TextStyle(
                              color: _textColor.withOpacity(0.8),
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Finish Setup Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle finish setup action
                    print("Setup Finished");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Finish Setup",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Save and Continue Later Link
              Center(
                child: TextButton(
                  onPressed: () {
                    // Handle save and continue later
                  },
                  child: Text(
                    "Save and Continue Later",
                    style: TextStyle(
                      color: _subtitleColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleCard({
    required String title,
    required String subtitle,
    required String description,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _lightTealBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: _primaryColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: _textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: _subtitleColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: _primaryColor,
                activeTrackColor: _primaryColor.withOpacity(0.4),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              color: _subtitleColor,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100, // Slightly different styling as per screenshot
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.calendar_month, color: _textColor, size: 24),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fiscal Year End",
                    style: TextStyle(
                      color: _textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Annual tax return deadline",
                    style: TextStyle(
                      color: _subtitleColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Dropdown Field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _fiscalYearEnd,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down, color: _textColor),
                items: ["Hamle 30 (July 7)", "Tahsas 30 (January 8)", "Miazia 30 (May 8)"]
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: _textColor, fontWeight: FontWeight.w500),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _fiscalYearEnd = newValue!;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 12),
          Text(
            "Your annual income tax return is due 4 months after your fiscal year ends.",
            style: TextStyle(
              color: _subtitleColor,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}