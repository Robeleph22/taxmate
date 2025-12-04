import 'package:flutter/material.dart';

// --- Main Entry Point with Bottom Navigation ---

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0;

  // The 4 main screens based on the bottom nav
  final List<Widget> _screens = [
    const DashboardScreen(),
    const CalendarScreen(),
    const NotificationsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF184E56),
          unselectedItemColor: Colors.grey[400],
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Calendar"),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Alerts"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Settings"),
          ],
        ),
      ),
    );
  }
}

// --- 1. Dashboard Screen ---

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section with Gradient Look
            Container(
              padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 24),
              decoration: const BoxDecoration(
                color: Color(0xFF184E56),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Welcome back,", style: TextStyle(color: Colors.white70, fontSize: 14)),
                          SizedBox(height: 4),
                          Text("Abebe Enterprises", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Stack(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.notifications, color: Colors.white),
                            onPressed: () {},
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Next Deadline Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("NEXT DEADLINE", style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: Colors.orange.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                              child: const Text("Due in 5 days", style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text("VAT Return Filing", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        const Text("Monthly VAT return for Tir 2016", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, color: Colors.white70, size: 14),
                            const SizedBox(width: 6),
                            const Text("Tir 30, 2016 (Feb 6)", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const DeadlineDetailsScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF184E56),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                minimumSize: const Size(0, 36),
                              ),
                              child: const Text("View Details", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Quick Stats", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF184E56))),
                      const Text("View All", style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildStatCard("Filed on Time", "12", "+2 this week", Colors.teal)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildStatCard("Upcoming", "3", "This month", Colors.orange)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildStatCard("Overdue", "0", "Action Needed", Colors.red)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildStatCard("Compliance", "98%", "All time", Colors.blue)),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // This Month's Deadlines
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("This Month's Deadlines", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF184E56))),
                      Icon(Icons.keyboard_arrow_down, color: Color(0xFF184E56)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildDeadlineCard(
                    title: "VAT Return Filing",
                    subtitle: "Monthly VAT return for Tir 2016",
                    dueDate: "Due Tir 30 (Feb 6)",
                    daysLeft: "5 days left",
                    icon: Icons.receipt_long,
                    color: Colors.orange,
                    isFiled: false,
                  ),
                  const SizedBox(height: 12),
                  _buildDeadlineCard(
                    title: "Payroll Tax Payment",
                    subtitle: "Employee income tax withholding",
                    dueDate: "Due Tir 7 (Jan 10)",
                    daysLeft: "12 days left",
                    icon: Icons.groups,
                    color: Colors.teal,
                    isFiled: false,
                  ),
                  const SizedBox(height: 12),
                  _buildDeadlineCard(
                    title: "Withholding Tax Return",
                    subtitle: "Not applicable - WHT not enabled",
                    dueDate: "Due Tir 15 (Jan 22)",
                    daysLeft: "",
                    icon: Icons.monetization_on,
                    color: Colors.grey,
                    isFiled: false,
                    isDisabled: true,
                  ),

                  const SizedBox(height: 24),

                  // Tax Filing Resources
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F7FA),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: const Color(0xFF184E56), borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.school, color: Colors.white),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Tax Filing Resources", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF184E56))),
                              SizedBox(height: 4),
                              Text("Access guides, forms, and tutorials to help you file correctly.", style: TextStyle(fontSize: 11, color: Colors.black54)),
                              SizedBox(height: 8),
                              Text("Browse Resources ->", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF184E56))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                  const Text("Recent Activity", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF184E56))),
                  const SizedBox(height: 16),
                  _buildActivityRow("VAT Return Filed", "Tahsas 2016 • Filed on time", "2 days ago", Colors.green),
                  _buildActivityRow("Payroll Tax Paid", "Tahsas 2016 • Filed on time", "5 days ago", Colors.green),
                  _buildActivityRow("Reminder Sent", "VAT Return due in 7 days", "7 days ago", Colors.blueGrey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), spreadRadius: 2, blurRadius: 10)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(title == "Overdue" ? Icons.warning_amber : Icons.check_circle_outline, color: color, size: 16),
              const SizedBox(width: 8),
              Text(subtitle, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF184E56))),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildDeadlineCard({required String title, required String subtitle, required String dueDate, required String daysLeft, required IconData icon, required Color color, required bool isFiled, bool isDisabled = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: isDisabled ? Colors.transparent : (isFiled ? Colors.grey[200]! : color.withOpacity(0.3)))),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: isDisabled ? Colors.grey[100] : color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, color: isDisabled ? Colors.grey : color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDisabled ? Colors.grey : const Color(0xFF184E56))),
                    Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
          if (!isDisabled) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                const SizedBox(width: 4),
                Text(dueDate, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                if (daysLeft.isNotEmpty) ...[
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                    child: Text(daysLeft, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF184E56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 0), // Slim button
                  minimumSize: const Size(0, 36),
                ),
                child: const Text("Mark as Filed", style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ),
          ] else ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                const SizedBox(width: 4),
                Text(dueDate, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                const Spacer(),
                const Text("Enable in Settings", style: TextStyle(fontSize: 11, color: Colors.teal, fontWeight: FontWeight.bold)),
              ],
            )
          ]
        ],
      ),
    );
  }

  Widget _buildActivityRow(String title, String subtitle, String time, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(Icons.check, size: 14, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF184E56))),
                  Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
            Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// --- 2. Calendar Screen ---

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF184E56),
        elevation: 0,
        title: const Text("Tax Calendar", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.white))],
      ),
      body: Column(
        children: [
          // Calendar Header & Grid
          Container(
            color: const Color(0xFF184E56),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_left, color: Colors.white70)),
                    const Text("Tir 2016 (January 2024)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_right, color: Colors.white70)),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      // Weekdays
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                            .map((e) => Text(e, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF184E56))))
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                      // Simplified Grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemCount: 31,
                        itemBuilder: (context, index) {
                          int day = index + 1;
                          bool isToday = day == 19;
                          bool isDue = day == 7 || day == 30;

                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isToday ? Colors.transparent : Colors.transparent,
                              border: isToday
                                  ? Border.all(color: const Color(0xFF184E56), width: 1.5)
                                  : (isDue ? Border.all(color: day == 7 ? Colors.teal : Colors.orange, width: 1.5) : null),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "$day",
                              style: TextStyle(
                                color: const Color(0xFF184E56),
                                fontWeight: isToday || isDue ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildLegendDot(Colors.teal, "Filed"),
                          _buildLegendDot(Colors.orange, "Due Soon"),
                          _buildLegendDot(Colors.red, "Overdue"),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text("Deadlines This Month", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF184E56))),
                const SizedBox(height: 16),
                _buildCalendarTask("7", "Payroll Tax", "Employee income tax", "Filed on Tir 7, 2016", Colors.teal, true),
                const SizedBox(height: 12),
                _buildCalendarTask("7", "Pension", "Monthly contribution", "Filed on Tir 7, 2016", Colors.teal, true),
                const SizedBox(height: 12),
                _buildCalendarTask("30", "VAT Return", "Monthly filing", "Due in 5 days", Colors.orange, false),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLegendDot(Color color, String text) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }

  Widget _buildCalendarTask(String day, String title, String subtitle, String status, Color color, bool isDone) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: isDone ? Colors.teal.withOpacity(0.3) : Colors.orange.withOpacity(0.3))),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: const Color(0xFFF5F7F9), borderRadius: BorderRadius.circular(8)),
            child: Text(day, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF184E56))),
                Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                const SizedBox(height: 4),
                Text(status, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
              ],
            ),
          ),
          if (isDone)
            const Icon(Icons.check_circle, color: Colors.teal, size: 20)
          else
            const Icon(Icons.chevron_right, color: Colors.orange, size: 20),
        ],
      ),
    );
  }
}

