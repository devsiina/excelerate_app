import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtl;
  late final TextEditingController _titleCtl;
  late final TextEditingController _emailCtl;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _nameCtl = TextEditingController(text: userProvider.name);
    _titleCtl = TextEditingController(text: userProvider.title);
    _emailCtl = TextEditingController(text: userProvider.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xFFFFC857),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameCtl,
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _titleCtl,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailCtl,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Please enter email';
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(v)) return 'Enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final userProvider = Provider.of<UserProvider>(context, listen: false);
                    userProvider.updateProfile(
                      name: _nameCtl.text,
                      title: _titleCtl.text,
                      email: _emailCtl.text,
                    ).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile updated successfully'))
                      );
                      Navigator.pop(context);
                    });
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFC857)),
                child: const Text('Save', style: TextStyle(color: Colors.black)),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameCtl.dispose();
    _titleCtl.dispose();
    _emailCtl.dispose();
    super.dispose();
  }
}
