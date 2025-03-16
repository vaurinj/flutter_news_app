import 'package:flutter/material.dart';
import 'package:labs/pages/home.dart';
import 'package:labs/pages/login.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Page',
      theme: ThemeData(       
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 0, 234)),
        useMaterial3: true,
      ),
        initialRoute: '/',
      routes: {
        '/': (context) => const ProfilePage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),

      },
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.bold,
            color: Colors.white),            
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 89, 12, 102),
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color.fromARGB(255, 89, 12, 102), width: 4),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'vauring',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            const Text(
              'zayetsvikysia018@gmail.com',
               style: TextStyle(fontSize: 16, color: Colors.grey),
            ), 
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 5,
              ),
              child: SizedBox(
                width: 200,
                child: OutlinedButton(
                  onPressed: () {
                     Navigator.push(
                      // ignore: inference_failure_on_instance_creation
                      context, MaterialPageRoute(builder: (context) => const LoginPage())
                      );
                  }, 
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color.fromARGB(255, 89, 12, 102), 
                      width: 2,
                      ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),  
                 
                    ), child: const Text('Log out'),
                  ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                width: 200,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context, '/home', 
                      );
                  }, 
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color.fromARGB(255, 89, 12, 102), width: 2,
                      ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),  
                 
                    ), child: const Text('Home page'),
                  ),
              ),
             ),
          ],
        ),
      ),
    );
  }
} 
 