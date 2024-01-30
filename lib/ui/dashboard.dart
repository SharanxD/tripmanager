import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tripmanager/modals/colors.dart';
import 'package:tripmanager/modals/events.dart';
import 'package:url_launcher/url_launcher.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final scrollcontrol = ItemScrollController();
  final itemkey = GlobalKey();
  int selected = 0;
  int datediff = DateTime(2024, 1, 13).day - DateTime.now().day;
  int ontrip = DateTime.now().day - DateTime(2024, 1, 12).day;
  List<DateTime> days = [
    DateTime(2024, 1, 13),
    DateTime(2024, 1, 14),
    DateTime(2024, 1, 15),
    DateTime(2024, 1, 16),
  ];
  DateTime todayDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  void initState() {
    setState(() {
      selected = days.indexOf(todayDate);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(days.contains(todayDate));
    final schedulecontroller = PageController(
        initialPage: days.contains(todayDate) ? days.indexOf(todayDate) : 0);
    myColors mcol = myColors();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10),
              child: Text("My DashBoard",
                  style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: mcol.darkblueteal)),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: size.width * 0.45,
                    height: size.width * 0.45,
                    decoration: BoxDecoration(
                        color: mcol.darkblueteal,
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.width * 0.02,
                          ),
                          Text(
                            (datediff >= 0 ? datediff : 0).toString(),
                            style: GoogleFonts.poppins(
                                fontSize: size.width * 0.24,
                                fontWeight: FontWeight.bold,
                                color: mcol.lightblue),
                          ),
                          Text(
                            "Days to Trip",
                            style: GoogleFonts.poppins(
                                fontSize: 28, color: Colors.white),
                          )
                        ]),
                  ),
                  Container(
                    width: size.width * 0.45,
                    height: size.width * 0.45,
                    decoration: BoxDecoration(
                        color: mcol.darkblueteal,
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.width * 0.02,
                          ),
                          Text(
                            (ontrip >= 0 ? ontrip : 0).toString(),
                            style: GoogleFonts.poppins(
                                fontSize: size.width * 0.24,
                                fontWeight: FontWeight.bold,
                                color: mcol.lightblue),
                          ),
                          Text(
                            "Days on Trip",
                            style: GoogleFonts.poppins(
                                fontSize: 28, color: Colors.white),
                          )
                        ]),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width,
              height: 70,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: ListView.builder(
                  itemCount: days.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = index;
                            schedulecontroller.jumpToPage(index);
                          });
                        },
                        child: Container(
                          width: size.width / 4.85,
                          height: 40,
                          decoration: BoxDecoration(
                              color: selected == index
                                  ? mcol.orange
                                  : mcol.lightblue,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text(
                              days[index].day.toString(),
                              style: GoogleFonts.montserrat(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: selected == index
                                      ? mcol.white
                                      : mcol.darkblueteal),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: size.width,
                height: size.height * 0.45,
                child: PageView(
                  controller: schedulecontroller,
                  onPageChanged: (value) {
                    setState(() {
                      selected = value;
                    });
                  },
                  children: [
                    ScheduleList(
                      size: size,
                      mcol: mcol,
                      daylist: day13,
                    ),
                    ScheduleList(
                      size: size,
                      mcol: mcol,
                      daylist: day14,
                    ),
                    ScheduleList(
                      size: size,
                      mcol: mcol,
                      daylist: day15,
                    ),
                    ScheduleList(
                      size: size,
                      mcol: mcol,
                      daylist: day16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class ScheduleList extends StatelessWidget {
  const ScheduleList(
      {super.key,
      required this.size,
      required this.mcol,
      required this.daylist});

  final Size size;
  final myColors mcol;
  final List<Event> daylist;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: daylist.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Container(
              width: size.width,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: mcol.lightblue),
              child: Stack(
                children: [
                  Positioned(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: DateTime.now()
                              .difference(daylist[index].start)
                              .inSeconds /
                          daylist[index]
                              .end
                              .difference(daylist[index].start)
                              .inSeconds,
                      color: mcol.darkblueteal.withOpacity(0.4),
                      backgroundColor: mcol.lightblue,
                      minHeight: 100,
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Icon(daylist[index].icondata),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              daylist[index].eventname,
                              style: GoogleFonts.montserrat(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: mcol.darkblueteal),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 6.0, bottom: 10),
                              child: Container(
                                width: size.width * 0.6,
                                height: 2,
                                color: mcol.darkblueteal,
                              ),
                            ),
                            Text(
                              "${daylist[index].start.hour}.${daylist[index].start.minute}  -  ${daylist[index].end.hour}.${daylist[index].end.minute}",
                              style: GoogleFonts.montserrat(
                                  fontSize: 24, color: mcol.darkblueteal),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: daylist[index].document != "",
                          child: GestureDetector(
                            onTap: () async {
                              Uri url = Uri.parse(daylist[index].document);
                              await launchUrl(url);
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Icon(
                                Icons.description,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
