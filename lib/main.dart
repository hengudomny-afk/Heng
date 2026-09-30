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
              builder: (_) => DetailScreen(title: title),
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

          _item(context, Icons.description, 'Script'),
_item(context, Icons.people, 'Characters'),
_item(context, Icons.movie_creation, 'Scenes'),
_item(context, Icons.image, 'Images'),
_item(context, Icons.video_library, 'Videos'),
_item(context, Icons.record_voice_over, 'Voice'),
_item(context, Icons.music_note, 'Music'),

          const SizedBox(height: 20),

          FilledButton.icon(
            onPressed: () async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Expanded(
              child: Text('កំពុងរៀបចំវីដេអូ AI...'),
            ),
          ],
        ),
      );
    },
  );

  await Future.delayed(const Duration(seconds: 2));

  if (!context.mounted) return;

  Navigator.pop(context);

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        'បានចាប់ផ្តើមបង្កើត៖ Script → Characters → Scenes → Images → Videos',
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

Widget _item(BuildContext context, IconData icon, String title) {
  return Card(
    margin: const EdgeInsets.only(bottom: 10),
    child: ListTile(
      leading: CircleAvatar(
        child: Icon(icon),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(title: title),
          ),
        );
      },
    ),
  );
}
}
class DetailScreen extends StatelessWidget {
  final String title;

  const DetailScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    String content = '';

    if (title == 'Script') {
      content = '''
ក្តីសុបិនពីវាលស្រែ

ដារ៉ា គឺជាក្មេងប្រុសខ្មែរម្នាក់ដែលរស់នៅជនបទជាមួយឪពុកម្តាយ។

រៀងរាល់ព្រឹក ដារ៉ាក្រោកពីព្រលឹម ជួយឪពុកម្តាយរៀបចំឧបករណ៍ ហើយចុះទៅធ្វើស្រែ។

ទោះបីជាជីវិតនៅជនបទមានការលំបាកក៏ដោយ ដារ៉ាមានក្តីសុបិនធំមួយ គឺចង់ក្លាយជាអ្នកបង្កើតវីដេអូ AI។

ពេលយប់ បន្ទាប់ពីបញ្ចប់ការងារ ដារ៉ាតែងតែប្រើទូរស័ព្ទចាស់របស់គាត់ ដើម្បីរៀនអំពី AI និងការបង្កើតវីដេអូ។

ម្តាយបានសួរ៖
«កូនចង់ក្លាយជាអ្វីនៅថ្ងៃអនាគត?»

ដារ៉ាឆ្លើយថា៖
«ខ្ញុំចង់ក្លាយជាអ្នកបង្កើតវីដេអូ AI ហើយចង់បង្កើតរឿងល្អៗអំពីជីវិតជនបទខ្មែរ»។

ម្តាយញញឹម ហើយនិយាយថា៖
«កូននៅជនបទក៏អាចសម្រេចក្តីសុបិនបានដែរ។ សំខាន់គឺត្រូវខិតខំរៀន និងកុំបោះបង់»។

ដារ៉ាបន្តរៀនរាល់យប់។ ពេលថ្ងៃ គាត់ជួយឪពុកម្តាយធ្វើស្រែ។ ពេលយប់ គាត់រៀនសរសេររឿង បង្កើតរូបភាព បង្កើតសំឡេង និងបង្កើតវីដេអូដោយប្រើ AI។

មួយថ្ងៃ ដារ៉ាបានបង្កើតវីដេអូដំបូងរបស់គាត់ អំពីជីវិតកសិករខ្មែរ ហើយយកទៅបង្ហាញឪពុកម្តាយ។

ឪពុកបាននិយាយ៖
«ប៉ាមិនសូវយល់ពី AI ទេ ប៉ុន្តែប៉ាមានមោទនភាពចំពោះកូន»។

ដារ៉ាបន្តខិតខំរៀន និងបង្កើតវីដេអូជាបន្តបន្ទាប់។

នៅទីបំផុត ក្តីសុបិនរបស់ដារ៉ាបានក្លាយជាការពិត។ គាត់ក្លាយជាអ្នកបង្កើតវីដេអូ AI ដែលចែករំលែករឿងរ៉ាវ និងវប្បធម៌ខ្មែរទៅកាន់មនុស្សជុំវិញពិភពលោក។

មេរៀន៖
ទីកន្លែងដែលយើងកើត មិនមែនជាអ្វីដែលកំណត់ក្តីសុបិនរបស់យើងទេ។ ប្រសិនបើយើងខិតខំរៀន និងមិនបោះបង់ ក្តីសុបិនអាចក្លាយជាការពិតបាន។
''';
   } else if (title == 'Characters') {
  content = '''
តួអង្គសំខាន់ៗ

👦 ដារ៉ា
ក្មេងប្រុសខ្មែរអាយុប្រហែល 15 ឆ្នាំ រស់នៅជនបទជាមួយឪពុកម្តាយ។ គាត់ជួយគ្រួសារធ្វើស្រែ ហើយមានក្តីសុបិនចង់ក្លាយជាអ្នកបង្កើតវីដេអូ AI។

👨 ឪពុក
ជាកសិករខ្មែរ ខិតខំធ្វើស្រែដើម្បីចិញ្ចឹមគ្រួសារ។ គាត់ស្ងប់ស្ងាត់ និងគាំទ្រក្តីសុបិនរបស់កូន។

👩 ម្តាយ
ជាម្តាយរបស់ដារ៉ា មានភាពទន់ភ្លន់ និងតែងតែលើកទឹកចិត្តកូនឱ្យខិតខំរៀន និងកុំបោះបង់ក្តីសុបិន។

🎬 លក្ខណៈរូបរាង
តួអង្គទាំងអស់មានរូបរាងខ្មែរ និងសម្លៀកបំពាក់សមរម្យតាមជីវិតជនបទខ្មែរ។
''';
  } else if (title == 'Scenes') {
    content = '''
🎬 ឈុតឆាកវីដេអូ

ឈុតទី 1
👦 ដារ៉ា ក្មេងប្រុសខ្មែរអាយុ 15 ឆ្នាំ
កំពុងជួយឪពុកម្តាយធ្វើស្រែនៅជនបទ។

ឈុតទី 2
🌾 ដារ៉ា កំពុងធ្វើការនៅក្នុងវាលស្រែ
ជាមួយឪពុកម្តាយ នៅពេលព្រឹក។

ឈុតទី 3
📱 នៅពេលយប់ ដារ៉ាប្រើទូរស័ព្ទ
សិក្សាអំពី AI និងការបង្កើតវីដេអូ។

ឈុតទី 4
💻 ដារ៉ាចាប់ផ្តើមបង្កើតវីដេអូ AI
អំពីជីវិតកសិករខ្មែរ។

ឈុតទី 5
🎥 វីដេអូដំបូងរបស់ដារ៉ាត្រូវបានបញ្ចប់
ហើយគាត់បង្ហាញវាឱ្យឪពុកម្តាយមើល។

ឈុតទី 6
🌅 ដារ៉ាបន្តរៀន និងបង្កើតវីដេអូ
រហូតក្លាយជាអ្នកបង្កើតវីដេអូ AI។
''';
        } else {
    content = 'នេះជាទំព័រ $title\n\nមាតិកានឹងត្រូវបង្កើតនៅជំហានបន្ទាប់។';
  }

  return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 18,
            height: 1.7,
          ),
        ),
      ),
    );
  }
}
