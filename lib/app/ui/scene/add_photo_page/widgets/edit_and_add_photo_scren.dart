import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/ui/scene/add_photo_page/widgets/photo_text_field.dart';

class EditAndAddPhotoScreen extends StatelessWidget {
  final FocusNode _nameNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _descriptionKey = GlobalKey<FormState>();
  final File pictureFile;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<String> tags = [];
  EditAndAddPhotoScreen(this.pictureFile);
  void dropFocus(BuildContext context) {
    Focus.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          FlatButton(
            onPressed: () => print("tapped"),
            child: Text(
              "Add",
              style: TextStyle(color: AppColors.underLineColor, fontSize: 15),
            ),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => dropFocus(context),
        child: Flex(direction: Axis.vertical, children: [
          Expanded(
            child: Image.file(
              pictureFile,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PhotoTextField.nameField(
                        controller: _nameController,
                        focusNode: _nameNode,
                        validKey: _nameKey,
                        action: () => _descriptionNode.requestFocus()),
                    SizedBox(
                      height: 10,
                    ),
                    PhotoTextField.descriptionField(
                        controller: _descriptionController,
                        focusNode: _descriptionNode,
                        validKey: _descriptionKey,
                        action: () => dropFocus(context)),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
