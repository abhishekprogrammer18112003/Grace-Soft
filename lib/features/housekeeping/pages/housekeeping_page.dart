// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';
import 'package:gracesoft/nav_screen.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:gracesoft/features/housekeeping/widget/assign_staff_drop_down.dart';
import 'package:gracesoft/features/housekeeping/widget/hk_status_drop_down_widget.dart';
import 'package:http/http.dart' as http;
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_data.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';
import 'package:gracesoft/core/constants/url_constant.dart';
import 'package:intl/intl.dart';

class HouseKeepingPage extends StatefulWidget {
  const HouseKeepingPage({super.key});

  @override
  State<HouseKeepingPage> createState() => _HouseKeepingPageState();
}

class _HouseKeepingPageState extends State<HouseKeepingPage> {
  List<dynamic> roomStatusList = [];
  List<dynamic> workersList = [];
  List<dynamic> dAndUList = [],
      dirtyList = [],
      cleanList = [],
      vacantList = [],
      invalidList = [];

  TextEditingController roomNoteController = TextEditingController();
  TextEditingController hkNoteController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int allCnt = 0, dAndU = 0, dirty = 0, clean = 0, vacant = 0, invalid = 0;

  List<String> roomStatuses1 = [
    "All",
    "Dirty & UnAssigned",
    "Dirty",
    "Clean",
    "Vacant",
    " Invalid Card"
  ];

  bool _isLoadingRoomStatus = false;

  List<String> ColumnName = [
    "Arrival",
    "Departure",
    "Room Details",
    "Room Notes",
    "Reservation Status",
    "Housekeeping Status",
    "Assign Staff",
    "Housekeeping Notes"
  ];

  @override
  void initState() {
    super.initState();
    func();
  }

  Future<void> func() async {
    dateController.text = DateFormat('yyyy/MM/dd').format(DateTime.now());
    await GetRoomStatus();
    await GetWorkersDetails();
  }

