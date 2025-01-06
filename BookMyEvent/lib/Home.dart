import 'dart:convert';

import 'package:apiselfproject/CityScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  List<dynamic> countryList = [];
  List<dynamic> sliderList = [];
  List<dynamic> catagoryList = [];
  PageController pageController = PageController();
  String? SelectCountry;
  String? selectedCountryId;
  String? selectedCountryFlag;
  // String? selectCountry;
  bool isloading = false;

  Future<void> featchCountry() async {
    var response = await http
        .get(Uri.parse("https://www.bme.seawindsolution.ae/api/f/country"));

    if (response.statusCode == 200) {
      setState(() {
        var data = jsonDecode(response.body);
        countryList = data["responsedata"];
        isloading = true;
      });
    }
  }

  Future<void> featchSlider() async {
    var response = await http
        .get(Uri.parse("https://www.bme.seawindsolution.ae/api/f/slider"));
    if (response.statusCode == 200) {
      setState(() {
        var data = jsonDecode(response.body);
        sliderList = data["responsedata"];
      });
    }
  }

  Future<void> featchCatagory() async {
    var response = await http
        .get(Uri.parse("https://www.bme.seawindsolution.ae/api/f/category"));
    if (response.statusCode == 200) {
      setState(() {
        var data = jsonDecode(response.body);
        catagoryList = data["responsedata"];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    featchCountry();
    featchSlider();
    featchCatagory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Book my \n Event",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 10),
            ),
            isloading
                ? DropdownButton(
                    iconSize: 20,
                    iconDisabledColor: Colors.white,
                    items: countryList.map<DropdownMenuItem<String>>((country) {
                      return DropdownMenuItem(
                          value: country["Title"],
                          child: Row(
                            children: [
                              Image.network(country["Image"]),
                              SizedBox(
                                width: 10,
                              ),
                              Text(country["Title"]),
                            ],
                          ));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        SelectCountry = value;
                        var selected = countryList.firstWhere(
                          (element) => element["Title"] == SelectCountry,
                        );
                        selectedCountryId = selected["ID"].toString();
                        selectedCountryFlag = selected["Title"];
                      });
                      if (selectedCountryId != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyCityScreen(
                              countryId: selectedCountryId,
                            ),
                          ),
                        );
                      }
                    },
                    // value: selectCountry,
                    hint: Text("select a country"),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
// SizedBox(width: 5,),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.notification_add_outlined)),
            // SizedBox(width: 2,),

            // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          ],
        ),
      ),
      endDrawer: Drawer(
        // shadowColor: Colors.amber,
        backgroundColor: Colors.pink.shade100,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Sign In"),
              ),
            ),
            ListTile(
              title: Text(
                "My Profile",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              leading: Icon(
                Icons.person,
                size: 30,
              ),
            ),
             ListTile(
              title: Text(
                "List Your Show",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              leading: Icon(
                Icons.shop,
                size: 30,
              ),
            ),
             ListTile(
              title: Text(
                "Offers",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              leading: Icon(
                Icons.offline_bolt_sharp,
                size: 30,
              ),
            ),
             ListTile(
              title: Text(
                "About",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              leading: Icon(
                Icons.three_mp_rounded,
                size: 30,
              ),
            ),
             ListTile(
              title: Text(
                "Contact",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              leading: Icon(
                Icons.contact_phone,
                size: 30,
              ),
            ),
             ListTile(
              title: Text(
                "FAQ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              leading: Icon(
                Icons.contact_support_rounded,
                size: 30,
              ),
            ),
             ListTile(
              title: Text(
                "Help & Support",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              leading: Icon(
                Icons.mobile_screen_share_rounded,
                size: 30,
              ),
            ),
             ListTile(
              title: Text(
                "Sign Out",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              leading: Icon(
                Icons.arrow_circle_right_rounded,
                size: 30,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.pink,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                      // InkWell(child: Text("ListyourShow"),)
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink.shade300),
                          onPressed: () {},
                          child: Text("Listyourshow")),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink.shade300),
                          onPressed: () {},
                          child: Text("offers"))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          label: Text(
                            "workshop",
                            style: TextStyle(color: Colors.pink),
                          ),
                          icon: Icon(
                            Icons.work,
                            color: Colors.pink,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          label: Text(
                            "Kids",
                            style: TextStyle(color: Colors.pink),
                          ),
                          icon: Icon(Icons.toys, color: Colors.pink),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          label: Text(
                            "Comedy",
                            style: TextStyle(color: Colors.pink),
                          ),
                          icon: Icon(Icons.theater_comedy, color: Colors.pink),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          label: Text(
                            "Music",
                            style: TextStyle(color: Colors.pink),
                          ),
                          icon: Icon(Icons.library_music, color: Colors.pink),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              child: PageView.builder(
                itemCount: sliderList.length,
                controller: pageController,
                itemBuilder: (context, index) {
                  var sliderItem = sliderList[index];
                  return InkWell(
                    child: Image.network(
                      sliderItem["Image"],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            SmoothPageIndicator(
              controller: pageController,
              count: sliderList.length,
              effect: ScrollingDotsEffect(
                  activeDotColor: Colors.pink,
                  dotColor: Colors.grey,
                  dotHeight: 8,
                  dotWidth: 8),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Find New Experience",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Engage, Invetigate Draft a Plan",
                      style: TextStyle(fontSize: 10),
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          Text(
                            "See all",
                            style: TextStyle(fontSize: 12, color: Colors.pink),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 12,
                            color: Colors.pink,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.pink,
                    child: Center(child: Text("")),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.pink,
                    child: Center(child: Text("")),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.pink,
                    child: Center(child: Text("")),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.pink,
                    child: Center(child: Text("")),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.pink,
                    child: Center(child: Text("")),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.pink,
                    child: Center(child: Text("")),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "P R E M I E R E",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.play_circle,
                          color: Colors.pink,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Watch, new Poular events",
                      style: TextStyle(fontSize: 10),
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          Text(
                            "See all",
                            style: TextStyle(fontSize: 12, color: Colors.pink),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 12,
                            color: Colors.pink,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 300,
              child: ListView.builder(
                itemCount: catagoryList.length,
                itemBuilder: (context, index) {
                  var catagory = catagoryList[index];
                  return InkWell(
                    onTap: () {
                      // print("Slelect catagory: ${catagory["Title"]}");
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      width: 150,
                      decoration: BoxDecoration(color: Colors.grey.shade200),
                      child: Column(
                        children: [
                          Image.network(
                            catagory["Image"],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.error),
                          ),
                          Text(
                            catagory["Title"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          selectedItemColor: Colors.pink,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range), label: "Event"),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_rounded), label: "List Show"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
    );
  }
}
