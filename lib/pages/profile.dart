import 'package:flutter/material.dart';
import 'package:labs/pages/home.dart';
import 'package:labs/pages/login.dart'; // Додайте імпорт для екрану логіну
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
        '/': (context) => const ProfilePage(), 
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(), // Додайте екран логіну
      },
    );
  }
}


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('login') ?? 'Unknown User';
      _email = prefs.getString('email') ?? 'No Email';
    });
  }

  Future<void> _logout() async {
    //final prefs = await SharedPreferences.getInstance();
    //await prefs.clear(); // Очищаємо збережені дані
     Navigator.pushAndRemoveUntil(
    context,
    // ignore: inference_failure_on_instance_creation
    MaterialPageRoute(builder: (context) => const LoginPage()),
    (Route<dynamic> route) => false, // Видаляє всі попередні маршрути
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 89, 12, 102),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Color.fromARGB(255, 89, 12, 102),
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              _username,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Text(
              _email,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 5),
              child: SizedBox(
                width: 200,
                child: OutlinedButton(
                  onPressed: _logout,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color.fromARGB(255, 89, 12, 102), width: 2),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Log out'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                width: 200,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');                  
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color.fromARGB(255, 89, 12, 102), width: 2),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Home page'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
