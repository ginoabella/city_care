import 'package:city_care/pages/incident_list_page.dart';
import 'package:city_care/viewmodels/report_incident_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ReportIncidentViewModel(),
          )
        ],
        child: IncidentListPage(),
      ),
    );
  }
}
