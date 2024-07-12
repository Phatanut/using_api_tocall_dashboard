import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_report/RainfallThai.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class LineCharts extends StatefulWidget {
  const LineCharts({super.key});

  @override
  State<LineCharts> createState() => _DashBoardDBState();
}

class _DashBoardDBState extends State<LineCharts> {
  List<RainfallThai> usersA = [];
  List<RainfallThai> usersB = [];
  List<RainfallThai> usersE = [];
  @override
  void initState() {
    super.initState();
    fetchUsersA();
    usersB = usersA;
    usersE = usersB;
  }

  void _runFilter(String enteredKeyword) {
    List<RainfallThai> usersC = [];
    if (enteredKeyword.isEmpty) {
      usersC = usersA;
    } else {
      usersC = usersA
          .where((user) =>
              user.EngName.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      usersB = usersC;
    });
  }

  void _runFilter2(String enteredKeyword) {
    List<RainfallThai> usersD = [];
    if (enteredKeyword.isEmpty) {
      usersD = usersB;
    } else {
      usersD = usersB
          .where((user) =>
              user.Year.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      usersE = usersD;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Line Charts"),
        backgroundColor: Colors.pink[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            DropdownButton(
              hint: Text("Select City"),
              isExpanded: true,
              icon: Icon(Icons.playlist_add_check_circle_sharp),
              items: usersA.map((e) => e.EngName).toSet().map((e) {
                return DropdownMenuItem(
                    value: e.toString(), child: Text(e.toString()));
              }).toList(),
              onChanged: (value) => _runFilter(value!),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButton(
              hint: Text("Select Year"),
              isExpanded: true,
              icon: Icon(Icons.playlist_add_check_circle_sharp),
              items: usersA.map((e) => e.Year).toSet().map((e) {
                return DropdownMenuItem(
                    value: e.toString(), child: Text(e.toString()));
              }).toList(),
              onChanged: (value) => _runFilter2(value!),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title:
                      ChartTitle(text: 'Average Amount of Rainfall per Area'),
                  legend: Legend(
                    isVisible: true,
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<RainfallThai, String>>[
                    LineSeries<RainfallThai, String>(
                      dataSource: usersE,
                      xValueMapper: (RainfallThai monthai, _) =>
                          monthai.MonThai,
                      yValueMapper: (RainfallThai avgrain, _) =>
                          num.tryParse(avgrain.AvgRain),
                      name: "City 1",
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  void fetchUsersA() async {
    print('LINE CHART called');
    const urlA = "https://v1.nocodeapi.com/somson/csv2json/FiNgooylUhAppsEk";
    final uriA = Uri.parse(urlA);
    final responseA = await http.get(uriA);
    final bodyA = responseA.body;
    final jsonsA = jsonDecode(bodyA);
    final jsonA = jsonsA['json'] as List<dynamic>;
    final transformedA = jsonA.map((obj) {
      return RainfallThai(
          ProvinceName: '',
          EngName: obj['EngName'],
          toID: '',
          MonThai: obj['MonThai'],
          MinRain: '',
          MaxRain: '',
          AvgRain: obj['AvgRain'],
          region: '',
          Year: obj['Year'],
          Month: '',
          Date: '');
    }).toList();

    setState(() {
      usersA = transformedA;
    });
    print('LINE CHART completed');
  }
}
