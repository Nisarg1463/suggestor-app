// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:suggestor/backend.dart';
import 'package:suggestor/data_structures.dart';

class CardList extends StatefulWidget {
  final List<Place> inputList;
  const CardList(this.inputList, {Key? key}) : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.inputList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: GestureDetector(
              onTap: () {
                showMap(widget.inputList[index]);
              },
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: Text(widget.inputList[index].name),
                ),
              ),
            ),
          );
        });
  }
}
