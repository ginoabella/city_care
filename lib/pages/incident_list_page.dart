import 'package:city_care/pages/incident_report_page.dart';
import 'package:city_care/viewmodels/report_incident_view_model.dart';
import 'package:city_care/widget/incident_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncidentListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incidents'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          IncidentList(),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  onPressed: () {
                    _navigateToReportIncidentPage(context);
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _navigateToReportIncidentPage(BuildContext context) async {
    final vm = Provider.of<ReportIncidentViewModel>(context, listen: false);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IncidentReportPage(
          vm: vm,
        ),
        fullscreenDialog: true,
      ),
    );
  }
}
