import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/animated_search_bar.dart';
import 'settings_page.dart';
import '../providers/user_provider.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: const SafeArea(
        child: _HomeContent(),
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

  Widget _recommendedCard(BuildContext context, String title, String instructor, String students, {String? imageUrl}) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: imageUrl != null
                ? Image.network(
                    imageUrl,
                    height: 90,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => _buildGradientPlaceholder(),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return _buildGradientPlaceholder();
                    },
                  )
                : _buildGradientPlaceholder(),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
                const SizedBox(height: 8),
        Text('$instructor • $students students',
          style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, fontSize: 12)),
                const SizedBox(height: 8),
                const Row(children: [
                  Icon(Icons.star, color: Colors.orange, size: 16),
                  SizedBox(width: 6),
                  Text('4.7')
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientPlaceholder() {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(108, 92, 231, 0.8),
            Color.fromRGBO(108, 92, 231, 0.4),
          ],
        ),
      ),
      child: const Center(
        child: Icon(Icons.code, color: Colors.white, size: 32),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                children: [
                  Consumer<UserProvider>(
                    builder: (context, user, _) => CircleAvatar(
                      radius: 26,
                      backgroundColor: isDark ? Colors.grey[800] : Colors.deepPurple,
                      backgroundImage: user.profilePicPath != null
                          ? FileImage(File(user.profilePicPath!))
                          : null,
                      child: user.profilePicPath == null
                          ? const Icon(Icons.person, color: Colors.white)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Moshe Yagami', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.titleMedium?.color)),
                      const SizedBox(height: 4),
                      Text('TempleOS evangelist', style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color))
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsPage()),
                    ),
                    icon: const Icon(Icons.settings)
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AnimatedSearchBar(
                hintText: 'Search courses, languages...',
                onChanged: (value) {
                  if (value.length >= 3) {
                    Navigator.pushNamed(
                      context,
                      '/search',
                      arguments: value,
                    );
                  }
                },
                onFilterTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Filter Programs',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text('Level'),
                          Wrap(
                            spacing: 8,
                            children: [
                              'Beginner',
                              'Intermediate',
                              'Advanced',
                            ].map((level) => FilterChip(
                              label: Text(level),
                              onSelected: (selected) {
                               
                                Navigator.pop(context);
                              },
                              selected: false,
                            )).toList(),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                },
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
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _recommendedCard(
                            context,
                            'Full-Stack Bootcamp',
                            'Dr. Angela Yu',
                            '1,503,573',
                            imageUrl: 'https://img-c.udemycdn.com/course/750x422/1565838_e54e_16.jpg',
                          ),
                          _recommendedCard(
                            context,
                            'React Mastery',
                            'Jonas Schmedtmann',
                            '148,106',
                            imageUrl: 'https://img-c.udemycdn.com/course/750x422/2395488_bd78_3.jpg',
                          ),
                          _recommendedCard(
                            context,
                            'Data Science A-Z',
                            'Kirill Eremenko',
                            '420,981',
                            imageUrl: 'https://images.unsplash.com/photo-1531497865143-8b1f32e3a8be?w=400',
                          ),
                          _recommendedCard(
                            context,
                            'UI/UX Design Essentials',
                            'Jonny Ive',
                            '95,204',
                            imageUrl: 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=400',
                          ),
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
                          _categoryCard(context, Icons.bar_chart, 'Data Science', const Color(0xFF0984E3)),
                          _categoryCard(context, Icons.language, 'Languages', const Color(0xFFF368E0)),
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
