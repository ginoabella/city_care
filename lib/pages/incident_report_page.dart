import 'package:city_care/viewmodels/report_incident_view_model.dart';
import 'package:flutter/material.dart';

class IncidentReportPage extends StatelessWidget {
  final ReportIncidentViewModel vm;

  const IncidentReportPage({Key key, this.vm}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //final vm = Provider.of<ReportIncidentViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report an Incident'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              onChanged: (value) => vm.title = value,
              decoration: InputDecoration(
                labelText: 'Enter Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            TextField(
              onChanged: (value) => vm.description = value,
              textInputAction: TextInputAction.done,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                labelText: 'Enter Description',
              ),
            ),
            FlatButton(
              color: Colors.green,
              onPressed: () {
                _buildSaveIncident(context, vm);
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _buildSaveIncident(
      BuildContext context, ReportIncidentViewModel vm) async {
    // TODO: validation can be done here and execute save incident if valid
    // TODO: display progress indicator
    await vm.saveIncident();
    // TODO: catch error
    Navigator.pop(context);
  }
}
