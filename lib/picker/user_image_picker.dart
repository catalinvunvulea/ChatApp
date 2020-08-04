import 'package:flutter/material.dart';

import 'dart:io'; //to use the File widget

import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) imagePickFn;

  UserImagePicker(this.imagePickFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  final _picker = ImagePicker();
 
  Future _pickImage() async {
    final pickedImageFile = await _picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,//reduce img quality to save space
      maxWidth: 150,
    );

    setState(() {
      _pickedImage = File(pickedImageFile.path);
      widget.imagePickFn(_pickedImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImage != null
              ? FileImage(
                  _pickedImage) //if we would use an immage from a link, we wouldn;t use FileImage
              : null,
        ),
        FlatButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
          textColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
