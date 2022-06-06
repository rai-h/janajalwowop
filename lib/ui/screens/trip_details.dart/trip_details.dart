import 'package:flutter/material.dart';
import 'package:janajaldoot/models/tripOrder.model.dart';
import 'package:janajaldoot/sevices/trip.services.dart';
import 'package:janajaldoot/ui/helping_widget/round_button.dart';
import 'package:janajaldoot/ui/screens/trip_otp_screen/trip_otp_screen.dart';
import 'package:maps_launcher/maps_launcher.dart';

class TripDetails extends StatefulWidget {
  final String tripId;
  final String status;
  final String tripCode;
  const TripDetails(
      {Key? key,
      required this.tripId,
      required this.status,
      required this.tripCode})
      : super(key: key);

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  List<TripOrderModel> tripOrderList = [];
  @override
  void initState() {
    callApi();
    // TODO: implement initState
    super.initState();
  }

  callApi() async {
    tripOrderList =
        await TripServices.getTripOrderList(context, widget.tripId, '10', '0');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.tripCode,
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: ListView.builder(
        itemCount: tripOrderList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              TripDetailsCard(
                tripOrderModel: tripOrderList[index],
              ),
              Divider(
                thickness: 1,
              )
            ],
          );
        },
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
                    'Quantity: ',
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
                'Customer Details: ',
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
                'Delivery Location: ',
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
                'Delivery Point: ',
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
          Row(
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
                  text: 'Deliver'),
              RoundButton(
                  onPress: () {
                    MapsLauncher.launchCoordinates(
                        double.parse(widget.tripOrderModel.latitude!),
                        double.parse(widget.tripOrderModel.longtitude!));
                  },
                  color: Colors.green.shade600,
                  text: 'GO'),
            ],
          ),
        ],
      ),
    );
  }
}
