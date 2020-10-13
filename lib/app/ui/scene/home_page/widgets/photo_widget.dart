import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gallery_test/app/ui/scene/home_page/widgets/detail_picture_page.dart';
import 'package:gallery_test/data/gateway/picture.dart';

class PictureWidget extends StatelessWidget {
  final Picture picture;

  const PictureWidget(this.picture, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isSvg = this.picture.name.contains(".svg");

    void _tapHadler() {
      picture.incViews();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailPicturePage(picture),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(7.5),
      child: GestureDetector(
          onTap: _tapHadler,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: isSvg
                ? SvgPicture.network(
                    picture.url,
                    fit: BoxFit.contain,
                  )
                : CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: picture.url,
                    filterQuality: FilterQuality.medium,
                    placeholder: (context, url) =>
                        Image.asset("assets/logo.png"),
                  ),
          )),
    );
  }
}