// --- 3. Notifications Screen ---

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF184E56), Color(0xFF184E56)],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Notifications", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text("Mark all read", style: TextStyle(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _buildFilterChip("All", true),
                      const SizedBox(width: 8),
                      _buildFilterChip("Reminders", false),
                      const SizedBox(width: 8),
                      _buildFilterChip("Updates", false),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildNotifCard(
                    icon: Icons.notifications_active,
                    iconBg: Colors.orange[50]!,
                    iconColor: Colors.orange,
                    title: "VAT Return Due Soon",
                    time: "2h ago",
                    body: "Your VAT return for Tir 2016 is due in 5 days. Make sure you have all required documents ready.",
                    action: "View Details",
                    borderColor: Colors.orange,
                  ),
                  const SizedBox(height: 12),
                  _buildNotifCard(
                    icon: Icons.check_circle,
                    iconBg: Colors.teal[50]!,
                    iconColor: Colors.teal,
                    title: "Filing Confirmed",
                    time: "1d ago",
                    body: "Your payroll tax payment for Tahsas 2016 has been successfully recorded. Great job!",
                    action: "View Receipt",
                    borderColor: Colors.teal,
                  ),
                  const SizedBox(height: 12),
                  _buildNotifCard(
                    icon: Icons.info,
                    iconBg: Colors.blue[50]!,
                    iconColor: Colors.blue,
                    title: "New Tax Regulation",
                    time: "2d ago",
                    body: "The Ministry of Revenue has updated VAT filing guidelines. Review the changes to ensure compliance.",
                    action: "Read More",
                    borderColor: Colors.blue,
                  ),
                  const SizedBox(height: 12),
                  _buildNotifCard(
                    icon: Icons.calendar_month,
                    iconBg: Colors.grey[100]!,
                    iconColor: Colors.grey,
                    title: "Reminder Set",
                    time: "3d ago",
                    body: "You'll receive a reminder 7 days before your next pension contribution deadline.",
                    action: "",
                    borderColor: Colors.transparent,
                    isRead: true,
                  ),
                  const SizedBox(height: 24),
                  const Center(child: Text("You're all caught up!", style: TextStyle(color: Colors.grey, fontSize: 12))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? const Color(0xFF184E56) : Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildNotifCard({required IconData icon, required Color iconBg, required Color iconColor, required String title, required String time, required String body, required String action, required Color borderColor, bool isRead = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: borderColor, width: 4)),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
                    child: Icon(icon, color: iconColor, size: 16),
                  ),
                  const SizedBox(width: 12),
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isRead ? Colors.grey : const Color(0xFF184E56))),
                ],
              ),
              Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 44.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(body, style: TextStyle(fontSize: 12, color: Colors.grey[700], height: 1.5)),
                if (action.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(action, style: const TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold)),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- 4. Settings Screen ---

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

// --- 5. Deadline Details Screen (Updated to match Screenshot) ---

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