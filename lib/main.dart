import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PassEZ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.yellow[300],
          secondary: Colors.yellow[300]
        ),
      ),
      home: const MyHomePage(title: 'PassEZ: Password generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

String randomNumStr () {
  return Random().nextInt(100).toString();
}

String genPass () {
  String word = WordPair.random().asSnakeCase;
  String connectedWord = word.split('_').join(randomNumStr());
  return randomNumStr() + connectedWord + randomNumStr();
}

class _MyHomePageState extends State<MyHomePage> {
  var passWord = genPass();

  void _changeWord() {
    setState(() {
      passWord = genPass();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              const Text('Here\'s your password:', style: TextStyle(fontSize: 30),),
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow[300],
                  border: Border.all(color: Colors.yellow.shade300),
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SelectableText(passWord,
                  style: const TextStyle(
                      fontSize: 30,
                    ),
                  )
                ),
              ),
              TextButton(
                child: const Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: passWord));
                  Fluttertoast.showToast(
                   msg: "Copied to clipboard.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.yellow.shade300),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
              )
          ],
        ),  
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeWord,
        child: const Icon(Icons.password),
        foregroundColor: Colors.black,
        
      ),
    );
  }
}
