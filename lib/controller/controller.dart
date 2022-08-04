import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:orderapp/components/customSnackbar.dart';
import 'package:orderapp/db_helper.dart';
import 'package:orderapp/model/accounthead_model.dart';
import 'package:orderapp/model/productCompany_model.dart';
import 'package:orderapp/model/productsCategory_model.dart';
import 'package:orderapp/model/registration_model.dart';
import 'package:orderapp/model/sideMenu_model.dart';
import 'package:orderapp/model/userType_model.dart';
import 'package:orderapp/model/verify_registrationModel.dart';
import 'package:orderapp/model/wallet_model.dart';
import 'package:orderapp/screen/ADMIN_/adminModel.dart';
import 'package:orderapp/screen/ORDER/2_companyDetailsscreen.dart';
import 'package:orderapp/screen/ORDER/externalDir.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/network_connectivity.dart';
import '../model/balanceGet_model.dart';
import '../model/productdetails_model.dart';
import '../model/staffarea_model.dart';
import '../model/staffdetails_model.dart';

class Controller extends ChangeNotifier {
  bool? fromDb;
  double gross = 0.0;
  double gross_tot = 0.0;
  double dis_tot = 0.0;
  double cess_tot = 0.0;
  double tax_tot = 0.0;

  double disc_amt = 0.0;
  double net_amt = 0.0;
  double taxable_rate = 0.0;
  // double salesNetamt = 0.0;
  double salesTotal = 0.0;

  double tax = 0.0;
  double cgst_amt = 0.0;
  double cgst_per = 0.0;
  double sgst_amt = 0.0;
  double sgst_per = 0.0;
  double igst_amt = 0.0;
  double igst_per = 0.0;
  double disc_per = 0.0;
  double cess = 0.0;
  bool isLoading = false;
  bool isCompleted = false;
  bool isUpload = false;
  bool filterCompany = false;
  bool salefilterCompany = false;
  String? salefilteredeValue;
  String? filteredeValue;
  bool isAdminLoading = false;
  String? menu_index;
  ExternalDir externalDir = ExternalDir();
  bool isListLoading = false;
  int? selectedTabIndex;
  String? userName;
  String? selectedAreaId;
  CustomSnackbar snackbar = CustomSnackbar();
  bool isSearch = false;
  bool isreportSearch = false;
  String? areaId;
  bool flag = false;
  List<String> gridHeader = [];
  String? areaSelecton;
  int returnCount = 0;
  bool isVisible = false;
  double returnTotal = 0.0;
  bool? noreportdata;
  bool? continueClicked;
  bool returnprice = false;
  int? shopVisited;
  int? noshopVisited;
  List<bool> selected = [];
  List<bool> isDown = [];
  List<bool> isUp = [];

  List<bool> saleItemselected = [];

  List<bool> filterComselected = [];
  List<bool> returnselected = [];
  List<bool> returnirtemExists = [];

  bool isautodownload = false;

  // List<bool> returnSelected = [];

  String? areaidFrompopup;
  List<bool> isExpanded = [];
  List<Today> adminDashboardList = [];
  bool returnqty = false;
  List<bool> isVisibleTable = [];
  List<Map<String, dynamic>> collectionList = [];
  List<Map<String, dynamic>> productcompanyList = [];
  List<Map<String, dynamic>> fetchcollectionList = [];
  List<bool> settingOption = [];
  List<Map<String, dynamic>> filterList = [];
  List<Map<String, dynamic>> sortList = [];
  List<Map<String, dynamic>> filteredProductList = [];
  List<Map<String, dynamic>> salefilteredProductList = [];

  List<Map<String, dynamic>> returnList = [];
  bool filter = false;
  bool isDownloaded = false;
  // String? custmerSelection;
  int? customerCount;
  List<String> tableColumn = [];
  List<Map<String, dynamic>> res = [];
  List<String> tableHistorydataColumn = [];
  // List<Map<String, dynamic>> reportOriginalList1 = [];
  String? editedRate;
  String? order_id;
  String? searchkey;
  String? reportSearchkey;
  String? sname;
  String? sid;
  String? userType;
  String? updateDate;
  String? orderTotal1;
  String? saleTot;
  List<String?> orderTotal2 = [];
  String? ordernumber;
  String? cid;
  String? cname;
  int? qtyinc;
  int? returnqtyinc;
  String? itemRate;
  List<CD> c_d = [];
  List<Map<String, dynamic>> historyList = [];
  List<Map<String, dynamic>> reportOriginalList = [];
  List<Map<String, dynamic>> settingsList = [];
  List<Map<String, dynamic>> walletList = [];
  List<Map<String, dynamic>> historydataList = [];
  List<Map<String, dynamic>> staffOrderTotal = [];
  String? area;
  String? splittedCode;
  double amt = 0.0;
  List<CD> data = [];
  double? totalPrice;
  double? returntotalPrice;
  String? totrate;
  String? priceval;
  List<String> areaAutoComplete = [];
  List<Map<String, dynamic>> menuList = [];
  List<Map<String, dynamic>> reportData = [];
  List<Map<String, dynamic>> sumPrice = [];
  List<Map<String, dynamic>> collectionsumPrice = [];
  String collectionAmount = "0.0";
  String returnAmount = "0.0";
  String ordrAmount = "0.0";
  String salesAmount = "0.0";
  String? remarkCount;
  String? orderCount;
  String? collectionCount;
  String? salesCount;
  String? ret_count;
  List<Map<String, dynamic>> remarkList = [];
  List<Map<String, dynamic>> remarkStaff = [];
  String? firstMenu;
  List<Map<String, dynamic>> listWidget = [];
  List<TextEditingController> controller = [];
  List<TextEditingController> qty = [];
  List<TextEditingController> salesqty = [];
  List<TextEditingController> discount_prercent = [];
  List<TextEditingController> discount_amount = [];

  List<bool> rateEdit = [];
  String? count;
  String? sof;
  String? versof;
  String? vermsg;
  String? heading;
  String? fp;
  List<Map<String, dynamic>> bagList = [];
  List<Map<String, dynamic>> salebagList = [];

