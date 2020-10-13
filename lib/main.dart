import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_test/app/ui/scene/home_page/home_page.dart';
import 'package:gallery_test/app/ui/scene/navigation_page/navigation_screen.dart';

import 'app/ui/scene/home_page/bloc/load_mode.dart';
import 'app/ui/scene/home_page/bloc/pictures_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.white,
        canvasColor: Colors.white,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PicturesBloc<NewLoadMode>(),
          ),
          BlocProvider(
            create: (context) => PicturesBloc<PopularLoadMode>(),
          ),
        ],
        child: NavigationScreen(),
      ),
    ); //WelcomeScreen());
  }
}
