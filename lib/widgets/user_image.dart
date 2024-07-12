import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 150,
        imageQuality: 50 //تحديد جودة الصورة كلما زادت زادة المساحة التخزينية

        );

    if (pickedImage != null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
           foregroundImage:_pickedImageFile==null?null: FileImage(_pickedImageFile!),
        ),
        TextButton.icon(
          onPressed:_pickImage,
          icon: const Icon(Icons.image),
          label: Text(
            "add image",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        )
      ],
    );
  }
}
