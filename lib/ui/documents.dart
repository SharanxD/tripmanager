import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripmanager/modals/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Documents extends StatefulWidget {
  const Documents({super.key});

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
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
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10, bottom: 30),
                  child: Text("My Documents",
                      style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: mcol.darkblueteal)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Aadhar",
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: mcol.darkblueteal,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AddharTile(
                        size: size,
                        mcol: mcol,
                        Name: "Prakash",
                        drivelink:
                            "https://drive.google.com/file/d/1m9yPZ-xhVNOhTaYFzTntkXnmJZYHOwkD/view?usp=sharing",
                      ),
                      AddharTile(
                        size: size,
                        mcol: mcol,
                        Name: "Jayarani",
                        drivelink:
                            "https://drive.google.com/file/d/1Hu5gNkipIiYm-ze_woFB1iqzYqGAAjSw/view?usp=sharing",
                      ),
                      AddharTile(
                        size: size,
                        mcol: mcol,
                        Name: "Sharan",
                        drivelink:
                            "https://drive.google.com/file/d/1nLQlmaz8eG7bMsWBS3Pdyxb57Sd5ogqy/view?usp=sharing",
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.66,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: DocumentTile(
                            size: size,
                            mcol: mcol,
                            heading: "MAS-AMD",
                            subtitle: "Flight Ticket",
                            documenturl:
                                "https://drive.google.com/file/d/1Lge1a112Q2HhlUqdBOkv-NoL9KMi6M_-/view?usp=sharing",
                          ),
                        ),
                        DocumentTile(
                          size: size,
                          mcol: mcol,
                          heading: "Ahmedabad-Somnath",
                          subtitle: "Train Ticket",
                          documenturl:
                              "https://drive.google.com/file/d/1ccH67D8eAOMyohyr7Cn_l64LYvmyKAjG/view?usp=sharing",
                        ),
                        DocumentTile(
                          size: size,
                          mcol: mcol,
                          heading: "Somnath- Dwarka",
                          subtitle: "Train Ticket",
                          documenturl:
                              "https://drive.google.com/file/d/1WirHLmAHfs9aZSotCXjxrQ0dtU6HCEe1/view?usp=sharing",
                        ),
                        DocumentTile(
                          size: size,
                          mcol: mcol,
                          heading: "Dwarka-Rajkot",
                          subtitle: "Train Ticket",
                          documenturl:
                              "https://drive.google.com/file/d/1pEuEmsmBsLlBLpOLnJaaFrfA2eTBhgQ5/view?usp=sharing",
                        ),
                        DocumentTile(
                          size: size,
                          mcol: mcol,
                          heading: "Rajkot-Ahmedabad",
                          subtitle: "Train Ticket",
                          documenturl:
                              "https://drive.google.com/file/d/1KUAKPekSLQGgsdOJ-9WKp_W9LWYjZqYM/view?usp=sharing",
                        ),
                        DocumentTile(
                          size: size,
                          mcol: mcol,
                          heading: "AMD-MAS",
                          subtitle: "Flight Ticket",
                          documenturl:
                              "https://drive.google.com/file/d/1Lge1a112Q2HhlUqdBOkv-NoL9KMi6M_-/view?usp=drive_link",
                        )
                      ],
                    ),
                  ),
                ),
              ])),
    ));
  }
}

class AddharTile extends StatelessWidget {
  const AddharTile(
      {super.key,
      required this.size,
      required this.mcol,
      required this.Name,
      required this.drivelink});

  final Size size;
  final myColors mcol;
  final String drivelink;
  final String Name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Uri url = Uri.parse(drivelink);
        await launchUrl(url);
      },
      child: Container(
        width: size.width * 0.3,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: mcol.lightblue),
        child: Center(
            child: Text(
          Name,
          style: GoogleFonts.montserrat(fontSize: 24, color: mcol.darkblueteal),
        )),
      ),
    );
  }
}

class DocumentTile extends StatelessWidget {
  const DocumentTile(
      {super.key,
      required this.size,
      required this.mcol,
      required this.heading,
      required this.subtitle,
      required this.documenturl});

  final Size size;
  final myColors mcol;
  final String heading;
  final String subtitle;
  final String documenturl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Container(
        width: size.width,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: mcol.lightblue),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: GoogleFonts.montserrat(
                        fontSize: 32,
                        color: mcol.darkblueteal,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: size.width * 0.5,
                    height: 2,
                    color: mcol.darkblueteal,
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      color: mcol.darkblueteal,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  Uri url = Uri.parse(documenturl);
                  await launchUrl(url);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.description,
                    size: 40,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
