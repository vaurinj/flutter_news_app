import 'package:flutter/material.dart';
import 'package:labs/pages/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 0, 234),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}

abstract class NewsItem {
  String get title;
  String get description;
}

class UserNews extends NewsItem {
  String userTitle;
  String userDescription;

  UserNews(this.userTitle, this.userDescription);

  @override
  String get title => userTitle;

  @override
  String get description => userDescription;

  Map<String, String> toMap() {
    return {
      'title': userTitle,
      'description': userDescription,
    };
  }

  static UserNews fromMap(Map<String, String> map) {
    return UserNews(map['title']!, map['description']!);
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NewsSection();
  }
}

class NewsSection extends StatefulWidget {
  const NewsSection({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewsSectionState createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  final List<UserNews> _newsList = [];

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> newsStrings = prefs.getStringList('news') ?? [];
    setState(() {
      _newsList.clear();
      for (var newsString in newsStrings) {
        final Map<String, String> newsMap = _mapFromJson(newsString);
        _newsList.add(UserNews.fromMap(newsMap));
      }
    });
  }

  Future<void> _saveNews() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> newsStrings = _newsList
        .map((news) => _mapToJson(news.toMap()))
        .toList();
    await prefs.setStringList('news', newsStrings);
  }

  String _mapToJson(Map<String, String> map) {
    return map.toString();
  }

  Map<String, String> _mapFromJson(String jsonString) {
    final String cleanedJson = jsonString.replaceAll(RegExp(r'[{}]'), '');
    final List<String> keyValuePairs = cleanedJson.split(',');
    final Map<String, String> map = {};
    for (var pair in keyValuePairs) {
      final List<String> keyValue = pair.split(':');
      map[keyValue[0].trim()] = keyValue[1].trim();
    }
    return map;
  }

  void _addNews(String title, String description) {
    setState(() {
      _newsList.add(UserNews(title, description));
    });
    _saveNews();
  }

  void _editNews(int index, String newTitle, String newDescription) {
    setState(() {
      _newsList[index].userTitle = newTitle;
      _newsList[index].userDescription = newDescription;
    });
    _saveNews();
  }

  void _deleteNews(int index) {
    setState(() {
      _newsList.removeAt(index);
    });
    _saveNews();
  }

  void _showNewsDialog({int? index}) {
    final bool isEditing = index != null;
    final TextEditingController titleController = TextEditingController(
        text: isEditing ? _newsList[index].title : '',);
    final TextEditingController descriptionController = TextEditingController(
        text: isEditing ? _newsList[index].description : '',);

    // ignore: inference_failure_on_function_invocation
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit News' : 'Add News'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  if (isEditing) {
                    _editNews(index, titleController.text,
                        descriptionController.text,);
                  } else {
                    _addNews(titleController.text, descriptionController.text);
                  }
                  Navigator.pop(context);
                }
              },
              child: Text(isEditing ? 'Save' : 'Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 89, 12, 102),
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_newsList.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  'Here will be your news',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                itemCount: _newsList.length,
                itemBuilder: (context, index) {
                  final news = _newsList[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: const Icon(Icons.article, color: Colors.purple),
                      title: Text(news.title,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(news.description,
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showNewsDialog(index: index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteNews(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: _showNewsDialog,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color.fromARGB(255, 89, 12, 102), width: 2),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Add News'),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      // ignore: inference_failure_on_instance_creation
                      MaterialPageRoute(builder: (context) => const ProfilePage()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color.fromARGB(255, 89, 12, 102), width: 2),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Profile'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
