import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/chatbot_controller.dart';

class TaxMateScreen extends StatelessWidget {
  const TaxMateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatbotController>();
    final TextEditingController inputController = TextEditingController();

    // Define exact colors from the screenshot
    final Color primaryTeal = const Color(0xFF539E95); // The main teal color
    final Color darkText = const Color(0xFF1B2C40); // Dark blue/black text
    final Color secondaryText = const Color(0xFF6B7280); // Grey description text
    final Color backgroundColor = const Color(0xFFF1F8F9); // Light blueish background
    final Color cardBorderColor = const Color(0xFFE0EBEB); // Light border for cards

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable Content Area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    // 1. Robot Avatar
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: primaryTeal,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: primaryTeal.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.smart_toy_outlined, // Closest match to the robot
                        color: Colors.white,
                        size: 48,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 2. Welcome Title
                    Text(
                      'Welcome to TaxMate AI',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: darkText,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Inter', // Assuming a standard sans-serif
                      ),
                    ),

                    const SizedBox(height: 12),

                    // 3. Subtitle
                    Text(
                      'Ask about VAT, PAYE, WHT, penalties,\nor filing dates. I\'m here to help!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: secondaryText,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // 4. "Suggested Questions" Header
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Suggested Questions',
                        style: TextStyle(
                          color: darkText,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 5. Suggestions List
                    _SuggestionCard(
                      icon: Icons.description_outlined,
                      title: 'Explain Category A vs B',
                      subtitle: 'Learn about business classifications',
                      accentColor: primaryTeal,
                      borderColor: cardBorderColor,
                    ),
                    const SizedBox(height: 12),
                    _SuggestionCard(
                      icon: Icons.calendar_today_outlined,
                      title: 'When is my next VAT deadline?',
                      subtitle: 'Get personalized deadline reminders',
                      accentColor: primaryTeal,
                      borderColor: cardBorderColor,
                    ),
                    const SizedBox(height: 12),
                    _SuggestionCard(
                      icon: Icons.calculate_outlined,
                      title: 'How do I calculate PAYE?',
                      subtitle: 'Understand payroll tax calculations',
                      accentColor: primaryTeal,
                      borderColor: cardBorderColor,
                    ),
                    const SizedBox(height: 12),
                    _SuggestionCard(
                      icon: Icons.warning_amber_rounded,
                      title: 'What are late filing penalties?',
                      subtitle: 'Learn about compliance requirements',
                      accentColor: primaryTeal,
                      borderColor: cardBorderColor,
                    ),
                  ],
                ),
              ),
            ),

            // 6. Bottom Input Area
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade100)),
              ),
              child: Row(
                children: [
                  // Attachment Button
                  const _CircleButton(
                    icon: Icons.attach_file,
                    color: Color(0xFFEEF5F5),
                    iconColor: Color(0xFF5A7575),
                  ),

                  const SizedBox(width: 12),

                  // Text Input Field
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF5F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        controller: inputController,
                        decoration: const InputDecoration(
                          hintText: 'Type your question...',
                          hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onSubmitted: (value) {
                          controller.sendMessage(value);
                          inputController.clear();
                        },
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Mic Button
                  const _CircleButton(
                    icon: Icons.mic_none,
                    color: Color(0xFFEEF5F5),
                    iconColor: Color(0xFF5A7575),
                  ),

                  const SizedBox(width: 12),

                  // Send Button
                  _CircleButton(
                    icon: Icons.send_rounded,
                    color: primaryTeal,
                    iconColor: Colors.white,
                    onTap: () {
                      controller.sendMessage(inputController.text);
                      inputController.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Helper Widgets ---

class _SuggestionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accentColor;
  final Color borderColor;

  const _SuggestionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon Container
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: accentColor, size: 24),
          ),
          const SizedBox(width: 16),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Color(0xFF1B2C40),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color iconColor;
  final VoidCallback? onTap;

  const _CircleButton({
    required this.icon,
    required this.color,
    required this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
    );
  }
}