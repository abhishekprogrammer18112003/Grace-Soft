// ignore_for_file: unused_import, non_constant_identifier_names, unused_field, prefer_const_constructors, must_be_immutable, use_build_context_synchronously, annotate_overrides
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_data.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';
import 'package:gracesoft/core/utils.dart';
import 'package:gracesoft/features/housekeeping/widget/select_day.dart';
import 'package:gracesoft/features/reservations/pages/edit_room_details_page.dart';
import 'package:gracesoft/features/reservations/pages/enter_room_details_page.dart';
import 'package:gracesoft/nav_screen.dart';
import 'package:gracesoft/ui/custom_text_field.dart';
import 'package:gracesoft/ui/custom_text_form_field.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import '../../../core/constants/url_constant.dart';

class EditReservationPage extends StatefulWidget {
  dynamic data;
  EditReservationPage({super.key, required this.data});

  @override
  State<EditReservationPage> createState() => _EditReservationPageState();
}

class _EditReservationPageState extends State<EditReservationPage> {
  bool _isLoadingRoomRates = false;
  @override
  void initState() {
    super.initState();
    print(widget.data);
    initialize();
  }

  //=============== initialize =====================
  Future<void> initialize() async {
    await GetRoomRates();
    await getReservationDetails();
    getCalendarInitialData();
    await GetAccountCodeRates();
  }

  List<dynamic> reservedRooms = [];
  int totalGuest = 0;
  double unitRate = 0.00,
      unitTotal = 0.00,
      extraPersonCharge = 0.00,
      tax = 0.00,
      miscelleneous = 0.00,
      postTaxTotal = 0.00,
      amountDue = 0.00,
      amountPaid = 0.0;

  //=====================Guest Info ===============================
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  //===================Payment Info ==============================
  TextEditingController accountCodeController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController MMController = TextEditingController();
  TextEditingController YYController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  int adults = 0, children = 0, infants = 0;
  List<dynamic> accountCodeList = [];
  String selectedStatus = "";
  List<dynamic> rates = [];

