import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gallery_test/app/ui/custom_widgets/logo_picture.dart';

class SplashScreen extends StatefulWidget {
  final Widget home;
  final Duration fadeDuration;
  final Duration delay;
  const SplashScreen({
    Key key,
    this.home,
    this.fadeDuration = const Duration(milliseconds: 1000),
    this.delay = const Duration(milliseconds: 1000),
  }) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller =
        AnimationController(duration: widget.fadeDuration, vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    _animate();
//this will start the animation
  }

  void _animate() async {
    await controller.forward();
    await Future.delayed(widget.delay);
    await controller.reverse();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => widget.home));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FadeTransition(
          opacity: animation,
          child: Center(
              child: LogoPicture(
            size: 200.0,
          )),
        ));
  }
}
