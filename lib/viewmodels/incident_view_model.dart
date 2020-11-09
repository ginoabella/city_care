import 'package:city_care/models/incident.dart';

class IncidentViewModel {
  final Incident incident;

  IncidentViewModel({this.incident});

  String get title => incident.title;

  String get description => incident.description;

  String get imageURL => incident.imageURL;
}
