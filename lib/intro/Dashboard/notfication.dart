import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import 'controllers/notification_controller.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.chatbot);
        },
        backgroundColor: const Color(0xFF184E56),
        child: Image.asset('assets/Img/img.png', width: 35, height: 35),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF184E56), Color(0xFF184E56)],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 12), // Adjust for status bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Notifications",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: controller.markAllRead,
                          child: const Text(
                            "Mark all read",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
            ),
          ),
          Expanded(
            child: Obx(() {
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
                return const Center(
                  child: Text(
                    "You're all caught up!",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                );
              }

              final items = state.data!;

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final n = items[index];

                  if (n.id == '1') {
                    return _buildNotifCard(
                      icon: Icons.notifications_active,
                      iconBg: Colors.orange[50]!,
                      iconColor: Colors.orange,
                      title: n.title,
                      time: n.timeAgo,
                      body: n.body,
                      action: "View Details",
                      borderColor: Colors.orange,
                      isRead: n.read,
                    );
                  } else if (n.id == '2') {
                    return _buildNotifCard(
                      icon: Icons.check_circle,
                      iconBg: Colors.teal[50]!,
                      iconColor: Colors.teal,
                      title: n.title,
                      time: n.timeAgo,
                      body: n.body,
                      action: "View Receipt",
                      borderColor: Colors.teal,
                      isRead: n.read,
                    );
                  } else if (n.id == '3') {
                    return _buildNotifCard(
                      icon: Icons.info,
                      iconBg: Colors.blue[50]!,
                      iconColor: Colors.blue,
                      title: n.title,
                      time: n.timeAgo,
                      body: n.body,
                      action: "Read More",
                      borderColor: Colors.blue,
                      isRead: n.read,
                    );
                  }

                  return _buildNotifCard(
                    icon: Icons.calendar_month,
                    iconBg: Colors.grey[100]!,
                    iconColor: Colors.grey,
                    title: n.title,
                    time: n.timeAgo,
                    body: n.body,
                    action: "",
                    borderColor: Colors.transparent,
                    isRead: n.read,
                  );
                },
              );
            }),
          ),
        ],
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

  Widget _buildNotifCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String time,
    required String body,
    required String action,
    required Color borderColor,
    bool isRead = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: borderColor, width: 4)),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5),
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
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
                    child: Icon(icon, color: iconColor, size: 16),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: isRead ? Colors.grey : const Color(0xFF184E56),
                    ),
                  ),
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
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                if (action.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    action,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}