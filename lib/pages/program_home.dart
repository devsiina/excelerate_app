import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/program_provider.dart';
import '../models/program_model.dart';
import '../utils/result.dart'; // Import from the same location as repositories

class ProgramHome extends StatefulWidget {
  const ProgramHome({super.key});
  @override
  State<ProgramHome> createState() => _ProgramHomeState();
}

class _ProgramHomeState extends State<ProgramHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _courseCard(BuildContext context, Program program) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            image: program.imageUrl.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(program.imageUrl),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: program.imageUrl.isEmpty
              ? const Icon(Icons.play_circle_fill, color: Colors.deepPurple, size: 36)
              : null,
        ),
        title: Text(program.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${program.instructor} • ${program.rating} ⭐ • ${program.students}'),
        trailing: ElevatedButton(
          onPressed: () => _enrollInProgram(context, program),
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFC857)),
          child: const Text('Enroll', style: TextStyle(color: Colors.black87)),
        ),
        onTap: () => _showProgramDetails(context, program),
      ),
    );
  }

  void _showProgramDetails(BuildContext context, Program program) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(program.title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (program.imageUrl.isNotEmpty)
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(program.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              Text('Instructor: ${program.instructor}'),
              Text('Duration: ${program.duration}'),
              Text('Level: ${program.level}'),
              Text('Rating: ${program.rating} ⭐'),
              Text('Students: ${program.students}'),
              const SizedBox(height: 10),
              Text(
                program.description,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _enrollInProgram(context, program);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFC857)),
            child: const Text('Enroll Now', style: TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  Future<void> _enrollInProgram(BuildContext context, Program program) async {
    final programProvider = Provider.of<ProgramProvider>(context, listen: false);
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(color: Color(0xFFFFC857)),
            SizedBox(width: 16),
            Text('Enrolling...'),
          ],
        ),
      ),
    );

    try {
      await programProvider.enrollInProgram(program.id);
      
      if (mounted) Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully enrolled in ${program.title}'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (mounted) Navigator.pop(context);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to enroll: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgramProvider>(
      builder: (context, programProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('All Programs'),
            backgroundColor: const Color(0xFFFFC857),
          ),
          body: Column(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: const Color(0xFFFFC857),
                indicatorWeight: 3,
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Beginner'),
                  Tab(text: 'Intermediate'),
                  Tab(text: 'Advanced'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildResultList(programProvider.getProgramsByLevel('All')),
                    _buildResultList(programProvider.getProgramsByLevel('Beginner')),
                    _buildResultList(programProvider.getProgramsByLevel('Intermediate')),
                    _buildResultList(programProvider.getProgramsByLevel('Advanced')),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgramList(List<Program> programs) {
    if (programs.isEmpty) {
      return const Center(
        child: Text('No programs found for this level'),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      children: programs.map((program) => _courseCard(context, program)).toList(),
    );
  }

  // Fixed method - use the pattern that matches your Result class
  Widget _buildResultList(Result<List<Program>> result) {
    if (result.isSuccess) {
      final programs = result.data!;
      if (programs.isEmpty) {
        return const Center(child: Text('No programs found for this level'));
      }
      return _buildProgramList(programs);
    } else {
      return Center(child: Text('Error: ${result.error}'));
    }
  }
}