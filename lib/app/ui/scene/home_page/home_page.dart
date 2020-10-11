import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/ui/scene/home_page/widgets/search_field.dart';
import 'package:gallery_test/app/ui/scene/home_page/widgets/top_nav_bar.dart';

class HomePage extends StatelessWidget {
  final String id;

  const HomePage({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: SearchField(),
        bottom: TopNavigationBar(),
      ),
      body: Center(
        child: Text(
          id,
          style: TextStyle(fontSize: 20, color: Colors.green),
        ),
      ),
    );
  }
}
