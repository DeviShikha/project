import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyCityScreen extends StatefulWidget {
  String? countryId;
  MyCityScreen({super.key, required this.countryId});

  @override
  State<MyCityScreen> createState() => _MyCityScreenState();
}

class _MyCityScreenState extends State<MyCityScreen> {
  List<dynamic> cityList = [];
  // bool isloading = true;

  Future<void> featchCity() async {
    var response = await http.get(Uri.parse(
        "https://www.bme.seawindsolution.ae/api/f/city/${widget.countryId}"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      cityList = data["responsedata"];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    featchCity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick a Region"),
      ),
      body: 
      cityList.isNotEmpty
          ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                      hintText: "Seach for your city",
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.pink,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.my_location_outlined,
                            color: Colors.pink,
                          )),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                SizedBox(
                  height: 25,
                ),
                Text("POPULAR CITIES"),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemCount: cityList.length,
                    itemBuilder: (context, index) {
                      var city = cityList[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context, city["Title"]);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.grey),
                              ),
                              alignment: Alignment.center,
                              child: ClipRRect(
                                child: Image.network(
                                  city["Image"],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              city["Title"],
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  "OTHER CITIES",
                  style: TextStyle(fontWeight: FontWeight.w900),
                )
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
