import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:janajaldoot/controller/ui.controller.dart';
import 'package:provider/provider.dart';

showChangeLanguage(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: LanguageOption(),
        title: Center(
          child: Text(
            'profile_screen.change_language'.tr(),
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
        ),
        actions: [
          Center(
            child: MaterialButton(
              color: Colors.green,
              minWidth: 0,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      );
    },
  );
}

class LanguageOption extends StatefulWidget {
  const LanguageOption({Key? key}) : super(key: key);

  @override
  State<LanguageOption> createState() => _LanguageOptionState();
}

class _LanguageOptionState extends State<LanguageOption> {
  String selecteLanguage = 'English';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getInitialValue() {
    selecteLanguage = context.locale.languageCode == 'hi' ? "Hindi" : "English";
  }

  @override
  void didChangeDependencies() {
    getInitialValue();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                  value: "Hindi",
                  groupValue: selecteLanguage,
                  onChanged: (value) {
                    context.setLocale(Locale('hi', 'IN'));
                    Provider.of<UiController>(context, listen: false)
                        .changeNavbarIndex(1);
                    setState(() {
                      selecteLanguage = value.toString();
                    });
                  }),
              Text('Hindi',
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            children: [
              Radio(
                  value: "English",
                  groupValue: selecteLanguage,
                  onChanged: (value) {
                    context.setLocale(Locale('en', 'US'));
                    Provider.of<UiController>(context, listen: false)
                        .changeNavbarIndex(1);
                    setState(() {
                      selecteLanguage = value.toString();
                    });
                  }),
              Text(
                'English',
                style: TextStyle(
                    color: Colors.grey.shade800, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
