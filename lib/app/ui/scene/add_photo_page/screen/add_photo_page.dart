import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_test/app/ui/custom_widgets/action_button.dart';
import 'package:gallery_test/app/ui/scene/add_photo_page/widgets/edit_and_add_photo_scren.dart';
import 'package:gallery_test/app/ui/scene/navigation_page/bloc/repository_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddPhotoPage extends StatelessWidget {
  ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    String email = context
        .bloc<RepositoryBloc>()
        .user
        .email; // Да, переменная в билде, но мне нужен этот email
    return Center(
        child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ActionButton(
        onPressed: () async {
          PickedFile pickedFile =
              await _picker.getImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            File file = File(pickedFile.path);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditAndAddPhotoScreen(file, email)));
          }
        },
        caption: "Add photo",
        backGroundColor: Colors.white,
        textColor: Colors.black,
      ),
    ));
  }
}
