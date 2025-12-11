// lib/screens/home_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show TabController, TabBarView;
import 'package:cupertino_native/cupertino_native.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    // The tab bar has 4 items, so the controller length is 4.
    _controller = TabController(length: 4, vsync: this);

    // Listener to update the internal state and sync with CNTabBar's currentIndex
    _controller.addListener(() {
      final i = _controller.index;
      if (i != _index) setState(() => _index = i);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // A simple black placeholder widget for the tab content
  Widget _placeholderTab({required String label}) {
    return Container(
      color: CupertinoColors.black, // Explicitly black background
      child: Center(
        child: Text(
          'Tab: $label',
          style: const TextStyle(color: CupertinoColors.white, fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // CupertinoPageScaffold provides the basic iOS page structure
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        // Title for the navigation bar
        middle: Text('HiAnime'),
        backgroundColor: CupertinoColors.black, // Darken the nav bar
      ),
      // Use Stack to layer the content (TabBarView) and the native tab bar (CNTabBar)
      child: Stack(
        children: [
          // 1. Content View (TabBarView) - fills the entire available space
          Positioned.fill(
            child: TabBarView(
              controller: _controller,
              children: [
                _placeholderTab(label: 'Home'), // Tab 0
                _placeholderTab(label: 'A-Z'), // Tab 1
                _placeholderTab(label: 'Schedule'), // Tab 2
                _placeholderTab(
                  label: 'Search',
                ), // Tab 3 (using the magnifyingglass icon)
              ],
            ),
          ),

          // 2. Native Tab Bar Overlay (CNTabBar) - aligned to the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: CNTabBar(
              items: const [
                // Tab 0: Home
                CNTabBarItem(label: 'Home', icon: CNSymbol('house.fill')),
                // Tab 1: A-Z
                CNTabBarItem(label: 'A-Z', icon: CNSymbol('list.bullet')),
                // Tab 2: Schedule
                CNTabBarItem(label: 'Schedule', icon: CNSymbol('calendar')),
                // Tab 3: Search (no label, just icon)
                CNTabBarItem(icon: CNSymbol('magnifyingglass')),
              ],
              currentIndex: _index, // Currently selected tab index
              split:
                  true, // Setting 'split' and 'rightCount' for the visual effect
              rightCount: 1, // The last item (Search) is on the right side
              shrinkCentered: true, // Centers the middle items
              onTap: (i) {
                // Update state and animate the TabBarView when an item is tapped
                setState(() => _index = i);
                _controller.animateTo(i);
              },
            ),
          ),
        ],
      ),
    );
  }
}
