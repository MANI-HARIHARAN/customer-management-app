import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:http/http.dart' as http;
import 'package:jerose/index.dart';

import 'input.dart';
import 'search.dart';

void main(List<String> args) {
  runApp(const Updateuser());
}

class Updateuser extends StatefulWidget {
  const Updateuser({Key? key}) : super(key: key);

  @override
  State<Updateuser> createState() => _UpdateuserState();
}

class _UpdateuserState extends State<Updateuser> {
  List<dynamic> users = [];
  final TextEditingController _idController = TextEditingController();
  TextEditingController NameController = TextEditingController();
  TextEditingController cellcontroller = TextEditingController();
  TextEditingController boxcontroller = TextEditingController();
  TextEditingController feecontroller = TextEditingController();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
            child: Text(
              'EDIT CUSTOMER',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20,
                color: Color.fromARGB(249, 255, 255, 255),
              ),
            ),
          ),
          backgroundColor: const Color.fromARGB(137, 34, 134, 248)),
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
              leading: const Icon(Icons.home_filled),
              title: const Text('HOME'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Api()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Add Customer'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Registerpage()),
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
              title: Text(user['customer_name']),
              subtitle: Text(user['cell_no']),
              // trailing: Text(user['amount']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(user['amount']),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Delete'),
                        content: const Text('confirm to delete'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Back'),
                          ),
                          TextButton(
                            onPressed: () {
                              deleteUser(user['id']);
                              Navigator.pop(context);
                            },
                            child: const Text('delete'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    _idController.text = user['id'].toString();
                    return AlertDialog(
                      title: const Text('Update User'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: NameController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'NAME',
                              icon: Icon(Icons.add_call),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: cellcontroller,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'PHONE',
                              icon: Icon(Icons.add_call),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: boxcontroller,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'BOX',
                              icon: Icon(Icons.add_call),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: feecontroller,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'AMOUNT',
                              icon: Icon(Icons.add_call),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            updateUser(user['id']);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Api(),
                              ),
                            );
                          },
                          child: const Text('Update'),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  void updateUser(id) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/customer_update/$id');
    final response = await http.put(url, body: {
      'customer_name': NameController.text,
      'cell_no': cellcontroller.text,
      'box_no': boxcontroller.text,
      'amount': feecontroller.text,
    });

    if (response.statusCode == 200) {
      // User successfully updated
    } else {
      // Failed to update user
      throw Exception('Failed to update user');
    }
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
}
