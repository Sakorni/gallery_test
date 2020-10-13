import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/resources/asset_images_path.dart';
import 'package:gallery_test/app/ui/scene/home_page/widgets/tag_field.dart';
import 'package:gallery_test/app/ui/scene/home_page/widgets/under_picture_fields.dart';
import 'package:gallery_test/data/gateway/picture.dart';

class DetailPicturePage extends StatelessWidget {
  final Picture picture;

  const DetailPicturePage(this.picture);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Flex(direction: Axis.vertical, children: [
        Expanded(
          flex: 1,
          child: CachedNetworkImage(
            imageUrl: picture.url,
            fit: BoxFit.fill,
          ),
        ),
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  UnderPictureField.nameAndViews(
                    name: picture.name,
                    views: picture.countOfViews,
                  ),
                  SizedBox(height: 10),
                  UnderPictureField.authorAndDate(
                    author: picture.author,
                    date: picture.createdAt,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: Text(
                      picture.description,
                      maxLines: 10,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                      children:
                          picture.tags.map((tag) => TagField(tag)).toList()),
                ],
              ),
            )),
      ]),
    );
  }
}
