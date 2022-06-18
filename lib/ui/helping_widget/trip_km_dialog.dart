import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:janajaldoot/sevices/trip.services.dart';
import 'package:janajaldoot/ui/helping_widget/custom_textfield.dart';
import 'package:janajaldoot/ui/screens/home_screen/home_screen.dart';
import 'package:janajaldoot/ui/screens/main_widget.dart';

showKMtDialog(
  BuildContext context,
  TextEditingController kmController,
  String tripId,
  String status, {
  bool endTrip = false,
}) async {
  String errorText = '';
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: AlertDialog(
          content: SizedBox(
            height: 50,
            child: Center(
              child: CustomTextField(
                text: 'KM',
                controller: kmController,
                textInputType: TextInputType.number,
              ),
            ),
          ),
          title: Container(
              child: Text(
            'Enter Trip ${endTrip ? 'End' : 'Start'} KM',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          )),
          actions: [
            MaterialButton(
              color: Colors.green,
              minWidth: 0,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () async {
                if (kmController.text.trim().length != 0) {
                  endTrip
                      ? await TripServices.updateTripEndStatus(
                          context,
                          tripId,
                          kmController.text.trim(),
                        )
                      : await TripServices.getTripOrderList(
                          context,
                          tripId,
                          status,
                          kmController.text.isEmpty
                              ? '0'
                              : kmController.text.trim(),
                        );
                } else {
                  EasyLoading.showToast('Please enter valid');
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            MaterialButton(
              color: Colors.red.shade600,
              minWidth: 0,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () async {
                endTrip
                    ? Navigator.pop(context)
                    : Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => MainWidget(),
                        ),
                        (route) => false);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
