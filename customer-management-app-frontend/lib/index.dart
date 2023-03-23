// import 'dart:convert';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jerose/update.dart';

import 'input.dart';
import 'search.dart';

void main(List<String> args) {
  runApp(const Api());
}

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  List<dynamic> users = [];
  int currentIndex = 0;
  final TextEditingController _idController = TextEditingController();

  @override
  void initState() {
    fetchData();
    super.initState();
  }
// how to add drawer in flutter ?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            greeting(),
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20,
              color: Color.fromARGB(249, 255, 255, 255),
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomerSearch(),
                  ),
                );
              },
              icon: const Icon(Icons.search_outlined))
        ],
        backgroundColor: const Color.fromARGB(137, 34, 134, 248),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 96, 199, 255),
                image: DecorationImage(
                  image: AssetImage("images/6.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(
                'Options',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_add_alt_sharp),
              title: const Text('Add Customer'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Registerpage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit customer'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Updateuser()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: ListView.separated(
          itemCount: users.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.grey,
            height: 5,
          ),
          itemBuilder: (BuildContext context, int index) {
            final user = users[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(
                user['customer_name'],
              ),
              subtitle: Text(user['cell_no']),
              trailing: Text(user['amount']),
              // onTap: () {
              //   showDialog(
              //       context: context,
              //       builder: (BuildContext context) {
              //         return AlertDialog(
              //           title: const Text('Delete User'),
              //           content: TextField(
              //             controller: _idController,
              //             keyboardType: TextInputType.number,
              //             decoration: const InputDecoration(
              //               labelText: 'Enter User ID',
              //               border: OutlineInputBorder(),
              //             ),
              //           ),
              //           actions: [
              //             TextButton(
              //               onPressed: () {
              //                 Navigator.pop(context);
              //               },
              //               child: const Text('Cancel'),
              //             ),
              //             ElevatedButton(
              //               onPressed: () {
              //                 deleteUser(_idController.text);
              //                 Navigator.pop(context);
              //               },
              //               child: const Text('Delete'),
              //             ),
              //           ],
              //         );
              //       });
              // },
            );
          },
        ),
      ),
    );
  }

  void fetchData() async {
    print("api");
    const url = "http://127.0.0.1:8000/api/customer";
    final uri = Uri.parse(url);
    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      setState(() {
        users = json['data'];
      });
      print("complete");
    } else {
      print("Failed to fetch data");
    }
  }

  void deleteUser(id) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/customer_delete/$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      // User successfully deleted
    } else {
      // Failed to delete user
      throw Exception('Failed to delete user');
    }
  }

  String greeting() {
    final hour = TimeOfDay.now().hour;
    if (hour <= 11) {
      return "Good morning";
    } else if (hour <= 17) {
      return "Good afternoon";
    }
    return "Good evening";
  }
}
