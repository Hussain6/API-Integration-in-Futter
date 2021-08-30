import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  getuser() async {
    var users = [];
    var response =
        await http.get(Uri.https("jsonplaceholder.typicode.com", "users"));
    var jsonData = jsonDecode(response.body);

    for (var i in jsonData) {
      UserModal user =
          UserModal(i['name'], i['username'], i['company']['name']);
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getuser(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Text("No Data in Api"),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(snapshot.data[i].name),
                    subtitle: Text(snapshot.data[i].company),
                  );
                });
          }
        },
      ),
    );
  }
}

class UserModal {
  var name;
  var username;
  var company;

  UserModal(this.name, this.username, this.company);
}
