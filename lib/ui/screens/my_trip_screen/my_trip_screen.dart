import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:janajaldoot/controller/auth.controller.dart';
import 'package:janajaldoot/models/trip.model.dart';
import 'package:janajaldoot/sevices/trip.services.dart';
import 'package:janajaldoot/ui/helping_widget/camera_screen.dart';
import 'package:janajaldoot/ui/helping_widget/round_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:janajaldoot/ui/screens/home_screen/home_screen.dart';
import 'package:janajaldoot/ui/screens/main_widget.dart';
import 'package:janajaldoot/ui/screens/trip_details.dart/trip_details.dart';
import 'package:provider/provider.dart';

class MyTripScreen extends StatefulWidget {
  const MyTripScreen({Key? key}) : super(key: key);

  @override
  State<MyTripScreen> createState() => _MyTripScreenState();
}

class _MyTripScreenState extends State<MyTripScreen> {
  List<TripModel> tripList = [];
  @override
  void initState() {
    callApi();
    // TODO: implement initState
    super.initState();
  }

  callApi() async {
    tripList = await TripServices.getWOWTripList(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "navbar.my_trips".tr(),
        ),
      ),
      body: tripList.isEmpty
          ? Container()
          : ListView.builder(
              itemCount: tripList.length,
              itemBuilder: ((context, index) {
                // print(tripList[index].fileStatus);
                // print(tripList[index].statusId);
                // print(tripList[index].tripCode);
                // print("object $index");
                return TripCard(
                  tripModel: tripList[index],
                );
              })),
    );
  }
}

class TripCard extends StatefulWidget {
  final TripModel tripModel;
  TripCard({Key? key, required this.tripModel}) : super(key: key);

  @override
  State<TripCard> createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> {
  final ImagePicker _picker = ImagePicker();
  XFile? photo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(10),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                widget.tripModel.tripCode ?? "",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: widget.tripModel.fileStatus == 1
                        ? () {
                            EasyLoading.showToast('Already captured');
                          }
                        : () async {
                            photo = await _picker.pickImage(
                                source: ImageSource.camera, imageQuality: 1);

                            if (photo != null) {
                              await TripServices.uploadTripStartImage(
                                context,
                                widget.tripModel.tripId!,
                                '1',
                                '',
                                base64.encode(
                                  await photo!.readAsBytes(),
                                ),
                              );
                            }

                            print(base64.encode(await photo!.readAsBytes()));
                            setState(() {});
                          },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'my_trips_screen.capture_odometer'.tr(),
                      style: TextStyle(color: Colors.white),
                    ),
                    color: widget.tripModel.fileStatus == 1
                        ? Colors.red.shade300
                        : Colors.red.shade700,
                  ),
                  MaterialButton(
                    onPressed: widget.tripModel.fileStatus == 1
                        ? () {
                            Provider.of<AuthController>(context, listen: false)
                                .changeTripOrderList([]);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TripDetails(
                                tripCode: widget.tripModel.tripCode!,
                                tripId: widget.tripModel.tripId!,
                                status: widget.tripModel.statusId!,
                                showKMDialog: widget.tripModel.statusId == '8',
                              ),
                            ));
                          }
                        : () {
                            EasyLoading.showToast(
                                'Please capture Odometer\'s picture first');
                          },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      widget.tripModel.statusId == '10'
                          ? 'my_trips_screen.view_details'.tr()
                          : 'my_trips_screen.start_trip'.tr(),
                      style: TextStyle(color: Colors.white),
                    ),
                    color: widget.tripModel.statusId == '10'
                        ? Colors.blue.shade700
                        : widget.tripModel.fileStatus == 1
                            ? Colors.green.shade700
                            : Colors.green.shade300,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
