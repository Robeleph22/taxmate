import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxmate/intro/setup_your_business.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  // Define the content for each page based on your screenshots
  final List<OnboardingContent> _contents = [
    OnboardingContent(
      title: "Track Ethiopian Tax\nDeadlines Automatically",
      description:
      "Stay on top of all your tax obligations with\nautomated tracking designed specifically\nfor Ethiopian businesses.",
      icon: Icons.calendar_month_rounded,
      iconColor: const Color(0xFF2B7A78), // Dark Teal
      pageIndex: "1 of 3",
    ),
    OnboardingContent(
      title: "Smart Reminders Before\nEvery Due Date",
      description:
      "Receive timely notifications so you're\nalways prepared. Customize reminder\nfrequency to match your workflow.",
      icon: Icons.notifications_active_rounded,
      iconColor: const Color(0xFFFBC02D), // Gold/Yellow
      pageIndex: "2 of 3",
    ),
    OnboardingContent(
      title: "Customize in Under 1\nMinute",
      description:
      "Answer a few simple questions and we'll\ncreate a personalized tax calendar just for\nyour business.",
      icon: Icons.bolt_rounded,
      iconColor: const Color(0xFF2B7A78), // Dark Teal
      pageIndex: "3 of 3",
    ),
  ];

  // Define colors based on the screenshots
  final Color _primaryColor = const Color(0xFF2B7A78); // Teal Green for buttons
  final Color _circleBackground = const Color(0xFFE0F2F1); // Light Mint
  final Color _textColor = const Color(0xFF172B4D); // Dark Blue/Grey
  final Color _subtitleColor = const Color(0xFF7A869A); // Grey

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _contents.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.to(() =>  BusinessSetupScreen());
    }
  }

  void _onSkip() {
    Get.to(() =>  BusinessSetupScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              // Top Bar: Page Index and Skip Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _contents[_currentPage].pageIndex,
                    style: TextStyle(
                      color: _subtitleColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: _onSkip,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: _primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(flex: 1),

              // Page View Section
              Expanded(
                flex: 8,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _contents.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _buildPageContent(_contents[index]);
                  },
                ),
              ),

              const Spacer(flex: 1),

              // Dot Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _contents.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: _currentPage == index ? 24 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? _primaryColor
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Bottom Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentPage == _contents.length - 1
                        ? "Get Started"
                        : "Next",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageContent(OnboardingContent content) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Circular Icon Background
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _circleBackground,
            boxShadow: [
              BoxShadow(
                color: _circleBackground.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Center(
            child: Icon(
              content.icon,
              size: 80,
              color: content.iconColor,
            ),
          ),
        ),
        const SizedBox(height: 48),

        // Title
        Text(
          content.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _textColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),

        // Description
        Text(
          content.description,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _subtitleColor,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

// Data Model for Onboarding Content
class OnboardingContent {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final String pageIndex;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.pageIndex,
  });
}