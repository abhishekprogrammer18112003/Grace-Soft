// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                      const Text("RoomTotal"),
                      Text(data['RoomTotal'].toString())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("OtherCharges"),
                      Text(data['OtherCharges'].toString())
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("PreTaxTotal"),
                      Text(data['PreTaxTotal'].toString())
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [const Text("Tax"), Text(data['Tax'].toString())],
                  ),
                  const Divider(thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("PostTaxTotal"),
                      Text(data['PostTaxTotal'].toString())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "AmountPaid",
                      ),
                      Text(data['AmountPaid'].toString())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("AmountDue",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold)),
                      Text(data['AmountDue'].toString())
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
                      const Text("Name"),
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
                          const Text("City"),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(data['City'].toString()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("State"),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(data['State'].toString()),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Zip"),
                      Text(data['Zip'].toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Country"),
                      Text(data['Country'].toString()),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("HomePhone"),
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
                      const Text("Payment Type"),
                      Text(data['CCType'].toString()),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Container(
                      width: double.infinity,
                      child: const Text(
                        "PAY AMOUNT DUE",
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
                      const Text("Room Name"),
                      Text(data['RoomNames'].toString()),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Arrival Date"),
                      Text(data['ArrDate'].toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Departure Date"),
                      Text(data['DeptDate'].toString()),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Stay Length"),
                      Text(data['StayLength'].toString()),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("No of Guest"),
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
