// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_field, prefer_final_fields, avoid_print, non_constant_identifier_names, must_be_immutable, unused_import, curly_braces_in_flow_control_structures

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gracesoft/core/constants/app_data.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';

class EnterRoomDetailsPage extends StatefulWidget {
  List<dynamic> rates;
  Function(dynamic, int, double, double, double, double) ontap;
  EnterRoomDetailsPage({super.key, required this.rates, required this.ontap});

  @override
  State<EnterRoomDetailsPage> createState() => _EnterRoomDetailsPageState();
}

class _EnterRoomDetailsPageState extends State<EnterRoomDetailsPage> {
  //====================Room Selection ===========================
  TextEditingController nightsController = TextEditingController();
  int totalGuest = 0;
  TextEditingController AdultController = TextEditingController();
  TextEditingController kidsController = TextEditingController();
  TextEditingController infantsController = TextEditingController();
  TextEditingController rateNameController = TextEditingController();
  TextEditingController roomTypeController = TextEditingController();
  TextEditingController roomNameController = TextEditingController();
  final _roomSelectionFormKey = GlobalKey<FormState>();

  //========================Booking Summary ================================
  double unitRate = 0.00,
      unitTotal = 0.00,
      extraPersonCharge = 0.00,
      miscelleneous = 0.00;


  @override
  void initState() {
    super.initState();
    nightsController.text = '1';
    AdultController.text = '1';
    kidsController.text = '0';
    infantsController.text = '0';
    print(departure);
  }

  List<dynamic> reservedRooms = [];
  dynamic selctedRateName = {};

