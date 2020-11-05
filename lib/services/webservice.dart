import 'package:city_care/models/incident.dart';
import 'package:dio/dio.dart';

class Webservice {
  Future<void> saveIncident(Incident incident) async {
    const url = 'https://vast-savannah-75068.herokuapp.com/incidentsNoImage';

    try {
      await Dio().post(
        url,
        data: {
          'title': incident.title,
          'description': incident.description,
        },
        options: Options(contentType: 'application/x-www-form-urlencoded'),
      );
    } catch (e) {
      throw Exception('Faild Posting');
    }
  }

  Future<List<Incident>> getAllIncident() async {
    const url = 'https://vast-savannah-75068.herokuapp.com/incidents';

    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final Iterable list = response.data as List;
        return list
            .map((incident) =>
                Incident.fromJson(incident as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Unable to get the list of Incidents');
      }
    } catch (e) {
      throw Exception('Failed get');
    }
  }
}
