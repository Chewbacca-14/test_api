import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
  Future<void> fetchData() async {
    var url = Uri.parse('https://backendminiapps.ru/api/zoom/login');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = response.body;

      log(data);
    } else if (response.statusCode == 204) {
      log('204');
    } else {
      log('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                const channel = MethodChannel('flutter_channel');
                var ringtones = await channel.invokeMethod('getRingtones');
                log(ringtones.toString());
              },
              child: Text('Get ringtones'),
            )
          ],
        ),
      ),
    );
  }
}