  List<Map<String, dynamic>> newList = [];
  List<Map<String, dynamic>> newreportList = [];
  List<Map<String, dynamic>> remarkreportList = [];
  List<Map<String, dynamic>> masterList = [];
  List<Map<String, dynamic>> orderdetailsList = [];
  bool settingsRateOption = false;
  List<Map<String, dynamic>> staffList = [];
  List<Map<String, dynamic>> staffId = [];
  List<Map<String, dynamic>> productName = [];
  List<Map<String, dynamic>> areDetails = [];
  List<Map<String, dynamic>> cmpDetails = [];
  List<Map<String, dynamic>> custmerDetails = [];
  List<Map<String, dynamic>> areaList = [];
  List<Map<String, dynamic>> companyList = [];
  List<Map<String, dynamic>> customerList = [];
  List<Map<String, dynamic>> todayOrderList = [];
  List<Map<String, dynamic>> todayCollectionList = [];
  List<Map<String, dynamic>> todaySalesList = [];
  List<Map<String, dynamic>> copyCus = [];
  List<Map<String, dynamic>> prodctItems = [];
  List<Map<String, dynamic>> ordernum = [];
  List<Map<String, dynamic>> approximateSum = [];
  // List<WalletModal> wallet = [];
  StaffDetails staffModel = StaffDetails();
  UserTypeModel userTypemodel = UserTypeModel();
  Balance balanceModel = Balance();
  AccountHead accountHead = AccountHead();
  StaffArea staffArea = StaffArea();
  ProductDetails proDetails = ProductDetails();
  String? path;
  String? textFile;
//////////////////////////////// API CONNECTION //////////////////////
//////////////////////////////REGISTRATION ///////////////////////////
  Future<RegistrationData?> postRegistration(
      String company_code,
      String? fingerprints,
      String phoneno,
      String deviceinfo,
      BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      await OrderAppDB.instance.deleteFromTableCommonQuery('menuTable', "");
      print("Text fp...$fingerprints");
      print("company_code.........$company_code");
      if (value == true) {
        try {
          Uri url =
              Uri.parse("http://trafiqerp.in/order/fj/get_registration.php");
          Map body = {
            'company_code': company_code,
            'fcode': fingerprints,
            'deviceinfo': deviceinfo,
            'phoneno': phoneno
          };
          print("body----${body}");
          isLoading = true;
          notifyListeners();
          http.Response response = await http.post(
            url,
            body: body,
          );
          print("body ${body}");
          var map = jsonDecode(response.body);
          print("map register ${map}");
          // print("response ${response}");
          RegistrationData regModel = RegistrationData.fromJson(map);
          userType = regModel.type;
          print("usertype----$userType");
          sof = regModel.sof;
          fp = regModel.fp;
          String? msg = regModel.msg;
          print("fp----- $fp");
          print("sof----${sof}");
          if (sof == "1") {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("company_id", company_code);
            /////////////// insert into local db /////////////////////
            late CD dataDetails;
            String? fp1 = regModel.fp;
            print("fingerprint......$fp1");
            prefs.setString("fp", fp!);
            String? os = regModel.os;
            regModel.c_d![0].cid;
            cid = regModel.cid;
            cname = regModel.c_d![0].cnme;
            notifyListeners();

            await externalDir.fileWrite(fp1!);

            for (var item in regModel.c_d!) {
              print("ciddddddddd......$item");
              c_d.add(item);
            }
            verifyRegistration(context);

            await OrderAppDB.instance
                .deleteFromTableCommonQuery('registrationTable', "");
            var res =
                await OrderAppDB.instance.insertRegistrationDetails(regModel);
            print("inserted ${res}");
            isLoading = false;
            notifyListeners();
            prefs.setString("userType", userType!);
            prefs.setString("cid", cid!);
            prefs.setString("os", os!);

            prefs.setString("cname", cname!);

            String? user = prefs.getString("userType");

            print("fnjdxf----$user");
            getCompanyData();
            // OrderAppDB.instance.deleteFromTableCommonQuery('menuTable',"");
            getMenuAPi(cid!, fp1, company_code, context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CompanyDetails(
                        type: "",
                        msg: "",
                      )),
            );
          }
          /////////////////////////////////////////////////////

          if (sof == "0") {
            CustomSnackbar snackbar = CustomSnackbar();
            snackbar.showSnackbar(context, msg.toString(), "");
          }

          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

//////////////////////VERIFY REGISTRATION/////////////////////////////
  Future<RegistrationData?> verifyRegistration(BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      String? compny_code;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      compny_code = prefs.getString("company_id");
      String? fp = prefs.getString("fp");
      ///////////////// find app version/////////////////////////
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      print("App new version $version");
      ///////////////////////////////////////////////////////////
      Map map = {
        '0': compny_code,
        "1": fp,
      };

      List list = [];
      list.add(map);
      var jsonen = jsonEncode(list);
      print("json----$jsonen");
      print("listrrr----$list");
      if (value == true) {
        try {
          Uri url =
              Uri.parse("http://trafiqerp.in/order/fj/verify_registration.php");
          Map body = {
            'json_result': jsonen,
          };
          // Map test={'json_result':[{"0":"RONPBQ9AAXVO","1":"ssss"}]};
          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("verify--$map");
          VerifyRegistration verRegModel = VerifyRegistration.fromJson(map);
          versof = verRegModel.sof;
          vermsg = verRegModel.msg;
          print("vermsg----$vermsg");

          // /////////////////////////////////////////////////////
          print("cid----fp-----$compny_code---$fp");
          if (fp != null && compny_code != null) {
            print("entereddddsd");
            prefs.setString("versof", versof!);
            prefs.setString("vermsg", vermsg!);
            print("versofbhg----${vermsg}");
            getCompanyData();
            if (versof == "0") {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CompanyDetails(
                          type: "",
                          msg: vermsg,
                        )),
              );
            }
          }

          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

  //////////////////////GET MENU////////////////////////////////////////
  Future<RegistrationData?> getMenuAPi(String company_code, String fp,
      String apk_key, BuildContext context) async {
    var res;
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        print("company_code---fp-${company_code}---${fp}..${apk_key}");

        try {
          Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_menu.php");
          Map body = {
            'apk_key': apk_key,
            'company_code': company_code,
            'fingerprint': fp,
          };
          print("body.........$body");
          http.Response response = await http.post(
            url,
            body: body,
          );

          print("bodymenuuuuuu ${body}");
          var map = jsonDecode(response.body);
          print("map menu ${map}");
          SideMenu sidemenuModel = SideMenu.fromJson(map);
          firstMenu = sidemenuModel.first;
          print("menuitem----${sidemenuModel.menu![0].menu_name}");
          print("firstMenu----$firstMenu");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("firstMenu", firstMenu!);
          for (var menuItem in sidemenuModel.menu!) {
            print("menuitem----${menuItem.menu_name}");
            res = await OrderAppDB.instance
                .insertMenuTable(menuItem.menu_index!, menuItem.menu_name!);
            // menuList.add(menuItem);
          }
          print("insertion----$res");
          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

  /////////////////////////// GET BALANCE ////////////////////////////
  Future<Balance?> getBalance(String? cid, String? code) async {
    print("get balance...............${cid}");
    var restaff;
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_balance.php");
      Map body = {
        'cid': cid,
        'code': code,
      };
      http.Response response = await http.post(
        url,
        body: body,
      );

      List map = jsonDecode(response.body);
      print("map ${map}");
      if (map != null) {
        for (var getbal in map) {
          balanceModel = Balance.fromJson(getbal);
        }
      }
      print("inserted staff ${balanceModel.ba}");
      return balanceModel;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /////////////////////// GET STAFF DETAILS////////////////////////////////
  Future<StaffDetails?> getStaffDetails(String cid) async {
    print("getStaffDetails...............${cid}");
    var restaff;
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_staff.php");
      Map body = {
        'cid': cid,
      };
      http.Response response = await http.post(
        url,
        body: body,
      );
      List map = jsonDecode(response.body);
      print("map ${map}");
      for (var staff in map) {
        staffModel = StaffDetails.fromJson(staff);
        restaff = await OrderAppDB.instance.insertStaffDetails(staffModel);
      }
      print("inserted staff ${restaff}");
      notifyListeners();
      return staffModel;
    } catch (e) {
      print(e);
      return null;
    }
  }

  ////////////////////FETCH MENU TABLE ///////////////////////////////
  fetchMenusFromMenuTable() async {
    var res = await OrderAppDB.instance.selectAllcommon('menuTable', "");

    print("menu from table----$res");
    menuList.clear();

    for (var menu in res) {
      menuList.add(menu);
    }
    print("menuList----${menuList}");

    notifyListeners();
  }

/////////////////GET USER TYPE//////////////////////////////////////
  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cid = prefs.getString("cid");
    print("getuserType...............${cid}");
    var resuser;
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_user.php");
      Map body = {
        'cid': cid,
      };

      http.Response response = await http.post(
        url,
        body: body,
      );
      print("body user ${body}");
      var map = jsonDecode(response.body);
      print("mapuser ${map}");

      for (var user in map) {
        print("user----${user}");
        userTypemodel = UserTypeModel.fromJson(user);
        resuser = await OrderAppDB.instance.insertUserType(userTypemodel);
        // print("inserted ${restaff}");
      }
      print("inserted user ${resuser}");

      /////////////// insert into local db /////////////////////
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

////////////////////// GET STAFF AREA ///////////////////////////////////
  Future<StaffArea?> getAreaDetails(String cid) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_area.php");
      Map body = {
        'cid': cid,
      };
      print("compny----${cid}");
      http.Response response = await http.post(
        url,
        body: body,
      );
      print("body ${body}");
      List map = jsonDecode(response.body);
      print("maparea ${map.length}");
      await OrderAppDB.instance
          .deleteFromTableCommonQuery('areaDetailsTable', "");

      for (var staffarea in map) {
        print("staffarea----${staffarea.length}");
        staffArea = StaffArea.fromJson(staffarea);
        var staffar =
            await OrderAppDB.instance.insertStaffAreaDetails(staffArea);
        print("inserted ${staffar}");
      }
      /////////////// insert into local db /////////////////////
      notifyListeners();
      return staffArea;
    } catch (e) {
      print(e);
      return null;
    }
  }

//////////////////////////////////GET ACCOUNT HEADS//////////////////////////////////////
  Future<AccountHead?> getaccountHeadsDetails(
      BuildContext context, String s, String cid, int index) async {
    print("cid...............${cid}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString("userType");
    String? sid = prefs.getString("sid");

    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_achead.php");
      Map body = {
        'cid': cid,
      };

      isLoading = true;
      isDownloaded = true;
      notifyListeners();
      print("compny----${cid}");
      http.Response response = await http.post(
        url,
        body: body,
      );
      print("body ${body}");
      List map = jsonDecode(response.body);
      print("map ${map}");
      await OrderAppDB.instance
          .deleteFromTableCommonQuery("accountHeadsTable", "");

      for (var ahead in map) {
        print("ahead------${ahead}");
        accountHead = AccountHead.fromJson(ahead);
        var account = await OrderAppDB.instance.insertAccoundHeads(accountHead);
      }

      final prefs = await SharedPreferences.getInstance();

      String? us = await prefs.getString('st_username');
      String? pwd = await prefs.getString('st_pwd');
      if (us != null && pwd != null) {
        if (areaidFrompopup != null) {
          dashboardSummery(sid!, s, areaidFrompopup!, context);
        } else {
          if (userType == "staff") {
            print("satfff");
            dashboardSummery(sid!, s, "", context);
          }
        }
      }
      isDownloaded = false;
      isDown[index] = true;
      isLoading = false;

      notifyListeners();

      // return accountHead;
    } catch (e) {
      print(e);
      return null;
    }
  }

  ////////////////////////// GET WALLET ///////////////////////////////////////
  Future<WalletModal?> getWallet(BuildContext context, int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cid = prefs.getString("cid");
    NetConnection.networkConnection(context).then((value) async {
      // await OrderAppDB.instance.deleteFromTableCommonQuery('menuTable', "");
      if (value == true) {
        try {
          Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_wallet.php");
          Map body = {
            'cid': cid,
          };
          isDownloaded = true;
          isCompleted = true;
          isLoading = true;
          notifyListeners();
          http.Response response = await http.post(
            url,
            body: body,
          );
          await OrderAppDB.instance
              .deleteFromTableCommonQuery("walletTable", "");
          var map = jsonDecode(response.body);
          print("map ${map}");
          WalletModal walletModal;
          // walletModal.
          for (var item in map) {
            walletModal = WalletModal.fromJson(item);
            await OrderAppDB.instance.insertwalletTable(walletModal);
            // menuList.add(menuItem);
          }
          isDownloaded = false;
          isDown[index] = true;
          isLoading = false;

          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

  /////////////////////////SAVE RETURN TABLE //////////////////////////////////
  saveReturnDetails(
      String cid, List<Map<String, dynamic>> om, BuildContext context) async {
    try {
      print("haiii");
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/stock_return_save.php");
      isLoading = true;
      notifyListeners();
      // print("body--${body}");
      var mapBody = jsonEncode(om);
      print("mapBody--${mapBody}");

      var jsonD = jsonDecode(mapBody);

      http.Response response = await http.post(
        url,
        body: {'cid': cid, 'om': mapBody},
      );

      print("after");

      var map = jsonDecode(response.body);
      print("response return----${map}");

      for (var item in map) {
        if (item["stock_r_id"] != null) {
          await OrderAppDB.instance.upadteCommonQuery("returnMasterTable",
              "status='${item["stock_r_id"]}'", "return_id='${item["id"]}'");
        }
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

  ///////////////DASHBOARD DATA ///////////////////////////
  adminDashboard(String cid) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_today.php");
      Map body = {
        'cid': cid,
      };
      isAdminLoading = true;
      // notifyListeners();
      http.Response response = await http.post(
        url,
        body: body,
      );

      print("body ${body}");
      var map = jsonDecode(response.body);
      print("maparea ${map}");
      late Today todayDetails;
      isAdminLoading = false;
      notifyListeners();
      AdminDash admin = AdminDash.fromJson(map);
      heading = admin.caption;
      updateDate = admin.cvalue;

      print("TodayDash ${admin.today![0].group}");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("heading", heading!);
      prefs.setString("updateDate", updateDate!);
      adminDashboardList.clear();

      for (var item in admin.today!) {
        adminDashboardList.add(item);
        // print("item-----${item.tileCount}");
      }
      print("TodayDash ${adminDashboardList}");

      notifyListeners();
      // return staffArea;
    } catch (e) {
      print("errordash Data $e");
      return null;
    }
  }

  ///////////////////////GET PRODUCT DETAILS//////////////////////////
  Future<ProductDetails?> getProductDetails(String cid, int index) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_prod.php");
      Map body = {
        'cid': cid,
      };
      print("compny----${cid}");
      isDownloaded = true;

      isLoading = true;
      notifyListeners();

      http.Response response = await http.post(
        url,
        body: body,
      );
      await OrderAppDB.instance
          .deleteFromTableCommonQuery("productDetailsTable", "");
      // print("body ${body}");
      List map = jsonDecode(response.body);
      // print("map ${map}");
      for (var pro in map) {
        proDetails = ProductDetails.fromJson(pro);
        var product =
            await OrderAppDB.instance.insertProductDetails(proDetails);
      }
      isDownloaded = false;
      isDown[index] = true;

      isLoading = false;
      notifyListeners();
      /////////////// insert into local db /////////////////////
    } catch (e) {
      print(e);
      return null;
    }
  }

  //////////////////ORDER SAVE AND SEND/////////////////////////
  saveOrderDetails(String cid, List<Map<String, dynamic>> om,
      BuildContext context, int index) async {
    try {
      print("haiii");
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/order_save.php");
      isLoading = true;
      notifyListeners();
      // print("body--${body}");
      var mapBody = jsonEncode(om);
      print("mapBody--${mapBody}");

      // var jsonD = jsonDecode(mapBody);
      var body = {'cid': cid, 'om': mapBody};
      print("body----------$body");
      http.Response response = await http.post(
        url,
        body: {'cid': cid, 'om': mapBody},
      );

      print("after");

      var map = jsonDecode(response.body);
      print("response----${map}");

      for (var item in map) {
        if (item["order_id"] != null) {
          await OrderAppDB.instance.upadteCommonQuery("orderMasterTable",
              "status='${item["order_id"]}'", "order_id='${item["id"]}'");
        }
      }
      isLoading = false;

      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

  ////////////////////////////////////////////////////////////////////////////
  saveSalesDetails(String cid, List<Map<String, dynamic>> om,
      BuildContext context, int index) async {
    try {
      print("haiii");
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/sale_save.php");
      isLoading = true;
      notifyListeners();
      // print("body--${body}");
      var mapBody = jsonEncode(om);
      print("mapBody--${mapBody}");

      // var jsonD = jsonDecode(mapBody);
      var body = {'cid': cid, 'om': mapBody};
      print("body sales ---------$body");
      http.Response response = await http.post(
        url,
        body: {'cid': cid, 'om': mapBody},
      );
      print("after-----$response");

      var map = jsonDecode(response.body);
      print("response sales----${map}");
      for (var item in map) {
        print("itemtt----$item");
        if (item["s_id"] != null) {
          await OrderAppDB.instance.upadteCommonQuery("salesMasterTable",
              "status='${item["s_id"]}'", "sales_id='${item["s_id"]}'");
        }
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

/////////////////////////////GET PRODUCT CATEGORY//////////////////////////////
  Future<ProductsCategoryModel?> getProductCategory(
      String cid, int index) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_cat.php");
      Map body = {
        'cid': cid,
      };
      print("compny----${cid}");
      isDownloaded = true;
      isLoading = true;
      notifyListeners();

      http.Response response = await http.post(
        url,
        body: body,
      );
      // print("body ${body}");
      await OrderAppDB.instance
          .deleteFromTableCommonQuery("productsCategory", "");
      List map = jsonDecode(response.body);
      print("map ${map}");
      ProductsCategoryModel category;
      for (var cat in map) {
        category = ProductsCategoryModel.fromJson(cat);
        var product = await OrderAppDB.instance.insertProductCategory(category);
        isDownloaded = false;
        isDown[index] = true;
        isLoading = false;
        notifyListeners();

        // print("inserted ${account}");
      }
      /////////////// insert into local db /////////////////////
      // notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

  ////////////////////////////////GET COMPANY/////////////////////////////////
  Future<ProductCompanymodel?> getProductCompany(String cid, int index) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_com.php");
      Map body = {
        'cid': cid,
      };
      print("compny----${cid}");
      isDownloaded = true;
      isLoading = true;
      notifyListeners();

      http.Response response = await http.post(
        url,
        body: body,
      );
      await OrderAppDB.instance.deleteFromTableCommonQuery("companyTable", "");
      // print("body ${body}");
      List map = jsonDecode(response.body);
      print("map ${map}");
      ProductCompanymodel productCompany;
      for (var proComp in map) {
        productCompany = ProductCompanymodel.fromJson(proComp);
        var product =
            await OrderAppDB.instance.insertProductCompany(productCompany);
      }
      isDownloaded = false;
      isDown[index] = true;

      isLoading = false;
      notifyListeners();
      /////////////// insert into local db /////////////////////
    } catch (e) {
      print(e);
      return null;
    }
  }

// /////////////////////////////INSERT into SALES bag and master table///////////////////////////////////////////////
  insertToSalesbagAndMaster(
    String os,
    String date,
    String time,
    String customer_id,
    String staff_id,
    String aid,
    double total_price,
    double gross_tot,
    double tax_tot,
    double dis_tot,
    double cess_tot,
  ) async {
    List<Map<String, dynamic>> om = [];
    int sales_id = await OrderAppDB.instance
        .getMaxCommonQuery('salesDetailTable', 'sales_id', "os='${os}'");
    int rowNum = 1;
    print("salebagList length........${salebagList.length}");
    if (salebagList.length > 0) {
      String billNo = "${os}" + "${rowNum}";
      print("bill no........$billNo");
      var result = await OrderAppDB.instance.insertsalesMasterandDetailsTable(
          sales_id,
          0,
          0.0,
          0.0,
          "",
          "",
          date,
          time,
          os,
          customer_id,
          "",
          billNo,
          staff_id,
          aid,
          0,
          "",
          "",
          "",
          rowNum,
          "salesMasterTable",
          "",
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          gross_tot,
          dis_tot,
          tax_tot,
          cess_tot,
          0.0,
          total_price,
          0.0,
          0,
          0);

      for (var item in salebagList) {
        print("item....$item");
        double rate = double.parse(item["rate"]);
        await OrderAppDB.instance.insertsalesMasterandDetailsTable(
          sales_id,
          item["qty"],
          rate,
          item["unit_rate"],
          item["code"],
          item["hsn"],
          date,
          time,
          os,
          customer_id,
          "",
          billNo,
          staff_id,
          aid,
          0,
          "",
          "",
          "",
          rowNum,
          "salesDetailTable",
          item["itemName"],
          double.parse(item["totalamount"]),
          item["discount_amt"],
          item["discount_per"],
          item["tax_amt"],
          item["tax_per"],
          item["cgst_per"],
          item["cgst_amt"],
          item["sgst_per"],
          item["sgst_amt"],
          item["igst_per"],
          item["igst_amt"],
          item["ces_amt"],
          item["ces_per"],
          0.0,
          0.0,
          0.0,
          0.0,
          item["net_amt"],
          0.0,
          0.0,
          0,
          0,
        );
        rowNum = rowNum + 1;
      }
    }
    await OrderAppDB.instance.deleteFromTableCommonQuery(
        "salesBagTable", "os='${os}' AND customerid='${customer_id}'");

    bagList.clear();
    notifyListeners();
  }

  //////////////insert to order master and details///////////////////////
  insertToOrderbagAndMaster(
    String os,
    String date,
    String time,
    String customer_id,
    String user_id,
    String aid,
    double total_price,
  ) async {
    print("hhjk----$date");
    List<Map<String, dynamic>> om = [];
    int order_id = await OrderAppDB.instance
        .getMaxCommonQuery('orderDetailTable', 'order_id', "os='${os}'");
    int rowNum = 1;
    if (bagList.length > 0) {
      await OrderAppDB.instance.insertorderMasterandDetailsTable(
          "",
          order_id,
          0,
          0.0,
          " ",
          date,
          time,
          os,
          customer_id,
          user_id,
          aid,
          0,
          "",
          rowNum,
          "orderMasterTable",
          total_price);

      for (var item in bagList) {
        print("orderid---$order_id");
        double rate = double.parse(item["rate"]);
        await OrderAppDB.instance.insertorderMasterandDetailsTable(
            item["itemName"],
            order_id,
            item["qty"],
            rate,
            item["code"],
            date,
            time,
            os,
            customer_id,
            user_id,
            aid,
            0,
            "",
            rowNum,
            "orderDetailTable",
            total_price);
        rowNum = rowNum + 1;
      }
    }
    await OrderAppDB.instance.deleteFromTableCommonQuery(
        "orderBagTable", "os='${os}' AND customerid='${customer_id}'");

    bagList.clear();
    notifyListeners();
  }

///////////////////////insertreturnMasterandDetailsTable//////////////////////////////
  insertreturnMasterandDetailsTable(
      String os,
      String date,
      String time,
      String customer_id,
      String user_id,
      String aid,
      double total_price,
      String? refNo,
      String? reason) async {
    print(
        "values--------$date--$time$customer_id-$user_id--$aid--$total_price--$refNo--$reason");
    // List<Map<String, dynamic>> om = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? os1 = prefs.getString("os");
    int return_id = await OrderAppDB.instance
        .getMaxCommonQuery('returnMasterTable', 'return_id', "os='${os1}'");
    print("return_id----$return_id");
    int rowNum = 1;
    if (returnList.length > 0) {
      await OrderAppDB.instance.insertreturnMasterandDetailsTable(
          "",
          return_id,
          0,
          0.0,
          " ",
          date,
          time,
          os1!,
          customer_id,
          user_id,
          aid,
          0,
          "",
          rowNum,
          "returnMasterTable",
          total_price,
          reason!,
          refNo!);

      for (var item in returnList) {
        print("return_id---$return_id");
        // double rate = double.parse(item["rate"]);
        await OrderAppDB.instance.insertreturnMasterandDetailsTable(
            item["item"],
            return_id,
            item["qty"],
            double.parse(item["rate"]),
            item["code"],
            date,
            time,
            os1,
            customer_id,
            user_id,
            aid,
            0,
            "",
            rowNum,
            "returnDetailTable",
            total_price,
            "",
            "");
        rowNum = rowNum + 1;
      }
    }

    returnList.clear();
    notifyListeners();
  }

  //////////////////staff log details insertion//////////////////////
  insertStaffLogDetails(String sid, String sname, String datetime) async {
    var logdata =
        await OrderAppDB.instance.insertStaffLoignDetails(sid, sname, datetime);
    notifyListeners();
  }

//////////////////////////////////UPDATE ////////////////////
  /////////////////////////////updateqty/////////////////////
  updateQty(String qty, int cartrowno, String customerId, String rate) async {
    List<Map<String, dynamic>> res = await OrderAppDB.instance
        .updateQtyOrderBagTable(qty, cartrowno, customerId, rate);
    if (res.length >= 0) {
      bagList.clear();
      for (var item in res) {
        bagList.add(item);
      }
      print("re from controller----$res");
      notifyListeners();
    }
  }

  ////////////////////////////////////////////////////////////////////
  salesupdateQty(
      String qty, int cartrowno, String customerId, String rate) async {
    print("qtyuuu----$qty");
    List<Map<String, dynamic>> res = await OrderAppDB.instance
        .updateQtySalesBagTable(qty, cartrowno, customerId, rate);
    if (res.length >= 0) {
      salebagList.clear();
      for (var item in res) {
        salebagList.add(item);
      }
      print("re from controller----$res");
      notifyListeners();
    }
  }

  /////////////////// SELECT //////////////////////
  //////////////////////SELECT WALLET ////////////////////////////////////////////////////
  fetchwallet() async {
    walletList.clear();
    var res = await OrderAppDB.instance.selectAllcommon('walletTable', "");
    for (var item in res) {
      walletList.add(item);
    }
    print("fetch wallet-----$walletList");
  }

  ////////////////////remark selection/////////
  fetchremarkFromTable(String custmerId) async {
    remarkList.clear();
    var res = await OrderAppDB.instance
        .selectAllcommonwithdesc('remarksTable', "rem_cusid='${custmerId}'");

    for (var menu in res) {
      remarkList.add(menu);
    }
    print("remarkList----${remarkList}");

    notifyListeners();
  }

  ///////////////////////FETCH PRODUCT COMPANY LIST ///////////////////////////////////////
  fetchProductCompanyList() async {
    try {
      List<
          Map<String,
              dynamic>> result = await OrderAppDB.instance.executeGeneralQuery(
          "Select '0' comid,'All' comanme union all select comid,comanme from companyTable");
      print("resulttttt.....$result");
      productcompanyList.clear();
      if (result != 0) {
        for (var item in result) {
          productcompanyList.add(item);
        }
      }
      print("executeGeneralQuery---$productcompanyList");
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

///////////////filter company////////////////////////////
  filterwithCompany(String cusId, String comId, String type) async {
    isLoading = true;
    List<Map<String, dynamic>> result = [];
    // notifyListeners();
    // List<Map<String, dynamic>> result = await OrderAppDB.instance
    //     .selectAllcommon('productDetailsTable', "companyId='${comId}'");
    if (type == "sale order") {
      filterCompany = true;

      result =
          await OrderAppDB.instance.selectfrombagandfilterList(cusId, comId);
      filteredProductList.clear();
      for (var item in result) {
        filteredProductList.add(item);
      }
      var length = filteredProductList.length;
      print("filter list length.........$length");
      filterComselected = List.generate(length, (index) => false);
      print("filteredProductList--$filteredProductList");
    }
    if (type == "sales") {
      salefilterCompany = true;

      result = await OrderAppDB.instance
          .selectfromsalesbagandfilterList(cusId, comId);
      salefilteredProductList.clear();
      for (var item in result) {
        salefilteredProductList.add(item);
      }
      var length = salefilteredProductList.length;
      print("filter list length.........$length");
      filterComselected = List.generate(length, (index) => false);
      print("filteredProductList--$salefilteredProductList");
    }

    print("products filter-----$result");

    isLoading = false;
    notifyListeners();
  }

///////////////////////////////////////////////////////
  getCompanyData() async {
    try {
      isLoading = true;
      // notifyListeners();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? cid = prefs.getString("cid");
      print('cojhkjd---$cid');
      var res = await OrderAppDB.instance.selectCompany("cid='${cid}'");
      print("res companyList----${res}");
      for (var item in res) {
        companyList.add(item);
      }
      print("companyList ----${companyList}");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

  ///////////////////////GET AREA///////////////////////////////
  getArea(String? sid) async {
    String areaName;
    print("staff...............${sid}");
    try {
      areaList = await OrderAppDB.instance.getArea(sid!);
      print("areaList----${areaList}");
      print("areaList before ----${areDetails}");
      areDetails.clear();

      for (var item in areaList) {
        areDetails.add(item);
      }
      print("areaList adding ----${areDetails.length}");
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

  /////////////////////GET CUSTOMER////////////////////////////////
  getCustomer(String aid) async {
    print("aid...............${aid}");
    try {
      print("custmerDetails after clear----${custmerDetails}");
      custmerDetails.clear();
      customerList = await OrderAppDB.instance.getCustomer(aid);
      print("customerList----${customerList}");
      for (var item in customerList) {
        custmerDetails.add(item);
      }
      print("custmr length----${custmerDetails.length}");
      print("custmerDetails adding $custmerDetails");
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

  //////////////////////GET PRODUCT LIST/////////////////////////////////
  getProductList(String customerId) async {
    print("haii---");
    int flag = 0;
    productName.clear();
    try {
      isLoading = true;
      // notifyListeners();
      prodctItems =
          await OrderAppDB.instance.selectfromOrderbagTable(customerId);
      print("prodctItems----${prodctItems.length}");

      for (var item in prodctItems) {
        productName.add(item);
      }
      var length = productName.length;
      print("text length----$length");
      qty = List.generate(length, (index) => TextEditingController());
      selected = List.generate(length, (index) => false);
      returnselected = List.generate(length, (index) => false);
      returnirtemExists = List.generate(length, (index) => false);
      isLoading = false;
      notifyListeners();
      print("product name----${productName}");

      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

/////////////////////////////////////////////////////////////////
  getSaleProductList(String customerId) async {
    print("customer id......$customerId");
    print("haii---");
    int flag = 0;

    try {
      isLoading = true;
      // notifyListeners();
      prodctItems =
          await OrderAppDB.instance.selectfromsalebagTable(customerId);
      print("prodctItems----${prodctItems.length}");
      productName.clear();
      for (var item in prodctItems) {
        productName.add(item);
      }
      var length = productName.length;
      print("text length----$length");
      qty = List.generate(length, (index) => TextEditingController());
      selected = List.generate(length, (index) => false);
      // returnselected = List.generate(length, (index) => false);

      isLoading = false;
      notifyListeners();
      print("product name----${productName}");

      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

//////////////////GET ORDER NUMBER///////////////////////////////////
  getOrderno() async {
    try {
      ordernum = await OrderAppDB.instance.getOrderNo();
      print("ordernum----${ordernum}");

      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

  ///////////////GET BAG DETAILS/////////////////////
  getBagDetails(String customerId, String os) async {
    bagList.clear();
    isLoading = true;
    notifyListeners();
    List<Map<String, dynamic>> res =
        await OrderAppDB.instance.getOrderBagTable(customerId, os);
    for (var item in res) {
      bagList.add(item);
    }
    rateEdit = List.generate(bagList.length, (index) => false);
    // filterComselected = List.generate(length, (index) => false);

    generateTextEditingController("sale order");
    print("bagList vxdvxd----$bagList");

    isLoading = false;
    notifyListeners();
  }

//////////////////////////////////////////////////////
  getSaleBagDetails(String customerId, String os) async {
    print("customer id sale .................$customerId...$os");
    salebagList.clear();

    isLoading = true;
    notifyListeners();
    List<Map<String, dynamic>> res =
        await OrderAppDB.instance.getSaleBagTable(customerId, os);
    for (var item in res) {
      salebagList.add(item);
    }
    rateEdit = List.generate(salebagList.length, (index) => false);
    salesqty =
        List.generate(salebagList.length, (index) => TextEditingController());
    discount_prercent =
        List.generate(salebagList.length, (index) => TextEditingController());
    discount_amount =
        List.generate(salebagList.length, (index) => TextEditingController());

    generateTextEditingController("sales");
    print("salebagList vxdvxd----$salebagList");

    isLoading = false;
    notifyListeners();
  }

  ////////////////////GET HISTORY DATA/////////////////////////
  getSaleHistoryData(String table, String? condition) async {
    isLoading = true;
    print("haiiii");
    historydataList.clear();
    tableHistorydataColumn.clear();
    List<Map<String, dynamic>> result =
        await OrderAppDB.instance.todaySaleHistory(table, condition);

    for (var item in result) {
      historydataList.add(item);
    }
    print("historydataList----$historydataList");
    var list = historydataList[0].keys.toList();
    print("**list----$list");
    for (var item in list) {
      print(item);
      tableHistorydataColumn.add(item);
    }
    isLoading = false;
    notifyListeners();

    notifyListeners();
  }

/////////////////////////////////////////////////////////////////
  getHistoryData(String table, String? condition) async {
    isLoading = true;
    print("haiiii");
    historydataList.clear();
    tableHistorydataColumn.clear();
    List<Map<String, dynamic>> result =
        await OrderAppDB.instance.selectCommonQuery(table, condition);

    for (var item in result) {
      historydataList.add(item);
    }
    print("historydataList----$historydataList");
    var list = historydataList[0].keys.toList();
    print("**list----$list");
    for (var item in list) {
      print(item);
      tableHistorydataColumn.add(item);
    }
    isLoading = false;
    notifyListeners();

    notifyListeners();
  }

  /////////////////SELCT TOTAL ORDER FROM MASTER TABLE///////////
  getOrderMasterTotal(String table, String? condition) async {
    print("inside select data");

    List<Map<String, dynamic>> result =
        await OrderAppDB.instance.selectAllcommon(table, condition);
    print("resulttttt.....$result");
    if (result != 0) {
      for (var item in result) {
        staffOrderTotal.add(item);
      }
    }

    print("staff order total........$staffOrderTotal");
    notifyListeners();
  }
  // selectedSet() {
  //   var length = productName.length;
  //   qty = List.generate(length, (index) => TextEditingController());

  //   selected = List.generate(length, (index) => false);
  // }
////////////////////////////GET SHOP VISITED//////////////////////////////////////
  // getShopVisited(String userId, String date) async {
  //   shopVisited = await OrderAppDB.instance.getShopsVisited(userId, date);
  //   var res = await OrderAppDB.instance.countCustomer(areaidFrompopup);
  //   print("col--ret-- $collectionCount--$orderCount--$remarkCount--$ret_count");
  //   if (res != null) {
  //     customerCount = res.length;
  //   }
  //   if (collectionCount == 0 &&
  //       orderCount == 0 &&
  //       remarkCount == null &&
  //       ret_count == null) {
  //     print("collection--");
  //     noshopVisited = customerCount;
  //   } else {
  //     noshopVisited = customerCount! - shopVisited!;
  //   }
  //   notifyListeners();
  // }

  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////
  setCname() async {
    final prefs = await SharedPreferences.getInstance();
    String? came = prefs.getString("cname");
    cname = came;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////
  setSname() async {
    final prefs = await SharedPreferences.getInstance();
    String? same = prefs.getString("st_username");

    sname = same;
    notifyListeners();
  }

  customerListClear() {
    customerList.clear();
    notifyListeners();
  }

  setSplittedCode(String splitted) {
    splittedCode = splitted;
    notifyListeners();
  }

  ////////////////////////////////
  generateTextEditingController(String type) {
    var length;
    if (type == "sale order") {
      length = bagList.length;
    }
    if (type == "sales") {
      length = salebagList.length;
    }
    print("text length----$length");
    controller = List.generate(length, (index) => TextEditingController());
    print("length----$length");
    // notifyListeners();
  }

/////////////////////////////////////////////////////////////

  Future<dynamic> setStaffid(String sname) async {
    print("Sname.............$sname");
    try {
      ordernum = await OrderAppDB.instance.setStaffid(sname);
      print("ordernum----${ordernum}");

      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

  ///////////////////////////////////
  deleteFromOrderBagTable(int cartrowno, String customerId, int index) async {
    print("cartrowno--$cartrowno--index----$index");
    List<Map<String, dynamic>> res = await OrderAppDB.instance
        .deleteFromOrderbagTable(cartrowno, customerId);

    bagList.clear();
    for (var item in res) {
      bagList.add(item);
    }
    print("after delete------$res");
    controller.removeAt(index);
    print("controllers----$controller");
    generateTextEditingController("sale order");
    notifyListeners();
  }

/////////////////////////////////////////////////////////////
  deleteFromSalesBagTable(int cartrowno, String customerId, int index) async {
    print("cartrowno--$cartrowno--index----$index");
    List<Map<String, dynamic>> res =
        await OrderAppDB.instance.deleteFromSalesagTable(cartrowno, customerId);

    bagList.clear();
    for (var item in res) {
      bagList.add(item);
    }
    print("after delete------$res");
    controller.removeAt(index);
    print("controllers----$controller");
    generateTextEditingController("sales");
    notifyListeners();
  }

  ////////////// update remarks /////////////////////////////
  // updateRemarks(String customerId, String remark) async {
  //   print("remark.....${customerId}${remark}");
  //   // res = await OrderAppDB.instance.updateRemarks(customerId, remark);
  //   if (res != null) {
  //     for (var item in res) {
  //       remarkList.add(item);
  //     }
  //   }

  //   print("re from controller----$res");
  //   notifyListeners();
  // }
  //////////////////// CALCULATION ///////////////////////////
  calculateorderTotal(String os, String customerId) async {
    orderTotal1 = await OrderAppDB.instance.gettotalSum(os, customerId);
    print("orderTotal1---$orderTotal1");
    notifyListeners();
  }

  /////////calculate total////////////////
  calculatesalesTotal(String os, String customerId) async {
    try {
      print("calculate sales updated tot....$os...$customerId");
      List res = await OrderAppDB.instance.getsaletotalSum(os, customerId);
      salesTotal = double.parse(res[0]);

      gross_tot = double.parse(res[5]);

      tax_tot = res[9];

      cess_tot = double.parse(res[4]);
      // print("result sale...${res[3].runtimeType}");
      dis_tot = double.parse(res[3]);
      // print("result sale.22..${dis_tot.runtimeType}");

      print(
          "result sal--${salesTotal}----${gross_tot}---${tax_tot}---${cess_tot}--${dis_tot}");

      print("salesTotal---$salesTotal");
      notifyListeners();
      orderTotal2.clear();
      if (res != null && res.length != 0) {
        for (var item in res) {
          orderTotal2.add(item);
        }
      }
      print("orderTotal2.....$orderTotal2");
      notifyListeners();
    } catch (e) {
      print(e);
    }
    // return res[0];
  }
/////////////////////////////////////////////////

  calculateAmt(String rate, String _controller) {
    amt = double.parse(rate) * double.parse(_controller);
    // notifyListeners();
  }

  calculatereturnTotal() async {
    returnTotal = 0;
    for (int i = 0; i < returnList.length; i++) {
      print(" returnList[i]-${returnList[i]["total"]}");
      returnTotal = returnTotal + double.parse(returnList[i]["total"]);
    }

    print("orderTotal---$returnTotal");
    // notifyListeners();
  }

  ////////////////count from table///////
  countFromTable(String table, String os, String customerId) async {
    isLoading = true;
    // notifyListeners();
    print("table--customerId-$table-$customerId--$os");
    count = await OrderAppDB.instance
        .countCommonQuery(table, "os='${os}' AND customerid='${customerId}'");
    isLoading = false;

    notifyListeners();
  }

  qtyIncrement() {
    qtyinc = 1 + qtyinc!;
    print("qty-----$qtyinc");
    notifyListeners();
  }

  returnqtyIncrement() {
    returnqty = true;
    returnqtyinc = 1 + returnqtyinc!;
    print("qty-----$returnqtyinc");
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////
  qtyDecrement() {
    returnqty = true;
    qtyinc = qtyinc! - 1;
    print("qty-----$qtyinc");
    notifyListeners();
  }

  returnqtyDecrement() {
    returnqtyinc = returnqtyinc! - 1;
    print("qty-----$qtyinc");
    notifyListeners();
  }

  /////////////////////////////////////////////////
  setIssearch(bool issearch) {
    isSearch = issearch;
    notifyListeners();
  }

  setreportsearch(bool issearch) {
    isreportSearch = issearch;
    notifyListeners();
  }

////////////////////////////////////////////////////////////////
  setQty(int qty) {
    qtyinc = qty;
    print("qty.......$qty");
    // notifyListeners();
  }

  setreturnQty(int qty) {
    returnqtyinc = qty;
    // notifyListeners();
  }

/////////////////////
  setPrice(String rate) {
    totrate = rate;
    print("rate.$rate");
    notifyListeners();
  }

  ///////////////////////////////////

  setAmt(
    String price,
  ) {
    totalPrice = double.parse(price);

    // notifyListeners();
  }

  setreturnAmt(
    String price,
  ) {
    returntotalPrice = double.parse(price);
    priceval = double.parse(price).toStringAsFixed(2);
    print("priceval........$returntotalPrice...$priceval");
    // notifyListeners();
  }

  totalCalculation(String rate) {
    totalPrice = double.parse(rate) * qtyinc!;
    print("total pri-----$totalPrice");
    notifyListeners();
  }

  returntotalCalculation(String rate) {
    returnprice = true;
    returntotalPrice = double.parse(rate) * returnqtyinc!;
    priceval = returntotalPrice!.toStringAsFixed(2);
    print("total pri-----$returntotalPrice.....$priceval");
    notifyListeners();
  }

  setisVisible(bool isvis) {
    isVisible = isvis;
    notifyListeners();
  }

  ////////////////////////////////////////////////////
  editRate(String rate, int index) {
    rateEdit[index] = true;
    editedRate = rate;
    notifyListeners();
  }

  generateEditRateList() {
    var length = bagList.length;
    List.generate(length, (index) => false);
    // notifyListeners();
  }

  selectFromSettings() async {
    settingsList.clear();
    var res = await OrderAppDB.instance.selectAllcommon('settings', "");
    for (var item in res) {
      settingsList.add(item);
    }
    print("settingsList--$settingsList");
    notifyListeners();
  }

  ///////////////////////////////////////////////////////
  setSettingOption(int length) {
    settingOption = List.generate(length, (index) => false);
    notifyListeners();
  }
////////////////////////////////Remarks/////////////////////////////////////
  // insertRemarks(String date, String Cus_id, String ser, String text,
  //     String sttid, String cancel, String status) async {
  //   var logdata =
  //       await OrderAppDB.instance.insertremarkTable(date, Cus_id, ser, text,sttid,cancel,status);
  //   notifyListeners();
  // }
  ///////////////////////////////////////////////////////////////////////
  // downloadAllPages(String cid) async {
  //   isLoading = true;
  //   print("isloaading---$isLoading");
  //   notifyListeners();
  //   // getaccountHeadsDetails(cid, "all");
  //   getProductCategory(cid, "all");
  //   getProductCompany(cid, "all");
  //   // getProductDetails(cid, "all");
  //   isLoading = false;
  //   print("isloaading---$isLoading");

  //   notifyListeners();
  // }

  //////////////////////TODAY COLLECTION AND ORDER//////////////////////////////////////////

  Future<dynamic> todayOrder(String date, String? condition) async {
    todayOrderList.clear();
    isLoading = true;
    print("haiiii");
    var result = await OrderAppDB.instance.todayOrder(date, condition!);
    print("aftr cut----$result");
    if (result != null) {
      for (var item in result) {
        todayOrderList.add(item);
      }
      isExpanded = List.generate(todayOrderList.length, (index) => false);
      isVisibleTable = List.generate(todayOrderList.length, (index) => false);
    }

    print("todayOrderList----$todayOrderList");
    isLoading = false;
    notifyListeners();
  }

  ///////////////////////////////////////////////
  Future<dynamic> todayCollection(String date, String condition) async {
    todayCollectionList.clear();
    isLoading = true;
    print("haiiii");
    print("contrler date----$date");
    var result = await OrderAppDB.instance.todayCollection(date, condition);

    print("aftr cut----$result");
    if (result != null) {
      for (var item in result) {
        todayCollectionList.add(item);
      }
      isExpanded = List.generate(todayCollectionList.length, (index) => false);
      isVisibleTable =
          List.generate(todayCollectionList.length, (index) => false);
    }

    print("todayCollectionList----$todayCollectionList");
    isLoading = false;
    notifyListeners();
  }

///////////////////////// today sales ///////////////////
  Future<dynamic> todaySales(String date, String condition) async {
    todaySalesList.clear();
    isLoading = true;
    print("haiiii");
    print("contrler date----$date");
    var result = await OrderAppDB.instance.todaySales(date, condition);

    print("aftr cut----$result");
    if (result != null) {
      for (var item in result) {
        todaySalesList.add(item);
      }
      isExpanded = List.generate(todaySalesList.length, (index) => false);
      isVisibleTable = List.generate(todaySalesList.length, (index) => false);
    }

    print("today sales date ----$todaySalesList");
    isLoading = false;
    notifyListeners();
  }

//////////////////////////////////////////////////////////
  selectReportFromOrder(BuildContext context, String userId, String date,
      String likeCondition) async {
    print("report userId----$userId");
    reportData.clear();
    reportOriginalList.clear();
    Map map = {};
    isLoading = true;
    // notifyListeners();
    var res = await OrderAppDB.instance
        .getReportDataFromOrderDetails(userId, date, context, likeCondition);

    print("result-cxc----$res");
    if (res != null && res.length > 0) {
      for (var item in res) {
        reportData.add(item);
      }
    } else {
      noreportdata = true;

      // notifyListeners();
      // snackbar.showSnackbar(context, "please download customers !!!");
    }
    print('report data----${reportData.length}');
    isLoading = false;
    notifyListeners();
  }

  /////////////////////////////////////////////

  ////////////////// remark from filter //////////////
  //  setRemarkfilterReports(String remark, String  remarked) {
  //   isLoading = true;
  //   notifyListeners();
  //   if (fltrType == "balance") {
  //     filterList = reportData.where((element) {
  //       //  print('${element["bln"].runtimeType}') ;
  //       return (element["bln"] > minPrice && element["bln"] < maxPrice);
  //       // return (element["bln"] > minPrice && element["bln"] < maxPrice);
  //     }).toList();
  //     isLoading = false;

  //     notifyListeners();
  //   }
  //   if (fltrType == "order amount") {
  //     filterList = reportData.where((element) {
  //       //  print('${element["bln"].runtimeType}') ;
  //       return (element["order_value"] > minPrice &&
  //           element["order_value"] < maxPrice);
  //       // return (element["bln"] > minPrice && element["bln"] < maxPrice);
  //     }).toList();
  //     isLoading = false;

  //     notifyListeners();
  //   }
  //   print("filters-----$filterList");
  //   notifyListeners();
  // }

  ///////////////////////////////////////////////////////
  setDateFilter(String fromDate, String toDate) {
    print("remarked......$fromDate $toDate");
  }

  /////////////////////////////////////////////
  searchfromreport(BuildContext context, String userId, String date) async {
    print("searchkey----$reportSearchkey");

    if (reportSearchkey!.isEmpty) {
      // isreportSearch = false;
      newreportList = reportData;
    } else {
      print("re----${reportData.length}");
      // newreportList.clear();
      newreportList = await OrderAppDB.instance.getReportDataFromOrderDetails(
          userId, date, context, " A.hname LIKE '$reportSearchkey%' ");
      // newreportList = reportData
      //     .where((element) => element["name"]
      //         .toLowerCase()
      //         .contains(reportSearchkey!.toLowerCase()))
      //     .toList();
      notifyListeners();
      print("new---$newreportList");
    }
  }

///////////////// dashboard summery /////////////
  Future<dynamic> dashboardSummery(
      String sid, String date, String aid, BuildContext context) async {
    print("stafff  iddd $sid");
    double d1 = 0.0;
    double d = 0.0;
    double d2 = 0.0;
    double d4 = 0.0;

    var res = await OrderAppDB.instance.dashboardSummery(sid, date, aid);
    var result = await OrderAppDB.instance.countCustomer(areaidFrompopup);
    print("resultresult-- $aid");
    if (result.length > 0) {
      customerCount = result.length;
    }

    print("customerCount----$customerCount");
    orderCount = res[0]["ordCnt"].toString();
    salesCount = res[0]["saleCnt"].toString();
    collectionCount = res[0]["colCnt"].toString();
    print("collectioncount...$collectionCount");
    remarkCount = res[0]["rmCnt"].toString();
    print("remarkCount...$remarkCount");
    ret_count = res[0]["retCnt"].toString();

    print("jhfjsd-----${res[0]["colVal"]}--${res[0]["ordVal"]}");
    if (res[0]["colVal"] != null) {
      if (res[0]["colVal"] == 0) {
        d1 = 0.0;
      } else {
        d1 = res[0]["colVal"];
      }
    }
    collectionAmount = d1.toStringAsFixed(2);
    if (res[0]["ordVal"] != null) {
      if (res[0]["ordVal"] == 0) {
        d2 = 0.0;
      } else {
        d2 = res[0]["ordVal"];
      }
    }
    ordrAmount = d2.toStringAsFixed(2);
    if (res[0]["saleVal"] != null) {
      if (res[0]["saleVal"] == 0) {
        d = 0.0;
      } else {
        d = res[0]["saleVal"];
      }
    }
    salesAmount = d.toStringAsFixed(2);
    print("salesAmount----${res[0]["saleVal"]}");
    if (res[0]["retVal"] != null) {
      if (res[0]["retVal"] == 0) {
        d4 = 0.0;
      } else {
        d4 = res[0]["retVal"];
      }
    }
    returnAmount = d4.toStringAsFixed(2);
    shopVisited = res[0]["cusCount"];

    if (customerCount == null) {
      snackbar.showSnackbar(context, "Please download Customers", "");
    } else {
      noshopVisited = customerCount! - shopVisited!;
    }
    notifyListeners();
  }

///////////////////////////////////////////////////////////////////
//   Future<dynamic> mainDashAmounts(String sid, String date) async {
//     collectionAmount = await OrderAppDB.instance.sumCommonQuery("rec_amount",
//         'collectionTable', "rec_staffid='$sid' AND rec_date='$date'");
//     ordrAmount = await OrderAppDB.instance.sumCommonQuery(
//         "total_price",
//         'orderMasterTable',
//         "userid='$sid' AND orderdate='$date' AND areaid='$areaidFrompopup'");
//     returnAmount = await OrderAppDB.instance.sumCommonQuery(
//         "total_price",
//         'returnMasterTable',
//         "userid='$sid' AND return_date='$date' AND areaid='$areaidFrompopup'");
//     if (collectionAmount == null || collectionAmount.isEmpty) {
//       collectionAmount = "0.0";
//     }
//     if (ordrAmount == null || ordrAmount.isEmpty) {
//       ordrAmount = "0.0";
//     }
//     if (returnAmount == null || returnAmount.isEmpty) {
//       returnAmount = "0.0";
//     }
//     print("Amount---$collectionAmount--$ordrAmount");
//     notifyListeners();
//   }
// ////////////////////////////////////////////////////////////////////

//   Future<dynamic> mainDashtileValues(String sid, String date) async {
//     print("haiii pty");
//     String condition = " ";
//     if (areaidFrompopup != null) {
//       // condition = "and areaid='$areaidFrompopup'";
//       // condition = " and "
//     }

//     orderCount = await OrderAppDB.instance.countCommonQuery("orderMasterTable",
//         " userid='$sid' AND orderdate='$date' $condition");
//     collectionCount = await OrderAppDB.instance.countCommonQuery(
//         "collectionTable", "rec_staffid='$sid' AND rec_date='$date'");
//     // print("collection count---$collectionCount");
//     remarkCount = await OrderAppDB.instance.countCommonQuery(
//         "remarksTable", "rem_staffid='$sid' AND rem_date='$date'");
//     // print("remarkCountt---$remarkCount");

//     ret_count = await OrderAppDB.instance.countCommonQuery("returnMasterTable",
//         "userid='$sid' AND return_date='$date' $condition");
//     print("ret_count---$ret_count");

//     // if (collectionCount == 0 &&
//     //     orderCount == 0 &&
//     //     remarkCount == 0 &&
//     //     ret_count == 0) {
//     //   shopVisited = 0;
//     // }
//     print("no shop--$noshopVisited");
//     print("shop visited---$shopVisited");
//     notifyListeners();
//   }

/////////////////////////////////////////////////////////////////
  setFilter(bool filters) {
    filter = filters;
    // notifyListeners();
  }

  // filterReports(
  //     String fltrType, double? minPrice, double? maxPrice, String? remark) {
  //   filterList.clear();
  //   print("minPrice-maxPrice-$minPrice--$maxPrice");
  //   isLoading = true;
  //   notifyListeners();
  //   if (fltrType == "balance") {
  //     filterList = reportData.where((element) {
  //       //  print('${element["bln"].runtimeType}') ;
  //       return (element["bln"] > minPrice && element["bln"] < maxPrice);
  //       // return (element["bln"] > minPrice && element["bln"] < maxPrice);
  //     }).toList();
  //     isLoading = false;

  //     notifyListeners();
  //   }
  //   if (fltrType == "order amount") {
  //     for (var item in reportData) {
  //       if (item["order_value"] != null && item["order_value"] != 0) {
  //         if (item["order_value"] > minPrice &&
  //             item["order_value"] < maxPrice) {
  //           filterList.add(item);
  //         }
  //       }
  //     }

  //     // print('hfjkd----$filterList');
  //     isLoading = false;
  //     notifyListeners();
  //   }

  //   if (fltrType == "collection") {
  //     for (var item in reportData) {
  //       if (item["collection_sum"] != null && item["collection_sum"] != 0) {
  //         if (item["collection_sum"] > minPrice &&
  //             item["collection_sum"] < maxPrice) {
  //           filterList.add(item);
  //         }
  //       }
  //     }

  //     // print('hfjkd----$filterList');
  //     isLoading = false;
  //     notifyListeners();
  //   }
  //   if (fltrType == "remark") {
  //     if (remark == "Remarked") {
  //       filterList = reportData.where((element) {
  //         //  print('${element["bln"].runtimeType}') ;
  //         return (element["remark_count"] != null &&
  //             element["remark_count"] != 0);
  //         // return (element["bln"] > minPrice && element["bln"] < maxPrice);
  //       }).toList();
  //     } else {
  //       filterList = reportData.where((element) {
  //         //  print('${element["bln"].runtimeType}') ;
  //         return (element["remark_count"] == null ||
  //             element["remark_count"] == 0);
  //         // return (element["bln"] > minPrice && element["bln"] < maxPrice);
  //       }).toList();
  //     }

  //     isLoading = false;

  //     notifyListeners();
  //   }
  //   print("filters-----$filterList");
  //   notifyListeners();
  // }

  toggleExpansion(int index) {
    for (int i = 0; i < isExpanded.length; i++) {
      if (isExpanded[index] != isExpanded[i] && isExpanded[i]) {
        isExpanded[i] = !isExpanded[i];
        isVisibleTable[i] = !isVisibleTable[i];
      }
    }
  }

  areaSelection(String area) async {
    // areaSelecton.clear();
    print("area.......$area");
    areaidFrompopup = area;
    List<Map<String, dynamic>> result = await OrderAppDB.instance
        .selectAllcommon('areaDetailsTable', "aid='${area}'");
    areaSelecton = result[0]["aname"];
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("areaSelectionPopup", areaSelecton!);
    print("area---$areaidFrompopup");
    notifyListeners();
  }

  //////////////////////////////////////////////////////////////////////////
  fetchtotalcollectionFromTable(String cusid) async {
    fetchcollectionList.clear();
    isLoading = true;
    var res = await OrderAppDB.instance
        .selectAllcommonwithdesc('collectionTable', "rec_cusid = '$cusid'");
    if (res != null) {
      for (var menu in res) {
        fetchcollectionList.add(menu);
      }
    }
    print("fetchcollectionList----${fetchcollectionList}");
    isLoading = false;
    notifyListeners();
  }

  /////////////////////// fetch collection table ////////////
  fetchrcollectionFromTable(String custmerId, String todaydate) async {
    collectionList.clear();

    var res = await OrderAppDB.instance
        .selectAllcommonwithdesc('collectionTable', "rec_cusid='${custmerId}'");

    for (var menu in res) {
      collectionList.add(menu);
    }
    print("collectionList----${collectionList}");
    notifyListeners();
  }

  clearList(List list) {
    list.clear();
    print("list.length----${list.length}");
    notifyListeners();
  }

  ///////////////Return////////////////////////
  addToreturnList(Map<String, dynamic> value) {
    print("value---${value}");
    bool flag = false;
    int i;
    if (returnList.length > 0) {
      print("return length----${returnList.length}");
      for (i = 0; i < returnList.length; i++) {
        print("hyyyyy----${returnList[i]["code"]}");
        if (returnList[i]["code"] == value["code"]) {
          flag = true;
          break;
        } else {
          flag = false;
        }
      }
      if (flag == true) {
        print(
            "returnList[i]------------------${returnList[i]["total"].runtimeType}");
        print("value[i]------------------${value["total"].runtimeType}");

        returnList[i]["qty"] = returnList[i]["qty"] + value["qty"];
        double d =
            double.parse(returnList[i]["total"]) + double.parse(value["total"]);
        returnList[i]["total"] = d.toString();
        print("qty--${returnList[i]["qty"]}");
      } else {
        returnList.add(value);
      }
    } else {
      returnList.add(value);
    }
    returnCount = returnList.length;
    print("return List----$returnList");
    notifyListeners();
  }

  // selectfromreturnList(){
  //   returnList.
  // }

  deleteFromreturnList(index) {
    returnList.removeAt(index);
    returnCount = returnCount - 1;
    notifyListeners();
  }

  updatereturnQty(int index, int updteretrnQty, double rate) {
    print("index---updteretrnQty-$index--$updteretrnQty---$rate");
    for (int i = 0; i < returnList.length; i++) {
      if (i == index) {
        returnList[i]["qty"] = updteretrnQty;
        returnList[i]["total"] = rate.toStringAsFixed(2);
        notifyListeners();
      }
    }
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////

  uploadOrdersData(String cid, BuildContext context, int index) async {
    List<Map<String, dynamic>> resultQuery = [];
    List<Map<String, dynamic>> om = [];
    isUpload = true;
    notifyListeners();
    var result = await OrderAppDB.instance.selectMasterTable();
    print("output------$result");
    if (result != null) {
      String jsonE = jsonEncode(result);
      var jsonDe = jsonDecode(jsonE);
      print("jsonDe--${jsonDe}");
      for (var item in jsonDe) {
        resultQuery = await OrderAppDB.instance.selectDetailTable(item["oid"]);
        item["od"] = resultQuery;
        om.add(item);
      }
      if (om.length > 0) {
        print("entede");
        saveOrderDetails(cid, om, context, index);
      }
      isUpload = false;
      isUp[index] = true;
      notifyListeners();
      print("om----$om");
    } else {
      snackbar.showSnackbar(context, "Nothing to upload!!!", "sale order");
    }

    notifyListeners();
  }

  ////////////////////////upload salesdata////////////////////////////////////////
  uploadSalesData(String cid, BuildContext context, int index) async {
    List<Map<String, dynamic>> resultQuery = [];
    List<Map<String, dynamic>> om = [];
    isUpload = true;
    notifyListeners();
    var result = await OrderAppDB.instance.selectSalesMasterTable();
    print("output------$result");
    if (result != null) {
      String jsonE = jsonEncode(result);
      var jsonDe = jsonDecode(jsonE);
      print("jsonDe--${jsonDe}");
      for (var item in jsonDe) {
        print("item,hd----$item");
        resultQuery =
            await OrderAppDB.instance.selectSalesDetailTable(item["s_id"]);
        item["od"] = resultQuery;
        om.add(item);
      }
      if (om.length > 0) {
        print("entede");
        saveSalesDetails(cid, om, context, index);
      }
      isUpload = false;
      isUp[index] = true;
      notifyListeners();
      print("om----$om");
    } else {
      snackbar.showSnackbar(context, "Nothing to upload!!!", "");
    }

    notifyListeners();
  }

  /////////////////////////upload customer/////////////////////////////////////////
  uploadCustomers(BuildContext context, int index) async {
    try {
      var result =
          await OrderAppDB.instance.selectAllcommon('customerTable', "");
      if (result.length > 0) {
        Uri url = Uri.parse("http://trafiqerp.in/order/fj/cus_save.php");
        isUpload = true;
        isLoading = true;
        notifyListeners();
        var customer = await OrderAppDB.instance.uploadCustomer();
        print("customer result----$customer");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? cid = prefs.getString("cid");
        String cm = jsonEncode(customer);
        print("cm----$cm");
        Map body = {
          'cid': cid,
          'cm': cm,
        };
        print("order body.....$body");
        http.Response response = await http.post(
          url,
          body: body,
        );
        isUpload = false;
        isUp[index] = true;
        isLoading = false;
        notifyListeners();
        // print("response----$response");
        var map = jsonDecode(response.body);
        print("map ${map}");
        if (map.length > 0) {
          await OrderAppDB.instance
              .deleteFromTableCommonQuery("customerTable", "");
        }
      } else {
        snackbar.showSnackbar(context, "Nothing to upload!!!", "");
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  ////////////////////////upload return data////////////////////////
  uploadReturnData(String cid, BuildContext context, int index) async {
    List<Map<String, dynamic>> resultQuery = [];
    List<Map<String, dynamic>> om = [];
    isUpload = true;
    notifyListeners();
    var result = await OrderAppDB.instance.selectReturnMasterTable();
    print("output------$result");
    String jsonE = jsonEncode(result);
    var jsonDe = jsonDecode(jsonE);
    print("jsonDe--${jsonDe}");
    for (var item in jsonDe) {
      resultQuery =
          await OrderAppDB.instance.selectReturnDetailTable(item["srid"]);
      item["od"] = resultQuery;
      om.add(item);
    }
    if (om.length > 0) {
      print("entede");
      saveReturnDetails(cid, om, context);
      isUpload = false;
      isUp[index] = true;
      notifyListeners();
    } else {
      snackbar.showSnackbar(context, "Nothing to upload!!!", "");
    }
    print("om----$om");
    notifyListeners();
  }

  /////////////////////////upload customer/////////////////////////////////////////
  uploadRemarks(BuildContext context, int index) async {
    print("haicollection");
    try {
      var result = await OrderAppDB.instance.uploadRemark();
      print("remark result......$result");
      if (result.length > 0) {
        Uri url = Uri.parse("http://trafiqerp.in/order/fj/rem_save.php");
        isUpload = true;
        isLoading = true;
        notifyListeners();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? cid = prefs.getString("cid");
        String rm = jsonEncode(result);
        print("collection----$rm");
        Map body = {
          'cid': cid,
          'rm': rm,
        };
        print("remark map......$body");
        http.Response response = await http.post(
          url,
          body: body,
        );
        isLoading = false;
        notifyListeners();
        // print("response----$response");
        var map = jsonDecode(response.body);
        print("response remark----${map}");
        for (var item in map) {
          print("update data.......$map");
          if (item["rid"] != null) {
            print("update data1.......$map");
            await OrderAppDB.instance.upadteCommonQuery("remarksTable",
                "rem_status='${item["rid"]}'", "rem_row_num='${item["phid"]}'");
          }
        }
        isUpload = false;
        isUp[index] = true;
      } else {
        snackbar.showSnackbar(context, "Nothing to upload!!!", "");
      }

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  /////////////////UPLOAD COLLECTION TABLE////////////////
  uploadCollectionData(BuildContext context, int index) async {
    print("haicollection");
    try {
      var result = await OrderAppDB.instance.uploadCollections();
      print("collection result......$result");
      if (result.length > 0) {
        Uri url = Uri.parse("http://trafiqerp.in/order/fj/col_save.php");
        isUpload = true;
        isLoading = true;
        notifyListeners();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? cid = prefs.getString("cid");
        String rm = jsonEncode(result);
        print("collection----$rm");
        Map body = {
          'cid': cid,
          'rm': rm,
        };
        print("collection map......$body");
        http.Response response = await http.post(
          url,
          body: body,
        );
        isLoading = false;
        notifyListeners();
        // print("response----$response");
        var map = jsonDecode(response.body);
        print("response collection----${map}");
        for (var item in map) {
          print("update data.......$map");
          if (item["col_id"] != null) {
            print("update data1.......");
            await OrderAppDB.instance.upadteCommonQuery(
                "collectionTable",
                "rec_status='${item["col_id"]}'",
                "rec_row_num='${item["phid"]}'");
          }
        }
        isUpload = false;
        isUp[index] = true;
      } else {
        snackbar.showSnackbar(context, "Nothing to upload!!!", "");
      }

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
  // getProductItems(String table) async {
  //   productName.clear();
  //   try {
  //     isLoading = true;
  //     // notifyListeners();
  //     prodctItems = await OrderAppDB.instance.selectCommonquery(table, '');
  //     print("prodctItems----${prodctItems}");

  //     for (var item in prodctItems) {
  //       productName.add(item);
  //       // productName.add(item["code"] + '-' + item["item"]);
  //       // notifyListeners();
  //     }
  //     var length = productName.length;
  //     print("text length----$length");
  //     qty = List.generate(length, (index) => TextEditingController());
  //     isLoading = false;
  //     notifyListeners();
  //     print("product name----${productName}");
  //     // print("product productRate----${productRate}");
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  //   notifyListeners();
  // }

  ////////////////////////SEARCH PROCESS ////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  searchProcess(String customerId, String os, String comid, String type) async {
    print("searchkey--comid--$searchkey---$comid");
    List<Map<String, dynamic>> result = [];
    newList.clear();

    if (searchkey!.isEmpty) {
      newList = productName;
      var length = newList.length;
      print("text length----$length");
      qty = List.generate(length, (index) => TextEditingController());
      selected = List.generate(length, (index) => false);
    } else {
      // newList.clear();
      isListLoading = true;
      notifyListeners();
      print("else is search");
      isSearch = true;

      // newList = productName
      //     .where((product) =>
      //         product["item"]
      //             .toLowerCase()
      //             .contains(searchkey!.toLowerCase()) ||
      //         product["code"]
      //             .toLowerCase()
      //             .contains(searchkey!.toLowerCase()) ||
      //         product["categoryId"]
      //             .toLowerCase()
      //             .contains(searchkey!.toLowerCase()))
      //     .toList();

      // List<Map<String, dynamic>> res =
      //     await OrderAppDB.instance.getOrderBagTable(customerId, os);
      // for (var item in res) {
      //   bagList.add(item);
      // }
// print("jhfdjkhfjd----$bagList");
      if (comid == "") {
        result = await OrderAppDB.instance.searchItem('productDetailsTable',
            searchkey!, 'item', 'code', 'categoryId', " ");
      } else {
        result = await OrderAppDB.instance.searchItem(
            'productDetailsTable',
            searchkey!,
            'item',
            'code',
            'categoryId',
            " and companyId='${comid}'");
      }

      for (var item in result) {
        newList.add(item);
      }
      isListLoading = false;
      notifyListeners();
      var length = newList.length;
      selected = List.generate(length, (index) => false);
      qty = List.generate(length, (index) => TextEditingController());

      if (newList.length > 0) {
        print("enterde");
        if (type == "sale order") {
          for (var item = 0; item < newList.length; item++) {
            print("newList[item]----${newList[item]}");

            for (var i = 0; i < bagList.length; i++) {
              print("bagList[item]----${bagList[i]}");

              if (bagList[i]["code"] == newList[item]["code"]) {
                print("ifff");
                selected[item] = true;
                break;
              } else {
                print("else----");
                selected[item] = false;
              }
            }
          }
        }
        if (type == "sales") {
          for (var item = 0; item < newList.length; item++) {
            print("newList[item]----${newList[item]}");

            for (var i = 0; i < salebagList.length; i++) {
              print("bagList[item]----${salebagList[i]}");

              if (salebagList[i]["code"] == newList[item]["code"]) {
                print("ifff");
                selected[item] = true;
                break;
              } else {
                print("else----");
                selected[item] = false;
              }
            }
          }
        }
      }

      print("text length----$length");

      print("selected[item]-----${selected}");

      // notifyListeners();
    }

    print("nw list---$newList");
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////
  String rawCalculation(
      double rate,
      double qty,
      double disc_per,
      double disc_amount,
      double tax_per,
      double cess_per,
      String method,
      int state_status,
      int index,
      bool onSub,
      String? disCalc) {
    flag = false;

    print(
        "attribute---$qty-$disCalc --$rate--$disc_per--$disc_amount--$tax_per--$cess_per--$method");
    if (method == "0") {
      /////////////////////////////////method=="0" - excluisive , method=1 - inclusive
      taxable_rate = rate;
    } else if (method == "1") {
      double percnt = tax_per + cess_per;
      taxable_rate = rate * (1 - (percnt / (100 + percnt)));
      print("exclusive tax....$percnt...$taxable_rate");
    }
    gross = taxable_rate * qty;
    print("gros----$gross");
    if (disCalc == "disc_amt") {
      disc_per = (disc_amount / gross) * 100;
      disc_amt = disc_amount;
      print("discount_prercent---$disc_amount---${discount_prercent.length}");
      if (onSub) {
        discount_prercent[index].text = disc_per.toStringAsFixed(2);
      }
      print("disc_per----$disc_per");
    }

    if (disCalc == "disc_per") {
      print("yes hay---$disc_per");
      disc_amt = (gross * disc_per) / 100;
      if (onSub) {
        discount_amount[index].text = disc_amt.toStringAsFixed(4);
      }
      print("disc-amt----$disc_amt");
    }

    if (disCalc == "qty") {
      disc_amt = double.parse(discount_amount[index].text);
      disc_per = double.parse(discount_prercent[index].text);
      print("disc-amt qty----$disc_amt...$disc_per");
    }

    if (state_status == 0) {
      ///////state_status=0--loacal///////////state_status=1----inter-state
      cgst_per = tax_per / 2;
      sgst_per = tax_per / 2;
      igst_per = 0;
    } else {
      cgst_per = 0;
      sgst_per = 0;
      igst_per = tax_per;
    }

    if (disCalc == "") {
      print("inside nothingg.....");
      disc_per = (disc_amount / taxable_rate) * 100;
      disc_amt = disc_amount;
      print("rsr....$disc_per....$disc_amt..");
    }

    tax = (gross - disc_amt) * (tax_per / 100);
    print("tax....$tax....$gross... $disc_amt...$tax_per");
    if (tax < 0) {
      tax = 0.00;
    }
    cgst_amt = (gross - disc_amt) * (cgst_per / 100);
    sgst_amt = (gross - disc_amt) * (sgst_per / 100);
    igst_amt = (gross - disc_amt) * (igst_per / 100);
    cess = (gross - disc_amt) * (cess_per / 100);
    net_amt = ((gross - disc_amt) + tax + cess);
    if (net_amt < 0) {
      net_amt = 0.00;
    }
    print("netamount.cal...$net_amt");

    print(
        "disc_per calcu mod=0..$tax..$gross... $disc_amt...$tax_per-----$net_amt");
    notifyListeners();
    return "success";
  }

  ///////////////////////////////////////////////////////
  keyContainsListcheck(String key, int index) {
    print("rhdhsz---$key-$returnList");
    bool exist = returnList.any((element) => element.values.contains(key));
    returnirtemExists[index] = exist;
  }
}
