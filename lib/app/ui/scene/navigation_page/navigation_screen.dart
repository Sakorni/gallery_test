import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/resources/asset_images_path.dart';
import 'package:gallery_test/app/ui/scene/add_photo_page/screen/add_photo_page.dart';
import 'package:gallery_test/app/ui/scene/home_page/bloc/load_mode.dart';
import 'package:gallery_test/app/ui/scene/home_page/bloc/pictures_bloc.dart';
import 'package:gallery_test/app/ui/scene/home_page/home_page.dart';
import 'package:gallery_test/app/ui/scene/navigation_page/bloc/repository_bloc.dart';
import 'package:gallery_test/app/ui/scene/profile_page/bloc/profile_pic_bloc.dart';
import 'package:gallery_test/app/ui/scene/profile_page/screen/profile_page.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int index;
  double _size = 23;
  final homePage = MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => PicturesBloc<NewLoadMode>(),
      ),
      BlocProvider(
        create: (context) => PicturesBloc<PopularLoadMode>(),
      ),
    ],
    child: HomePage(),
  );
  final photoPage = AddPhotoPage();
  final profilePage = BlocProvider(
      create: (context) =>
          ProfilePicBloc(context.bloc<RepositoryBloc>().user.email),
      child: ProfilePage());
  List<Widget> pages = [];

  @override
  void initState() {
    index = 0;
    pages = [homePage, photoPage, profilePage];
    super.initState();
  }

  void tapHandler(int index) {
    setState(() {
      this.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: tapHandler,
          items: [
            BottomNavigationBarItem(
                label: '',
                icon: Image.asset(
                  NavBarIconAssetsPath.home,
                  width: _size,
                  height: _size,
                )),
            BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                NavBarIconAssetsPath.photo,
                width: _size,
                height: _size,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                NavBarIconAssetsPath.profile,
                width: _size,
                height: _size,
              ),
            )
          ],
          unselectedItemColor: AppColors.mainGray,
          selectedItemColor: AppColors.underLineColor,
        ),
        body: IndexedStack(
          children: pages,
          index: index,
        ));
  }
}
