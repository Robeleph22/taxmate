import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Settings", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF184E56))),
                  CircleAvatar(backgroundColor: Colors.grey[300], radius: 14, child: const Icon(Icons.help_outline, size: 18, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 24),
              // Profile Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF327680), Color(0xFF184E56)]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.business, color: Color(0xFF184E56)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Abebe Enterprises", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          SizedBox(height: 4),
                          Text("TIN: 0012345678", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit, color: Colors.white70)),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              _buildSectionTitle("Business Profile"),
              _buildSettingTile(Icons.domain, "Business Name", "Abebe Enterprises PLC", hasArrow: true),
              _buildSettingTile(Icons.badge, "Tax Identification Number", "0012345678", hasArrow: true),
              _buildSettingTile(Icons.location_on, "Business Location", "Addis Ababa, Bole", hasArrow: true),

              const SizedBox(height: 24),
              _buildSectionTitle("Tax Configuration"),
              _buildSwitchTile(Icons.receipt_long, "VAT Registered", "Value Added Tax", true),
              _buildSwitchTile(Icons.groups, "Have Employees", "Payroll obligations", true),
              _buildSwitchTile(Icons.monetization_on, "Withholding Agent", "WHT obligations", false),
              _buildSettingTile(Icons.calendar_today, "Fiscal Year End", "Hamle 30 (July 7)", hasArrow: true, isTrailingIconDown: true),

              const SizedBox(height: 24),
              _buildSectionTitle("Notifications"),
              _buildSwitchTile(Icons.notifications_active, "Push Notifications", "Deadline reminders", true),
              _buildSwitchTile(Icons.email, "Email Reminders", "Weekly summaries", true),
              _buildSettingTile(Icons.access_time, "Reminder Schedule", "7, 3, and 1 day before", hasArrow: true),

              const SizedBox(height: 24),
              _buildSectionTitle("Support & Resources"),
              _buildSettingTile(Icons.book, "Tax Filing Guide", "", hasArrow: true),
              _buildSettingTile(Icons.headset_mic, "Contact Support", "", hasArrow: true),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    // Sign out logic
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Colors.red[200]!),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Sign Out", style: TextStyle(color: Colors.red)),
                ),
              ),
              const SizedBox(height: 24),
              const Center(child: Text("Ethiopian Tax Reminder v1.0.0", style: TextStyle(color: Colors.grey, fontSize: 10))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF184E56))),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, String subtitle, {bool hasArrow = false, bool isTrailingIconDown = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF184E56)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF184E56))),
                if (subtitle.isNotEmpty)
                  Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          if (hasArrow) Icon(isTrailingIconDown ? Icons.keyboard_arrow_down : Icons.chevron_right, color: Colors.grey[400], size: 20),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, String subtitle, bool value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFFF5F7F9), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 18, color: const Color(0xFF184E56)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF184E56))),
                Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: (v) {},
            activeColor: const Color(0xFF184E56),
          ),
        ],
      ),
    );
  }
}