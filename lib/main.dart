import 'package:flutter/material.dart';

void main() {
  runApp(const AIStoryStudio());
}

class AIStoryStudio extends StatelessWidget {
  const AIStoryStudio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Story Studio',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🎬 AI Story Studio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'បង្កើតរឿងរបស់អ្នកជាមួយ AI',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('ពីគំនិតរឿង ទៅជា Script, Scenes និង Video'),
          const SizedBox(height: 25),

          FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NewProjectScreen(),
                ),
              );
            },
            icon: const Icon(Icons.auto_awesome),
            label: const Padding(
              padding: EdgeInsets.all(14),
              child: Text(
                'បង្កើតរឿងថ្មី',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            'គម្រោងរបស់ខ្ញុំ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          _project(context, 'រឿងស្នេហាខ្មែរ ❤️', '8 Scenes • 2:35'),
          _project(context, 'ដំណើរទៅឋានព្រះចន្ទ 🌙', '12 Scenes • 4:10'),
        ],
      ),
    );
  }

  Widget _project(BuildContext context, String title, String info) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.movie),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(info),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => StudioScreen(title: title),
            ),
          );
        },
      ),
    );
  }
}

class NewProjectScreen extends StatefulWidget {
  const NewProjectScreen({super.key});

  @override
  State<NewProjectScreen> createState() => _NewProjectScreenState();
}

class _NewProjectScreenState extends State<NewProjectScreen> {
  final controller = TextEditingController();

  String genre = 'ស្នេហា';
  String language = 'ខ្មែរ';
  String duration = 'Short';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('✨ បង្កើតរឿងថ្មី'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'គំនិតរឿង',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: controller,
            maxLines: 6,
            decoration: const InputDecoration(
              hintText:
                  'ឧ. បុរសក្រីក្រម្នាក់ស្រឡាញ់នារីអ្នកមាន...',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 18),

          DropdownButtonFormField<String>(
            value: genre,
            decoration: const InputDecoration(
              labelText: 'ប្រភេទរឿង',
              border: OutlineInputBorder(),
            ),
            items: [
              'ស្នេហា',
              'កំប្លែង',
              'ភ័យរន្ធត់',
              'Fantasy',
              'ប្រវត្តិសាស្ត្រ',
            ]
                .map(
                  (x) => DropdownMenuItem(
                    value: x,
                    child: Text(x),
                  ),
                )
                .toList(),
            onChanged: (v) {
              setState(() => genre = v!);
            },
          ),

          const SizedBox(height: 14),

          DropdownButtonFormField<String>(
            value: language,
            decoration: const InputDecoration(
              labelText: 'ភាសា',
              border: OutlineInputBorder(),
            ),
            items: ['ខ្មែរ', 'English']
                .map(
                  (x) => DropdownMenuItem(
                    value: x,
                    child: Text(x),
                  ),
                )
                .toList(),
            onChanged: (v) {
              setState(() => language = v!);
            },
          ),

          const SizedBox(height: 14),

          DropdownButtonFormField<String>(
            value: duration,
            decoration: const InputDecoration(
              labelText: 'ប្រវែង',
              border: OutlineInputBorder(),
            ),
            items: ['Short', '5 នាទី', '10 នាទី', '30 នាទី']
                .map(
                  (x) => DropdownMenuItem(
                    value: x,
                    child: Text(x),
                  ),
                )
                .toList(),
            onChanged: (v) {
              setState(() => duration = v!);
            },
          ),

          const SizedBox(height: 25),

          FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StudioScreen(
                    title: controller.text.isEmpty
                        ? 'គម្រោងថ្មី'
                        : controller.text,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.auto_awesome),
            label: const Padding(
              padding: EdgeInsets.all(14),
              child: Text(
                'Generate Story',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StudioScreen extends StatelessWidget {
  final String title;

  const StudioScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎬 Project Studio'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

          _item(Icons.description, 'Script'),
          _item(Icons.people, 'Characters'),
          _item(Icons.movie_creation, 'Scenes'),
          _item(Icons.image, 'Images'),
          _item(Icons.video_library, 'Videos'),
          _item(Icons.record_voice_over, 'Voice'),
          _item(Icons.music_note, 'Music'),

          const SizedBox(height: 20),

          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'AI Video Generator នឹងភ្ជាប់នៅជំហានបន្ទាប់ ✨',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.auto_awesome),
            label: const Padding(
              padding: EdgeInsets.all(14),
              child: Text('Generate with AI'),
            ),
          ),

          const SizedBox(height: 10),

          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Export Video នឹងមាននៅជំហានបន្ទាប់'),
                ),
              );
            },
            icon: const Icon(Icons.download),
            label: const Text('Export Video'),
          ),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String title) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
