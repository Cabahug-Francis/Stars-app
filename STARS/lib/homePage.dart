import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'error.dart';
import 'model.dart';
import 'nasaCard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Nasa>> nasa;
  final String uri = "https://apodapi.herokuapp.com/api/?count=5";

  Future<List<Nasa>> fetchNasa() async {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body);

      if (jsonList is List) {
        return jsonList.map((json) => Nasa.fromJson(json)).toList();
      }
    }
    throw Exception("Error");
  }

  @override
  void initState() {
    super.initState();
    nasa = fetchNasa();
    //TODO
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "STARS",
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        //text
        elevation: 16.0,
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.autorenew),
            onPressed: () {
              setState(() {
                nasa = fetchNasa();
              });
            },
          )
        ],
      ),
      body: FutureBuilder(
          future: nasa,
          builder: (BuildContext context, AsyncSnapshot<List<Nasa>> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                padding: EdgeInsets.all(16.0),
                children:
                    snapshot.data.map((nasa) => NasaCard(nasa: nasa)).toList(),
              );
            } else if (snapshot.hasError) {
              return Error(error: snapshot.error);
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
              );
            }
          }),
    );
  }
}
