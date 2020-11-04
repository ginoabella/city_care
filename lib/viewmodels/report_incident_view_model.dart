import 'package:city_care/models/incident.dart';
import 'package:city_care/services/webservice.dart';
import 'package:flutter/material.dart';

class ReportIncidentViewModel extends ChangeNotifier {
  String title;
  String description;

  Future<void> saveIncident() async {
    final incident = Incident(title: title, description: description);
    await Webservice().saveIncident(incident);
  }
}
