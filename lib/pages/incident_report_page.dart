import 'dart:io';

import 'package:camera/camera.dart';
import 'package:city_care/pages/take_picture_page.dart';
import 'package:city_care/viewmodels/report_incident_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class IncidentReportPage extends StatefulWidget {
  final ReportIncidentViewModel vm;

  const IncidentReportPage({Key key, this.vm}) : super(key: key);

  @override
  _IncidentReportPageState createState() => _IncidentReportPageState();
}

class _IncidentReportPageState extends State<IncidentReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report an Incident'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              child: widget.vm.imagePath == null
                  ? Image.asset(
                      'images/CarImage.jpg',
                      fit: BoxFit.cover,
                    )
                  : Image.file(File(widget.vm.imagePath)),
            ),
            FlatButton(
              color: Colors.grey,
              onPressed: () {
                _showPhotoSelectionOptions(context);
              },
              child: const Text(
                'Take Picture',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextField(
              onChanged: (value) => widget.vm.title = value,
              decoration: InputDecoration(
                labelText: 'Enter Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            TextField(
              onChanged: (value) => widget.vm.description = value,
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
                // TODO: So that this can only be executed or pressed once
                _buildSaveIncident(context, widget.vm);
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

  Future<void> _showPhotoSelectionOptions(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take a Picture'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_album),
                title: const Text('Select from Photo Library'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showPhotoAlbum();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showPhotoAlbum() async {
    final PickedFile pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() => widget.vm.imagePath = pickedImage.path);
    }
  }

  Future<void> _showCamera() async {
    // below commented code is also working and simpler
    // final PickedFile pickedImage =
    //     await ImagePicker().getImage(source: ImageSource.camera);
    // if (pickedImage != null) {
    //   setState(() => widget.vm.imagePath = pickedImage.path);
    // }

    final cameras = await availableCameras();
    final camera = cameras.first;

    final String result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TakePicturePage(camera: camera),
      ),
    );
    if (result != null) {
      setState(() => widget.vm.imagePath = result);
      print(result);
    }
  }
}