  Future<void> _showRoomRateSelectionDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a Rate Name'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                widget.rates.length,
                (index) => ListTile(
                  title: Text(widget.rates[index]['RateName']),
                  onTap: () {
                    setState(() {
                      rateNameController.text = widget.rates[index]['RateName'];
                      selctedRateName = widget.rates[index];

                      unitRate = selctedRateName['Rate'].toDouble();
                      unitTotal = unitRate;

                      AdultController.text = '1';
                      kidsController.text = '0';
                      infantsController.text = '0';
                      extraPersonCharge = 0.0;
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

  dynamic selectedRoomType = {};
  Future<void> _showRoomTypeSelectionDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a Room Type'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                AppData.dropdownList.length,
                (index) => ListTile(
                  title: Text(AppData.dropdownList[index]['RoomType']),
                  onTap: () {
                    setState(() {
                      roomTypeController.text =
                          AppData.dropdownList[index]['RoomType'];
                      selectedRoomType = AppData.dropdownList[index];
                    });
                    _filterRoomsList(roomTypeController.text);
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

  List<dynamic> _filterList = [];
  bool _isFiltering = false;
  _filterRoomsList(String roomType) {
    setState(() {
      _isFiltering = true;
    });
    _filterList.clear();
    for (var data in AppData.calendarInitialData) {
      if (data['RoomType'] == roomType) {
        _filterList.add(data);
      }
    }
    setState(() {
      _isFiltering = false;
    });
  }

  Future<void> _showRoomNameSelectionDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a Room Name'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                _filterList.length,
                (index) => ListTile(
                  title: Text(_filterList[index]['RoomName']),
                  onTap: () {
                    setState(() {
                      roomNameController.text = _filterList[index]['RoomName'];
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

  DateTime arrivalselectedDate = DateTime.now();
  DateTime departureselectedDate = DateTime.now().add(Duration(days: 1));
  String arrival =
          "${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}",
      departure =
          "${DateTime.now().add(Duration(days: 1)).year.toString()}-${DateTime.now().add(Duration(days: 1)).month.toString()}-${DateTime.now().add(Duration(days: 1)).day.toString()}";

  Future<void> _arrivalselectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: arrivalselectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != arrivalselectedDate) {
      setState(() {
        arrivalselectedDate = picked;
        arrival = "${picked.year}-${picked.month}-${picked.day}";
        nightsController.text = departureselectedDate
            .difference(arrivalselectedDate)
            .inDays
            .toString();
        print(nightsController.text);
      });

      if (departureselectedDate.difference(arrivalselectedDate).inDays < 0) {
        AppData.showErrorSnackbar(
            context, "Entered date should be less than departure date !");
        setState(() {
          arrivalselectedDate = DateTime.now();
          arrival =
              "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
          nightsController.text = departureselectedDate
              .difference(arrivalselectedDate)
              .inDays
              .toString();
          print(nightsController.text);
        });
      }
    }
  }

  Future<void> _departureselectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: departureselectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != departureselectedDate) {
      setState(() {
        print("departure");
        departureselectedDate = picked;
        departure = "${picked.year}-${picked.month}-${picked.day}";
        nightsController.text =
            (departureselectedDate.difference(arrivalselectedDate).inDays + 1)
                .toString();
        print(nightsController.text);
      });
    }

    if (departureselectedDate.difference(arrivalselectedDate).inDays <= 0) {
      AppData.showErrorSnackbar(
          context, "Entered date should be less than Arrival date !");
      setState(() {
        departureselectedDate = DateTime.now();
        departure =
            "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
        nightsController.text = departureselectedDate
            .difference(arrivalselectedDate)
            .inDays
            .toString();
        print(nightsController.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Room Details"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _roomSelectionFormKey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //=============== Arrival Date ======================
                Text(
                  "Arrival",
                  style: AppTextStyles.textStyles_PTSans_16_400_Secondary,
                ),

                Container(
                  height: 50,
                  width: Get.width * 0.6,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: "${arrivalselectedDate.toLocal()}".split(' ')[0],
                    ),
                    onTap: () => _arrivalselectDate(context),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.calendar_today),
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                //========================= Departure Date =======================

                Text(
                  "Departure",
                  style: AppTextStyles.textStyles_PTSans_16_400_Secondary,
                ),
                Container(
                  height: 50,
                  width: Get.width * 0.6,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: "${departureselectedDate.toLocal()}".split(' ')[0],
                    ),
                    onTap: () => _departureselectDate(context),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.calendar_today),
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                //================nights=========================
                Row(
                  children: [
                    const Text(
                      "Nights",
                      style: AppTextStyles.textStyles_PTSans_16_400_Secondary,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 55,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: nightsController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Nights';
                          }

                          return null;
                        },
                        onChanged: (v) {
                          setState(() {
                            departureselectedDate = DateTime.now().add(Duration(
                                days: int.parse(nightsController.text)));
                            departure = departure =
                                "${DateTime.now().add(Duration(days: int.parse(nightsController.text))).year.toString()}-${DateTime.now().add(Duration(days: int.parse(nightsController.text))).month.toString()}-${DateTime.now().add(Duration(days: int.parse(nightsController.text))).day.toString()}";
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Nights',
                          hintStyle: TextStyle(fontSize: 13),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),

                //=========================Room type =====================

                GestureDetector(
                  onTap: () {
                    _showRoomTypeSelectionDialog(context);
                  },
                  child: Container(
                    height: 55,
                    width: Get.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: roomTypeController.text == ''
                                ? Text(
                                    'Room Type',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400),
                                  )
                                : Text(
                                    roomTypeController.text,
                                  )),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                // ================ room name ============================
                GestureDetector(
                  onTap: () {
                    _showRoomNameSelectionDialog(context);
                  },
                  child: Container(
                    height: 55,
                    width: Get.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: roomNameController.text == ''
                                ? Text(
                                    'Room Name',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400),
                                  )
                                : Text(
                                    roomNameController.text,
                                  )),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                //=========================ROOM RATE ========================

                GestureDetector(
                  onTap: () {
                    _showRoomRateSelectionDialog(context);
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
                            child: rateNameController.text == ''
                                ? Text(
                                    'Rate Name',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400),
                                  )
                                : Text(
                                    rateNameController.text,
                                  )),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                //==============number of guest ==========================

                Text("No of Guests",
                    style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(
                  width: 20,
                ),

                // ==============================Adults====================================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Adults",
                      style: AppTextStyles.textStyles_PTSans_16_400_Secondary,
                    ),
                    SizedBox(width: 50),
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        controller: AdultController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: "0",
                            labelStyle: TextStyle(fontSize: 13),
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  width: 10,
                ),

                //========================= Children ========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Children",
                      style: AppTextStyles.textStyles_PTSans_16_400_Secondary,
                    ),
                    SizedBox(width: 50),
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        controller: kidsController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: "0",
                            labelStyle: TextStyle(fontSize: 13),
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  width: 10,
                ),

                // =========================== infants ===========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Infants",
                      style: AppTextStyles.textStyles_PTSans_16_400_Secondary,
                    ),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        controller: infantsController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: "0",
                            labelStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder()),
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 30,
                ),

                ElevatedButton(
                    onPressed: () {
                      if (rateNameController.text == "" ||
                          roomTypeController.text == "" ||
                          roomNameController.text == "") {

                        AppData.showErrorSnackbar(context, "Please Fill the required fields");
                      }
                      else
                        addRoomDetails();
                      
                    },
                    child: Text('Save Room details'))
              ],
            ),
          ),
        ),
      ),
    );
  }



  Future<void> calculateBookingSummary() async {
    setState(() {
      unitRate = selctedRateName["Rate"].toDouble();
      unitTotal = unitRate;
      totalGuest =
          int.parse(AdultController.text) + int.parse(kidsController.text);
      if (totalGuest > 2) {
        double a = double.parse(AdultController.text);
        double b = double.parse(kidsController.text);
        double c = selctedRateName["ExtraPersonChargeAdult"].toDouble();
        double d = selctedRateName["ExtraPersonChargeChildren"].toDouble();
        if (int.parse(AdultController.text) > 2) {
          double left = a - 2;

          extraPersonCharge = c * left + d * b;
        } else {
          double left = b - (2 - a);
          extraPersonCharge = d * left;
        }
      }
    });
  }

  Future<void> addRoomDetails() async {
    await calculateBookingSummary();

    print("Calculated");
    int? propertyID = await AppData.getPropertyID();

    dynamic data = {
      "Assigned": true,
      "Children": kidsController.text,
      "ConfirmNum": 0,
      "CreatedDate":
          "${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}",
      "Custom1": null,
      "Custom2": null,
      "DormakabaOpValue": 0,
      "DormakabaStayId": null,
      "EndDate": departure.toString(),
      "EndTime": null,
      "ExtraCharge": extraPersonCharge.toString(),
      "ExtraCharges":
          "${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}:${extraPersonCharge.toString()}",
      "Gid": selctedRateName['GID'],
      "GroupCode": 0,
      "Guests": AdultController.text,
      "Hourly": false,
      "Hours": 0,
      "Infants": infantsController.text,
      "Mode": "ADD",
      "Nights": nightsController.text,
      "PropertyName": null,
      "RateName": rateNameController.text,
      "Reservation": null,
      "Room": {
        "Amenities": null,
        "BaseAmount": selectedRoomType["BaseAmount"],
        "ChargeType": selectedRoomType["ChargeType"],
        "Description": selectedRoomType["Description"],
        "EndTime": selectedRoomType["EndTime"],
        "ExtraPersonCharge": selectedRoomType["ExtraPersonCharge"],
        "ExtraPersonChargeAdult": selectedRoomType["ExtraPersonChargeAdult"],
        "ExtraPersonChargeChildren":
            selectedRoomType["ExtraPersonChargeChildren"],
        "GID": selectedRoomType["GID"],
        "GroupName": selectedRoomType["GroupName"],
        "IsPartial": selectedRoomType["IsPartial"],
        "MinimumTimeInterval": selectedRoomType["MinimumTimeInterval"],
        "OverrideRule": selectedRoomType["OverrideRule"],
        "PartialGID": selectedRoomType["PartialGID"],
        "Password": selectedRoomType["Password"],
        "Property": {"PropertyID": propertyID},
        "ReservationRuleBlocks": selectedRoomType["ReservationRuleBlocks"],
        "RoomID": selectedRoomType["RoomID"],
        "RoomName": roomNameController.text,
        "RoomNo": selectedRoomType["RoomNo"],
        "RoomType": selectedRoomType["RoomType"],
        "RuleInfo": selectedRoomType["RuleInfo"],
        "SelectedTaxType": selectedRoomType["SelectedTaxType"],
        "SelectedTaxes": selectedRoomType["SelectedTaxes"],
        "ShowInRegularChart": selectedRoomType["ShowInRegularChart"],
        "StartTime": selectedRoomType["StartTime"],
        "WeekEndCharge": selectedRoomType["WeekEndCharge"],
        "WeekenChargeInDay": selectedRoomType["WeekenChargeInDay"]
      },
      "RoomAmount": selctedRateName["Rate"].toString(),
      "RoomAmountForTax": 0,
      "RoomAmounts":
          "${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}:${selctedRateName["Rate"]}",
      "RuleOverridden": false,
      "Share": false,
      "Split": false,
      "StartDate": arrival.toString(),
      "StartTime": null,
      "Tax": 0,
      "dooraccess": null
    };

    setState(() {
      totalGuest = int.parse(AdultController.text) +
          int.parse(kidsController.text) +
          int.parse(infantsController.text);
      widget.ontap(data, totalGuest, unitRate, unitTotal, extraPersonCharge,
          miscelleneous);
    });

    Navigator.pop(context);
    print("Data Added Ssuccessfully");
  }
}
