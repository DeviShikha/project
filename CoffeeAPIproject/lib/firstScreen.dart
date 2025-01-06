import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:letsenklineproject/CoffeeDetels.dart';

class MyApiIntegration extends StatefulWidget {
  const MyApiIntegration({super.key});

  @override
  State<MyApiIntegration> createState() => _MyApiIntegrationState();
}

class _MyApiIntegrationState extends State<MyApiIntegration> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> coffeeList = [];
  List<dynamic> filteredList = [];

  Future<void> fetchCoffee() async {
    var response =
        await http.get(Uri.parse("https://api.sampleapis.com/coffee/hot"));
    if (response.statusCode == 200) {
      setState(() {
        coffeeList = jsonDecode(response.body);
        filteredList = coffeeList;
      });
    }
  }

  void filterSearch(String query) {
    setState(() {
      filteredList = coffeeList
          .where((coffee) => coffee["title"]
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCoffee();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("The Coffee Shop"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) => filterSearch(value),
              decoration: InputDecoration(
                hintText: "Search the coffee",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                var coffee = filteredList[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          coffee["title"],
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        subtitle: Text(coffee["description"]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Ingredients:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            // coffee["ingredients"] == null
                            // ||
                            coffee["ingredients"].isEmpty
                                ? Text("No ingredients available.")
                                : Column(
                                    children: (coffee["ingredients"]
                                            as List<dynamic>)
                                        .map(
                                          (ingredient) => Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.circle,
                                                    size: 8),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    ingredient,
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 400,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MySecondDetailsScreen(
                                      coffeeId: coffee["id"],
                                    ),
                                  ));
                            },
                            child: Text(
                              "Search Details",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                              ),
                            )),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
