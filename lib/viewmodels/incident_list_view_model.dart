import 'package:city_care/services/error_service.dart';
import 'package:city_care/services/webservice.dart';
import 'package:city_care/viewmodels/incident_view_model.dart';
import 'package:flutter/material.dart';

enum Status {
  loading,
  empty,
  successs,
  error,
}

class IncidentListViewModel extends ChangeNotifier {
  Status _status = Status.empty;

  Status get status => _status;

  List<IncidentViewModel> incidents = <IncidentViewModel>[];

  Future<void> getAllIncidents() async {
    _status = Status.loading;
    notifyListeners();

    final results = await Webservice().getAllIncident().catchError(
          (_) => ErrorService.setError(description: 'Failed retrieving Data'),
        );

    if (ErrorService.hasError(reset: true)) {
      _status = Status.error;
    } else {
      incidents = results
          .map(
            (incident) => IncidentViewModel(incident: incident),
          )
          .toList();
      _status = incidents.isEmpty ? Status.empty : Status.successs;
    }

    notifyListeners();
  }

  String get errorDescription => ErrorService.errorDescription;
}
