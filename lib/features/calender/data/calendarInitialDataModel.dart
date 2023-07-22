class calendar_Initial_data_Model {
  List<Rooms>? rooms;
  List<HouseKeepingStatuses>? houseKeepingStatuses;
  List<ReservationStatuses>? reservationStatuses;
  List<String>? collapseStatuses;
  List<Legends>? legends;

  calendar_Initial_data_Model(
      {this.rooms,
      this.houseKeepingStatuses,
      this.reservationStatuses,
      this.collapseStatuses,
      this.legends});

  calendar_Initial_data_Model.fromJson(Map<String, dynamic> json) {
    if (json['Rooms'] != null) {
      rooms = <Rooms>[];
      json['Rooms'].forEach((v) {
        rooms!.add(new Rooms.fromJson(v));
      });
    }
    if (json['HouseKeepingStatuses'] != null) {
      houseKeepingStatuses = <HouseKeepingStatuses>[];
      json['HouseKeepingStatuses'].forEach((v) {
        houseKeepingStatuses!.add(new HouseKeepingStatuses.fromJson(v));
      });
    }
    if (json['ReservationStatuses'] != null) {
      reservationStatuses = <ReservationStatuses>[];
      json['ReservationStatuses'].forEach((v) {
        reservationStatuses!.add(new ReservationStatuses.fromJson(v));
      });
    }
    collapseStatuses = json['CollapseStatuses'].cast<String>();
    if (json['Legends'] != null) {
      legends = <Legends>[];
      json['Legends'].forEach((v) {
        legends!.add(new Legends.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rooms != null) {
      data['Rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    if (this.houseKeepingStatuses != null) {
      data['HouseKeepingStatuses'] =
          this.houseKeepingStatuses!.map((v) => v.toJson()).toList();
    }
    if (this.reservationStatuses != null) {
      data['ReservationStatuses'] =
          this.reservationStatuses!.map((v) => v.toJson()).toList();
    }
    data['CollapseStatuses'] = this.collapseStatuses;
    if (this.legends != null) {
      data['Legends'] = this.legends!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rooms {
  Null? property;
  int? roomID;
  String? roomName;
  String? roomType;
  int? gID;
  Null? selectedTaxType;
  Null? selectedTaxes;
  Null? groupName;
  String? roomNo;
  bool? reservationRuleBlocks;
  Null? ruleInfo;
  bool? overrideRule;
  Null? password;
  Null? startTime;
  Null? endTime;
  bool? isPartial;
  int? partialGID;
  int? minimumTimeInterval;
  Null? chargeType;
  String? description;
  String? amenities;
  double? baseAmount;
  int? extraPersonCharge;
  int? extraPersonChargeAdult;
  int? extraPersonChargeChildren;
  int? weekEndCharge;
  String? weekenChargeInDay;
  bool? showInRegularChart;

  Rooms(
      {this.property,
      this.roomID,
      this.roomName,
      this.roomType,
      this.gID,
      this.selectedTaxType,
      this.selectedTaxes,
      this.groupName,
      this.roomNo,
      this.reservationRuleBlocks,
      this.ruleInfo,
      this.overrideRule,
      this.password,
      this.startTime,
      this.endTime,
      this.isPartial,
      this.partialGID,
      this.minimumTimeInterval,
      this.chargeType,
      this.description,
      this.amenities,
      this.baseAmount,
      this.extraPersonCharge,
      this.extraPersonChargeAdult,
      this.extraPersonChargeChildren,
      this.weekEndCharge,
      this.weekenChargeInDay,
      this.showInRegularChart});

  Rooms.fromJson(Map<String, dynamic> json) {
    property = json['Property'];
    roomID = json['RoomID'];
    roomName = json['RoomName'];
    roomType = json['RoomType'];
    gID = json['GID'];
    selectedTaxType = json['SelectedTaxType'];
    selectedTaxes = json['SelectedTaxes'];
    groupName = json['GroupName'];
    roomNo = json['RoomNo'];
    reservationRuleBlocks = json['ReservationRuleBlocks'];
    ruleInfo = json['RuleInfo'];
    overrideRule = json['OverrideRule'];
    password = json['Password'];
    startTime = json['StartTime'];
    endTime = json['EndTime'];
    isPartial = json['IsPartial'];
    partialGID = json['PartialGID'];
    minimumTimeInterval = json['MinimumTimeInterval'];
    chargeType = json['ChargeType'];
    description = json['Description'];
    amenities = json['Amenities'];
    baseAmount = json['BaseAmount'];
    extraPersonCharge = json['ExtraPersonCharge'];
    extraPersonChargeAdult = json['ExtraPersonChargeAdult'];
    extraPersonChargeChildren = json['ExtraPersonChargeChildren'];
    weekEndCharge = json['WeekEndCharge'];
    weekenChargeInDay = json['WeekenChargeInDay'];
    showInRegularChart = json['ShowInRegularChart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Property'] = this.property;
    data['RoomID'] = this.roomID;
    data['RoomName'] = this.roomName;
    data['RoomType'] = this.roomType;
    data['GID'] = this.gID;
    data['SelectedTaxType'] = this.selectedTaxType;
    data['SelectedTaxes'] = this.selectedTaxes;
    data['GroupName'] = this.groupName;
    data['RoomNo'] = this.roomNo;
    data['ReservationRuleBlocks'] = this.reservationRuleBlocks;
    data['RuleInfo'] = this.ruleInfo;
    data['OverrideRule'] = this.overrideRule;
    data['Password'] = this.password;
    data['StartTime'] = this.startTime;
    data['EndTime'] = this.endTime;
    data['IsPartial'] = this.isPartial;
    data['PartialGID'] = this.partialGID;
    data['MinimumTimeInterval'] = this.minimumTimeInterval;
    data['ChargeType'] = this.chargeType;
    data['Description'] = this.description;
    data['Amenities'] = this.amenities;
    data['BaseAmount'] = this.baseAmount;
    data['ExtraPersonCharge'] = this.extraPersonCharge;
    data['ExtraPersonChargeAdult'] = this.extraPersonChargeAdult;
    data['ExtraPersonChargeChildren'] = this.extraPersonChargeChildren;
    data['WeekEndCharge'] = this.weekEndCharge;
    data['WeekenChargeInDay'] = this.weekenChargeInDay;
    data['ShowInRegularChart'] = this.showInRegularChart;
    return data;
  }
}

class HouseKeepingStatuses {
  int? statusID;
  String? status;
  Null? active;
  Null? color;

  HouseKeepingStatuses({this.statusID, this.status, this.active, this.color});

  HouseKeepingStatuses.fromJson(Map<String, dynamic> json) {
    statusID = json['StatusID'];
    status = json['Status'];
    active = json['Active'];
    color = json['Color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusID'] = this.statusID;
    data['Status'] = this.status;
    data['Active'] = this.active;
    data['Color'] = this.color;
    return data;
  }
}

class ReservationStatuses {
  Property? property;
  String? columnName;
  String? newLabel;
  String? defaultLabel;
  Null? itemName;
  String? color;

  ReservationStatuses(
      {this.property,
      this.columnName,
      this.newLabel,
      this.defaultLabel,
      this.itemName,
      this.color});

  ReservationStatuses.fromJson(Map<String, dynamic> json) {
    property = json['Property'] != null
        ? new Property.fromJson(json['Property'])
        : null;
    columnName = json['ColumnName'];
    newLabel = json['NewLabel'];
    defaultLabel = json['DefaultLabel'];
    itemName = json['ItemName'];
    color = json['Color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.property != null) {
      data['Property'] = this.property!.toJson();
    }
    data['ColumnName'] = this.columnName;
    data['NewLabel'] = this.newLabel;
    data['DefaultLabel'] = this.defaultLabel;
    data['ItemName'] = this.itemName;
    data['Color'] = this.color;
    return data;
  }
}

class Property {
  int? propertyID;
  Null? propertyName;
  Null? baseURL;
  bool? childrenFreeStay;
  bool? showChildren;
  Null? cCValidation;
  Null? creditCardPassword;
  Null? logo;
  Null? address;
  Null? city;
  Null? state;
  Null? zip;
  Null? phone;
  Null? fax;
  Null? email;
  Null? website;
  Null? pOSId;
  Null? cDNPath;
  int? groupID;
  Null? userID;
  Null? userName;
  Null? shiftNo;
  Null? authToken;
  bool? pOSEnabled;
  bool? oTAEnabled;
  bool? houseKeeping;
  bool? housekeepingMenu;
  Null? country;
  bool? indianTax;
  bool? expediaInterface;
  bool? bookingInterface;
  bool? tripInterface;
  bool? isAxisRoomEnabled;
  bool? campres;
  bool? isPOS;
  bool? isQuickBook;
  bool? isGiftShop;
  bool? isStockManagement;
  bool? isCRM;
  Null? cHAINNAME;
  bool? iscondo;
  bool? giftCertificate;
  bool? yieldManagement;
  bool? directBilling;
  bool? chequeManagement;
  bool? swimmingPoolModule;
  bool? isWebsite;
  bool? eikasp;
  bool? isInvoiceSetup;
  bool? isSiteMinder;
  Null? distributor;
  bool? iCalendar;
  bool? qBInterface;
  bool? qBOAuth2;
  bool? cashDrawer;
  bool? isLiteVersion;
  bool? cRSInterface;
  bool? isAutomatedReport;
  bool? isEasyWebRezV3;
  bool? isMinistryManagement;
  bool? isGraceOTAExpedia;
  bool? isGraceOTABooking;
  bool? isChurhProperty;
  bool? isAirBnb;
  bool? isGoogleHotel;
  Null? showMenuIcons;
  bool? isAutoPayment;
  String? date;
  Null? staffName;
  Null? mailFrom;
  bool? showCVV;
  Null? companyCode;
  Null? companyName;
  Null? multiLanguages;
  Null? cCTransactionMode;
  bool? isBetaProperty;

  Property(
      {this.propertyID,
      this.propertyName,
      this.baseURL,
      this.childrenFreeStay,
      this.showChildren,
      this.cCValidation,
      this.creditCardPassword,
      this.logo,
      this.address,
      this.city,
      this.state,
      this.zip,
      this.phone,
      this.fax,
      this.email,
      this.website,
      this.pOSId,
      this.cDNPath,
      this.groupID,
      this.userID,
      this.userName,
      this.shiftNo,
      this.authToken,
      this.pOSEnabled,
      this.oTAEnabled,
      this.houseKeeping,
      this.housekeepingMenu,
      this.country,
      this.indianTax,
      this.expediaInterface,
      this.bookingInterface,
      this.tripInterface,
      this.isAxisRoomEnabled,
      this.campres,
      this.isPOS,
      this.isQuickBook,
      this.isGiftShop,
      this.isStockManagement,
      this.isCRM,
      this.cHAINNAME,
      this.iscondo,
      this.giftCertificate,
      this.yieldManagement,
      this.directBilling,
      this.chequeManagement,
      this.swimmingPoolModule,
      this.isWebsite,
      this.eikasp,
      this.isInvoiceSetup,
      this.isSiteMinder,
      this.distributor,
      this.iCalendar,
      this.qBInterface,
      this.qBOAuth2,
      this.cashDrawer,
      this.isLiteVersion,
      this.cRSInterface,
      this.isAutomatedReport,
      this.isEasyWebRezV3,
      this.isMinistryManagement,
      this.isGraceOTAExpedia,
      this.isGraceOTABooking,
      this.isChurhProperty,
      this.isAirBnb,
      this.isGoogleHotel,
      this.showMenuIcons,
      this.isAutoPayment,
      this.date,
      this.staffName,
      this.mailFrom,
      this.showCVV,
      this.companyCode,
      this.companyName,
      this.multiLanguages,
      this.cCTransactionMode,
      this.isBetaProperty});

  Property.fromJson(Map<String, dynamic> json) {
    propertyID = json['PropertyID'];
    propertyName = json['PropertyName'];
    baseURL = json['BaseURL'];
    childrenFreeStay = json['ChildrenFreeStay'];
    showChildren = json['ShowChildren'];
    cCValidation = json['CCValidation'];
    creditCardPassword = json['CreditCardPassword'];
    logo = json['Logo'];
    address = json['Address'];
    city = json['City'];
    state = json['State'];
    zip = json['Zip'];
    phone = json['Phone'];
    fax = json['Fax'];
    email = json['Email'];
    website = json['Website'];
    pOSId = json['POSId'];
    cDNPath = json['CDNPath'];
    groupID = json['GroupID'];
    userID = json['UserID'];
    userName = json['UserName'];
    shiftNo = json['ShiftNo'];
    authToken = json['AuthToken'];
    pOSEnabled = json['POSEnabled'];
    oTAEnabled = json['OTAEnabled'];
    houseKeeping = json['HouseKeeping'];
    housekeepingMenu = json['HousekeepingMenu'];
    country = json['Country'];
    indianTax = json['IndianTax'];
    expediaInterface = json['ExpediaInterface'];
    bookingInterface = json['BookingInterface'];
    tripInterface = json['TripInterface'];
    isAxisRoomEnabled = json['IsAxisRoomEnabled'];
    campres = json['Campres'];
    isPOS = json['IsPOS'];
    isQuickBook = json['IsQuickBook'];
    isGiftShop = json['IsGiftShop'];
    isStockManagement = json['IsStockManagement'];
    isCRM = json['IsCRM'];
    cHAINNAME = json['CHAINNAME'];
    iscondo = json['Iscondo'];
    giftCertificate = json['GiftCertificate'];
    yieldManagement = json['YieldManagement'];
    directBilling = json['DirectBilling'];
    chequeManagement = json['ChequeManagement'];
    swimmingPoolModule = json['SwimmingPoolModule'];
    isWebsite = json['IsWebsite'];
    eikasp = json['Eikasp'];
    isInvoiceSetup = json['IsInvoiceSetup'];
    isSiteMinder = json['IsSiteMinder'];
    distributor = json['Distributor'];
    iCalendar = json['ICalendar'];
    qBInterface = json['QBInterface'];
    qBOAuth2 = json['QBOAuth2'];
    cashDrawer = json['CashDrawer'];
    isLiteVersion = json['IsLiteVersion'];
    cRSInterface = json['CRSInterface'];
    isAutomatedReport = json['IsAutomatedReport'];
    isEasyWebRezV3 = json['IsEasyWebRezV3'];
    isMinistryManagement = json['IsMinistryManagement'];
    isGraceOTAExpedia = json['IsGraceOTAExpedia'];
    isGraceOTABooking = json['IsGraceOTABooking'];
    isChurhProperty = json['IsChurhProperty'];
    isAirBnb = json['IsAirBnb'];
    isGoogleHotel = json['IsGoogleHotel'];
    showMenuIcons = json['ShowMenuIcons'];
    isAutoPayment = json['IsAutoPayment'];
    date = json['Date'];
    staffName = json['StaffName'];
    mailFrom = json['MailFrom'];
    showCVV = json['ShowCVV'];
    companyCode = json['CompanyCode'];
    companyName = json['CompanyName'];
    multiLanguages = json['MultiLanguages'];
    cCTransactionMode = json['CCTransactionMode'];
    isBetaProperty = json['IsBetaProperty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PropertyID'] = this.propertyID;
    data['PropertyName'] = this.propertyName;
    data['BaseURL'] = this.baseURL;
    data['ChildrenFreeStay'] = this.childrenFreeStay;
    data['ShowChildren'] = this.showChildren;
    data['CCValidation'] = this.cCValidation;
    data['CreditCardPassword'] = this.creditCardPassword;
    data['Logo'] = this.logo;
    data['Address'] = this.address;
    data['City'] = this.city;
    data['State'] = this.state;
    data['Zip'] = this.zip;
    data['Phone'] = this.phone;
    data['Fax'] = this.fax;
    data['Email'] = this.email;
    data['Website'] = this.website;
    data['POSId'] = this.pOSId;
    data['CDNPath'] = this.cDNPath;
    data['GroupID'] = this.groupID;
    data['UserID'] = this.userID;
    data['UserName'] = this.userName;
    data['ShiftNo'] = this.shiftNo;
    data['AuthToken'] = this.authToken;
    data['POSEnabled'] = this.pOSEnabled;
    data['OTAEnabled'] = this.oTAEnabled;
    data['HouseKeeping'] = this.houseKeeping;
    data['HousekeepingMenu'] = this.housekeepingMenu;
    data['Country'] = this.country;
    data['IndianTax'] = this.indianTax;
    data['ExpediaInterface'] = this.expediaInterface;
    data['BookingInterface'] = this.bookingInterface;
    data['TripInterface'] = this.tripInterface;
    data['IsAxisRoomEnabled'] = this.isAxisRoomEnabled;
    data['Campres'] = this.campres;
    data['IsPOS'] = this.isPOS;
    data['IsQuickBook'] = this.isQuickBook;
    data['IsGiftShop'] = this.isGiftShop;
    data['IsStockManagement'] = this.isStockManagement;
    data['IsCRM'] = this.isCRM;
    data['CHAINNAME'] = this.cHAINNAME;
    data['Iscondo'] = this.iscondo;
    data['GiftCertificate'] = this.giftCertificate;
    data['YieldManagement'] = this.yieldManagement;
    data['DirectBilling'] = this.directBilling;
    data['ChequeManagement'] = this.chequeManagement;
    data['SwimmingPoolModule'] = this.swimmingPoolModule;
    data['IsWebsite'] = this.isWebsite;
    data['Eikasp'] = this.eikasp;
    data['IsInvoiceSetup'] = this.isInvoiceSetup;
    data['IsSiteMinder'] = this.isSiteMinder;
    data['Distributor'] = this.distributor;
    data['ICalendar'] = this.iCalendar;
    data['QBInterface'] = this.qBInterface;
    data['QBOAuth2'] = this.qBOAuth2;
    data['CashDrawer'] = this.cashDrawer;
    data['IsLiteVersion'] = this.isLiteVersion;
    data['CRSInterface'] = this.cRSInterface;
    data['IsAutomatedReport'] = this.isAutomatedReport;
    data['IsEasyWebRezV3'] = this.isEasyWebRezV3;
    data['IsMinistryManagement'] = this.isMinistryManagement;
    data['IsGraceOTAExpedia'] = this.isGraceOTAExpedia;
    data['IsGraceOTABooking'] = this.isGraceOTABooking;
    data['IsChurhProperty'] = this.isChurhProperty;
    data['IsAirBnb'] = this.isAirBnb;
    data['IsGoogleHotel'] = this.isGoogleHotel;
    data['ShowMenuIcons'] = this.showMenuIcons;
    data['IsAutoPayment'] = this.isAutoPayment;
    data['Date'] = this.date;
    data['StaffName'] = this.staffName;
    data['MailFrom'] = this.mailFrom;
    data['ShowCVV'] = this.showCVV;
    data['CompanyCode'] = this.companyCode;
    data['CompanyName'] = this.companyName;
    data['MultiLanguages'] = this.multiLanguages;
    data['CCTransactionMode'] = this.cCTransactionMode;
    data['IsBetaProperty'] = this.isBetaProperty;
    return data;
  }
}

class Legends {
  int? statusId;
  String? status;
  String? color;

  Legends({this.statusId, this.status, this.color});

  Legends.fromJson(Map<String, dynamic> json) {
    statusId = json['StatusId'];
    status = json['Status'];
    color = json['Color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusId'] = this.statusId;
    data['Status'] = this.status;
    data['Color'] = this.color;
    return data;
  }
}