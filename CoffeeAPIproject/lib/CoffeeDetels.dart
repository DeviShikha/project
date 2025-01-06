import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MySecondDetailsScreen extends StatefulWidget {
  final int coffeeId;
  MySecondDetailsScreen({super.key, required this.coffeeId});

  @override
  State<MySecondDetailsScreen> createState() => _MySecondDetailsScreenState();
}

class _MySecondDetailsScreenState extends State<MySecondDetailsScreen> {
  Map<String, dynamic> coffeeData = {};
  bool isLoading = true;

  Future<void> fetchId() async {
    try {
      var response = await http.get(
        Uri.parse("https://api.sampleapis.com/coffee/hot/${widget.coffeeId}"),
      );
      if (response.statusCode == 200) {
        setState(() {
          coffeeData = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        // throw Exception("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching data: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("More Information"),
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : coffeeData == null
                ? const Center(child: Text("Failed to load data"))
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.network(
                            coffeeData?["image"],
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 100),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          coffeeData["title"],
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          coffeeData["description"],
                          style: const TextStyle(fontSize: 16),
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
                            coffeeData["ingredients"] == null 
                                ?  Text("No ingredients available.")
                                : Column(
                                    children: (coffeeData["ingredients"]
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
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Column(
                        //     children: [
                        //       Text(
                        //         "Ingredients",
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w900, fontSize: 16),
                        //       ),
                        //       coffeeData["ingredients"] == null 
                        //       ? Text(" ")
                        //       : Column(
                        //         children: (coffeeData["ingredients"] as List<dynamic>.map(
                        //           (ingredient) => Row(
                        //             childrent: [

                        //             ]
                        //           )
                        //         )),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Give me your Feedback",
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.thumb_up)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.thumb_down))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
