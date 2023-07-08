import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_colors.dart';

class TomorrowStayover extends StatefulWidget {
  const TomorrowStayover({super.key});

  @override
  State<TomorrowStayover> createState() => _TomorrowStayoverState();
}

class _TomorrowStayoverState extends State<TomorrowStayover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: Text('Tomorrow Stayover',
            style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  // width: double.infinity,
                  height: Get.height * 0.21,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(199, 158, 158, 158).withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: Get.height * 0.1,
                            width: Get.width * 0.1,
                            color: Colors.black87,
                            child: RotatedBox(
                              quarterTurns: -1,
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: '4127',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Mr. " + "Manohar Mathew",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.primary,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.18,
                                  ),
                                  Icon(Icons.person),
                                  Text("1")
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),

                              //icon for arrival and departure
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.share_arrival_time),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Arrival",
                                    style: TextStyle(
                                        // color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.2,
                                  ),
                                  Icon(Icons.departure_board),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Departure",
                                    style: TextStyle(
                                        // color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),

                              //dates
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("05/29/2023"),
                                  SizedBox(
                                    width: Get.width * 0.2,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("05/31/2023"),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              //Rooom no.
                              Row(
                                children: [
                                  Icon(Icons.door_back_door_outlined),
                                  Text(
                                    "  Country Inn Suite Type 54",
                                    style: TextStyle(
                                        // color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Referral: ",
                                      style: TextStyle(
                                          // color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                  Text(
                                    "	EasyWebRez",
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Container(
                                    height: 30,
                                    width: 70,
                                    color: Colors.green,
                                    child: Center(
                                        child: Text(
                                      "Booked",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      )),
                ),
              );
            }),
      ),
    );
  }
}
