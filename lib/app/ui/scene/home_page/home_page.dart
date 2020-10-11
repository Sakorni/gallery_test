import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gallery_test/app/ui/scene/home_page/widgets/preloader.dart';
import 'package:gallery_test/app/ui/scene/home_page/widgets/search_field.dart';
import 'package:gallery_test/app/ui/scene/home_page/widgets/top_nav_bar.dart';

class HomePage extends StatefulWidget {
  final String id;

  const HomePage({Key key, this.id}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex;
  List<Widget> pages = [
    Center(
      child: Text("1"),
    ),
    Preloader(),
  ];

  void topNavigatorTapHandler(int index) {
    if (selectedIndex != index) {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: SearchField(),
        bottom: TopNavigationBar(
          tapHandler: topNavigatorTapHandler,
        ),
      ),
      body: pages[selectedIndex],
    );
  }
}
