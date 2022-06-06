import 'package:flutter/material.dart';
import 'package:janajaldoot/models/tripOrder.model.dart';
import 'package:janajaldoot/ui/helping_widget/custom_textfield.dart';
import 'package:janajaldoot/ui/helping_widget/round_button.dart';

class TripOtpScreen extends StatefulWidget {
  final TripOrderModel tripOrderModel;
  const TripOtpScreen({Key? key, required this.tripOrderModel})
      : super(key: key);

  @override
  State<TripOtpScreen> createState() => _TripOtpScreenState();
}

class _TripOtpScreenState extends State<TripOtpScreen> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'My Trips',
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'OTP Verification',
            style: TextStyle(
                fontSize: 20,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Order No : ',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'CO/22-23-563',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 1,
          ),
          Text(
            'A OTP will be sent on ${widget.tripOrderModel.customerMobile}.\nOTP is valid for 5 minutes.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 130,
            child: CustomTextField(
              isObscure: true,
              controller: otpController,
              text: 'OTP',
              maxLength: 4,
              textInputType: TextInputType.numberWithOptions(
                  signed: false, decimal: false),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
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
              SizedBox(
                height: 20,
              ),
              RoundButton(
                  onPress: () {},
                  color: Colors.green.shade600,
                  text: 'Send OTP'),
            ],
          ),
        ],
      ),
    );
  }
}
