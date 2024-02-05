import 'dart:convert';
import 'dart:typed_data';

import 'package:admin/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:admin/presentation/Cubits/navigation_cubit/navi_cubit.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:admin/presentation/Shared/WidgetBuilders.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../config/utils/styles/app_colors.dart';
import '../../../../../domain/Models/UserModel.dart';

class ModifyAdminScreen extends StatefulWidget {
  final UserModel userModel;

  ModifyAdminScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  _ModifyAdminScreenState createState() => _ModifyAdminScreenState();
}

class _ModifyAdminScreenState extends State<ModifyAdminScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _addressController;
  String? _imageBytes;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userModel.name);
    _emailController = TextEditingController(text: widget.userModel.email);
    _phoneNumberController =
        TextEditingController(text: widget.userModel.phoneNumber);
    _addressController = TextEditingController(text: widget.userModel.address);
    _imageBytes = widget.userModel.photoID;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modify ${widget.userModel.name} Data'),
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
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 20),
              TextField(
                enabled: false,
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
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
                    buttonText: 'Modify',
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
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneNumberController.text.isNotEmpty &&
        _addressController.text.isNotEmpty) {
      UserModel userData = UserModel(
        name: _nameController.text,
        email: _emailController.text,
        password: widget.userModel.password,
        phoneNumber: _phoneNumberController.text,
        address: _addressController.text,
        photoID: _imageBytes ?? "NOPHOTO",
        userID: widget.userModel.userID,
        lastLogin: widget.userModel.lastLogin,
        lastAttend: widget.userModel.lastAttend,
        lastEleave: widget.userModel.lastEleave,
      );
      RemoteDataCubit.get(context)
          .updateAdminData(userData)
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
