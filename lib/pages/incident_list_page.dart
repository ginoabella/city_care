import 'package:city_care/pages/incident_report_page.dart';
import 'package:city_care/viewmodels/incident_list_view_model.dart';
import 'package:city_care/viewmodels/report_incident_view_model.dart';
import 'package:city_care/widget/incident_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncidentListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final incidentListViewVM = Provider.of<IncidentListViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Incidents'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          _buildIncidentList(incidentListViewVM),
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

  Widget _buildIncidentList(IncidentListViewModel incidentListViewVM) {
    switch (incidentListViewVM.status) {
      case Status.loading:
        return const Center(child: CircularProgressIndicator());
      case Status.empty:
        return const Center(child: Text("No incident found"));
      case Status.successs:
        return IncidentList(incidents: incidentListViewVM.incidents);
      case Status.error:
        return Text(incidentListViewVM.errorDescription);
    }
    return const Text('Error......'); // should not go this point
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
    Provider.of<IncidentListViewModel>(context, listen: false)
        .getAllIncidents();
  }
}
