import 'package:flutter/material.dart';
import 'my_learning.dart';
import 'notifications_page.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Different tabs
  static final List<Widget> _pages = <Widget>[
    const _HomeContent(),
    const MyLearningPage(),
    const NotificationsPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int i) {
    setState(() => _selectedIndex = i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFFFFC857),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: 'My Learning'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

// The original Home content stays here
class _HomeContent extends StatelessWidget {
  const _HomeContent();

  Widget _categoryCard(BuildContext context, IconData icon, String title, Color bg) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/program'),
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: Colors.white, size: 34),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }

  Widget _progressCard(BuildContext context, String title, double value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: const CircleAvatar(backgroundColor: Color(0xFFF1E7FF), child: Icon(Icons.play_circle_fill, color: Colors.deepPurple)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            LinearProgressIndicator(value: value, color: const Color(0xFFFFC857), backgroundColor: Colors.grey[200]),
            const SizedBox(height: 6),
            Text('${(value * 100).toInt()}% Completed')
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.pushNamed(context, '/program'),
      ),
    );
  }

  Widget _recommendedCard(String title, String instructor, String students) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.all(12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('$instructor • $students students', style: const TextStyle(color: Colors.black54, fontSize: 12)),
        const Spacer(),
        Row(children: const [Icon(Icons.star, color: Colors.orange, size: 16), SizedBox(width: 6), Text('4.7')])
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFFDEBD0), Color(0xFFFFF6E5)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                children: [
                  const CircleAvatar(radius: 26, backgroundColor: Colors.deepPurple, child: Icon(Icons.person, color: Colors.white)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Moshe Yagami', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('TempleOS evangelist', style: TextStyle(color: Colors.black54))
                    ],
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search for a programming language...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none)),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: [
                    const Text('Recommended Programs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _recommendedCard('Full-Stack Bootcamp', 'Dr. Angela Yu', '1,503,573'),
                          _recommendedCard('React Mastery', 'Jonas Schmedtmann', '148,106'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text('Categories', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _categoryCard(context, Icons.code, 'Development', const Color(0xFF6C5CE7)),
                          _categoryCard(context, Icons.palette, 'Design', const Color(0xFF00B894)),
                          _categoryCard(context, Icons.analytics, 'Business', const Color(0xFFFF6B6B)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text('Continue Learning', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    _progressCard(context, 'Flutter for Beginners', 0.1),
                    _progressCard(context, 'Intro to Python', 0.45),
                    _progressCard(context, 'Web Accessibility', 0.8),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
