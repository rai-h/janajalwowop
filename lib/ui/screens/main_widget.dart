import 'package:flutter/material.dart';
import 'package:janajaldoot/controller/ui.controller.dart';
import 'package:janajaldoot/ui/helping_widget/custom_navbar.dart';
import 'package:provider/provider.dart';

class MainWidget extends StatefulWidget {
  final bool showToast;
  final String toastString;
  const MainWidget({Key? key, this.showToast = false, this.toastString = ''})
      : super(key: key);

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  String deviceId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<UiController>(builder: (context, notifier, _) {
      return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Positioned(
              top: -(size.width * 0.2),
              left: -(size.width * 0.2),
              child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    'assets/images/janajal_logo.png',
                    fit: BoxFit.fill,
                    width: size.width * 0.7,
                  )),
            ),
            Positioned(
              bottom: -(size.width * 0.2),
              right: -(size.width * 0.2),
              child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    'assets/images/janajal_logo.png',
                    fit: BoxFit.contain,
                    width: size.width * 0.9,
                  )),
            ),
            Align(
              alignment: Alignment.center,
              child: Opacity(
                  opacity: 0.1,
                  child: Image.asset(
                    'assets/images/wow.png',
                    fit: BoxFit.fill,
                    width: size.width * 0.7,
                  )),
            ),
            Container(
              child: notifier.mainWidget,
            ),
          ],
        ),
        bottomNavigationBar: const CustomNavbar(),
      );
    });
  }
}