  Future<void> _showAccountCodeSelectionDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a Account Name'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                accountCodeList.length,
                (index) => ListTile(
                  title: Text(
                      "${accountCodeList[index]['AccountCode']}  ${accountCodeList[index]['AccountName']}"),
                  onTap: () {
                    // Update the text field with the selected item
                    setState(() {
                      accountCodeController.text =
                          "${accountCodeList[index]['AccountName']}  (${accountCodeList[index]['AccountCode']})";
                      // selctedRateName = rates[index];
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Edit Reservation',
          style: AppTextStyles.textStyles_PTSans_16_400_Secondary.copyWith(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        actions: [
          !_isLoadingRoomRates
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButton<String>(
                      value: selectedStatus,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedStatus = newValue!;
                        });
                      },
                      items: AppData.status
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: !_isLoadingRoomRates
            ? !_isSavingReservation
                ? Column(
                    children: [
                      _roomSelection(),
                      _guest_summary(),
                      _payment_summary(),
                      _booking_summary(),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            editReservation();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text('Edit Reservation',
                              style: AppTextStyles
                                  .textStyles_PlusJakartaSans_30_700_Primary
                                  .copyWith(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                : Container(
                    height: Get.height,
                    width: Get.width,
                    color: Color.fromARGB(51, 255, 255, 255),
                    child: Center(child: CircularProgressIndicator()),
                  )
            : Center(
                child: Padding(
                padding: EdgeInsets.only(top: 100.0),
                child: CircularProgressIndicator(),
              )),
      ),
    );
  }

  bool _isSavingReservation = false;
  dynamic propertyDetails = {};

  //=================SAVE RESERVATION =====================
  Future<void> editReservation() async {
    setState(() {
      _isSavingReservation = true;
    });
    // await getPropertyDetails();

    String? accessToken = await AppData.getAccessToken();
    int? propertyID = await AppData.getPropertyID();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    print("==============Reserved Rooms ===================");
    print(jsonEncode(reservedRooms));
    // Map<String, dynamic> body = {
    //   "CanOverride": false,
    //   "OverridePasswords": [],
    //   "Reservation": {
    // "CheckInDate": "${reservedRooms[0]["StartDate"]}",
    // "CheckOutDate": "${reservedRooms[0]["EndDate"]}",
    // "CreatedDate":
    //     "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
    //     "ReservedRooms": reservedRooms,
    //     "Adults": adults.toString(),
    //     "AmountDue": amountDue.toString(),
    //     "AmountPaid": 0,
    //     "AutoEmail": 1,
    //     "CCNo": null,
    //     "CCType": accountCodeController.text.toString(),
    //     "CVV": false,
    //     "CompanyCode": null,
    //     "CompanyName": null,
    //     "ConfirmNum": 0,
    //     "Discount": 0,
    //     "DiscountType": null,
    //     "Discounts": [],
    //     "DocumentAttachment": null,
    //     "EndTime": null,
    //     "ExpDate": null,
    //     "ExpMonth": null,
    //     "ExpYear": null,
    //     "ExtraCharges": 0,
    //     "FolioNo": null,
    //     "GroupCode": 0,
    //     "GroupName": null,
    // "Guest": {
    //   "Address1": addressController.text.toString(),
    //   "Address2": "",
    //   "Anniversary": null,
    //   "BillingAddress": null,
    //   "BillingCity": null,
    //   "BillingProvince": null,
    //   "BillingState": null,
    //   "BillingZipPostal": null,
    //   "BirthDate1": null,
    //   "BirthDate2": null,
    //   "CCNumber": null,
    //   "CCType": accountCodeController.text.toString(),
    //   "CellPhone": "",
    //   "City": cityController.text.toString(),
    //   "Comments": "",
    //   "CompanyCode": "",
    //   "Country": countryCodeController.text.toString(),
    //   "CountryISOCode": "in",
    //   "CountryPhoneCode": countryCodeController.text.toString(),
    //   "CreatedDate":
    //       "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
    //   "Custom1": null,
    //   "Custom2": null,
    //   "Custom3": null,
    //   "Custom4": null,
    //   "Custom5": null,
    //   "Custom6": null,
    //   "DisplayNotes": false,
    //   "Email": emailController.text.toString(),
    //   "ExpDt": "",
    //   "ExpiryDate": null,
    //   "Fax": "",
    //   "FirstName": firstNameController.text.toString(),
    //   "FirstName1": null,
    //   "FirstStayed": "6/29/2023 12:00:00 AM",
    //   "GuestCount": 0,
    //   "GuestID": 0,
    //   "GuestName": null,
    //   "GuestType": "",
    //   "HomePhone": mobileController.text.toString(),
    //   "Image": "",
    //   "IsExistingGuest": false,
    //   "JobTitle": null,
    //   "LastName": lastNameController.text.toString(),
    //   "LastName1": null,
    //   "LastStayed": "11/24/2023 12:00:00 AM",
    //   "License": null,
    //   "PropertyID": propertyID,
    //   "Province": "",
    //   "ReferralId": null,
    //   "ScreenName": null,
    //   "Selected": false,
    //   "State": stateController.text.toString(),
    //   "TotalReservation": 1,
    //   "VehicleMake": null,
    //   "VehicleModel": null,
    //   "VisitType": "",
    //   "WorkPhone": "",
    //   "Zip": zipController.text.toString()
    // },
    //     "Hourly": false,
    //     "Infants": infants,
    //     "InvMonth": null,
    //     "IsIndividualBilling": false,
    //     "IsMonthly": false,
    //     "Kids": children.toString(),
    //     "Mode": "ADD",
    //     "NoOfGuests": totalGuest.toString(),
    //     "Notes": "",
    //     "OtherCharges": 0,
    //     "PackageId": 0,
    //     "PageNo": 1,
    //     "PostTaxTotal": postTaxTotal.toString(),
    //     "PreTaxTotal": (postTaxTotal - tax).toString(),
    //     "Property": propertyDetails,
    //     "Referral": null,
    //     "RoomAmount": unitTotal.toString(),
    //     "RoomNames": null,
    //     "SendMailNow": false,
    //     "Share": false,
    //     "Split": false,
    //     "StartTime": null,
    //     "Status": "Booked",
    //     "StayLength": 1,
    //     "Tax": tax.toString(),
    //     "TaxExempt": false,
    //     "TotalHours": 0,
    //     "UnAssignedRes": false,
    //     "VrboCancelledBy": null
    //   },
    //   "DeletedDiscounts": []
    // };
    dynamic body = {
      "Adults": adults.toString(),
        "AmountDue": amountDue.toString(),
        "AmountPaid": amountPaid,
      "AutoEmail": 1,
      "CCNo": "",
      "CCType": accountCodeController.text.toString(),
      "CVV": false,
      "CheckInDate": "${reservedRooms[0]["StartDate"]}",
      "CheckOutDate": "${reservedRooms[0]["EndDate"]}",
      "CreatedDate":
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
      "CompanyCode": "",
      "CompanyName": "",
      "ConfirmNum": widget.data["ConfirmNum"],
      "Discount": 0,
      "DiscountType": "",
      "DocumentAttachment": "",
      "EndTime": "",
      "ExpDate": "",
      "ExpMonth": "",
      "ExpYear": "",
      "ExtraCharges": extraPersonCharge,
      "FolioNo": "",
      "GroupCode": 0,
      "GroupName": "",
      "Guest": {
        "Address1": addressController.text.toString(),
        "Address2": "",
        "Anniversary": null,
        "BillingAddress": null,
        "BillingCity": null,
        "BillingProvince": null,
        "BillingState": null,
        "BillingZipPostal": null,
        "BirthDate1": null,
        "BirthDate2": null,
        "CCNumber": null,
        "CCType": accountCodeController.text.toString(),
        "CellPhone": "",
        "City": cityController.text.toString(),
        "Comments": "",
        "CompanyCode": "",
        "Country": countryCodeController.text.toString(),
        "CountryISOCode": "in",
        "CountryPhoneCode": countryCodeController.text.toString(),
        "CreatedDate":
            "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
        "Custom1": null,
        "Custom2": null,
        "Custom3": null,
        "Custom4": null,
        "Custom5": null,
        "Custom6": null,
        "DisplayNotes": false,
        "Email": emailController.text.toString(),
        "ExpDt": "",
        "ExpiryDate": null,
        "Fax": "",
        "FirstName": firstNameController.text.toString(),
        "FirstName1": null,
        "FirstStayed": "6/29/2023 12:00:00 AM",
        "GuestCount": 0,
        "GuestID": guestDetails["GuestID"],
        "GuestName": null,
        "GuestType": "",
        "HomePhone": mobileController.text.toString(),
        "Image": "",
        "IsExistingGuest": false,
        "JobTitle": null,
        "LastName": lastNameController.text.toString(),
        "LastName1": null,
        "LastStayed": "11/24/2023 12:00:00 AM",
        "License": null,
        "PropertyID": propertyID,
        "Province": "",
        "ReferralId": null,
        "ScreenName": null,
        "Selected": false,
        "State": stateController.text.toString(),
        "TotalReservation": 1,
        "VehicleMake": null,
        "VehicleModel": null,
        "VisitType": "",
        "WorkPhone": "",
        "Zip": zipController.text.toString()
      },
      "Hourly": false,
      "Infants": infants,
      "InvMonth": null,
      "IsIndividualBilling": true,
      "IsMonthly": false,
      "Kids": children,
      "Mode": "MODIFY",
      "NoOfGuests": totalGuest,
      "Notes": notesController.text,
      "OtherCharges": miscelleneous,
      "PackageId": 0,
      "PageNo": 1,
      "PostTaxTotal": postTaxTotal,
      "PreTaxTotal": (postTaxTotal - tax),
      "Property": propertyDetails,
      "Referral": null,
      "ReservedRooms":reservedRooms,
      "RoomAmount": unitTotal,
      "RoomNames": null,
      "SendMailNow": false,
      "Share": false,
      "Split": false,
      "StartTime": "",
      "Status": selectedStatus.toString(),
      "StayLength": 1,
      "Tax": tax,
      "TaxExempt": false,
      "TotalHours": 0,
      "UnAssignedRes": false
    };
    print(
        "==========================================Body=========================================");
    print(body);
    http.Response response = await http.post(Uri.parse(EDIT_RESERVATION),
        headers: headers, body: jsonEncode(body));
    print('============ Editing Data =========');
// print(jsonEncode(reservedRooms));
    // print(response.body);
    // var data = jsonEncode(response.body);
    try {
      if (response.statusCode == 200) {
        setState(() {
          _isSavingReservation = false;
        });
        // print(body);
        print("=====================Printing body response ==================");
        Utils.printJson(response.body);
         Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context , MaterialPageRoute(builder: (context)=>BottomNavigationBarWidget(initialIndex: 1,)));
        print("Reservation Saved Successfully");
      }
    } catch (e) {
      print(e);
      // _showErrorSnackbar(context, "Something Went Wrong");
      AppData.showErrorSnackbar(
          context, "Something went wrong ! Please try again");

      setState(() {
        _isSavingReservation = false;
      });
    }
    // else {

    //
    // }
  }

  _roomSelection() => Container(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: Get.width * 0.25),
                    Text(
                      "Room Selection",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: Get.width * 0.13,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EnterRoomDetailsPage(
                                    rates: rates,
                                    ontap: (data, guest, rate, total,
                                        extracharge, mis) {
                                      print(data);
                                      setState(() {
                                        reservedRooms.add(data);
                                        adults += int.parse(data["Guests"]);
                                        children += int.parse(data["Children"]);
                                        infants += int.parse(data["Infants"]);
                                        totalGuest +=
                                            adults + children + infants;
                                        unitRate = rate;
                                        unitTotal += total;
                                        extraPersonCharge += extracharge;
                                        tax = ((unitTotal + extraPersonCharge) *
                                                22) /
                                            100;
                                        miscelleneous = mis;
                                        postTaxTotal = unitTotal +
                                            extraPersonCharge +
                                            tax +
                                            miscelleneous;
                                        amountDue = postTaxTotal;
                                      });
                                    })));
                      },
                      child: CircleAvatar(
                          radius: 13,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: SizedBox(
                  height: Get.height * 0.4,
                  child: reservedRooms.length == 0
                      ? Center(
                          child: Text("Add Room Details"),
                        )
                      : ListView.builder(
                          itemCount: reservedRooms.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: buildRoomsDetails(index),
                            );
                          },
                        ),
                ),
              )
            ],
          ),
        ),
      );

  buildRoomsDetails(int index) => Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 219, 219, 219),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(199, 158, 158, 158).withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // _buildResTag(),
                  // SizedBox(width: Get.width * 0.02),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildEditAndDelete(index),
                        // SizedBox(child: Divider(),),
                        const SizedBox(height: 5),
                        _buildArrival(),
                        const SizedBox(height: 3),
                        _buildDates(index),
                        SizedBox(height: Get.height * 0.007),
                        _buildRoomNumber(index),
                      ],
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                    child: Divider(
                  thickness: 1,
                  color: Colors.grey,
                )),
              ),
              const SizedBox(height: 1),
              Container(
                // color: Colors.blue,
                child: _buildCardFooter(index),
              )
            ],
          ),
        ),
      );

  _buildEditAndDelete(int index) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: Get.width * 0.05),
          Text(
            "#${index + 1}",
            style: AppTextStyles.textStyles_PlusJakartaSans_30_700_Primary
                .copyWith(fontSize: 16),
          ),
          SizedBox(width: Get.width * 0.5),
          GestureDetector(
              onTap: () {
                setState(() {
                  adults -= int.parse(reservedRooms[index]["Guests"]);
                  children -= int.parse(reservedRooms[index]["Children"]);
                  infants -= int.parse(reservedRooms[index]["Infants"]);

                  totalGuest = adults + children + infants;
                  unitTotal =
                      unitTotal - reservedRooms[index]["RoomAmount"].toDouble();
                  extraPersonCharge -=
                      reservedRooms[index]["ExtraCharge"].toDouble();
                  tax = (unitTotal + extraPersonCharge) * 22 / 100;
                  postTaxTotal =
                      unitTotal + extraPersonCharge + miscelleneous + tax;
                  amountDue = postTaxTotal;
                  reservedRooms.removeAt(index);
                });
              },
              child: Icon(Icons.delete)),
          SizedBox(width: 20),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditRoomDetailsPage(
                              rates: rates,
                              ontap:
                                  (data, guest, rate, total, extracharge, mis) {
                                print(data);
                                setState(() {
                                  adults -=
                                      int.parse(reservedRooms[index]["Guests"]);
                                  children -= int.parse(
                                      reservedRooms[index]["Children"]);
                                  infants -= int.parse(
                                      reservedRooms[index]["Infants"]);

                                  totalGuest = adults + children + infants;
                                  unitTotal = unitTotal -
                                      reservedRooms[index]["RoomAmount"]
                                          .toDouble();
                                  extraPersonCharge -= reservedRooms[index]
                                          ["ExtraCharge"]
                                      .toDouble();
                                  tax = (unitTotal + extraPersonCharge) *
                                      22 /
                                      100;
                                  postTaxTotal = unitTotal +
                                      extraPersonCharge +
                                      miscelleneous +
                                      tax;
                                  amountDue = postTaxTotal;
                                  reservedRooms.removeAt(index);
                                  reservedRooms.insert(index, data);
                                  // reservedRooms.add(data);
                                  adults += int.parse(data["Guests"]);
                                  children += int.parse(data["Children"]);
                                  infants += int.parse(data["Infants"]);
                                  totalGuest += adults + children + infants;
                                  unitRate = rate;
                                  unitTotal += total;
                                  extraPersonCharge += extracharge;
                                  tax = ((unitTotal + extraPersonCharge) * 22) /
                                      100;
                                  miscelleneous = mis;
                                  postTaxTotal = unitTotal +
                                      extraPersonCharge +
                                      tax +
                                      miscelleneous;
                                  amountDue = postTaxTotal;
                                });
                              },
                              data: reservedRooms[index],
                            )));
              },
              child: Icon(Icons.edit))
        ],
      );
  _buildArrival() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Get.width * 0.05,
          ),
          Row(
            children: [
              Icon(Icons.share_arrival_time),
              SizedBox(width: 5),
              Text(
                "Arrival",
                style: TextStyle(
                    // color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            width: Get.width * 0.2,
          ),
          Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: Row(
              children: [
                Icon(Icons.departure_board),
                SizedBox(width: 5),
                Text(
                  "Departure",
                  style: TextStyle(
                      // color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )
        ],
      );

  _buildDates(int index) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.width * 0.05,
          ),

          // const SizedBox(),
          Text(reservedRooms[index]["StartDate"].split("T")[0]),
          const SizedBox(width: 10),
          SizedBox(
            width: Get.width * 0.2,
          ),

          Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Text(reservedRooms[index]["EndDate"].split("T")[0]),
          ),
        ],
      );

  _buildRoomNumber(int index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: Get.width * 0.05),
              Text("Nights : "),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                // width: Get.width * 0.6,
                child: Text(
                  reservedRooms[index]["Nights"].toString(),
                  style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(width: Get.width * 0.2),
              Text("Guests : "),
              SizedBox(
                // width: Get.width * 0.6,
                child: Text(
                  "${reservedRooms[index]["Guests"]} / ${reservedRooms[index]["Children"]} / ${reservedRooms[index]["Infants"]}",
                  style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: Get.width * 0.05),
              Text("Rate : "),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: Get.width * 0.6,
                child: Text(
                  reservedRooms[index]["RateName"],
                  // "afksnfknasljnvkajnsnvakjsnjnijanskjn ijniainkjnan jnajnvkn",
                  style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: Get.width * 0.05),
              Text("Type : "),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: Get.width * 0.6,
                child: Text(
                  reservedRooms[index]["Room"]["RoomType"],
                  style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: Get.width * 0.05),
              Text("Name : "),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: Get.width * 0.6,
                child: Text(
                  reservedRooms[index]["Room"]["RoomName"],
                  style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      );

  _buildCardFooter(int index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text("unit Rate : ",
                    style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
                Text(reservedRooms[index]["RoomAmount"].toString()),
                SizedBox(
                  width: Get.width * 0.18,
                ),
              ],
            )
          ],
        ),
      );

  _guest_summary() => Container(
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //==============first Name =========================
                      CustomTextFormField(
                        controller: firstNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter First Name';
                          }

                          return null;
                        },
                        hint: "First Name *",
                        borderRadius: 8,
                        keyboardType: TextInputType.name,
                        validate: AutovalidateMode.onUserInteraction,
                      ),

                      SizedBox(
                        height: 5,
                      ),
                      //============last name ========================
                      CustomTextFormField(
                        controller: lastNameController,
                        validate: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Last Name';
                          }

                          return null;
                        },
                        hint: "Last Name *",
                        borderRadius: 8,
                        keyboardType: TextInputType.name,
                      ),

                      SizedBox(
                        height: 5,
                      ),
                      // ========================Address =========================
                      CustomTextFormField(
                        controller: addressController,
                        validate: AutovalidateMode.onUserInteraction,
                        hint: "Address",
                        borderRadius: 8,
                        keyboardType: TextInputType.name,
                      ),

                      SizedBox(
                        height: 5,
                      ),
                      //=======================city================
                      CustomTextFormField(
                        controller: cityController,
                        validate: AutovalidateMode.onUserInteraction,
                        hint: "City",
                        borderRadius: 8,
                        keyboardType: TextInputType.name,
                      ),

                      SizedBox(
                        height: 5,
                      ),
                      //=======================State===============
                      CustomTextFormField(
                        controller: stateController,
                        validate: AutovalidateMode.onUserInteraction,
                        hint: "State",
                        borderRadius: 8,
                        keyboardType: TextInputType.name,
                      ),

                      SizedBox(
                        height: 5,
                      ),

                      //=====================Country================
                      CustomTextFormField(
                        controller: countryController,
                        validate: AutovalidateMode.onUserInteraction,
                        hint: "Country",
                        borderRadius: 8,
                        keyboardType: TextInputType.name,
                      ),

                      SizedBox(
                        height: 5,
                      ),

                      //======================Zip===================
                      CustomTextFormField(
                        controller: zipController,
                        validate: AutovalidateMode.onUserInteraction,
                        hint: "Zip",
                        borderRadius: 8,
                        keyboardType: TextInputType.name,
                      ),

                      SizedBox(
                        height: 5,
                      ),
                      //============== Mobile Number ======================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: TextFormField(
                              controller: countryCodeController,
                              keyboardType: TextInputType.text,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Code';
                                }

                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Code',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(16.0),
                              ),
                            ),
                          ),
                          Container(
                            width: Get.width * 0.57,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: TextFormField(
                              controller: mobileController,
                              keyboardType: TextInputType.phone,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Mobile Number';
                                }

                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: '  Mobile Number *',
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      //=================email=====================
                      CustomTextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Email';
                          }

                          return null;
                        },
                        validate: AutovalidateMode.onUserInteraction,
                        hint: "Email *",
                        borderRadius: 8,
                        keyboardType: TextInputType.name,
                      ),
                    ],
                  ),
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
                    GestureDetector(
                      onTap: () {
                        _showAccountCodeSelectionDialog(context);
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: accountCodeController.text == ''
                                    ? Text(
                                        'Account Code',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w400),
                                      )
                                    : Text(
                                        accountCodeController.text,
                                      )),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    ),

                    //

                    SizedBox(
                      height: 5,
                    ),
                    //====================== Notes ====================
                    Container(
                      height: 55,
                      // width: Get.width * 0.5,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: notesController,
                        maxLines: 4,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Any Notes',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16.0),
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
                    SizedBox(
                      height: 8,
                    ),
                    PaymentSummaryShowTextWidget(
                      data: unitTotal,
                      text: "Unit Total",
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    PaymentSummaryShowTextWidget(
                        data: extraPersonCharge, text: "Extra Person Charge"),
                    const Divider(
                      thickness: 1,
                    ),
                    PaymentSummaryShowTextWidget(data: tax, text: "Tax"),
                    SizedBox(
                      height: 8,
                    ),
                    PaymentSummaryShowTextWidget(
                        data: miscelleneous, text: "Miscellenous"),
                    const Divider(thickness: 1),
                    PaymentSummaryShowTextWidget(
                        data: postTaxTotal, text: "Post Tax Total"),
                    SizedBox(
                      height: 8,
                    ),
                    PaymentSummaryShowTextWidget(
                        data: amountPaid, text: "Amount Paid"),
                    SizedBox(
                      height: 8,
                    ),
                    PaymentSummaryShowTextWidget(
                      data: amountDue,
                      text: "Amount Due",
                      color: Colors.blue,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
//============================== GET RESERVATION DETAILS ===================================
  dynamic reservationDetails = {};
  dynamic guestDetails = {};
  Future<void> getReservationDetails() async {
    setState(() {
      _isLoadingRoomRates = true;
    });
    String? accessToken = await AppData.getAccessToken();
    int? propertyID = await AppData.getPropertyID();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    dynamic body = {
      "ConfirmNum": widget.data["ConfirmNum"],
      "InvMonth": null,
      "Property": {"PropertyID": propertyID}
    };

    http.Response response = await http.post(Uri.parse(GET_RESERVATION_DETAILS),
        headers: headers, body: jsonEncode(body));

    var data = jsonDecode(response.body);
    print(
        "===================Get Reservation details=============================");

    if (response.statusCode == 200) {
      setState(() {
        reservationDetails = data["Reservation"];
        propertyDetails = data["Reservation"]["Property"];
        guestDetails = data["Reservation"]["Guest"];
        reservedRooms = data["ReservedRooms"];
        firstNameController.text = guestDetails["FirstName"];
        lastNameController.text = guestDetails["LastName"];
        addressController.text = guestDetails["Address1"];
        cityController.text = guestDetails["City"];
        stateController.text = guestDetails["State"];
        zipController.text = guestDetails["Zip"];
        countryController.text = guestDetails["Country"];
        countryCodeController.text = guestDetails["CountryPhoneCode"];
        mobileController.text = guestDetails["HomePhone"];
        emailController.text = guestDetails["Email"];

        accountCodeController.text = reservationDetails["CCType"];
        notesController.text = reservationDetails["Notes"];
        unitTotal = reservationDetails["RoomAmount"].toDouble();
        extraPersonCharge = reservationDetails["ExtraCharges"].toDouble();
        tax = reservationDetails["Tax"].toDouble();
        miscelleneous = reservationDetails["OtherCharges"].toDouble();
        postTaxTotal = reservationDetails["PostTaxTotal"].toDouble();
        amountDue = reservationDetails["AmountDue"].toDouble();
        amountPaid = reservationDetails["AmountPaid"].toDouble();
        adults = reservationDetails["Adults"];
        children = reservationDetails["Kids"];
        infants = reservationDetails["Infants"];
        totalGuest = reservationDetails["NoOfGuests"];
        selectedStatus = reservationDetails["Status"];
      });
      print(reservedRooms);

      setState(() {
        _isLoadingRoomRates = false;
      });
    } else {
      print("ERROR");
      setState(() {
        _isLoadingRoomRates = false;
      });
    }
  }

  //====================== GET ROOM RATES ============================
  Future<void> GetRoomRates() async {
    setState(() {
      _isLoadingRoomRates = true;
    });
    String? accessToken = await AppData.getAccessToken();
    int? propertyID = await AppData.getPropertyID();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    Map<String, dynamic> body = {
      "PropertyID": propertyID,
    };

    http.Response response = await http.post(Uri.parse(GET_ROOM_RATES_MASTER),
        headers: headers, body: jsonEncode(body));

    print('============ get ROOM RATES =========');
    print(response.body);
    var data;
    if (response.body.isNotEmpty) {
      data = jsonDecode(response.body);
      try {
        if (response.statusCode == 200) {
          rates.addAll(data);
          setState(() {
            _isLoadingRoomRates = false;
          });
        } else {
          AppData.showErrorSnackbar(
              context, "Something went wrong ! Please try again");

          setState(() {
            _isLoadingRoomRates = false;
          });
        }
      } catch (e) {
        AppData.showErrorSnackbar(context, e.toString());

        setState(() {
          _isLoadingRoomRates = false;
        });
      }
    } else {
      rates.clear();

      setState(() {
        _isLoadingRoomRates = false;
      });
    }
  }

  //====================== GET Account Details ============================
  Future<void> GetAccountCodeRates() async {
    setState(() {
      _isLoadingRoomRates = true;
    });
    String? accessToken = await AppData.getAccessToken();
    int? propertyID = await AppData.getPropertyID();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    Map<String, dynamic> body = {
      "PropertyID": propertyID,
    };

    http.Response response = await http.post(Uri.parse(GET_ACCOUNT_CODE),
        headers: headers, body: jsonEncode(body));

    print('============ get Accounts =========');
    print(response.body);
    var data;
    if (response.body.isNotEmpty) {
      data = jsonDecode(response.body);
      try {
        if (response.statusCode == 200) {
          accountCodeList.addAll(data);
          setState(() {
            _isLoadingRoomRates = false;
          });
        } else {
          // _showErrorSnackbar(
          //     context, "Something Went Wrong ! Please Try Again.");
          AppData.showErrorSnackbar(
              context, "Something went wrong ! Please try again");
          setState(() {
            _isLoadingRoomRates = false;
          });
        }
      } catch (e) {
        // _showErrorSnackbar(context, e.toString());
        AppData.showErrorSnackbar(context, e.toString());

        setState(() {
          _isLoadingRoomRates = false;
        });
      }
    } else {
      accountCodeList.clear();

      setState(() {
        _isLoadingRoomRates = false;
      });
    }
  }
}

List<dynamic> _roomsData = [];
Future<void> getCalendarInitialData() async {
  AppData.calendarInitialData.clear();
  AppData.dropdownList.clear();
  String? accessToken = await AppData.getAccessToken();
  int? propertyID = await AppData.getPropertyID();
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };

  dynamic body = {
    "PropertyId": propertyID,
  };

  http.Response response = await http.post(Uri.parse(INITIAL_DATA),
      headers: headers, body: jsonEncode(body));
  print(
      "===================Get Initial Calender data=============================");

  if (response.statusCode == 200) {
    AppData.calendarInitialData = jsonDecode(response.body.toString())['Rooms'];
    final groupedData =
        groupBy(AppData.calendarInitialData, (data) => data['RoomType']);

    // Extract the first occurrence from each group to get unique values
    AppData.dropdownList =
        groupedData.values.map((group) => group.first).toList();

    print(AppData.dropdownList);
    for (var data in AppData.calendarInitialData) {
      dynamic roomData = {
        "RoomName": data['RoomName'],
        "RoomType": data['RoomType'],
        "RoomID": data['RoomID']
      };
      _roomsData.add(roomData);
    }
  } else {
    print("ERROR");
  }
}

//============================== WIDGET ================================================
class PaymentSummaryShowTextWidget extends StatelessWidget {
  double data;
  String text;
  Color color;
  PaymentSummaryShowTextWidget(
      {super.key,
      required this.data,
      required this.text,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: AppTextStyles.textStyles_PTSans_16_400_Secondary.copyWith(
                fontSize: 14, fontWeight: FontWeight.w700, color: color)),
        Text(data.toString()),
      ],
    );
  }
}
