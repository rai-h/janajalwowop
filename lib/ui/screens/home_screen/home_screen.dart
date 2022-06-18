import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:janajaldoot/controller/auth.controller.dart';
import 'package:janajaldoot/sevices/wow.services.dart';
import 'package:janajaldoot/ui/helping_widget/change_langouge_dailog.dart';
import 'package:janajaldoot/ui/screens/login_screen/login_screen.dart';
import 'package:janajaldoot/utils/janajal.dart';
import 'package:janajaldoot/utils/shared_pref.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime now = DateTime.now();
  String startDate = Janajal.saleReportDareFormat.format(DateTime.now());
  String endDate = Janajal.saleReportDareFormat.format(DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1));
  String wowId = '';
  @override
  void initState() {
    callApi();
    // TODO: implement initState
    super.initState();
  }

  callApi() async {
    wowId = Provider.of<AuthController>(context, listen: false).getWowId!;
    WOWServices.getTodaysCollection(
        context, wowId.toUpperCase(), startDate, endDate);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            showChangeLanguage(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.deepPurple.shade800,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1)),
              child: Row(
                children: [
                  Text(
                    'A',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    '/अ',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                SharedPref.removeUserFromSharedPrefs();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
              },
              child: Icon(
                Icons.logout,
                size: 30,
              ),
            ),
          )
        ],
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.8),
        centerTitle: true,
        title: Image.asset(
          'assets/images/jjwowlogo.png',
          fit: BoxFit.contain,
          width: 90,
        ),
      ),
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Consumer<AuthController>(builder: (context, notifier, _) {
              return Column(
                children: [
                  ListTile(
                    leading: Image.asset('assets/images/icons/wow.png'),
                    title: Text(
                      'WOWID : ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    trailing: Text(
                      '${notifier.getWowId}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Material(
                    // elevation: 10,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueGrey.shade600.withOpacity(0.3),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: size.width * 0.95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'home_screen.my_wow_status'.tr(),
                            style: TextStyle(
                                color: Colors.blue.shade700,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          ListTile(
                            leading: Icon(Icons.opacity),
                            title: Text(
                              'home_screen.remaining_water'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            trailing: Text(
                              '${notifier.getRemainingWater} LTR(S)',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.storm),
                            title: Text(
                              'home_screen.ph'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            trailing: Text(
                              '${notifier.getPH}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.check_circle),
                            title: Text(
                              'home_screen.tds'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            trailing: Text(
                              '${notifier.getTds} ppm',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          // const ListTile(
                          //   leading: Icon(Icons.thermostat_auto),
                          //   title: Text(
                          //     'Temperature : ',
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.bold, fontSize: 16),
                          //   ),
                          //   trailing: Text(
                          //     '27.5 \u00B0C',
                          //     style: TextStyle(fontSize: 16),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(
              height: 20,
            ),
            Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 0,
              color: Colors.white70.withOpacity(0.2),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: Colors.black)),
                width: size.width * 0.95,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'home_screen.todays_collection'.tr(),
                      style: TextStyle(
                          color: Colors.deepOrange.shade500,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      height: 10,
                      thickness: 2,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<AuthController>(builder: (context, notifier, _) {
                      return Container(
                        padding: const EdgeInsets.all(45),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                        child: Text(
                          '\u{20B9} ${notifier.getTodaysCollection}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
