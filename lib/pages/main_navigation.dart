import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/navigation_service.dart';
import 'homepage.dart';
import 'my_learning.dart';
import 'notifications_page.dart';
import 'profile.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  static final List<Widget> _pages = <Widget>[
    const HomePage(),
    const MyLearningPage(),
    const NotificationsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavigationService(),
      child: Consumer<NavigationService>(
        builder: (context, navigationService, _) {
          return Scaffold(
            extendBody: true,
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: _pages[navigationService.selectedIndex],
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Material(
                  elevation: 8,
                  color: Colors.transparent,
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    elevation: 0,
                    currentIndex: navigationService.selectedIndex,
                    onTap: navigationService.setIndex,
                    selectedItemColor: const Color(0xFFFFC857),
                    unselectedItemColor: Colors.grey,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined),
                        activeIcon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.menu_book_outlined),
                        activeIcon: Icon(Icons.menu_book),
                        label: 'My Learning',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.notifications_outlined),
                        activeIcon: Icon(Icons.notifications),
                        label: 'Notifications',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person_outline),
                        activeIcon: Icon(Icons.person),
                        label: 'Profile',
                      ),
                    ],
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
