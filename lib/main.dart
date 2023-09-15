import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'random_year.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  RandomYear? _randomYear;

  Future<void> _getRandomYear() async {
    setState(() {
      _isLoading = true;
    });
    final Uri url = Uri.http(
      'numbersapi.com',
      '/random/year',
      {'json': ''},
    );
    final response = await http.get(url);
    final RandomYear year = RandomYear.fromJson(json.decode(response.body));
    setState(() {
      _randomYear = year;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getRandomYear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Text('${_randomYear?.text}'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _getRandomYear();
              },
              child: const Text('Get random year'),
            ),
          ],
        ),
      ),
    );
  }
}
