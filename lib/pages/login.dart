import 'package:flutter/material.dart';
import 'package:labs/pages/home.dart';
import 'package:labs/pages/registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(       
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 0, 234)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/registration': (context) => const RegistrationPage(),
        '/home': (context) => const HomePage(),

      },
      //home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState  extends State<LoginPage>{
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    ScaffoldMessenger.of(context).showSnackBar(
      // ignore: lines_longer_than_80_chars
      const SnackBar(content: Text('We`re sorry, login process is in development now'))
    );
  }
 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 28, 
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 89, 12, 102),
                    
                    ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                  controller: _loginController,
                  decoration: const InputDecoration(
                    labelText: 'Login',
                    border: OutlineInputBorder(),
                  ),
                ),
                ),      
                const SizedBox(height: 20),
                SizedBox(
                  width: 400,
                child: TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    
                  ),
                  obscureText: true,
                ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                   onPressed: (){
                    Navigator.pushNamed(context, '/home');
                   },
                  child: const Text('Log in'),
                  ),
                const SizedBox(height: 20),
                Center( 
                child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registration');
                },
                child: const Text(
                  'Don`t have an account? Click here ro register!',
                  style: TextStyle(
                      //color:Color.fromARGB(255, 89, 12, 102), // Колір тексту
                      fontSize: 14, // Розмір шрифту
                      fontWeight: FontWeight.bold, // Жирний текст (опціонально)
    ),
                  ),
                
  ),
),  
              ],
            ),
          ),
        ),
        ),
    );
  }
  
}
