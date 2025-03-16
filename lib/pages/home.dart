import 'package:flutter/material.dart';
import 'package:labs/pages/profile.dart';


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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 0, 234)),
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.bold,
            color: Colors.white),            
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 89, 12, 102),
        
      ),
     body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'News',
            style: TextStyle(
              fontSize: 26,
              color:  Color.fromARGB(255, 89, 12, 102),
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
         Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 5, 
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Іконка новини
                       Icon(
                        Icons.article,
                        size: 40,
                        color: Colors.purple,
                      ),
                       SizedBox(width: 10),
                      // Текст новини
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'News title',
                              style:  TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                             SizedBox(height: 5),
                             Text(
                              'description',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
         ),    
        Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: SizedBox(
                width: 200,
                child: OutlinedButton(
                  onPressed: () {
                     Navigator.push(
                      // ignore: inference_failure_on_instance_creation
                      context, MaterialPageRoute(builder: (context) => const ProfilePage())
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
                 
                    ), child: const Text('Profile'),
                  ),
              ),
             ),
        ),
          
      ],
      ),
    );
  }
} 
 