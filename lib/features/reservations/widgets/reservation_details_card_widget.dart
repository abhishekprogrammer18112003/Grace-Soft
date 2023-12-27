// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_data.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';
import 'package:gracesoft/core/constants/url_constant.dart';
import 'package:gracesoft/features/reservations/pages/edit_reservation_details.dart';
import 'package:gracesoft/features/reservations/pages/person_details_page.dart';
import 'package:gracesoft/features/reservations/pages/reservation_entry_page.dart';
import 'package:gracesoft/nav_screen.dart';
import 'package:http/http.dart' as http;

class ReservationDetailsCardWidget extends StatefulWidget {
  dynamic reservationData;
  ReservationDetailsCardWidget({super.key, required this.reservationData});

  @override
  State<ReservationDetailsCardWidget> createState() =>
      _ReservationDetailsCardWidgetState();
}

class _ReservationDetailsCardWidgetState
    extends State<ReservationDetailsCardWidget> {
  String? ArrDate;
  String? DeptDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String arrival = widget.reservationData["ArrDate"];
    List<String> arrDate = arrival.split('T');
    print(arrDate[0]);
    ArrDate = arrDate[0];

    String departure = widget.reservationData["DeptDate"];
    List<String> deptDate = departure.split('T');
    DeptDate = deptDate[0];
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? GestureDetector(
            onLongPress: () {
              _showOptionsDialog(context);
            },
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PersonDetailsPage(data: widget.reservationData)));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: widget.reservationData["Status"] != ''
                      ? Colors.white
                      : const Color.fromARGB(255, 204, 204, 204),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildResTag(),
                          SizedBox(width: Get.width * 0.02),
                          SizedBox(
                            width: Get.width * 0.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildNamePersonInfoRow(),
                                const SizedBox(height: 5),
                                _buildArrival(),
                                const SizedBox(height: 3),
                                _buildDates(),
                                SizedBox(height: Get.height * 0.007),
                                _buildRoomNumber(),
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
                        child: _buildCardFooter(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container(
            // height: Get.height,
            width: Get.width,
            color: const Color.fromARGB(52, 255, 255, 255),
            child: Center(child: CircularProgressIndicator()),
          );
  }

  _buildResTag() => Container(
        height: Get.height * 0.1,
        width: Get.width * 0.1,
        color: Colors.black54,
        child: RotatedBox(
          quarterTurns: -1,
          child: Center(
            child: RichText(
              text: TextSpan(
                text: widget.reservationData["ConfirmNum"].toString(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),
      );

  _buildNamePersonInfoRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: SizedBox(
              child: Text(
                " ${widget.reservationData["FullName"].toString()}",
                style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                    fontSize: 17),
              ),
            ),
          ),
          SizedBox(
              child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              children: [
                const Icon(Icons.person),
                const SizedBox(width: 2),
                Text(widget.reservationData["Guests"].toString())
              ],
            ),
          ))
        ],
      );
  _buildArrival() => const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

  _buildDates() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const SizedBox(),
          Text("  ${ArrDate}"),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Text("${DeptDate}"),
          ),
        ],
      );

  _buildRoomNumber() => Row(
        children: [
          const Icon(Icons.door_back_door_outlined),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            width: Get.width * 0.6,
            child: Text(
              "${widget.reservationData["RoomNames"]}",
              style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      );

  _buildCardFooter() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Post Tax Total: ",
                        style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                            .copyWith(
                                fontSize: 14, fontWeight: FontWeight.w800)),
                    Text(widget.reservationData["PostTaxTotal"].toString()),
                  ],
                ),
                Row(
                  children: [
                    Text("Amount Paid : ",
                        style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                            .copyWith(
                                fontSize: 14, fontWeight: FontWeight.w800)),
                    Text(widget.reservationData["AmountPaid"].toString()),
                  ],
                ),
              ],
            ),
            widget.reservationData["Status"] != ''
                ? Container(
                    height: 30,
                    width: 100,
                    color: widget.reservationData["Status"] == "CANCELLED"
                        ? Colors.red
                        : widget.reservationData["Status"] != "Confirmed"
                            ? Colors.blue
                            : Colors.green,
                    child: Center(
                        child: Text(
                      widget.reservationData["Status"],
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    )),
                  )
                : Container()
          ],
        ),
      );

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the dialog
                  // Implement the edit action
                  _handleEdit();
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the dialog
                  // Implement the delete action
                  _handleDelete();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleEdit() {
    // Implement the edit action here
    print(widget.reservationData);

    Navigator.push(context, MaterialPageRoute(builder: (context) => EditReservationPage(data : widget.reservationData)));
    print('Edit action');
  }

  void _handleDelete() {
    print(widget.reservationData);
    getReservationDetails();
  }

  bool _isLoading = false;
