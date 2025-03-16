import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registration Page',
      theme: ThemeData(       
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 0, 234)),
        useMaterial3: true,
      ),
       home: RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState  extends State<RegistrationPage>{
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _passwordcheckController = TextEditingController();


  void _login() {
    ScaffoldMessenger.of(context).showSnackBar(
      // ignore: lines_longer_than_80_chars
      const SnackBar(content: Text('We`re sorry, registrtion process is in development now'))
    );
  }
 
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Registration',
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
                        hintText: 'Enter your login',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                    child:TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                    child: TextFormField(
                      controller: _passwordcheckController,
                      decoration: const InputDecoration(
                        labelText: 'Password 2',
                        hintText: 'Enter your Password again',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _login,
                      child: const Text('Register an account'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 20, // Відступ знизу
            left: 20,   // Відступ зліва
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              //backgroundColor: Color.fromARGB(255, 89, 12, 102),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}