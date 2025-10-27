import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/program_provider.dart';
import 'program_home.dart'; // Make sure to import ProgramHome

class SearchResultsPage extends StatelessWidget {
  final String query;

  const SearchResultsPage({super.key, this.query = ''});

  static Route<void> route(String query) {
    return MaterialPageRoute(
      builder: (context) => SearchResultsPage(query: query),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ModalRoute.of(context)?.settings.arguments as String? ?? query;
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results: "$searchQuery"'),
        backgroundColor: const Color(0xFFFFC857),
      ),
      body: Consumer<ProgramProvider>(
        builder: (context, provider, _) {
          return provider.searchPrograms(searchQuery).when(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            failure: (error) => Center(
              child: Text('Error loading programs: $error'),
            ),
            success: (results) {
              if (results.isEmpty) {
                return const Center(
                  child: Text('No programs found matching your search.'),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final program = results[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          program.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported),
                          ),
                        ),
                      ),
                      title: Text(
                        program.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(program.instructor),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber[700], size: 16),
                              const SizedBox(width: 4),
                              Text(program.rating.toString()),
                              const SizedBox(width: 8),
                              Text('• ${program.students} students'),
                            ],
                          ),
                        ],
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProgramHome(), // ✅ Fixed
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}