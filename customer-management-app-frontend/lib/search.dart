// // // ignore_for_file: library_private_types_in_public_api

// // import 'dart:convert';

// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;

// // void main() {
// //   runApp(const Search());
// // }

// // class Search extends StatefulWidget {
// //   const Search({Key? key}) : super(key: key);

// //   @override
// //   _SearchState createState() => _SearchState();
// // }

// // class _SearchState extends State<Search> {
// //   final TextEditingController _searchController = TextEditingController();
// //   List<Map<String, dynamic>> _searchResult = [];

// //   Future<void> _fetchSearchResult(String query) async {
// //     final String apiUrl =
// //         'http://127.0.0.1:8000/api/customer_search?query=$query';
// //     final http.Response response = await http.get(Uri.parse(apiUrl));

// //     if (response.statusCode == 200) {
// //       final List<dynamic> result = json.decode(response.body);
// //       setState(() {
// //         _searchResult = result.cast<Map<String, dynamic>>();
// //       });
// //     } else {
// //       throw Exception('Failed to fetch search results');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Search Example',
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Search Example'),
// //         ),
// //         body: Column(
// //           children: [
// //             TextField(
// //               controller: _searchController,
// //               decoration: const InputDecoration(
// //                 hintText: 'Search',
// //                 prefixIcon: Icon(Icons.search),
// //                 border: OutlineInputBorder(),
// //               ),
// //               onSubmitted: (String query) {
// //                 _fetchSearchResult(query);
// //               },
// //             ),
// //             Expanded(
// //               child: DataTable(
// //                 columns: const [
// //                   DataColumn(label: Text('Name')),
// //                   DataColumn(label: Text('Phone')),
// //                   DataColumn(label: Text('Box No.')),
// //                   DataColumn(label: Text('Amount')),
// //                 ],
// //                 rows: _searchResult
// //                     .map(
// //                       (Map<String, dynamic> result) => DataRow(
// //                         cells: [
// //                           DataCell(Text(result['customer_name'].toString())),
// //                           DataCell(Text(result['cell_no'].toString())),
// //                           DataCell(Text(result['box_no'].toString())),
// //                           DataCell(Text(result['amount'].toString())),
// //                         ],
// //                       ),
// //                     )
// //                     .toList(),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Search extends StatefulWidget {
//   @override
//   _SearchState createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   final TextEditingController _controller = TextEditingController();
//   String _searchTerm = '';
//   List _searchResults = [];

//   void _onSearch() async {
//     if (_searchTerm.isEmpty) return;
//     final String apiUrl =
//         'http://127.0.0.1:8000/api/customer_search?query=$_searchTerm';
//     final response = await http.get(Uri.parse(apiUrl));
//     if (response.statusCode == 200) {
//       setState(() {
//         _searchResults = json.decode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search API Example'),
//       ),
//       body: Column(
//         children: [
//           TextField(
//             controller: _controller,
//             decoration: InputDecoration(
//               hintText: 'Enter search term',
//               suffixIcon: IconButton(
//                 icon: const Icon(Icons.search),
//                 onPressed: () {
//                   setState(() {
//                     _searchTerm = _controller.text;
//                   });
//                   _onSearch();
//                 },
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _searchResults.length,
//               itemBuilder: (context, index) {
//                 final result = _searchResults[index];
//                 return ListTile(
//                   title: Text(
//                     result['customer_name'],
//                   ),
//                   subtitle: Text(result['cell_no']),
//                   trailing: Text(result['amount']),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomerSearch extends StatefulWidget {
  @override
  _CustomerSearchState createState() => _CustomerSearchState();
}

class _CustomerSearchState extends State<CustomerSearch> {
  final searchController = TextEditingController();
  List<dynamic> customers = [];

  Future<void> searchCustomer(String query) async {
    String url = 'http://127.0.0.1:8000/api/customer_search?query=$query';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        customers = jsonDecode(response.body)['data'];
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search for customer',
              ),
              onChanged: (value) => searchCustomer(value),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: customers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(customers[index]['customer_name']),
                    subtitle: Text(customers[index]['cell_no']),
                    trailing: Text(customers[index]['box_no']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
