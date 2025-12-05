import 'package:flutter/material.dart';

class DeadlineDetailsScreen extends StatelessWidget {
  const DeadlineDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Custom Header Area
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF184E56), Color(0xFF266E78)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  // App Bar Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildHeaderButton(Icons.arrow_back, () => Navigator.pop(context)),
                      const Text(
                        "Deadline Details",
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      _buildHeaderButton(Icons.share, () {}),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: const Icon(Icons.receipt_long, color: Colors.white, size: 32),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "VAT Return Filing",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Monthly Value Added Tax Return",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            // Overlapping Card Content
            Transform.translate(
              offset: const Offset(0, -20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Main White Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Due Date & Time Left Row
                          Row(
                            children: [
                              Expanded(
                                child: _buildStatusBox(
                                  title: "Due Date",
                                  value: "Tir 30, 2016",
                                  subValue: "February 6, 2024",
                                  icon: Icons.calendar_today,
                                  color: Colors.orange,
                                  bgColor: const Color(0xFFFFF8E1),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildStatusBox(
                                  title: "Time Left",
                                  value: "5 Days",
                                  subValue: "120 hours",
                                  icon: Icons.access_time_filled,
                                  color: Colors.red,
                                  bgColor: const Color(0xFFFFEBEE),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // About This Tax
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0F7FA),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF184E56),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Icon(Icons.info, color: Colors.white, size: 16),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "About This Tax",
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF184E56), fontSize: 14),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "VAT registered businesses must file monthly returns by the 30th of each month following the reporting period. The return includes all taxable sales and purchases.",
                                        style: TextStyle(fontSize: 12, color: Colors.grey[700], height: 1.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Key Details
                          _buildDetailRow(Icons.account_balance, "Tax Authority:", "Ministry of Revenue"),
                          _buildDetailRow(Icons.description, "Form Required:", "VAT Return Form"),
                          _buildDetailRow(Icons.money_off, "Penalty for Late:", "5% + 1% per month"),
                          _buildDetailRow(Icons.refresh, "Frequency:", "Monthly"),

                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Divider(),
                          ),

                          // Required Documents
                          const Text(
                            "Required Documents",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF184E56)),
                          ),
                          const SizedBox(height: 12),
                          _buildCheckItem("Sales invoices for the period"),
                          _buildCheckItem("Purchase invoices for the period"),
                          _buildCheckItem("VAT calculation worksheet"),
                          _buildCheckItem("Bank payment receipt (if applicable)"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Filing Tips Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F2F1), // Light teal
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFB2DFDB)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xFF26A69A),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.lightbulb, color: Colors.white, size: 20),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Filing Tips", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF00695C))),
                                const SizedBox(height: 8),
                                _buildTipItem("Ensure all invoices are properly recorded"),
                                _buildTipItem("Double-check calculations before submission"),
                                _buildTipItem("Keep copies of all supporting documents"),
                                _buildTipItem("File online for faster processing"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Action Buttons
                    _buildActionButton(
                      text: "Mark as Filed",
                      icon: Icons.check_circle,
                      color: const Color(0xFF184E56),
                      textColor: Colors.white,
                      isPrimary: true,
                    ),
                    const SizedBox(height: 12),
                    _buildActionButton(
                      text: "Set Custom Reminder",
                      icon: Icons.notifications_active,
                      color: Colors.white,
                      textColor: const Color(0xFF184E56),
                      isPrimary: false,
                    ),
                    const SizedBox(height: 12),
                    _buildActionButton(
                      text: "Download Form Template",
                      icon: Icons.download,
                      color: Colors.white,
                      textColor: const Color(0xFF184E56),
                      isPrimary: false,
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets for Deadline Details ---

  Widget _buildHeaderButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildStatusBox({required String title, required String value, required String subValue, required IconData icon, required Color color, required Color bgColor}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 11, color: Colors.grey[600], fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 2),
          Text(subValue, style: TextStyle(fontSize: 10, color: Colors.grey[500])),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF26A69A)),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF184E56)), overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, size: 18, color: Color(0xFF26A69A)),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.3))),
        ],
      ),
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check, size: 16, color: Color(0xFF00695C)),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(fontSize: 12, color: Colors.grey[700], height: 1.3))),
        ],
      ),
    );
  }

  Widget _buildActionButton({required String text, required IconData icon, required Color color, required Color textColor, required bool isPrimary}) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: isPrimary ? null : Border.all(color: const Color(0xFF184E56), width: 1.5),
        boxShadow: isPrimary ? [
          BoxShadow(color: const Color(0xFF184E56).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))
        ] : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textColor, size: 20),
          const SizedBox(width: 12),
          Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 15)),
        ],
      ),
    );
  }
}