import 'dart:convert';
import 'dart:typed_data';

import 'package:admin/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../config/utils/styles/app_colors.dart';
import '../../../../../domain/Models/announcementModel.dart';
import '../../../../Cubits/navigation_cubit/navi_cubit.dart';
import '../../../../Shared/WidgetBuilders.dart';
import 'delete_announcement_screen.dart';

class ModifyAnnouncementScreen extends StatefulWidget {
  final AnnouncementModel announcementModel;

  ModifyAnnouncementScreen({Key? key, required this.announcementModel})
      : super(key: key);

  @override
  _ModifyAnnouncementScreenState createState() =>
      _ModifyAnnouncementScreenState();
}

class _ModifyAnnouncementScreenState extends State<ModifyAnnouncementScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;
  String? _imageBytes;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.announcementModel.title);
    _descriptionController =
        TextEditingController(text: widget.announcementModel.description);
    _dateController =
        TextEditingController(text: widget.announcementModel.date);
    _imageBytes = widget.announcementModel.image;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modify ${widget.announcementModel.title}'),
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
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      NaviCubit.get(context).navigate(context,
                          DeleteAnnouncementScreen(widget.announcementModel));
                    },
                    child: Text('Delete'),
                  ),
                  loadButton(
                      buttonWidth: getWidth(13, context),
                      onPressed: () {
                        onSubmitted();
                      },
                      textSize: 13,
                      buttonText: "Update"),
                  ElevatedButton(
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
        _imageBytes != null &&
        _titleController.text.isNotEmpty) {
      RemoteDataCubit.get(context)
          .updateAnnouncementPostsData(AnnouncementModel(
              date: _dateController.text,
              title: _titleController.text,
              description: _descriptionController.text,
              image: _imageBytes!))
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
