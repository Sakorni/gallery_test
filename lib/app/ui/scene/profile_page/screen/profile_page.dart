import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/resources/asset_images_path.dart';
import 'package:gallery_test/app/ui/scene/home_page/bloc/load_mode.dart';
import 'package:gallery_test/app/ui/scene/home_page/bloc/pictures_bloc.dart';
import 'package:gallery_test/app/ui/scene/home_page/widgets/list_of_pictures.dart';
import 'package:gallery_test/app/ui/scene/navigation_page/bloc/repository_bloc.dart';
import 'package:gallery_test/app/ui/scene/profile_page/widgets/circled_photo.dart';
import 'package:gallery_test/app/ui/scene/settings_page/settings_page.dart';
import 'package:gallery_test/data/gateway/user.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool focusedNow = true;
  void addListener() {
    var focus = FocusScope.of(context);
    if (!focus.hasListeners) {
      focus.addListener(() {
        if (focus.hasPrimaryFocus && (!focusedNow)) {
          setState(() {
            focusedNow = true;
          });
        }
        if (!focus.hasPrimaryFocus && focusedNow) focusedNow = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    addListener();
    User user = BlocProvider.of<RepositoryBloc>(context).user;

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
                onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(user),
                      ),
                    ),
                child: Image.asset(
                  AssetImagePath.settingsIcon,
                  scale: 1.5,
                )),
          ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircledPhoto(size: 100),
          SizedBox(height: 10),
          Text(
            user.name,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          SizedBox(height: 8),
          Text(
            user.dayOfBirth,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.mainGray,
            ),
          ),
          SizedBox(height: 27),
          Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: [
                DisplayField.views(user.views),
                DisplayField.loaded(user.loaded),
              ],
            ),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.mainGray))),
          ),
          Expanded(
            child: BlocProvider(
              create: (context) => PicturesBloc<UserMode>(email: user.email),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListOfPhotoPage<UserMode>(itemsInARow: 4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DisplayField extends StatelessWidget {
  final int value;
  final String text;
  DisplayField.views(this.value) : this.text = "Views: ";
  DisplayField.loaded(this.value) : this.text = "Loaded: ";
  String displayValue() => value > 999 ? "999+" : value.toString();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: RichText(
        text: TextSpan(
            style: TextStyle(fontSize: 12, color: Colors.black),
            children: [
              TextSpan(
                text: text,
              ),
              TextSpan(
                  text: displayValue(),
                  style: TextStyle(color: AppColors.mainGray)),
            ]),
      ),
    );
  }
}
