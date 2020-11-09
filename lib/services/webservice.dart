import 'dart:io';
import 'package:path/path.dart';

import 'package:city_care/models/incident.dart';
import 'package:city_care/utils/constants.dart';
import 'package:dio/dio.dart';

class Webservice {
  Future<void> saveIncident(Incident incident) async {
    const url = '${kUrl}incidents';

    final File file = File(incident.imageURL);
    final filename = basename(file.path.replaceAll(' ', ''));

    final FormData formData = FormData.fromMap({
      'title': incident.title,
      'description': incident.description,
      'image':
          await MultipartFile.fromFile(incident.imageURL, filename: filename)
    });

    try {
      await Dio().post(
        url,
        data: formData,
      );
    } catch (e) {
      throw Exception('Faild Posting');
    }
  }

  Future<List<Incident>> getAllIncident() async {
    const url = '${kUrl}incidents';

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
