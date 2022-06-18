import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:janajaldoot/controller/auth.controller.dart';
import 'package:janajaldoot/models/tripOrder.model.dart';
import 'package:janajaldoot/sevices/trip.services.dart';
import 'package:janajaldoot/ui/helping_widget/round_button.dart';
import 'package:janajaldoot/ui/helping_widget/trip_km_dialog.dart';
import 'package:janajaldoot/ui/screens/main_widget.dart';
import 'package:janajaldoot/ui/screens/my_trip_screen/my_trip_screen.dart';
import 'package:janajaldoot/ui/screens/trip_otp_screen/trip_otp_screen.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';

class TripDetails extends StatefulWidget {
  final String tripId;
  final String status;
  final String tripCode;
  final bool showKMDialog;
  const TripDetails(
      {Key? key,
      required this.tripId,
      required this.status,
      required this.tripCode,
      this.showKMDialog = false})
      : super(key: key);

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  List<TripOrderModel> tripOrderList = [];
  TextEditingController kmController = TextEditingController();
  bool isTripCompleted = true;
  bool endTripFileStatus = false;
  final ImagePicker _picker = ImagePicker();
  XFile? photo;
  @override
  void initState() {
    print(widget.status);
    widget.showKMDialog
        ? WidgetsBinding.instance!.addPostFrameCallback((_) async {
            await showKMtDialog(
                context, kmController, widget.tripId, widget.status);
          })
        : callApi();

    // TODO: implement initState
    super.initState();
  }

  callApi() async {
    await TripServices.getTripOrderList(
      context,
      widget.tripId,
      widget.status,
      kmController.text.isEmpty ? '0' : kmController.text.trim(),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => MainWidget(),
            ),
            (route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            widget.tripCode,
            style: TextStyle(fontSize: 22),
          ),
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => MainWidget(),
                    ),
                    (route) => false);
              },
              child: const Icon(Icons.arrow_back_ios_new_rounded)),
        ),
        body: Consumer<AuthController>(builder: (context, notifier, _) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: notifier.getTripTripOrderList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      TripDetailsCard(
                        tripOrderModel: notifier.getTripTripOrderList[index],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      notifier.getTripTripOrderList.length - 1 == index
                          ? SizedBox(
                              height: 50,
                            )
                          : Container()
                    ],
                  );
                },
              ),
              notifier.isTripCompleted
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: !notifier.endTripFileStatus
                          ? MaterialButton(
                              onPressed: () async {
                                photo = await _picker.pickImage(
                                    source: ImageSource.camera,
                                    imageQuality: 5);

                                if (photo != null) {
                                  await TripServices.uploadTripStartImage(
                                    context,
                                    widget.tripId,
                                    '2',
                                    '',
                                    base64.encode(
                                      await photo!.readAsBytes(),
                                    ),
                                  );
                                }

                                // print(base64.encode(photo!.readAsBytes()));
                                setState(() {});
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text(
                                'Capture Odometer',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.red.shade700,
                            )
                          : MaterialButton(
                              onPressed: () async {
                                await showKMtDialog(
                                  context,
                                  kmController,
                                  widget.tripId,
                                  widget.status,
                                  endTrip: true,
                                );
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text(
                                'End Trip',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.blue.shade700,
                            ),
                    )
                  : Container(),
            ],
          );
        }),
      ),
    );
  }
}

class TripDetailsCard extends StatefulWidget {
  final TripOrderModel tripOrderModel;
  const TripDetailsCard({Key? key, required this.tripOrderModel})
      : super(key: key);

  @override
  State<TripDetailsCard> createState() => _TripDetailsCardState();
}

class _TripDetailsCardState extends State<TripDetailsCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.tripOrderModel.orderNo.toString(),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'my_trips_screen.qunatity'.tr(),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: Text(
                      widget.tripOrderModel.quantity.toString(),
                      maxLines: 3,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'my_trips_screen.customer_details'.tr(),
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: size.width * 0.5,
                child: Text(
                  '${widget.tripOrderModel.customerName.toString()} \n ${widget.tripOrderModel.customerMobile.toString()}',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'my_trips_screen.delivery_location'.tr(),
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: size.width * 0.5,
                child: Text(
                  widget.tripOrderModel.deliveryLocation.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'my_trips_screen.delivery_point'.tr(),
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: size.width * 0.5,
                child: Text(
                  widget.tripOrderModel.deliveryLocation.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          widget.tripOrderModel.orderStatus != '12'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RoundButton(
                        onPress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => TripOtpScreen(
                                    tripOrderModel: widget.tripOrderModel,
                                  ))));
                        },
                        color: Colors.blue.shade600,
                        text: 'my_trips_screen.deliver'.tr()),
                    RoundButton(
                        onPress: () {
                          MapsLauncher.launchCoordinates(
                              double.parse(widget.tripOrderModel.latitude!),
                              double.parse(widget.tripOrderModel.longtitude!));
                        },
                        color: Colors.green.shade600,
                        text: 'my_trips_screen.navigate'.tr()),
                  ],
                )
              : Text(
                  'Delivered',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.w600),
                ),
        ],
      ),
    );
  }
}
