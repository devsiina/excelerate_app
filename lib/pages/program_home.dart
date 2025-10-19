import 'package:flutter/material.dart';

class ProgramHome extends StatefulWidget {
  const ProgramHome({super.key});
  @override
  State<ProgramHome> createState() => _ProgramHomeState();
}

class _ProgramHomeState extends State<ProgramHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Map<String, List<Map<String, dynamic>>> courseData = {
    "All": [
      {"title": "Full-Stack Bootcamp", "instructor": "Dr. Angela Yu", "rating": 4.7, "students": "1,503,573"},
      {"title": "Angular - Complete Guide", "instructor": "Maximilian", "rating": 4.7, "students": "839,363"},
      {"title": "React & Next.js Mastery", "instructor": "Jonas", "rating": 4.7, "students": "148,106"},
    ],
    "Beginner": [
      {"title": "Intro to Python", "instructor": "Angela Yu", "rating": 4.8, "students": "120,000"},
      {"title": "HTML & CSS Basics", "instructor": "Jonas", "rating": 4.7, "students": "85,000"},
    ],
    "Intermediate": [
      {"title": "Flutter Bootcamp", "instructor": "Maximilian", "rating": 4.6, "students": "97,000"},
      {"title": "Modern JavaScript (ES6+)", "instructor": "Brad Traversy", "rating": 4.7, "students": "110,000"},
    ],
    "Advanced": [
      {"title": "Advanced ML with TensorFlow", "instructor": "Andrew Ng", "rating": 4.9, "students": "200,000"},
      {"title": "Scalable Node.js Architecture", "instructor": "Colt Steele", "rating": 4.8, "students": "140,000"},
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  Widget _courseCard(Map<String, dynamic> course) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(width: 64, height: 64, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.play_circle_fill, color: Colors.deepPurple, size: 36)),
        title: Text(course['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${course['instructor']} • ${course['rating']} ⭐ • ${course['students']}'),
        trailing: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFC857)), child: const Text('Enroll', style: TextStyle(color: Colors.black87))),
        onTap: () {
          // navigate to details page when ready
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFFAF0E6), Color(0xFFF5F7FF)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: SafeArea(
          child: Column(children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12), child: Row(children: [
              const CircleAvatar(radius: 26, backgroundColor: Colors.deepPurple, child: Icon(Icons.person, color: Colors.white)),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Moshe Yagami', style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(height: 4), Text('TempleOS evangelist', style: TextStyle(color: Colors.black54))]),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle_outline)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
            ])),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: TextField(decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: 'Search for a programming language...', filled: true, fillColor: Colors.white, contentPadding: const EdgeInsets.symmetric(vertical: 14), border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none)))),
            const SizedBox(height: 10),
            TabBar(controller: _tabController, labelColor: Colors.black, unselectedLabelColor: Colors.grey, indicatorColor: const Color(0xFFFFC857), indicatorWeight: 3, tabs: const [Tab(text: 'All'), Tab(text: 'Beginner'), Tab(text: 'Intermediate'), Tab(text: 'Advanced')]),
            Expanded(child: TabBarView(controller: _tabController, children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12), child: ListView(children: courseData['All']!.map((c) => _courseCard(c)).toList())),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12), child: ListView(children: courseData['Beginner']!.map((c) => _courseCard(c)).toList())),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12), child: ListView(children: courseData['Intermediate']!.map((c) => _courseCard(c)).toList())),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12), child: ListView(children: courseData['Advanced']!.map((c) => _courseCard(c)).toList())),
            ])),
          ]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(type: BottomNavigationBarType.fixed, backgroundColor: Colors.white, selectedItemColor: const Color(0xFFFFC857), unselectedItemColor: Colors.grey, items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: 'My Learning'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Notifications'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ]),
    );
  }
}
