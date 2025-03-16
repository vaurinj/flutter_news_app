import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 0, 162)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter press counter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final TextEditingController _controller = TextEditingController();
  String _errorMessage = '';

    void _incrementCounter() {
      setState(() {
        _counter++;
     });
   }

  void _validateInput() {
    setState(() 
    {
      final String inputText = _controller.text.trim();
      if (inputText.isEmpty) {
        _errorMessage = ':3';
      }
      else {
        _errorMessage = 'it`s not number you know?';
      } 
      
      if (inputText.toLowerCase() == 'avada kedavra') {
        _counter = 0;
        _errorMessage = 'oops...';
         _controller.clear();
      }

      final int? number = int.tryParse(inputText);
      if (number != null) {
        _counter += number;
        _errorMessage  = '';
        _controller.clear();
      }     
                 
    });
    
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(     
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,       
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),

            // Text Field with validation
         Center(child: SizedBox(
            width: 500,
            child:TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'You can enter number here',
                errorText: _errorMessage.isEmpty ? null : _errorMessage,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed:  _controller.clear,
                  icon: const Icon(Icons.clear),
                  ),

              ),
              
            ),
          ),  
         ),  
            const SizedBox(height: 20),
           
           ElevatedButton(
              onPressed: _validateInput,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
