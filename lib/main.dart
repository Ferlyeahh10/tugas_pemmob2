import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const SkincareApp());
}

class SkincareApp extends StatelessWidget {
  const SkincareApp({super.key});

  @override
  Widget build(BuildContext context) {
    final turquoise = const Color(0xFF40E0D0);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skincare To-Do App',
      theme: ThemeData(
        primaryColor: turquoise,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.dancingScriptTextTheme(
          Theme.of(context).textTheme,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: turquoise,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ),
      home: const SkincareHomePage(),
    );
  }
}

// Halaman Pertama - To-Do List
class SkincareHomePage extends StatefulWidget {
  const SkincareHomePage({super.key});

  @override
  State<SkincareHomePage> createState() => _SkincareHomePageState();
}

class _SkincareHomePageState extends State<SkincareHomePage> {
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    if (_controller.text.isEmpty) return;
    setState(() {
      _tasks.add({"title": _controller.text, "done": false});
      _controller.clear();
    });
  }

  void _toggleDone(int index) {
    setState(() {
      _tasks[index]['done'] = !_tasks[index]['done'];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final turquoise = const Color(0xFF40E0D0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Skincare Schedule'),
        backgroundColor: turquoise,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input & Add button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Tambah Jadwal Skincare',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: _addTask, child: const Text('Add')),
              ],
            ),
            const SizedBox(height: 20),
            // List jadwal
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(child: Text('Belum ada jadwal'))
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        return Card(
                          child: ListTile(
                            leading: Checkbox(
                              value: task['done'],
                              onChanged: (value) => _toggleDone(index),
                              activeColor: turquoise,
                            ),
                            title: Text(
                              task['title'],
                              style: TextStyle(
                                decoration: task['done']
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteTask(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 10),
            // Button Next ke Tips
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TipsPage()),
                );
              },
              child: const Text('Next: Tips Skincare'),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Kedua - Tips Skincare
class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final turquoise = const Color(0xFF40E0D0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tips Skincare Harian'),
        backgroundColor: turquoise,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tips Skincare Harian:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '1. Bersihkan muka setiap pagi dan malam\n'
              '2. Gunakan pelembap sesuai tipe kulit\n'
              '3. Gunakan sunscreen setiap pagi\n'
              '4. Hindari menyentuh wajah terlalu sering\n'
              '5. Rutin eksfoliasi 1-2 kali seminggu',
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // kembali ke halaman pertama
                },
                child: const Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
