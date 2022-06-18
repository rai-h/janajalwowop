import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:janajaldoot/controller/auth.controller.dart';
import 'package:janajaldoot/models/salesReport.model.dart';
import 'package:janajaldoot/sevices/wow.services.dart';
import 'package:janajaldoot/utils/janajal.dart';
import 'package:provider/provider.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  String startDate = Janajal.saleReportDareFormat.format(DateTime.now());
  String endDate = Janajal.saleReportDareFormat.format(DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1));

  @override
  void initState() {
    WOWServices.getWowSalesReport(context, 'WOW0005', startDate, endDate);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            'sales_report_screen.sales_report'.tr(),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'sales_report_screen.start_date'.tr(),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year,
                                    DateTime.now().month - 3),
                                lastDate: DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day + 1))
                            .then((value) async {
                          if (value != null) {
                            startDate =
                                Janajal.saleReportDareFormat.format(value);
                            String wowId = await Provider.of<AuthController>(
                                    context,
                                    listen: false)
                                .getWowId!;
                            await WOWServices.getWowSalesReport(context,
                                wowId.toUpperCase(), startDate, endDate);
                            setState(() {});
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          startDate,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  '_',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.w500),
                ),
                Column(
                  children: [
                    Text(
                      'sales_report_screen.end_date'.tr(),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year,
                                    DateTime.now().month - 3),
                                lastDate: DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day + 1))
                            .then((value) async {
                          if (value != null) {
                            endDate =
                                Janajal.saleReportDareFormat.format(value);
                            String wowId = await Provider.of<AuthController>(
                                    context,
                                    listen: false)
                                .getWowId!;
                            await WOWServices.getWowSalesReport(context,
                                wowId.toUpperCase(), startDate, endDate);
                            setState(() {});
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          endDate,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: size.width,
              height: size.height - 100,
              child: Consumer<AuthController>(builder: (context, notifier, _) {
                return notifier.getSalesReportModelList.isNotEmpty
                    ? SaleCard(
                        salesReportModel: notifier.getSalesReportModelList[0],
                        startDate: startDate,
                        endDate: endDate,
                      )
                    : Center(
                        child: Text(
                          'No Data',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      );
              }),
            ),
          ],
        ));
  }
}

class SaleCard extends StatelessWidget {
  final SalesReportModel salesReportModel;
  final String startDate;
  final String endDate;
  const SaleCard(
      {Key? key,
      required this.salesReportModel,
      required this.startDate,
      required this.endDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(20),
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(15),
        width: size.width * 0.9,
        height: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  startDate,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  '-',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  endDate,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'sales_report_screen.amount'.tr(),
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '\u{20B9} ${salesReportModel.d1amt.toString()}',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'sales_report_screen.quantity'.tr(),
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${salesReportModel.d1ltr.toString()} Ltrs',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
