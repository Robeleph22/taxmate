import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxmate/intro/Dashboard/ai_chatbot.dart';
import 'controllers/calendar_controller.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CalendarController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const TaxMateScreen());
        },
        backgroundColor: const Color(0xFF184E56),
        child: Image.asset('assets/Img/img.png', width: 35, height: 35),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF184E56),
        elevation: 0,
        title: const Text(
          "Tax Calendar",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.white)),
        ],
      ),
      body: Obx(() {
        final state = controller.state.value;

        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.isError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, color: Colors.redAccent, size: 32),
                  const SizedBox(height: 12),
                  Text(
                    state.message ?? 'Something went wrong',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Color(0xFF184E56)),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.refreshData,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        if (state.isEmpty || state.data == null) {
          return const Center(
            child: Text(
              'No deadlines for this month',
              style: TextStyle(color: Color(0xFF184E56)),
            ),
          );
        }

        final data = state.data!;

        return Column(
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
                      IconButton(
                        onPressed: controller.goToPreviousMonth,
                        icon: const Icon(Icons.chevron_left, color: Colors.white70),
                      ),
                      Text(
                        data.monthLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        onPressed: controller.goToNextMonth,
                        icon: const Icon(Icons.chevron_right, color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        // Weekdays
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            'Sun',
                            'Mon',
                            'Tue',
                            'Wed',
                            'Thu',
                            'Fri',
                            'Sat',
                          ]
                              .map(
                                (e) => Text(
                                  e,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF184E56),
                                  ),
                                ),
                              )
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
                          itemCount: data.daysInMonth,
                          itemBuilder: (context, index) {
                            final day = index + 1;
                            final isToday = day == data.today;
                            final isDue = data.dueDays.contains(day);

                            return Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: isToday
                                    ? Border.all(color: const Color(0xFF184E56), width: 1.5)
                                    : (isDue
                                        ? Border.all(
                                            color: day == 7 ? Colors.teal : Colors.orange,
                                            width: 1.5,
                                          )
                                        : null),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '$day',
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
                            _buildLegendDot(Colors.teal, 'Filed'),
                            _buildLegendDot(Colors.orange, 'Due Soon'),
                            _buildLegendDot(Colors.red, 'Overdue'),
                          ],
                        ),
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
                  const Text(
                    'Deadlines This Month',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF184E56),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...data.tasks.map(
                    (task) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: _buildCalendarTask(
                        task.day,
                        task.title,
                        task.subtitle,
                        task.status,
                        task.day == '7' ? Colors.teal : Colors.orange,
                        task.day == '7',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
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