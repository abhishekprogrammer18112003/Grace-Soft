// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';
import 'package:gracesoft/features/housekeeping/widget/select_day.dart';
import 'package:intl/intl.dart';

class AddReservationPage extends StatefulWidget {
  const AddReservationPage({super.key});

  @override
  State<AddReservationPage> createState() => _AddReservationPageState();
}

class _AddReservationPageState extends State<AddReservationPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController city = TextEditingController();
    TextEditingController zip = TextEditingController();
    TextEditingController state = TextEditingController();
    TextEditingController country = TextEditingController();
    TextEditingController phoneNo = TextEditingController();
    TextEditingController adult = TextEditingController();
    TextEditingController child = TextEditingController();
    DateTime? _selectedDateofArrival;
    final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
    Future<void> _selectDate() async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (picked != null && picked != _selectedDateofArrival) {
        setState(() {
          _selectedDateofArrival = picked;
        });
      }
    }

    // late int totalGuest = int.parse(adult.toString()) + int.parse(child.toString());
    // TextEditingController name = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _guest_summary(name, city, zip, state, country, phoneNo),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                color: Colors.deepPurple,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(198, 135, 133, 133)
                        .withOpacity(0.5),
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
                          const SizedBox(
                            width: double.infinity,
                            height: 35,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: "Select Room",
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            width: double.infinity,
                            height: 35,
                            decoration: BoxDecoration(border: Border.all()),
                            child: GestureDetector(
                              onTap: () {
                                _selectDate();
                              },
                              child: Text(
                                _selectedDateofArrival == Null
                                    ? "Select Date of Arrival"
                                    : _selectedDateofArrival.toString(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            width: double.infinity,
                            height: 35,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: "Departure Date",
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          const SizedBox(
                            width: double.infinity,
                            height: 35,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: "Stay Length",
                                  border: OutlineInputBorder()),
                            ),
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
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700)),
                              Container(
                                  child: Row(
                                children: [
                                  const Icon(Icons.family_restroom),
                                  Text("0"),
                                  const SizedBox(
                                    width: 9,
                                  ),
                                  const Icon(FontAwesomeIcons.person),
                                  SizedBox(
                                    width: 55,
                                    height: 35,
                                    child: TextField(
                                      controller: adult,
                                      decoration: InputDecoration(
                                          labelText: "Adult",
                                          labelStyle: TextStyle(fontSize: 13),
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 9,
                                  ),
                                  const Icon(FontAwesomeIcons.child),
                                  Container(
                                    // padding: EdgeInsets.all(2),
                                    child: SizedBox(
                                      width: 60,
                                      height: 35,
                                      child: TextField(
                                        controller: child,
                                        decoration: InputDecoration(
                                            labelText: "Child",
                                            labelStyle: TextStyle(fontSize: 15),
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                  ),
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
            ),
            _booking_summary(),
            _payment_summary(),
          ],
        ),
      ),
    );
  }
}

_booking_summary() => Container(
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
                      const Text("fdg")
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
                      const Text("dsf")
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
                      const Text("dsf")
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
                      const Text("dsf")
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
                      const Text("dsf")
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
                      const Text("dsf")
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
                      const Text(
                        "dsf",
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

_guest_summary(
        TextEditingController name,
        TextEditingController city,
        TextEditingController zip,
        TextEditingController state,
        TextEditingController country,
        TextEditingController phoneNo) =>
    Container(
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
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: TextField(
                      controller: name,
                      decoration: const InputDecoration(
                          labelText: "Name", border: OutlineInputBorder()),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        height: 35,
                        child: TextField(
                          controller: city,
                          decoration: const InputDecoration(
                              labelText: "City", border: OutlineInputBorder()),
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 35,
                        child: TextField(
                          controller: zip,
                          decoration: const InputDecoration(
                              labelText: "Zip", border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: TextField(
                      controller: state,
                      decoration: const InputDecoration(
                          labelText: "State", border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: TextField(
                      controller: country,
                      decoration: const InputDecoration(
                          labelText: "Country", border: OutlineInputBorder()),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: TextField(
                      controller: phoneNo,
                      decoration: const InputDecoration(
                          labelText: "Phone No", border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

_payment_summary() => Container(
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
                      const Text("Fds"),
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

_room_summary(TextEditingController child, TextEditingController adult,
        DateTime selectedDateofArrival, Future<void> _selectDate()) =>
    Container(
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
                  const SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Select Room",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      _selectDate;
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: 35,
                      child: Text(
                        selectedDateofArrival == DateTime.now()
                            ? "Select Date of Arrival"
                            : selectedDateofArrival.toString(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Departure Date",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Stay Length",
                          border: OutlineInputBorder()),
                    ),
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
                          Text("0"),
                          const SizedBox(
                            width: 9,
                          ),
                          const Icon(FontAwesomeIcons.person),
                          SizedBox(
                            width: 55,
                            height: 35,
                            child: TextField(
                              controller: adult,
                              decoration: InputDecoration(
                                  labelText: "Adult",
                                  labelStyle: TextStyle(fontSize: 13),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          const SizedBox(
                            width: 9,
                          ),
                          const Icon(FontAwesomeIcons.child),
                          Container(
                            // padding: EdgeInsets.all(2),
                            child: SizedBox(
                              width: 60,
                              height: 35,
                              child: TextField(
                                controller: child,
                                decoration: InputDecoration(
                                    labelText: "Child",
                                    labelStyle: TextStyle(fontSize: 15),
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ),
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
