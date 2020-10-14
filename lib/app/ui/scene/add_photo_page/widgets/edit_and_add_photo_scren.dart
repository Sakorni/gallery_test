import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/ui/custom_widgets/tag_field.dart';
import 'package:gallery_test/app/ui/scene/add_photo_page/widgets/empty_tag.dart';
import 'package:gallery_test/app/ui/scene/add_photo_page/widgets/photo_text_field.dart';
import 'package:gallery_test/app/ui/scene/auth_page/bloc/utils/text_validators.dart';
import 'package:gallery_test/app/ui/scene/navigation_page/bloc/repository_bloc.dart';
import 'package:gallery_test/repository/firebase/firebase_firestore.dart';

class EditAndAddPhotoScreen extends StatefulWidget {
  final File pictureFile;
  final String email;

  EditAndAddPhotoScreen(this.pictureFile, this.email);

  @override
  _EditAndAddPhotoScreenState createState() => _EditAndAddPhotoScreenState();
}

class _EditAndAddPhotoScreenState extends State<EditAndAddPhotoScreen> {
  final FocusNode _nameNode = FocusNode();

  final FocusNode _descriptionNode = FocusNode();

  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _descriptionKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _newTagController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final List<String> tags = [];

  void dropFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void addTag() {
    String text = _newTagController.text;
    if (text.isNotEmpty) {
      _newTagController.clear();
      setState(() {
        tags.add(text);
      });
    }
  }

  void removeTag(String tag) {
    setState(() {
      tags.remove(tag);
    });
  }

  void addPicture(BuildContext context) {
    if (TextValidators.allValidated([_nameKey, _descriptionKey])) {
      FireStore.createImg(widget.pictureFile,
          author: widget.email,
          description: _descriptionController.text,
          name: _nameController.text,
          tags: tags);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tagList = List<Widget>.from(tags.map(
        (tag) => TagField.temporary(tag: tag, action: () => removeTag(tag))));
    tagList.add(EmptyTagField(controller: _newTagController, action: addTag));
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          FlatButton(
            onPressed: () => addPicture(context),
            child: Text(
              "Add",
              style: TextStyle(color: AppColors.underLineColor, fontSize: 15),
            ),
          )
        ],
      ),
      body: GestureDetector(
        excludeFromSemantics: true,
        onTap: () => dropFocus(context),
        child: Flex(direction: Axis.vertical, children: [
          Expanded(
            child: Image.file(
              widget.pictureFile,
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
                    Wrap(children: tagList)
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
