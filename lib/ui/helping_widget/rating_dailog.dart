import 'package:flutter/material.dart';
import 'package:janajaldoot/sevices/trip.services.dart';
import 'package:janajaldoot/ui/helping_widget/custom_textfield.dart';

showRatingDialog(
  BuildContext context,
  String orderId,
) async {
  TextEditingController controller = TextEditingController();
  int selectedRating = 0;

  controller.text = '';
  selectedRating = 0;
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: AlertDialog(
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: 220,
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState((() {
                                selectedRating = 1;
                              }));
                            },
                            child: Icon(
                              Icons.sentiment_very_dissatisfied,
                              size: 40,
                              color: selectedRating == 1
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState((() {
                                selectedRating = 2;
                              }));
                            },
                            child: Icon(
                              Icons.sentiment_dissatisfied,
                              size: 40,
                              color: selectedRating == 2
                                  ? Colors.redAccent
                                  : Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState((() {
                                selectedRating = 3;
                              }));
                            },
                            child: Icon(
                              Icons.sentiment_neutral,
                              size: 40,
                              color: selectedRating == 3
                                  ? Colors.amber
                                  : Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState((() {
                                selectedRating = 4;
                              }));
                            },
                            child: Icon(
                              Icons.sentiment_satisfied,
                              size: 40,
                              color: selectedRating == 4
                                  ? Colors.lightGreen
                                  : Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState((() {
                                selectedRating = 5;
                              }));
                            },
                            child: Icon(
                              Icons.sentiment_very_satisfied,
                              size: 40,
                              color: selectedRating == 5
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        text: "Comments",
                        maxLines: 3,
                        controller: controller,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        color: selectedRating == 0
                            ? Colors.blue.shade100
                            : Colors.blue,
                        minWidth: 0,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: selectedRating == 0
                            ? () {}
                            : () async {
                                await TripServices.saveOrderRating(
                                    context,
                                    orderId,
                                    selectedRating.toString(),
                                    controller.text,
                                    '1');
                              },
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          title: Center(
            child: Text(
              'Rate Your Order',
              style: TextStyle(
                color: Colors.red,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    },
  );
}
