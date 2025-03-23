import 'package:flutter/material.dart';
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
  final _formKey = GlobalKey<FormState>(); // Ключ форми

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordcheckController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } 
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

   String? _validatePasswordMatch(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> _saveUserData() async  {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('login', _loginController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('password', _passwordController.text);
  } 

  void _register() async {
    if (_formKey.currentState!.validate()) {
      await _saveUserData(); // Зберігаємо дані
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful!')),
      );
    }
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
                key: _formKey,
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
                      validator: (value) => value!.isEmpty
                        ? 'Login cannot be empty'
                        : null,
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
                      validator: _validateEmail,
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
                      validator: _validatePassword,
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
                      validator: _validatePasswordMatch
                    ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _register,
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