  DateTime selectedDate = DateTime.now();
  String date =
      "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        date = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: const Icon(
          Icons.house_outlined,
          size: 30,
        ),
        centerTitle: true,
        title: Text(
          "HouseKeeping",
          style: AppTextStyles.textStyles_Puritan_30_400_Secondary.copyWith(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              _buildDateButton(),
              _buildstatusButton(),
          
              // _buildRoomStatuses1(),
              if (selectedButton == "All") _buildRoomStatus(roomStatusList),
          
              if (selectedButton == "Dirty & UnAssigned")
                _buildRoomStatus(dAndUList),
          
              if (selectedButton == "Dirty") _buildRoomStatus(dirtyList),
          
              if (selectedButton == "Clean") _buildRoomStatus(cleanList),
          
              if (selectedButton == "Vacant") _buildRoomStatus(vacantList),
          
              if (selectedButton == "Invalid Card")
                _buildRoomStatus(invalidList),
            ],
          )),
    );
  }

  _buildDateButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: TextFormField(
          controller: dateController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            suffixIcon: const Icon(
              Icons.calendar_today,
            ),
            hintText: dateController.text,
            hintStyle: const TextStyle(color: AppColors.primary),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.primary),
                borderRadius: BorderRadius.circular(10)),
          ),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101));

            if (pickedDate != null) {
              String formattedDate =
                  intl.DateFormat('yyyy-MM-dd').format(pickedDate);

              setState(() {
                dateController.text = formattedDate;
              });
            } else {
              print("Review Date is not selected");
            }
          },
        ),
      );

  _buildstatusButton() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              createButton(
                  'All', Colors.white, roomStatusList.length.toString(), () {}),
              const SizedBox(height: 16),
              createButton('Dirty & UnAssigned', Colors.white,
                  dAndUList.length.toString(), () {}),
              const SizedBox(height: 16),
              createButton(
                  'Dirty', Colors.grey, dirtyList.length.toString(), () {}),
              const SizedBox(height: 16),
              createButton('Clean', Color.fromARGB(255, 125, 236, 128),
                  cleanList.length.toString(), () {}),
              const SizedBox(height: 16),
              createButton('Vacant', Color.fromARGB(231, 133, 179, 217),
                  vacantList.length.toString(), () {}),
              const SizedBox(height: 16),
              createButton('Invalid Card', Colors.orange,
                  invalidList.length.toString(), () {}),
            ],
          ),
        ),
      );

  createButton(String buttonText, Color color, String count, Function toDo) {
    return GestureDetector(
      onTap: () {
        selectButton(buttonText);
        setState(() {
          if (selectedButton == "All") {
             roomStatusList.isNotEmpty   ? _buildRoomStatus(roomStatusList) : Text("Data is Not Avaliable !");
          }
          if (selectedButton == "Dirty & UnAssigned") {
            dAndUList.isNotEmpty ? _buildRoomStatus(dAndUList) : Text("Data is Not Avaliable !");
          }
          if (selectedButton == "Dirty") {
            dirtyList.isNotEmpty ?  _buildRoomStatus(dirtyList) : Text("Data is Not Avaliable !");
          }
          if (selectedButton == "Clean") {
            cleanList.isNotEmpty ?  _buildRoomStatus(cleanList): Text("Data is Not Avaliable !");
          }
          if (selectedButton == "Vacant") {
            vacantList.isNotEmpty ?  _buildRoomStatus(vacantList): Text("Data is Not Avaliable !");
          }
          if (selectedButton == "Invalid Card") {
            invalidList.isNotEmpty ?  _buildRoomStatus(invalidList): Text("Data is Not Avaliable !");
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: selectedButton == buttonText ? Colors.blue : color,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  buttonText,
                  style: AppTextStyles.textStyles_PTSans_16_400_Secondary
                      .copyWith(
                          fontSize: 14,
                          color: selectedButton == buttonText
                              ? Colors.white
                              : Colors.black),
                ),
                const SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey,
                  child: Center(
                      child: Text(
                    count,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String selectedButton = 'All';

  void selectButton(String buttonText) {
    setState(() {
      selectedButton = buttonText;
    });
  }

  _buildRoomStatus(List<dynamic> data) =>  Padding(
        padding: const EdgeInsets.all(8.0),
        child: !_isLoadingRoomStatus
            ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: data.length != 0  ?  Column(
                  children: <Widget>[
                      DataTable(
                      dataRowHeight: 50,
                      columns: List.generate(8, (index) {
                        return DataColumn(label: Text(ColumnName[index]));
                      }),
                      rows: List.generate(data.length, (index) {
                        return   DataRow(
                          cells: List.generate(8, (cellIndex) {
                            //===================arrival ======================
                            if (ColumnName[cellIndex] == "Arrival") {
                              return DataCell(Text(
                                data[index]["dashBoard"]["ArrDate"],
                                style: AppTextStyles
                                    .textStyles_PlusJakartaSans_30_700_Primary
                                    .copyWith(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                              ));
                            }
                            //=======departure==============
                            if (ColumnName[cellIndex] == "Departure") {
                              return DataCell(Text(
                                data[index]["dashBoard"]["DeptDate"],
                                style: AppTextStyles
                                    .textStyles_PlusJakartaSans_30_700_Primary
                                    .copyWith(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                              ));
                            }
                            //============room details ====================
                            if (ColumnName[cellIndex] == "Room Details") {
                              return DataCell(Container(
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      data[index]["RoomName"],
                                      style: AppTextStyles
                                          .textStyles_PlusJakartaSans_30_700_Primary
                                          .copyWith(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                    ),
                                  )));
                            }
            
                            //================room notes================
                            if (ColumnName[cellIndex] == "Room Notes") {
                              return DataCell(Center(
                                  child: data[index]["RoomNotes"] != ""
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              data[index]["RoomNotes"],
                                              style: AppTextStyles
                                                  .textStyles_PlusJakartaSans_30_700_Primary
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  RoomNotesDialog(
                                                      data[index]["HKNotes"],
                                                      data[index]["RoomID"],
                                                      data[index]["StatusID"],
                                                      data[index]["StDate"],
                                                      roomNoteController.text,
                                                      data[index]["Staff"]
                                                          ["StaffName"]);
                                                },
                                                child: const Icon(
                                                  Icons.note_add,
                                                  color: AppColors.grey,
                                                ))
                                          ],
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            RoomNotesDialog(
                                                data[index]["HKNotes"],
                                                data[index]["RoomID"],
                                                data[index]["StatusID"],
                                                data[index]["StDate"],
                                                roomNoteController.text,
                                                data[index]["Staff"]
                                                    ["StaffName"]);
                                          },
                                          child: const Icon(
                                            Icons.note_add,
                                            color: AppColors.grey,
                                          ))));
                            }
                            //=======reservtion status ========================
                            if (ColumnName[cellIndex] == "Reservation Status") {
                              return DataCell(Center(
                                child: Text(
                                  data[index]["ReservationStatus"],
                                  style: AppTextStyles
                                      .textStyles_PlusJakartaSans_30_700_Primary
                                      .copyWith(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                ),
                              ));
                            }
                            //=================house keeping Status===============
                            if (ColumnName[cellIndex] ==
                                "Housekeeping Status") {
                              return DataCell(Center(
                                  child: HKStatusDropDown(
                                selectedIndex: data[index]["HKStatus"],
                                ontap: (stid) {
                                  setState(() {
                                    UpdateHKStatus(
                                        data[index]["HKNotes"],
                                        data[index]["RoomID"],
                                        stid,
                                                data[index]["StDate"],

                                        data[index]["RoomNotes"],
                              
                                        data[index]["Staff"]["StaffName"]);
                                  });
                                },
                              )));
                            }
                            // //==============assign staff ======================
            
                            if (ColumnName[cellIndex] == "Assign Staff") {
                              return DataCell(Center(
                                  child: AssignStaffDropDown(
                                selectedIndex: data[index]["Staff"]
                                    ["StaffName"],
                                staff: workersList,
                                onTap: (a) {
                                  setState(() {
                                    UpdateHKStatus(
                                        data[index]["HKNotes"],
                                        data[index]["RoomID"],
                                        data[index]["StatusID"],
                                        data[index]["StDate"],
                                        data[index]["RoomNotes"],

                                        a);
                                  });
                                },
                              )));
                            }
                            //============ Hhosuse keeping notes ====================
                            if (ColumnName[cellIndex] == "Housekeeping Notes") {
                              return DataCell(Center(
                                child: data[index]["HKNotes"] != ""
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            data[index]["HKNotes"],
                                            style: AppTextStyles
                                                .textStyles_PlusJakartaSans_30_700_Primary
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w400),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                HKNotesDialog(
                                                    hkNoteController.text,
                                                    data[index]["RoomID"],
                                                    data[index]["StatusID"],
                                                    data[index]["StDate"],
                                                    data[index]["RoomNotes"],
                                                    data[index]["Staff"]
                                                        ["StaffName"]);
                                              },
                                              child: const Icon(
                                                Icons.note_add,
                                                color: AppColors.grey,
                                              ))
                                        ],
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          HKNotesDialog(
                                              hkNoteController.text,
                                              data[index]["RoomID"],
                                              data[index]["StatusID"],
                                              data[index]["StDate"],
                                              data[index]["RoomNotes"],
                                              data[index]["Staff"]
                                                  ["StaffName"]);
                                        },
                                        child: const Icon(
                                          Icons.note_add,
                                          color: AppColors.grey,
                                        )),
                              ));
                            }
                            return DataCell(Text("error"));
                          }),
                        );
                      }),
                    ) ,
                  ],
                ) : Text("No data available !")
            ) 
  : CircularProgressIndicator(),
      );

  void RoomNotesDialog(String HkNotes, int? roomID, int? StatusID,
      String StatusDate, String roomNotes, String HkName) {
    roomNoteController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text("Add Room Notes"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: roomNoteController,
                decoration: const InputDecoration(labelText: "Enter Room Note"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  UpdateHKStatus(HkNotes, roomID, StatusID, StatusDate,
                      roomNoteController.text, HkName);
                },
                child: Text("Save"),
              ),
            ],
          ),
        );
      },
    );
  }

  void HKNotesDialog(String HkNotes, int? roomID, int? StatusID,
      String StatusDate, String roomNotes, String HkName) {
    hkNoteController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: hkNoteController,
                decoration:
                    const InputDecoration(labelText: "Enter housekeeping Note"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);

                  UpdateHKStatus(hkNoteController.text, roomID, StatusID,
                      StatusDate, roomNotes, HkName);
                },
                child: Text("Save"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showErrorSnackbar(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        duration: Duration(seconds: 3), // Adjust the duration as needed
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  //================get room statuses 1 =======================
  Future<void> GetRoomStatus() async {
    roomStatusList.clear();
    dAndUList.clear();
    dirtyList.clear();
    cleanList.clear();
    vacantList.clear();
    invalidList.clear();
    print(date);
    setState(() {
      _isLoadingRoomStatus = true;
    });
    String? accessToken = await AppData.getAccessToken();
    int? propertyID = await AppData.getPropertyID();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    Map<String, dynamic> body = {
      "PropertyID": propertyID,
      "StDate": date,
      "Comment": "Housekeeping",
      "StatusId": 0,
      "RoomID": 0,
      "Notes": "",
      "Housekeeper": "",
      "UserName": "",
      "Details": "",
      "ShiftName": "",
      "Day": "Today",
      "RoomNotes": "",
      "Action": "Housekeeping"
    };

    http.Response response = await http.post(Uri.parse(GET_HOUSEKEEPING_STATUS),
        headers: headers, body: jsonEncode(body));

    print('============ get room status =========');
    print(response.body);
    var data;
    if (response.body.isNotEmpty) {
      data = jsonDecode(response.body);
      try {
        if (response.statusCode == 200) {
          roomStatusList.addAll(data);
          for (dynamic item in roomStatusList) {
            if (item["StatusID"] == 1) {
              vacantList.add(item);
            }
            if (item["HKStatus"] == "Dirty & UnAssigned") {
              dAndUList.add(item);
            }
            if (item["StatusID"] == 3) {
              cleanList.add(item);
            }
            if (item["StatusID"] == 4) {
              invalidList.add(item);
            }
            if (item["HKStatus"] == "Dirty") {
              dirtyList.add(item);
            }
          }
          setState(() {
            _isLoadingRoomStatus = false;
          });
        } else {
          _showErrorSnackbar(
              context, "Something Went Wrong ! Please Try Again.");
          setState(() {
            _isLoadingRoomStatus = false;
          });
        }
      } catch (e) {
        _showErrorSnackbar(context, e.toString());
        setState(() {
          _isLoadingRoomStatus = false;
        });
      }
    } else {
      roomStatusList.clear();

      setState(() {
        _isLoadingRoomStatus = false;
      });
    }
  }

// =============get workers details ==============================
  Future<void> GetWorkersDetails() async {
    setState(() {
      _isLoadingRoomStatus = true;
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

    http.Response response = await http.post(Uri.parse(GET_WORKERS),
        headers: headers, body: jsonEncode(body));

    print('============ get Workers Details =========');
    print(response.body);
    var data;
    if (response.body.isNotEmpty) {
      data = jsonDecode(response.body);
      try {
        if (response.statusCode == 200) {
          workersList.addAll(data);
          setState(() {
            _isLoadingRoomStatus = false;
          });
        } else {
          _showErrorSnackbar(
              context, "Something Went Wrong ! Please Try Again.");
          setState(() {
            _isLoadingRoomStatus = false;
          });
        }
      } catch (e) {
        _showErrorSnackbar(context, e.toString());
        setState(() {
          _isLoadingRoomStatus = false;
        });
      }
    } else {
      workersList.clear();

      setState(() {
        _isLoadingRoomStatus = false;
      });
    }
  }

  bool _isUpdatingData = false;
  //========================= UPDATE HOUSEKEEPING STATUS ==============================

  void UpdateHKStatus(String HkNotes, int? roomID, int? StatusID,
      String StatusDate, String roomNotes, String HkName) async {
    setState(() {
      _isUpdatingData = true;
    });
    print(HkNotes);
    print(roomID);
    print(StatusID);
    print(roomNotes);
    print(HkName);
    print(date);

    String? accessToken = await AppData.getAccessToken();
    int? propertyID = await AppData.getPropertyID();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    Map<String, dynamic> body = {
      "PropertyID": 1885,
      "StDate": date,
      "Comment": "ADD",
      "StatusId": StatusID,
      "RoomID": roomID,
      "Notes": HkNotes,
      "Housekeeper": HkName,
      "UserName": "",
      "Details": "",
      "ShiftName": "ShiftName",
      "Day": "Today",
      "RoomNotes": roomNotes,
      "Action": "Housekeeping"
    };

    http.Response response = await http.post(
        Uri.parse(UPDATE_HOUSEKEEPING_STATUS),
        headers: headers,
        body: jsonEncode(body));

    print('============ UPDATE ROOM STATUS  SUCCESSFULLY=========');
    print(response.body);
    // var data;
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const BottomNavigationBarWidget(
                    initialIndex: 3,
                  )));
    } else {
      _showErrorSnackbar(context, "Something Went Wrong ! ");
      setState(() {
        _isUpdatingData = false;
      });
    }
  }
}
