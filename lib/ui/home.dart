import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tripmanager/modals/colors.dart';
import 'package:tripmanager/ui/dashboard.dart';
import 'package:tripmanager/ui/documents.dart';
import 'package:tripmanager/ui/photos.dart';
import 'package:tripmanager/ui/places.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> StoragePerm() async {
    var isStorage = await Permission.storage.status;
    print(isStorage.isGranted);
    if (!isStorage.isGranted) {
      await Permission.storage.request();
    }
  }

  @override
  void initState() {
    StoragePerm();
    super.initState();
  }

  List<Widget> pages = [DashBoard(), Places(), Documents(), Photos()];
  int selectedpage = 0;
  final pagecontroller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    myColors mcol = myColors();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          PageView(
            onPageChanged: (value) {
              setState(() {
                selectedpage = value;
              });
            },
            controller: pagecontroller,
            physics: NeverScrollableScrollPhysics(),
            children: pages,
          ),
          Positioned(
              bottom: 0,
              child: SizedBox(
                width: size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: size.width * 0.9,
                      height: 80,
                      color: mcol.lightblue,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedpage = 0;
                                  pagecontroller.jumpToPage(0);
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: selectedpage != 0
                                            ? mcol.lightblue
                                            : mcol.darkblueteal),
                                    child: Center(
                                      child: Icon(
                                        Icons.dashboard,
                                        color: selectedpage != 0
                                            ? mcol.darkblueteal
                                            : mcol.lightblue,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Dashboard",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16, color: mcol.darkblueteal),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedpage = 1;
                                  pagecontroller.jumpToPage(1);
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: selectedpage != 1
                                            ? mcol.lightblue
                                            : mcol.darkblueteal),
                                    child: Center(
                                      child: Icon(
                                        Icons.place,
                                        color: selectedpage != 1
                                            ? mcol.darkblueteal
                                            : mcol.lightblue,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                  Text("Places",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: mcol.darkblueteal))
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedpage = 2;
                                  pagecontroller.jumpToPage(2);
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: selectedpage == 2
                                            ? mcol.darkblueteal
                                            : mcol.lightblue),
                                    child: Center(
                                      child: Icon(
                                        Icons.document_scanner,
                                        color: selectedpage == 2
                                            ? mcol.lightblue
                                            : mcol.darkblueteal,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                  Text("Documents",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: mcol.darkblueteal))
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedpage = 3;

                                  pagecontroller.jumpToPage(3);
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: selectedpage == 3
                                            ? mcol.darkblueteal
                                            : mcol.lightblue),
                                    child: Center(
                                      child: Icon(
                                        Icons.photo,
                                        color: selectedpage == 3
                                            ? mcol.lightblue
                                            : mcol.darkblueteal,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                  Text("Photos",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: mcol.darkblueteal))
                                ],
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
