import 'package:city_care/viewmodels/incident_view_model.dart';
import 'package:flutter/material.dart';

class IncidentList extends StatelessWidget {
  final List<IncidentViewModel> incidents;

  const IncidentList({Key key, this.incidents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: incidents.length,
      itemBuilder: (context, index) {
        final incident = incidents[index];

        return ListTile(
          title: Text(incident.title),
        );
      },
    );
  }
}
