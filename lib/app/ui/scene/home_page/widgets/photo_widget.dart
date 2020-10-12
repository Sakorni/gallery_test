import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gallery_test/entity/gateway/picture.dart';

class PhotoWidget extends StatelessWidget {
  final Picture photo;

  const PhotoWidget(this.photo, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double _width = 166;
    double _height = 166;
    bool isSvg = this.photo.name.contains(".svg");
    BoxDecoration _decoration() {
      if (!isSvg) {
        return BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
            )
          ],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: ResizeImage(
                NetworkImage(
                  photo.url,
                ),
                width: _width.floor() * 3,
                height: _height.floor() * 3),
          ),
        );
      } else {
        return BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
            )
          ],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
        );
      }
    }

    void _tapHadler() => print("Image tapped");
    /*Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PhotoPage(photo),
          ),
        );*/

    return Padding(
      padding: const EdgeInsets.all(7.5),
      child: GestureDetector(
        onTap: _tapHadler,
        child: Container(
          width: _width,
          height: _width,
          child: isSvg
              ? SvgPicture.network(
                  photo.url,
                  fit: BoxFit.contain,
                )
              : null,
          decoration: _decoration(),
        ),
      ),
    );
  }
}
