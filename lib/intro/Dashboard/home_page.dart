import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import 'deadline_detail_page.dart';
import 'controllers/home_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.chatbot);
        },
        backgroundColor: const Color(0xFF184E56),
        child: Image.asset('assets/Img/img.png', width: 35, height: 35),
      ),
      body: Obx(() {
        final state = controller.state.value;

        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.isError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.message ?? 'Something went wrong'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: controller.refreshData,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state.isEmpty || state.data == null) {
          return const Center(child: Text('No dashboard data'));
        }

        final data = state.data!;

        return SingleChildScrollView(
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
                          children: [
                            const Text(
                              "Welcome back,",
                              style: TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              data.businessName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.notifications, color: Colors.white),
                              onPressed: () {
                                Get.toNamed(AppRoutes.notifications);
                              },
                            ),
                            if (data.unreadNotifications > 0)
                              Positioned(
                                right: 8,
                                top: 8,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Next Deadline Card (static content for now)
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
                              const Text(
                                "NEXT DEADLINE",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  "Due in 5 days",
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "VAT Return Filing",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Monthly VAT return for Tir 2016",
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  color: Colors.white70, size: 14),
                              const SizedBox(width: 6),
                              const Text(
                                "Tir 30, 2016 (Feb 6)",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  Get.to(() => const DeadlineDetailsScreen());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF184E56),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 0,
                                  ),
                                  minimumSize: const Size(0, 36),
                                ),
                                child: const Text(
                                  "View Details",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
                      children: const [
                        Text(
                          "Quick Stats",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF184E56),
                          ),
                        ),
                        Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            "Filed on Time",
                            data.stats.filedOnTime.toString(),
                            "+2 this week",
                            Colors.teal,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            "Upcoming",
                            data.stats.upcoming.toString(),
                            "This month",
                            Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            "Overdue",
                            data.stats.overdue.toString(),
                            "Action Needed",
                            Colors.red,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            "Compliance",
                            "${data.stats.compliancePercent}%",
                            "All time",
                            Colors.blue,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // This Month's Deadlines (kept static for now)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "This Month's Deadlines",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF184E56),
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFF184E56),
                        ),
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
                            decoration: BoxDecoration(
                              color: const Color(0xFF184E56),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child:
                                const Icon(Icons.school, color: Colors.white),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tax Filing Resources",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(0xFF184E56),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Access guides, forms, and tutorials to help you file correctly.",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Browse Resources ->",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF184E56),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                    const Text(
                      "Recent Activity",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF184E56),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildActivityRow(
                      "VAT Return Filed",
                      "Tahsas 2016 • Filed on time",
                      "2 days ago",
                      Colors.green,
                    ),
                    _buildActivityRow(
                      "Payroll Tax Paid",
                      "Tahsas 2016 • Filed on time",
                      "5 days ago",
                      Colors.green,
                    ),
                    _buildActivityRow(
                      "Reminder Sent",
                      "VAT Return due in 7 days",
                      "7 days ago",
                      Colors.blueGrey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
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