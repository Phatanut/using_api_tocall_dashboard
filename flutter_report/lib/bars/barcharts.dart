import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_report/RainfallThai.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class BarCharts extends StatefulWidget {
  const BarCharts({super.key});

  @override
  State<BarCharts> createState() => _BarChartsState();
}

class _BarChartsState extends State<BarCharts> {
  List<RainfallThai> usersG = [];
  List<RainfallThai> usersH = [];
  List<RainfallThai> usersK = [];
  @override
  void initState() {
    super.initState();
    fetchUsersB();
    usersH = usersG;
    usersK = usersH;
  }

  void _runFilter3(String enteredKeyword) {
    List<RainfallThai> usersI = [];
    if (enteredKeyword.isEmpty) {
      usersI = usersG;
    } else {
      usersI = usersG
          .where((user) =>
              user.EngName.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      usersH = usersI;
    });
  }

  void _runFilter4(String enteredKeyword) {
    List<RainfallThai> usersJ = [];
    if (enteredKeyword.isEmpty) {
      usersJ = usersH;
    } else {
      usersJ = usersH
          .where((user) =>
              user.Year.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      usersK = usersJ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bar Charts"),
        backgroundColor: Colors.purple[200],
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
              items: usersG.map((ea) => ea.EngName).toSet().map((ea) {
                return DropdownMenuItem(
                    value: ea.toString(), child: Text(ea.toString()));
              }).toList(),
              onChanged: (value) => _runFilter3(value!),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButton(
              hint: Text("Select Year"),
              isExpanded: true,
              icon: Icon(Icons.playlist_add_check_circle_sharp),
              items: usersG.map((ea) => ea.Year).toSet().map((ea) {
                return DropdownMenuItem(
                    value: ea.toString(), child: Text(ea.toString()));
              }).toList(),
              onChanged: (value) => _runFilter4(value!),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title:
                      ChartTitle(text: 'Maximum Amount of Rainfall per Area'),
                  legend: Legend(
                    isVisible: true,
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<RainfallThai, String>>[
                    BarSeries<RainfallThai, String>(
                      dataSource: usersK,
                      xValueMapper: (RainfallThai monthai, _) =>
                          monthai.MonThai,
                      yValueMapper: (RainfallThai maxrain, _) =>
                          num.tryParse(maxrain.MaxRain),
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

  void fetchUsersB() async {
    print('BAR CHART called');
    const urlB = "https://v1.nocodeapi.com/somson/csv2json/FiNgooylUhAppsEk";
    final uriB = Uri.parse(urlB);
    final responseB = await http.get(uriB);
    final bodyB = responseB.body;
    final jsonsB = jsonDecode(bodyB);
    final jsonB = jsonsB['json'] as List<dynamic>;
    final transformedB = jsonB.map((objb) {
      return RainfallThai(
          ProvinceName: '',
          EngName: objb['EngName'],
          toID: '',
          MonThai: objb['MonThai'],
          MinRain: '',
          MaxRain: objb['MaxRain'],
          AvgRain: '',
          region: '',
          Year: objb['Year'],
          Month: '',
          Date: '');
    }).toList();

    setState(() {
      usersG = transformedB;
    });
    print('BAR CHART completed');
  }
}
