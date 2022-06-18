import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:janajaldoot/models/tripOrder.model.dart';
import 'package:janajaldoot/sevices/trip.services.dart';
import 'package:janajaldoot/ui/helping_widget/custom_textfield.dart';
import 'package:janajaldoot/ui/helping_widget/rating_dailog.dart';
import 'package:janajaldoot/ui/helping_widget/round_button.dart';

class TripOtpScreen extends StatefulWidget {
  final TripOrderModel tripOrderModel;
  const TripOtpScreen({Key? key, required this.tripOrderModel})
      : super(key: key);

  @override
  State<TripOtpScreen> createState() => _TripOtpScreenState();
}

class _TripOtpScreenState extends State<TripOtpScreen> {
  bool showOtpButton = true;
  TextEditingController otpController = TextEditingController();
  String otpErorr = '';
  String otp = '';
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
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'trip_otp_screen.otp_verification'.tr(),
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
            'trip_otp_screen.otp_text'.tr() +
                " "
                    '${widget.tripOrderModel.customerMobile}.\n' +
                'trip_otp_screen.otp_text_1'.tr(),
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
              errorText: otpErorr,
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
                    if (otpController.text != otp || otp.isEmpty) {
                      otpErorr = 'Invalid OTP';
                    } else {
                      otpErorr = '';

                      TripServices.updateOrderStatus(
                        context,
                        widget.tripOrderModel.tripId!,
                        '10',
                        widget.tripOrderModel.orderId!,
                        '10',
                        widget.tripOrderModel.customerMobile!,
                        widget.tripOrderModel.orderNo!,
                        otp,
                      );
                    }
                    setState(() {});
                  },
                  color: Colors.blue.shade600,
                  text: 'my_trips_screen.deliver'.tr()),
              SizedBox(
                height: 20,
              ),
              showOtpButton
                  ? RoundButton(
                      onPress: () async {
                        otp = await TripServices.getOrderOtp(
                            context,
                            widget.tripOrderModel.tripId!,
                            widget.tripOrderModel.statusId!,
                            widget.tripOrderModel.orderId!,
                            widget.tripOrderModel.orderStatus!,
                            widget.tripOrderModel.customerMobile!,
                            widget.tripOrderModel.orderNo!);
                        if (otp.isNotEmpty) {
                          showOtpButton = false;
                          setState(() {});
                        }
                      },
                      color: Colors.green.shade600,
                      text: 'trip_otp_screen.send_otp'.tr())
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
