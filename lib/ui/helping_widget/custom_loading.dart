import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:math' as math;

class CustomLoading {
  static showLoading() {
    EasyLoading.show(indicator: RotatingIcon());
  }

  static removeLoading() {
    EasyLoading.dismiss();
  }
}

class RotatingIcon extends StatefulWidget {
  const RotatingIcon({Key? key}) : super(key: key);

  @override
  State<RotatingIcon> createState() => _RotatingIconState();
}

class _RotatingIconState extends State<RotatingIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 2))
        ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: child,
        );
      },
      child: Image.asset(
        "assets/images/icons/janajal_logo.png",
        height: 50,
      ),
    );
  }
}
