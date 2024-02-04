import 'dart:convert';
import 'dart:typed_data';

import 'package:admin/config/utils/styles/app_colors.dart';
import 'package:admin/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:admin/domain/Models/eventModel.dart';
import 'package:admin/presentation/Cubits/navigation_cubit/navi_cubit.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:admin/presentation/Shared/WidgetBuilders.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEventScreen extends StatefulWidget {
  AddEventScreen({Key? key}) : super(key: key);

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;
  late TextEditingController _locationName;
  late TextEditingController _locationLatitude;
  late TextEditingController _locationLongitude;
  String? _imageBytes;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _dateController = TextEditingController();
    _locationName = TextEditingController();
    _locationLatitude = TextEditingController();
    _locationLongitude = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _locationName.dispose();
    _locationLatitude.dispose();
    _locationLongitude.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new Event'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Container(
          width: getWidth(30, context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  _imageBytes = null;
                  _pickFile();
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: getHeight(20, context),
                    width: getWidth(45, context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.rectangle,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: (_imageBytes != null)
                        ? previewImage(
                            onTap: () {
                              _imageBytes = null;
                              _pickFile();
                            },
                            photoRadius: 20,
                            context: context,
                            fileUser: _imageBytes,
                            editable: true)
                        : chooseFile(context),
                  ),
                ),
              ),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _locationName,
                decoration: InputDecoration(labelText: 'Location Name'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _locationLatitude,
                decoration: InputDecoration(labelText: 'Location Latitude'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _locationLongitude,
                decoration: InputDecoration(labelText: 'Location Longitude'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  loadButton(
                    buttonWidth: getWidth(13, context),
                    textSize: 13,
                    onPressed: () {
                      onSubmitted();
                    },
                    buttonText: 'Add',
                  ),
                  TextButton(
                    onPressed: () {
                      NaviCubit.get(context).pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  onSubmitted() {
    if (_dateController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _locationName.text.isNotEmpty &&
        _locationLongitude.text.isNotEmpty &&
        _locationLatitude.text.isNotEmpty &&
        _imageBytes != null &&
        _titleController.text.isNotEmpty) {
      RemoteDataCubit.get(context)
          .addEventPostsData(EventModel(
              date: _dateController.text,
              title: _titleController.text,
              description: _descriptionController.text,
              image: _imageBytes!,
              locationName: _locationName.text,
              locationLatitude: _locationLatitude.text,
              locationLongitude: _locationLongitude.text,
              datePublished: DateTime.now().toString()))
          .then((value) => NaviCubit.get(context).pop(context));
    } else {
      showToast("Please fill in all details", AppColors.primaryColor, context);
    }
  }

  void _pickFile() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      Uint8List bytesUint8List = Uint8List.fromList(bytes);
      setState(() {
        _imageBytes = base64Encode(bytesUint8List);
      });
    }
  }
}
