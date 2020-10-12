import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gallery_test/app/resources/app_colors.dart';
import 'package:gallery_test/app/resources/asset_images_path.dart';
import 'package:gallery_test/entity/gateway/picture.dart';

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        picture.name,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Text(picture.countOfViews.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.mainGray,
                              )),
                          Image.asset(
                            AssetImagePath.eyeIcon,
                            width: 13,
                            height: 13,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        picture.author,
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.mainGray,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${picture.createdAt.day}.${picture.createdAt.month}.${picture.createdAt.year}",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.mainGray,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                      maxLines: 10,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                ],
              ),
            )),
      ]),
    );
  }
}
