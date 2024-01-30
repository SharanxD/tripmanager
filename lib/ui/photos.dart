import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripmanager/modals/colors.dart';
import 'package:tripmanager/modals/places.dart';
import 'package:tripmanager/services/services.dart';

class Photos extends StatefulWidget {
  const Photos({super.key});

  @override
  State<Photos> createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  FirebaseServices _s = FirebaseServices();
  List<String> images = [];
  Future<void> getallimages() async {
    List<String> temp2 = [];
    List<places> temp = await _s.readPlace() as List<places>;
    for (places a in temp) {
      if (a.imageurl != "") {
        temp2.add(a.imageurl);
      }
    }
    if (mounted) {
      setState(() {
        images = temp2;
      });
    }
  }

  @override
  void initState() {
    getallimages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getallimages();
    Size size = MediaQuery.of(context).size;
    myColors mcol = myColors();
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10, bottom: 30),
              child: Text("My Photos",
                  style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: mcol.darkblueteal)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                width: size.width,
                height: size.height * 0.76,
                child: GridView.builder(
                    itemCount: images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: size.width * 0.4,
                        height: 150,
                        decoration: BoxDecoration(
                            color: mcol.lightblue,
                            image: DecorationImage(
                                image: NetworkImage(images[index]),
                                fit: BoxFit.cover),
                            boxShadow: [
                              BoxShadow(
                                  color: mcol.darkblueteal,
                                  blurRadius: 10,
                                  spreadRadius: 2)
                            ],
                            borderRadius: BorderRadius.circular(20)),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
