import 'package:flutter/material.dart';
import 'package:janajaldoot/controller/auth.controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
                            'My WOW Status',
                            style: TextStyle(
                                color: Colors.blue.shade700,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          ListTile(
                            leading: Icon(Icons.opacity),
                            title: Text(
                              'Remainig Water : ',
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
                              'pH : ',
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
                              'TDS : ',
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
                      'Today\'s Collection',
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
                    Container(
                      padding: const EdgeInsets.all(45),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: const Text(
                        '\u{20B9} 356',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    )
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
