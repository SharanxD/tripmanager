// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tripmanager/modals/colors.dart';
import 'package:tripmanager/modals/places.dart';
import 'package:tripmanager/services/services.dart';

class Places extends StatefulWidget {
  const Places({super.key});

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  List<places> upcoming = [];
  List<places> commpleted = [];

  FirebaseServices _s = FirebaseServices();
  Future<void> getallplaces() async {
    List<places> temp = await _s.readPlace() as List<places>;
    List<places> temp2 = [];
    List<places> temp3 = [];
    if (mounted) {
      for (places a in temp) {
        if (a.visited == false) {
          temp2.add(a);
        } else {
          temp3.add(a);
        }
      }
      setState(() {
        upcoming = temp2;
        commpleted = temp3;
      });
    }
  }

  @override
  void initState() {
    getallplaces();
    super.initState();
  }

  int selected = 0;
  final _pagecontroller = PageController(initialPage: 0);
  final namecontroller = TextEditingController();
  final locationcontroller = TextEditingController();
  final commentscontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    myColors mcol = myColors();
    Future<void> addplace() async {
      return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Add Place to Visit",
                style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: mcol.darkblueteal),
              ),
              content: SizedBox(
                width: size.width * 0.9,
                height: size.height * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: mcol.lightblue,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            controller: namecontroller,
                            style: GoogleFonts.poppins(
                                fontSize: 24, color: mcol.darkblueteal),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Name",
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 24,
                                  color: mcol.darkblueteal,
                                )),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: mcol.lightblue,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            controller: locationcontroller,
                            style: GoogleFonts.poppins(
                                fontSize: 24, color: mcol.darkblueteal),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Location",
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 24,
                                  color: mcol.darkblueteal,
                                )),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: mcol.lightblue,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            controller: commentscontroller,
                            style: GoogleFonts.poppins(
                                fontSize: 24, color: mcol.darkblueteal),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Comments",
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 24,
                                  color: mcol.darkblueteal,
                                )),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      places place = places(
                          PlaceName: namecontroller.text,
                          PlaceLocation: locationcontroller.text,
                          visited: false,
                          datevisited: "",
                          imageurl: "",
                          remarks: commentscontroller.text);
                      _s.addPlace(place);
                      setState(() {
                        namecontroller.clear();
                        locationcontroller.clear();
                        commentscontroller.clear();
                      });
                      Navigator.pop(context);
                      FloatingSnackBar(
                          message: "Place Added",
                          context: context,
                          textStyle: GoogleFonts.poppins(
                              fontSize: 24, color: mcol.lightblue),
                          backgroundColor: Colors.black);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mcol.orange,
                        foregroundColor: mcol.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "Add",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mcol.lightblue,
                        foregroundColor: mcol.darkblueteal,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            );
          });
    }

    Future<void> placevisit(places place) async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            var imageurl = "";
            return AlertDialog(
              title: Text(
                "Place Visit",
                style: GoogleFonts.poppins(
                    fontSize: 38,
                    color: mcol.darkblueteal,
                    fontWeight: FontWeight.bold),
              ),
              content: SizedBox(
                width: size.width * 0.9,
                height: size.height * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Name: ",
                          style: GoogleFonts.montserrat(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          place.PlaceName,
                          style: GoogleFonts.montserrat(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Location: ",
                          style: GoogleFonts.montserrat(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          place.PlaceLocation,
                          style: GoogleFonts.montserrat(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Date Visited: ",
                          style: GoogleFonts.montserrat(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateTime.now().day.toString() +
                              "-" +
                              DateTime.now().month.toString() +
                              "-" +
                              DateTime.now().year.toString(),
                          style: GoogleFonts.montserrat(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Comments: ",
                          style: GoogleFonts.montserrat(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          place.remarks,
                          style: GoogleFonts.montserrat(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        width: size.width,
                        child: Center(
                            child: ElevatedButton(
                          onPressed: () async {
                            final _imagePicker = ImagePicker();

                            await Permission.photos.request();

                            XFile? image = await _imagePicker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              try {
                                Reference referenceroot =
                                    FirebaseStorage.instance.ref();
                                Reference referencedir =
                                    referenceroot.child('places');
                                Reference uploadref =
                                    referencedir.child(place.PlaceName);
                                uploadref.putFile(File(image!.path));
                                imageurl = await uploadref.getDownloadURL();
                                print(imageurl);
                              } catch (e) {}
                            } else {
                              FloatingSnackBar(
                                  message: "No image selected",
                                  context: context);
                            }

                            FloatingSnackBar(
                                message: "Photo Added",
                                context: context,
                                textStyle: GoogleFonts.poppins(
                                    fontSize: 24, color: mcol.lightblue),
                                backgroundColor: Colors.black);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: mcol.darkblueteal,
                              foregroundColor: mcol.lightblue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text(
                            "Pick Image",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                            ),
                          ),
                        )))
                  ],
                ),
              ),
              actions: [
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _s.visitplace(place, imageurl);
                      Navigator.pop(context);
                      FloatingSnackBar(
                          message: "Place Visited",
                          context: context,
                          textStyle: GoogleFonts.poppins(
                              fontSize: 24, color: mcol.lightblue),
                          backgroundColor: Colors.black);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mcol.orange,
                        foregroundColor: mcol.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "Visit",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mcol.lightblue,
                        foregroundColor: mcol.darkblueteal,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            );
          });
    }

    getallplaces();
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "My Places",
                      style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: mcol.darkblueteal),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: size.width * 0.45,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selected = 0;
                              _pagecontroller.jumpToPage(0);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selected == 0 ? mcol.orange : mcol.lightblue,
                              foregroundColor: selected == 0
                                  ? mcol.white
                                  : mcol.darkblueteal,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text(
                            "Upcoming".toUpperCase(),
                            style: GoogleFonts.poppins(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.45,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selected = 1;
                              _pagecontroller.jumpToPage(1);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selected == 1 ? mcol.orange : mcol.lightblue,
                              foregroundColor: selected == 1
                                  ? mcol.white
                                  : mcol.darkblueteal,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text(
                            "Completed".toUpperCase(),
                            style: GoogleFonts.poppins(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.68,
                  width: size.width * 0.95,
                  child: PageView(
                    controller: _pagecontroller,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 10.0, bottom: 20),
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: IconButton(
                                  onPressed: () {
                                    addplace();
                                  },
                                  icon: const Icon(Icons.add),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: mcol.orange,
                                      foregroundColor: mcol.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                            ),
                            SizedBox(
                                height: size.height * 0.6,
                                width: size.width * 0.95,
                                child: upcoming.isEmpty
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.place,
                                              size: 60,
                                            ),
                                            Text(
                                              "No Places Added Yet",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 32,
                                                  color: mcol.darkblueteal),
                                            ),
                                          ],
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: upcoming.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Container(
                                              width: size.width,
                                              height: 130,
                                              decoration: BoxDecoration(
                                                  color: mcol.lightblue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            upcoming[index]
                                                                .PlaceName,
                                                            style: GoogleFonts.poppins(
                                                                fontSize: 28,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: mcol
                                                                    .darkblueteal),
                                                          ),
                                                          Container(
                                                            height: 4,
                                                            width: size.width *
                                                                0.3,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              color: mcol
                                                                  .darkblueteal,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Location: ",
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: mcol
                                                                        .darkblueteal),
                                                              ),
                                                              Text(
                                                                upcoming[index]
                                                                    .PlaceLocation,
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            22,
                                                                        color: mcol
                                                                            .darkblueteal),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Comments: ",
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: mcol
                                                                        .darkblueteal),
                                                              ),
                                                              Text(
                                                                upcoming[index]
                                                                            .remarks ==
                                                                        ""
                                                                    ? "None"
                                                                    : upcoming[
                                                                            index]
                                                                        .remarks,
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            22,
                                                                        color: mcol
                                                                            .darkblueteal),
                                                              ),
                                                            ],
                                                          ),
                                                        ]),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            placevisit(upcoming[
                                                                index]);
                                                          },
                                                          icon: const Icon(
                                                              Icons.check),
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.green,
                                                              foregroundColor:
                                                                  mcol
                                                                      .lightblue,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10))),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            _s.deleteplace(
                                                                upcoming[
                                                                    index]);
                                                            FloatingSnackBar(
                                                                message:
                                                                    "Place Deleted",
                                                                context:
                                                                    context,
                                                                textStyle: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            24,
                                                                        color: mcol
                                                                            .lightblue),
                                                                backgroundColor:
                                                                    Colors
                                                                        .black);
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.red,
                                                              foregroundColor:
                                                                  mcol
                                                                      .lightblue,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10))),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        })),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: size.height * 0.6,
                          width: size.width * 0.95,
                          child: commpleted.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.place,
                                        size: 60,
                                      ),
                                      Text(
                                        "No Places Visited Yet",
                                        style: GoogleFonts.poppins(
                                            fontSize: 32,
                                            color: mcol.darkblueteal),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: commpleted.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlaceDetail(
                                                        place:
                                                            commpleted[index],
                                                      )));
                                        },
                                        child: Container(
                                          width: size.width,
                                          height: 270,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.grey),
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                width: size.width - 20,
                                                height: 230,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            commpleted[index]
                                                                .imageurl),
                                                        fit: BoxFit.cover)),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                child: Container(
                                                  width: size.width - 20,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      color: mcol.lightblue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                commpleted[
                                                                        index]
                                                                    .PlaceName,
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        28,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: mcol
                                                                        .darkblueteal),
                                                              ),
                                                              Container(
                                                                height: 4,
                                                                width:
                                                                    size.width *
                                                                        0.3,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4),
                                                                  color: mcol
                                                                      .darkblueteal,
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Location: ",
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize:
                                                                            24,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: mcol
                                                                            .darkblueteal),
                                                                  ),
                                                                  Text(
                                                                    commpleted[
                                                                            index]
                                                                        .PlaceLocation,
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize:
                                                                            22,
                                                                        color: mcol
                                                                            .darkblueteal),
                                                                  ),
                                                                ],
                                                              ),
                                                            ]),
                                                        IconButton(
                                                          onPressed: () {
                                                            _s.deleteplace(
                                                                commpleted[
                                                                    index]);
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.red,
                                                              foregroundColor:
                                                                  mcol
                                                                      .lightblue,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10))),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  })),
                    ],
                    onPageChanged: (value) {
                      setState(() {
                        selected = value;
                      });
                    },
                  ),
                )
              ]),
        ),
      ),
    ));
  }
}

