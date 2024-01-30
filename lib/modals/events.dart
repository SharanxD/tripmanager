import 'package:flutter/material.dart';

class Event {
  Event(
      {required this.eventname,
      required this.start,
      required this.end,
      required this.comments,
      required this.icondata,
      required this.document});
  final String eventname;
  final DateTime start;
  final DateTime end;
  final String comments;
  final IconData icondata;
  final String document;
}

List<Event> day13 = [
  Event(
      eventname: "Flight to Ahemedabad",
      icondata: Icons.flight,
      start: DateTime(2024, 1, 13, 17, 55),
      end: DateTime(2024, 1, 13, 20, 10),
      document:
          "https://drive.google.com/file/d/1Lge1a112Q2HhlUqdBOkv-NoL9KMi6M_-/view?usp=sharing",
      comments: "6E-848"),
  Event(
      eventname: "Train to Somnath",
      icondata: Icons.train,
      start: DateTime(2024, 1, 13, 22, 10),
      end: DateTime(2024, 1, 13, 23, 59),
      document:
          "https://drive.google.com/file/d/1ccH67D8eAOMyohyr7Cn_l64LYvmyKAjG/view?usp=drive_link",
      comments: "PNR: 8711644018 ")
];
List<Event> day14 = [
  Event(
      eventname: "Train to Somnath",
      icondata: Icons.train,
      start: DateTime(2024, 1, 14, 00, 00),
      document:
          "https://drive.google.com/file/d/1ccH67D8eAOMyohyr7Cn_l64LYvmyKAjG/view?usp=drive_link",
      end: DateTime(2024, 1, 14, 6, 00),
      comments: "PNR: 8711644018 "),
  Event(
      eventname: "Seeing Somnath",
      icondata: Icons.temple_hindu,
      start: DateTime(2024, 1, 14, 6, 00),
      document: "",
      end: DateTime(2024, 1, 14, 23, 05),
      comments: ""),
  Event(
      eventname: "Train to Dwarka",
      icondata: Icons.train,
      start: DateTime(2024, 1, 14, 23, 05),
      document:
          "https://drive.google.com/file/d/1WirHLmAHfs9aZSotCXjxrQ0dtU6HCEe1/view?usp=drive_link",
      end: DateTime(2024, 1, 14, 23, 59),
      comments: "PNR: 8858880964"),
];
List<Event> day15 = [
  Event(
      eventname: "Train to Dwarka",
      icondata: Icons.train,
      start: DateTime(2024, 1, 15, 00, 00),
      document:
          "https://drive.google.com/file/d/1WirHLmAHfs9aZSotCXjxrQ0dtU6HCEe1/view?usp=drive_link",
      end: DateTime(2024, 1, 15, 8, 15),
      comments: "PNR: 8858880964"),
  Event(
      eventname: "Seeing Dwarka",
      icondata: Icons.temple_hindu,
      start: DateTime(2024, 1, 15, 8, 15),
      end: DateTime(2024, 1, 15, 20, 54),
      document: "",
      comments: ""),
  Event(
      eventname: "Train to Rajkot",
      icondata: Icons.train,
      start: DateTime(2024, 1, 15, 20, 54),
      end: DateTime(2024, 1, 15, 23, 59),
      document:
          "https://drive.google.com/file/d/1pEuEmsmBsLlBLpOLnJaaFrfA2eTBhgQ5/view?usp=drive_link",
      comments: "PNR: 8512770251"),
];
List<Event> day16 = [
  Event(
      eventname: "Train to Rajkot",
      icondata: Icons.train,
      start: DateTime(2024, 1, 16, 00, 00),
      end: DateTime(2024, 1, 16, 1, 00),
      document:
          "https://drive.google.com/file/d/1pEuEmsmBsLlBLpOLnJaaFrfA2eTBhgQ5/view?usp=drive_link",
      comments: "PNR: 8512770251 "),
  Event(
      eventname: "Train to Ahmedabad",
      icondata: Icons.train,
      start: DateTime(2024, 1, 16, 02, 52),
      end: DateTime(2024, 1, 16, 7, 25),
      document:
          "https://drive.google.com/file/d/1KUAKPekSLQGgsdOJ-9WKp_W9LWYjZqYM/view?usp=drive_link",
      comments: "PNR: 8312769435 "),
  Event(
      eventname: "Seeing Ahmedabad",
      icondata: Icons.temple_hindu,
      start: DateTime(2024, 1, 16, 7, 25),
      end: DateTime(2024, 1, 16, 20, 50),
      document: "",
      comments: ""),
  Event(
      eventname: "Flight to Chennai",
      icondata: Icons.flight,
      start: DateTime(2024, 1, 16, 20, 50),
      end: DateTime(2024, 1, 16, 23, 15),
      document:
          "https://drive.google.com/file/d/1Lge1a112Q2HhlUqdBOkv-NoL9KMi6M_-/view?usp=sharing",
      comments: "6E-348"),
];
