import 'package:flutter/material.dart';

void main() {
  runApp(const NeetApp());
}

class NeetApp extends StatelessWidget {
  const NeetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NEET UG Prep',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF087F5B),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String language = 'Both';

  String text(String en, String hi) {
    if (language == 'Hindi') return hi;
    if (language == 'English') return en;
    return '$en / $hi';
  }

  @override
  Widget build(BuildContext context) {
    final subjects = [
      ['Biology', 'जीव विज्ञान', Icons.eco],
      ['Physics', 'भौतिक विज्ञान', Icons.bolt],
      ['Chemistry', 'रसायन विज्ञान', Icons.science],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('NEET UG Prep'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: (value) {
              setState(() => language = value);
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'Hindi', child: Text('हिंदी')),
              PopupMenuItem(value: 'English', child: Text('English')),
              PopupMenuItem(value: 'Both', child: Text('हिंदी + English')),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFF087F5B),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text('Welcome, Future Doctor!', 'भविष्य के डॉक्टर, स्वागत है!'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  text('Start your NEET preparation.',
                      'अपनी NEET की तैयारी शुरू करें।'),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            text('Study Subjects', 'विषय चुनें'),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          for (final subject in subjects)
            Card(
              child: ListTile(
                leading: Icon(
                  subject[2] as IconData,
                  color: const Color(0xFF087F5B),
                  size: 32,
                ),
                title: Text(
                  text(subject[0] as String, subject[1] as String),
                ),
                subtitle: Text(
                  text('Notes and practice questions',
                      'नोट्स और अभ्यास प्रश्न'),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SubjectPage(
                        title: text(
                          subject[0] as String,
                          subject[1] as String,
                        ),
                        language: language,
                      ),
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SubjectPage(
                    title: text('Mock Test', 'मॉक टेस्ट'),
                    language: language,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.assignment),
            label: Text(text('Practice MCQs', 'MCQ अभ्यास करें')),
          ),
        ],
      ),
    );
  }
}

class SubjectPage extends StatelessWidget {
  final String title;
  final String language;

  const SubjectPage({
    super.key,
    required this.title,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    final hindi = language != 'English';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.menu_book, size: 64, color: Color(0xFF087F5B)),
              const SizedBox(height: 18),
              Text(
                hindi
                    ? 'अध्याय और प्रश्न जल्द जोड़े जाएंगे।'
                    : 'Chapters and questions will be added next.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 12),
              Text(
                language == 'Both'
                    ? 'Chapter-wise study / अध्यायवार पढ़ाई'
                    : 'NEET UG Preparation',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
