// import 'dart:js';

// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';
import 'package:gracesoft/features/reservations/pages/edit_reservation_details.dart';

// ignore: must_be_immutable
class CalenderPersonDetailsPage extends StatefulWidget {
  CalenderPersonDetailsPage(
      {super.key, required this.data, required this.roomsData});
  dynamic data;
  dynamic roomsData;
  @override
  State<CalenderPersonDetailsPage> createState() =>
      _CalenderPersonDetailsPageState();
}

class _CalenderPersonDetailsPageState extends State<CalenderPersonDetailsPage> {
  String? ArrDate;
  String? DeptDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.roomsData['RoomName']);
    String arrival = widget.data["ResArrDate"];
    List<String> arrDate = arrival.split('T');

    ArrDate = arrDate[0];

    String departure = widget.data["ResDeptDate"];
    List<String> deptDate = departure.split('T');
    DeptDate = deptDate[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person Details'),
        actions: [

          GestureDetector(
            onTap: (){
                  Navigator.of(context).pop(); // Close the dialog
                  // Implement the edit action
                  _handleEdit();
                },
                child: Icon(Icons.edit),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: Get.height * 0.1,
              width: Get.width * 0.2,
              color: Colors.black,
              child: Center(
                  child: Text(
                widget.data["ConfirmNum"].toString(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700),
              )),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _guest_summary(widget.data),
            _room_summary(widget.data),
            _booking_summary(widget.data),
            // _payment_summary(widget.data),
          ],
        ),
      ),
    );
  }

  _booking_summary(dynamic data) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: Colors.deepPurple,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(198, 135, 133, 133).withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 6,
              offset: const Offset(0, 9), // changes position of shadow
            ),
          ],
        ),
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                ),
                child: const Text(
                  "Booking Summary",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    data['RoomRate'] != ''
                        ? buildWidget(
                            data: data['RoomRate'].toString(),
                            title: 'Room Rate : ')
                        : Container(),
                    // SizedBox(height: 5),
                    // data['OtherCharges'] != ''
                    //     ? buildWidget(
                    //         data: data['OtherCharges'].toString(),
                    //         title: 'Other Charges (in \$) :')
                    //     : Container(),
                    const Divider(
                      thickness: 1,
                    ),
                    // data['PreTaxTotal'] != ''
                    //     ? buildWidget(
                    //         data: data['PreTaxTotal'].toString(),
                    //         title: 'Pre Tax Total (in \$)')
                    //     : Container(),
                    // const Divider(
                    //   thickness: 1,
                    // ),
                    // data['Tax'] != ''
                    //     ? buildWidget(
                    //         data: data['Tax'].toString(),
                    //         title: 'Tax (in \$) :')
                    //     : Container(),
                    // const Divider(thickness: 1),
                    data['PostTaxTotal'] != ''
                        ? buildWidget(
                            data: data['PostTaxTotal'].toString(),
                            title: 'Post Tax Total :')
                        : Container(),
                    const Divider(
                      thickness: 1,
                    ),
                    buildWidget(
                        data: data['AmountPaid'].toString(),
                        title: 'Amount Paid :'),
                    const Divider(
                      thickness: 1,
                    ),
                    buildWidget(
                        data: data['AmountDue'].toString(),
                        title: 'Amount Due :',)
                  ],
                ),
              )
            ],
          ),
        ),
      );

  _guest_summary(dynamic data) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: Colors.deepPurple,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(198, 135, 133, 133).withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 6,
              offset: const Offset(0, 9), // changes position of shadow
            ),
          ],
        ),
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                ),
                child: const Text(
                  "Guest Info",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    data['FirstName'] != ''
                        ? buildWidget(
                            data:
                                " ${data["FirstName"].toString()} ${data["LastName"].toString()}",
                            title: 'Name : ')
                        : Container(),
                    const Divider(
                      thickness: 1,
                    ),
                    buildWidget(
                        data: data['GuestID'].toString(), title: 'Guest ID :'),
                    const Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        data['City'] != ''
                            ? Row(
                                children: [
                                  Text("City :",
                                      style: AppTextStyles
                                          .textStyles_PTSans_16_400_Secondary
                                          .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      width: Get.width * 0.35,
                                      child: Text(data['City'].toString())),
                                ],
                              )
                            : Container(),
                        data['State'] != ''
                            ? Row(
                                children: [
                                  Text("State :",
                                      style: AppTextStyles
                                          .textStyles_PTSans_16_400_Secondary
                                          .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      child: Text(data['State'].toString())),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                    data['Zip'] != ''
                        ? Row(
                            children: [
                              Text("Zip  :",
                                  style: AppTextStyles
                                      .textStyles_PTSans_16_400_Secondary
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(data['Zip'].toString()),
                            ],
                          )
                        : Container(),
                    data['Address1'] != ''
                        ? buildWidget(
                            data: data['Address1'].toString(),
                            title: 'Address :')
                        : Container(),
                    const Divider(
                      thickness: 1,
                    ),
                    data['Phone'] != ''
                        ? buildWidget(
                            data: data['Phone'].toString(),
                            title: 'Mobile Number :')
                        : Container(),
                    SizedBox(height: 5),
                    data['Email'] != ''
                        ? buildWidget(
                            data: data['Email'].toString(), title: 'Email :')
                        : Container(),
                    const Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Status :',
                            style: AppTextStyles
                                .textStyles_PTSans_16_400_Secondary
                                .copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w700)),
                        Card(
                          child: data["Status"] != ''
                              ? Container(
                                  height: 30,
                                  width: 100,
                                  color: data["Status"] == "CANCELLED"
                                      ? Colors.red
                                      : data["Status"] != "Confirmed"
                                          ? Colors.blue
                                          : Colors.green,
                                  child: Center(
                                      child: Text(
                                    data["Status"],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  )),
                                )
                              : Container(),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );


  _room_summary(dynamic data) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: Colors.deepPurple,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(198, 135, 133, 133).withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 6,
              offset: const Offset(0, 9), // changes position of shadow
            ),
          ],
        ),
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                ),
                child: const Text(
                  "Room Info",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.roomsData['RoomName'] != ''
                        ? buildWidget(
                            data: widget.roomsData['RoomName'].toString(),
                            title: 'Room Name  :')
                        : Container(),
                    SizedBox(height: 5),
                    widget.roomsData['RoomType'] != ''
                        ? buildWidget(
                            data: data['RoomType'].toString(),
                            title: 'Room Type  :')
                        : Container(),
                    const Divider(
                      thickness: 2,
                    ),
                    data['ResArrDate'] != ''
                        ? buildWidget(
                            data: ArrDate.toString(), title: 'Arrival Date :')
                        : Container(),
                    data['ResDeptDate'] != ''
                        ? buildWidget(
                            data: DeptDate.toString(),
                            title: 'Departure Date :')
                        : Container(),
                    const Divider(
                      thickness: 1,
                    ),
                    data['Days'] != ''
                        ? buildWidget(
                            data: data['Days'].toString(),
                            title: 'Staying Length :')
                        : Container(),
                    const Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("No of Guest",
                            style: AppTextStyles
                                .textStyles_PTSans_16_400_Secondary
                                .copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                        Container(
                            child: Row(
                          children: [
                            const Icon(Icons.family_restroom),
                            Text(data['Guests'].toString()),
                            const SizedBox(
                              width: 9,
                            ),
                            const Icon(FontAwesomeIcons.person),
                            Text(data['Infants'].toString()),
                            const SizedBox(
                              width: 9,
                            ),
                            const Icon(FontAwesomeIcons.child),
                            Text(data['Children'].toString()),
                          ],
                        )),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
      void _handleEdit() {
    // Implement the edit action here
    

    Navigator.push(context, MaterialPageRoute(builder: (context) => EditReservationPage(data : widget.data)));
    print('Edit action');
  }
  
}

class buildWidget extends StatelessWidget {
  String title;
  String data;
  buildWidget({super.key, required this.data, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                .copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
        SizedBox(
          width: Get.width * 0.35,
          child: Text(data.toString(),
              textAlign: TextAlign.end,
              style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w300)),
        ),
      ],
    );
    
  }
  
}
