import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_booking/features/urban/presentation/views/bottom_bar/menu_screen.dart';
import 'package:movie_booking/features/urban/presentation/views/bottom_bar/random_screen.dart';
import 'package:movie_booking/features/urban/presentation/views/bottom_bar/search_screen.dart';

class SkeletonScreen extends StatefulWidget {
  const SkeletonScreen({super.key});

  @override
  State<SkeletonScreen> createState() => _SkeletonScreenState();
}

class _SkeletonScreenState extends State<SkeletonScreen> {
  final _pageConntroller = PageController();

  final List<Widget> _bottomBarViews = [
    const SearchScreen(),
    const RandomScreen(),
    const MenuScreen(),
  ];

  final List<IconData> _icons = [
    Icons.search,
    Icons.settings,
  ];

  int _bottomNavIndex = 0;

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageConntroller,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: _bottomBarViews,
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pageConntroller.animateToPage(1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        },
        child: const Icon(Icons.shuffle),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: _icons.length,
        tabBuilder: (int index, bool isActive) => Icon(
          _icons[index],
          size: 24,
          color: isActive ? Colors.black : Colors.white,
        ),
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) {
          _pageConntroller.animateToPage((index == 1) ? 2 : index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        },
        //other params
      ),
    );
  }
}
