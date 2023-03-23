// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const Apical());

class Apical extends StatefulWidget {
  const Apical({Key? key}) : super(key: key);

  @override
  _ApicalState createState() => _ApicalState();
}

class _ApicalState extends State<Apical> {
  List<dynamic> data = [];

  // Future<void> fetchdata() async {
  //   final url = Uri.parse('http://127.0.0.1:8000/api/customer');
  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final jsonResponse = json.decode(response.body);
  //     setState(() {
  //       data = jsonResponse['data'];
  //     });
  //   } else {
  //     throw Exception('Failed to load data from server');
  //   }
  // }
  Future<void> fetchdata() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/customer');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          data = jsonResponse['data'];
        });
      } else {
        throw Exception('Failed to load data from server');
      }
    } catch (e) {
      // Handle the exception by showing an error message to the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to fetch data from server.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: fetchdata,
            child: const Text('Fetch Data'),
          ),
        ),
      ),
    );
  }
}