// List<dynamic> resvationDetails = [];
  Future<void> getReservationDetails() async {
    setState(() {
      _isLoading = true;
    });
    String? accessToken = await AppData.getAccessToken();
    int? propertyID = await AppData.getPropertyID();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    dynamic body = {
      "ConfirmNum": widget.reservationData["ConfirmNum"],
      "InvMonth": null,
      "Property": {
        "PropertyID": propertyID,
      }
    };

    http.Response response = await http.post(Uri.parse(GET_RESERVATION_DETAILS),
        headers: headers, body: jsonEncode(body));
    var data = jsonDecode(response.body);
    print(
        "===================Get Reservation Details=============================");
    if (response.statusCode == 200) {
      //Delete Reservation
      await deleteReservation(data["Reservation"]);
      Get.snackbar('Successfull', 'Reservation Deleted Successfully',
          backgroundColor: Colors.orange);
      setState(() {
        _isLoading = false;
      });
    } else {
      print("ERROR");
    }
  }

  Future<void> deleteReservation(dynamic data) async {
    String? accessToken = await AppData.getAccessToken();
    // int? propertyID = await AppData.getPropertyID();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

  dynamic body = {
    "Adults": 1,
    "AmountDue": 72.81,
    "AmountPaid": 0,
    "AutoEmail": 1,
    "CCNo": "",
    "CCType": "Cash Payment",
    "CVV": false,
    "CheckInDate": "2023-10-20",
    "CheckOutDate": "2023-10-21",
    "CompanyCode": "",
    "CompanyName": "",
    "ConfirmNum": data["ConfirmNum"],
    "CreatedDate": null,
    "Discount": 0,
    "DiscountType": "",
    
    "DocumentAttachment": "",
    "EndTime": "",
    "ExpDate": "",
    "ExpMonth": "",
    "ExpYear": "",
    "ExtraCharges": 0,
    "FolioNo": "",
    "GroupCode": 0,
    "GroupName": "",
    "Guest": {
        "Address1": "",
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
        "CCType": null,
        "CellPhone": "",
        "City": "",
        "Comments": null,
        "CompanyCode": "",
        "Country": "",
        "CountryISOCode": "in",
        "CountryPhoneCode": "+91",
        "Custom1": null,
        "Custom2": null,
        "Custom3": null,
        "Custom4": null,
        "Custom5": null,
        "Custom6": null,
        "DisplayNotes": false,
        "Email": "test@tec.ocm",
        "ExpDt": null,
        "ExpiryDate": null,
        "Fax": "",
        "FirstName": "Sathya",
        "FirstName1": null,
        "FirstStayed": null,
        "GuestCount": 0,
        "GuestID": 2936,
        "GuestName": null,
        "GuestType": "",
        "HomePhone": "9876543210",
        "Image": "",
        "IsExistingGuest": false,
        "JobTitle": null,
        "LastName": "R",
        "LastName1": null,
        "LastStayed": null,
        "License": null,
        "PropertyID": 0,
        "Province": "",
        "ReferralId": null,
        "ScreenName": null,
        "Selected": false,
        "State": "",
        "TotalReservation": 0,
        "VehicleMake": null,
        "VehicleModel": null,
        "VisitType": "",
        "WorkPhone": "",
        "Zip": ""
    },
    "Hourly": false,
    "Infants": 0,
    "InvMonth": null,
    "IsIndividualBilling": true,
    "IsMonthly": false,
    "Kids": 0,
    "Mode": "DELETE",
    "NoOfGuests": 1,
    "Notes": "",
    "OtherCharges": 0,
    "PackageId": 0,
    "PageNo": 1,
    "PostTaxTotal": 72.81,
    "PreTaxTotal": 65,
    "Property": {
        "Address": "No 20 Perunthalaivar kamarajar nagae",
        "AuthToken": null,
        "BaseURL": "http://localhost:4200",
        "BookingInterface": true,
        "CCTransactionMode": "RqValidation",
        "CCValidation": "RqValidation",
        "CDNPath": "https://gracebeta.blob.core.windows.net/userfiles1885",
        "CHAINNAME": "ten",
        "CRSInterface": false,
        "Campres": false,
        "CashDrawer": true,
        "ChequeManagement": false,
        "ChildrenFreeStay": true,
        "City": "fter",
        "CompanyCode": null,
        "CompanyName": null,
        "Country": null,
        "CreditCardPassword": null,
        "DirectBilling": true,
        "Distributor": "test123",
        "Eikasp": true,
        "Email": "testeremail278@gmail.com",
        "ExpediaInterface": true,
        "Fax": "texas 123",
        "GiftCertificate": true,
        "GroupID": 0,
        "HouseKeeping": true,
        "HousekeepingMenu": true,
        "ICalendar": true,
        "IndianTax": false,
        "IsAirBnb": true,
        "IsAuthOnly": true,
        "IsAutoPayment": true,
        "IsAutomatedReport": true,
        "IsAxisRoomEnabled": false,
        "IsBetaProperty": true,
        "IsCRM": true,
        "IsChurhProperty": false,
        "IsEasyWebRezV3": true,
        "IsGiftShop": true,
        "IsGoogleHotel": true,
        "IsGraceOTABooking": true,
        "IsGraceOTAExpedia": false,
        "IsInvoiceSetup": false,
        "IsLiteVersion": false,
        "IsMinistryManagement": false,
        "IsMultiLanguage": true,
        "IsPOS": true,
        "IsQuickBook": true,
        "IsSiteMinder": false,
        "IsStockManagement": true,
        "IsUnifiedInboxEmail": true,
        "IsUnifiedInboxText": true,
        "IsWebsite": true,
        "Iscondo": true,
        "LanguageFullName": null,
        "LanguageName": "en",
        "Logo": "https://gracebeta.blob.core.windows.net/userfiles1885/PMSUI/PrpertyInfo/ ",
        "MailFrom": "graceettabeach@gracesoft.com",
        "MultiLanguages": "English,Spanish,French",
        "OTAEnabled": true,
        "POSEnabled": true,
        "POSId": "R1885",
        "Phone": "8148879676",
        "PropertyID": 1885,
        "PropertyName": "property1",
        "QBInterface": true,
        "QBOAuth2": true,
        "ShiftNo": "2",
        "ShowCVV": true,
        "ShowChildren": true,
        "ShowMenuIcons": "selremove,combo,promo,addtoroom,clearall,billcancel,logout,discount,goto,printbill,pay",
        "StaffName": null,
        "State": "texas",
        "SwimmingPoolModule": true,
        "SwipeCard": true,
        "TripInterface": false,
        "UserID": "825",
        "UserName": null,
        "Website": "http://demo.easyinnkeeping.com/grace-etta/",
        "YieldManagement": true,
        "Zip": "12566"
    },
    "Referral": null,
    "ReservedRooms": [{
        "Assigned": true,
        "Children": 0,
        "ConfirmNum": 0,
        "Custom1": "",
        "Custom2": "",
        "EndDate": "2023-10-21",
        "EndTime": null,
        "ExtraCharge": 0,
        "ExtraCharges": "2023-10-20:0.00",
        "Gid": 1,
        "GroupCode": 0,
        "Guests": 1,
        "Hourly": false,
        "Hours": 0,
        "Infants": 0,
        "Mode": "SELECT",
        "Nights": 1,
        "RateName": "Daily Rate",
        "Reservation": null,
        "Room": {
            "Amenities": null,
            "BaseAmount": 0,
            "ChargeType": null,
            "Description": null,
            "EndTime": null,
            "ExtraPersonCharge": 0,
            "ExtraPersonChargeAdult": 0,
            "ExtraPersonChargeChildren": 0,
            "GID": 1,
            "GroupName": "Daily Rate",
            "IsPartial": false,
            "MinimumTimeInterval": 0,
            "OverrideRule": false,
            "PartialGID": 0,
            "Password": null,
            "Property": null,
            "ReservationRuleBlocks": false,
            "RoomID": 142,
            "RoomName": "1 King Bed Room 1",
            "RoomNo": null,
            "RoomType": "1 King Bed Room",
            "RuleInfo": null,
            "SelectedTaxType": null,
            "SelectedTaxes": null,
            "ShowInRegularChart": false,
            "StartTime": null,
            "WeekEndCharge": 0,
            "WeekenChargeInDay": null
        },
        "RoomAmount": 65,
        "RoomAmountForTax": 0,
        "RoomAmounts": "2023-10-20:65.00",
        "RuleOverridden": false,
        "Share": false,
        "Split": false,
        "StartDate": "2023-10-20",
        "StartTime": null,
        "Tax": 0
    }],
    "RoomAmount": 65,
    "RoomNames": null,
    "SendMailNow": false,
    "Share": false,
    "Split": false,
    "StartTime": "",
    "Status": "Checked-In",
    "StayLength": 1,
    "Tax": 7.81,
    "TaxExempt": false,
    "TotalHours": 0,
    "UnAssignedRes": false
};
    // dynamic body = data;

    http.Response response = await http.post(Uri.parse(DELETE_RESERVATION),
        headers: headers, body: jsonEncode(body));
        print("=============Deleting Reservation =============");
        print(response.statusCode);
        print(data["ConfirmNum"]);
    if (response.statusCode == 200) {
      //Delete Reservation
      print("Delete Successfully");
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigationBarWidget(initialIndex: 1,)));
    } else {
      print("ERROR");
    }
  }
}
