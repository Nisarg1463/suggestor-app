// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:suggestor/backend.dart';
import 'package:suggestor/card_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int lowerHalfFlex = 3;
  List<String> currentlyActiveCatagories = [];
  bool loaded = false;
  final searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    initialLoad();
  }

  void initialLoad() async {
    await getNearbyLocations();
    setState(() {
      loaded = true;
    });
  }

  void callback() {
    RefreshList(currentlyActiveCatagories);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (loaded)
        ? Scaffold(
            body: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 88, 124, 252),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                IconButton(
                                  iconSize: 40,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_left,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center, // use aligment
                            child: Image.asset('assets/images/Logo.png',
                                height: 60, width: 60, fit: BoxFit.cover),
                          ),
                          Text(
                            'Hello, ' + user.name,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: lowerHalfFlex,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 30, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 200, 200, 200),
                                    offset: const Offset(
                                      0.0,
                                      5.0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              width: 300,
                              child: TextField(
                                onSubmitted: (input) async {
                                  searchQuery(input, callback);
                                  lowerHalfFlex = 3;
                                  await Future.delayed(
                                      Duration(milliseconds: 200));
                                  setState(() {});
                                },
                                onTap: () {
                                  lowerHalfFlex = 2;
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Search for location',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: detailsOfLocation.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    (currentlyActiveCatagories.contains(
                                            detailsOfLocation.keys
                                                .toList()[index]))
                                        ? currentlyActiveCatagories.remove(
                                            detailsOfLocation.keys
                                                .toList()[index])
                                        : currentlyActiveCatagories.add(
                                            detailsOfLocation.keys
                                                .toList()[index]);
                                    RefreshList(currentlyActiveCatagories);
                                    setState(() {});
                                  },
                                  child: Card(
                                    elevation: 3,
                                    color: (currentlyActiveCatagories.contains(
                                            detailsOfLocation.keys
                                                .toList()[index])
                                        ? Color.fromARGB(255, 255, 154, 3)
                                        : Colors.white),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Text(
                                        detailsOfLocation.keys.toList()[index],
                                        style: TextStyle(
                                          color: (currentlyActiveCatagories
                                                  .contains(detailsOfLocation
                                                      .keys
                                                      .toList()[index])
                                              ? Colors.white
                                              : Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          (loaded)
                              ? Expanded(
                                  flex: 10, child: CardList(currentLocations))
                              : Container(),
                        ],
                      ))
                ],
              ),
            ),
          )
        : Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: const Alignment(1, 0.8),
                    child: Text(
                      'Loading locations',
                      style:
                          const TextStyle(color: Colors.orange, fontSize: 40),
                    ),
                  ),
                ),
                const CircularProgressIndicator(
                  color: Colors.orange,
                ),
                Expanded(child: Container())
              ],
            ),
          );
  }
}