class PlaceDetail extends StatefulWidget {
  PlaceDetail({super.key, required this.place});
  final places place;

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    myColors mcol = myColors();
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.5,
                    child: Image.network(
                      widget.place.imageurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      size: 80,
                      color: mcol.orange,
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Text(
                    widget.place.PlaceName,
                    style: GoogleFonts.poppins(
                        fontSize: 40,
                        color: mcol.darkblueteal,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    height: 4,
                    width: size.width,
                    color: mcol.darkblueteal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.width * 0.45,
                        height: 120,
                        decoration: BoxDecoration(
                            color: mcol.lightblue,
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(children: [
                            Text(
                              "Location: ",
                              style: GoogleFonts.montserrat(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: size.width * 0.4,
                              height: 1,
                              color: mcol.darkblueteal,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              widget.place.PlaceLocation,
                              style: GoogleFonts.poppins(fontSize: 24),
                            ),
                          ]),
                        ),
                      ),
                      Container(
                        width: size.width * 0.45,
                        height: 120,
                        decoration: BoxDecoration(
                            color: mcol.lightblue,
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(children: [
                            Text(
                              "Date Visited: ",
                              style: GoogleFonts.montserrat(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: size.width * 0.4,
                              height: 1,
                              color: mcol.darkblueteal,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              widget.place.datevisited,
                              style: GoogleFonts.poppins(fontSize: 24),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Container(
                    width: size.width,
                    height: 150,
                    decoration: BoxDecoration(
                        color: mcol.lightblue,
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(children: [
                        Text(
                          "Comments",
                          style: GoogleFonts.montserrat(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: size.width,
                          height: 1,
                          color: mcol.darkblueteal,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.place.remarks,
                          style: GoogleFonts.poppins(fontSize: 24),
                        ),
                      ]),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
