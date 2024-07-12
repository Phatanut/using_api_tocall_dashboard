import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_report/RainfallThai.dart';
import 'package:http/http.dart' as http;

//ดึงAPIมาในนี้

class FScreens extends StatefulWidget {
  const FScreens({super.key});

  @override
  State<FScreens> createState() => _FScreensState();
}

class _FScreensState extends State<FScreens> {
  List<RainfallThai> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Calling Test"),
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final ProvinceName = user.ProvinceName;
            final EngName = user.EngName;
            final toID = user.toID;
            final MonThai = user.MonThai;
            return ListTile(
              leading: CircleAvatar(
                child: Text(toID),
              ),
              title: Text('$ProvinceName' '__' '(' '$EngName' ')' ''),
              subtitle: Text(MonThai),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        backgroundColor: Colors.amber,
        child: Icon(Icons.api),
      ),
    );
  }

  void fetchUsers() async {
    print('fetchUsers called');
    const url = "https://v1.nocodeapi.com/somson/csv2json/FiNgooylUhAppsEk";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final jsons = jsonDecode(body);
    final json = jsons['json'] as List<dynamic>;
    final transformed = json.map((e) {
      return RainfallThai(
          ProvinceName: e['ProvinceName'],
          EngName: e["EngName"],
          toID: e['toID'],
          MonThai: e['MonThai'],
          MinRain: '',
          MaxRain: '',
          AvgRain: '',
          region: '',
          Year: '',
          Month: '',
          Date: '');
    }).toList();
    setState(() {
      users = transformed;
    });
    print('fetchUsers completed');
  }
}
