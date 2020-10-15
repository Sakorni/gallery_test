import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/resources/asset_images_path.dart';
import 'package:gallery_test/app/ui/scene/navigation_page/bloc/repository_bloc.dart';
import 'package:gallery_test/data/gateway/user.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = BlocProvider.of<RepositoryBloc>(context).user;

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            FlatButton(onPressed: () => print("press"), child: Text("label")),
          ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColors.mainGray),
                    image: DecorationImage(
                      image: AssetImage(NavBarIconAssetsPath.photo),
                    ))),
          ),
          Text(
            user.name,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          Text(
            user.dayOfBirth,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.mainGray,
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.mainGray))),
          )
        ],
      ),
    );
  }
}
