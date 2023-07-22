// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';

// ignore: must_be_immutable
class PersonDetailsPage extends StatefulWidget {
  PersonDetailsPage({super.key, required this.data});
  dynamic data;
  @override
  State<PersonDetailsPage> createState() => _PersonDetailsPageState();
}

class _PersonDetailsPageState extends State<PersonDetailsPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.data);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _guest_summary(widget.data),
            _room_summary(widget.data),
            _booking_summary(widget.data),
            _payment_summary(widget.data),
          ],
        ),
      ),
    );
  }
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Room Total",
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(data['RoomTotal'].toString())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Other Charges",
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(data['OtherCharges'].toString())
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Pre Tax Total",
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(data['PreTaxTotal'].toString())
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tax",
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(data['Tax'].toString())
                    ],
                  ),
                  const Divider(thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Post Tax Total",
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(data['PostTaxTotal'].toString())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Amount Paid",
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(data['AmountPaid'].toString())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Amount Due",
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(
                        data['AmountDue'].toString(),
                      )
                    ],
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Name",
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(data['FullName'].toString()),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("City :",
                              style: AppTextStyles
                                  .textStyles_PTSans_16_400_Secondary
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700)),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(data['City'].toString()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("State :",
                              style: AppTextStyles
                                  .textStyles_PTSans_16_400_Secondary
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700)),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(data['State'].toString()),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Zip",
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(data['Zip'].toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Country",
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(data['Country'].toString()),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("HomePhone",
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(data['HomePhone'].toString()),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

_payment_summary(dynamic data) => Container(
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
                "Payment Info",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Payment Type",
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(data['CCType'].toString()),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        "PAY AMOUNT DUE",
                        style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                            .copyWith(
                                fontSize: 14, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Room Name",
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(data['RoomNames'].toString()),
                    ],
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Arrival Date",
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(data['ArrDate'].toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Departure Date",
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(data['DeptDate'].toString()),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Stay Length",
                          style: AppTextStyles
                              .textStyles_PTSans_16_400_Secondary
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(data['StayLength'].toString()),
                    ],
                  ),
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
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                      Container(
                          child: Row(
                        children: [
                          const Icon(Icons.family_restroom),
                          Text(data['Guests'].toString()),
                          const SizedBox(
                            width: 9,
                          ),
                          const Icon(FontAwesomeIcons.person),
                          Text(data['Adults'].toString()),
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
