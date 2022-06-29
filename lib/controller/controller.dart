import 'dart:convert';
import 'package:flutter/material.dart';
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
import 'package:orderapp/screen/ORDER/2_companyDetailsscreen.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../components/network_connectivity.dart';
import '../model/balanceGet_model.dart';
import '../model/productdetails_model.dart';
import '../model/staffarea_model.dart';
import '../model/staffdetails_model.dart';

class Controller extends ChangeNotifier {
  bool isLoading = false;
  bool isListLoading = false;
  int? selectedTabIndex;
  String? userName;
  CustomSnackbar snackbar = CustomSnackbar();
  bool isSearch = false;
  bool isreportSearch = false;
  List<String> gridHeader=[];
  String? areaSelecton;
  int returnCount = 0;
  bool isVisible = false;
  double returnTotal = 0.0;
  bool noreportdata = false;
  bool returnprice = false;
  int? shopVisited;
  int? noshopVisited;
  List<bool> selected = [];
  List<bool> returnSelected = [];

  String? areaidFrompopup;
  List<bool> isExpanded = [];
  bool returnqty = false;
  List<bool> isVisibleTable = [];
  List<Map<String, dynamic>> collectionList = [];
  List<Map<String, dynamic>> fetchcollectionList = [];

  List<bool> settingOption = [];
  List<Map<String, dynamic>> filterList = [];
  List<Map<String, dynamic>> adminDashboardList = [];

  List<Map<String, dynamic>> sortList = [];
  List<Map<String, dynamic>> returnList = [];

  bool filter = false;
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

  String? orderTotal;
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
  List<String> areaAutoComplete = [];
  List<Map<String, dynamic>> menuList = [];
  List<Map<String, dynamic>> reportData = [];
  List<Map<String, dynamic>> sumPrice = [];
  List<Map<String, dynamic>> collectionsumPrice = [];
  String collectionAmount = "0.0";
  String returnAmount = "0.0";

  String ordrAmount = "0.0";
  String? remarkCount;
  String? orderCount;
  String? collectionCount;
  String? ret_count;

  List<Map<String, dynamic>> remarkList = [];
  List<Map<String, dynamic>> remarkStaff = [];
  String? firstMenu;
  List<Map<String, dynamic>> listWidget = [];
  List<TextEditingController> controller = [];
  List<TextEditingController> qty = [];
  List<bool> rateEdit = [];
  String? count;
  String? sof;
  String? versof;

  String? fp;
  List<Map<String, dynamic>> bagList = [];
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
////////////////////////////////////////////////////////////////////////
  Future<RegistrationData?> postRegistration(
      String company_code, BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      await OrderAppDB.instance.deleteFromTableCommonQuery('menuTable', "");
      if (value == true) {
        try {
          Uri url =
              Uri.parse("http://trafiqerp.in/order/fj/get_registration.php");
          Map body = {
            'company_code': company_code,
          };
          print("compny----${company_code}");
          isLoading = true;
          notifyListeners();
          http.Response response = await http.post(
            url,
            body: body,
          );

          print("body ${body}");
          var map = jsonDecode(response.body);
          print("map ${map}");
          // print("response ${response}");
          RegistrationData regModel = RegistrationData.fromJson(map);
          userType = regModel.type;
          sof = regModel.sof;
          fp = regModel.fp;
          String? msg = regModel.msg;
          print("fp----- $fp");
          print("sof----${sof}");
          if (sof == "1") {
            /////////////// insert into local db /////////////////////
            late CD dataDetails;
            String? fp1 = regModel.fp;
            String? os = regModel.os;
            userType = regModel.type;
            regModel.c_d![0].cid;
            cid = regModel.cid;
            cname = regModel.c_d![0].cnme;
            notifyListeners();
            for (var item in regModel.c_d!) {
              c_d.add(item);
            }
            var res =
                await OrderAppDB.instance.insertRegistrationDetails(regModel);

            print("inserted ${res}");
            isLoading = false;
            notifyListeners();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("company_id", company_code);
            prefs.setString("user_type", userType!);

            prefs.setString("cid", cid!);
            prefs.setString("os", os!);
            prefs.setString("fp", fp!);
            // verifyRegistration(context);

            getCompanyData();
            // OrderAppDB.instance.deleteFromTableCommonQuery('menuTable',"");
            getMenuAPi(cid!, fp1!, context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CompanyDetails(
                        type: "",
                      )),
            );
          }
          /////////////////////////////////////////////////////

          if (sof == "0") {
            CustomSnackbar snackbar = CustomSnackbar();
            snackbar.showSnackbar(context, "Invalid key");
          }

          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

//////////////////////verify registration/////////////////////////////
  Future<RegistrationData?> verifyRegistration(BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      // await OrderAppDB.instance.deleteFromTableCommonQuery('menuTable', "");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? compny_code = prefs.getString("company_id");
      String? fp = prefs.getString("fp");

      Map map = {
        '0': compny_code,
        "1": fp,
      };

      List list = [];
      list.add(map);
      var jsonen = jsonEncode(list);
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
          String? error = verRegModel.error;

          print("sof----${versof}");

          // /////////////////////////////////////////////////////

          // if (sof == "0") {
          //   CustomSnackbar snackbar = CustomSnackbar();
          //   snackbar.showSnackbar(context, "Invalid key");
          // }

          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

  //////////////////////getMenu////////////////////////////////////////
  Future<RegistrationData?> getMenuAPi(
      String company_code, String fp, BuildContext context) async {
    var res;
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        print("company_code---fp-${company_code}---${fp}");

        try {
          Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_menu.php");
          Map body = {
            'company_code': company_code,
            'fingerprint': fp,
          };

          http.Response response = await http.post(
            url,
            body: body,
          );

          print("body ${body}");
          var map = jsonDecode(response.body);
          print("map menu ${map}");

          SideMenu sidemenuModel = SideMenu.fromJson(map);
          firstMenu = sidemenuModel.first;
          for (var menuItem in sidemenuModel.menu!) {
            // print("menuitem----${menuItem.menu_name}");
            res = await OrderAppDB.instance
                .insertMenuTable(menuItem.menu_index!, menuItem.menu_name!);
            // menuList.add(menuItem);
          }

          // print("menu api---$")
          print("insertion");
          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

  /////////////////////////// get balance ////////////////////////////
  Future<Balance?> getBalance(String? cid, String? code) async {
    print("get balance...............${cid}");
    var restaff;
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_balance.php");
      Map body = {
        'cid': cid,
        'code': code,
      };
      // print("compny----${cid}");
      http.Response response = await http.post(
        url,
        body: body,
      );

      List map = jsonDecode(response.body);
      print("map ${map}");
      if (map != null) {
        for (var getbal in map) {
          balanceModel = Balance.fromJson(getbal);
          // restaff = await OrderAppDB.instance.insertStaffDetails(staffModel);
        }
      }

      print("inserted staff ${balanceModel}");
      /////////////// insert into local db /////////////////////
      notifyListeners();
      return balanceModel;
    } catch (e) {
      print(e);
      return null;
    }
  }

  ////////////////////menu table fetch///////////////////////////////
  fetchMenusFromMenuTable() async {
    menuList.clear();
    var res = await OrderAppDB.instance.selectAllcommon('menuTable', "");
    // print("menu from table----$res");

    for (var menu in res) {
      menuList.add(menu);
    }
    //print("menuList----${menuList}");

    notifyListeners();
  }

  ////////////////////remark selection/////////
  fetchremarkFromTable(String custmerId) async {
    remarkList.clear();
    var res = await OrderAppDB.instance
        .selectAllcommon('remarksTable', "rem_cusid='${custmerId}'");

    for (var menu in res) {
      remarkList.add(menu);
    }
    print("remarkList----${remarkList}");

    notifyListeners();
  }

  /////////////////////// Staff details////////////////////////////////
  Future<StaffDetails?> getStaffDetails(String cid) async {
    print("getStaffDetails...............${cid}");
    var restaff;
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_staff.php");
      Map body = {
        'cid': cid,
      };
      // print("compny----${cid}");
      http.Response response = await http.post(
        url,
        body: body,
      );
      // print("body ${body}");
      List map = jsonDecode(response.body);
      print("map ${map}");

      for (var staff in map) {
        // print("staff----${staff}");
        staffModel = StaffDetails.fromJson(staff);
        restaff = await OrderAppDB.instance.insertStaffDetails(staffModel);
        // print("inserted ${restaff}");
      }
      print("inserted staff ${restaff}");

      /////////////// insert into local db /////////////////////
      notifyListeners();
      return staffModel;
    } catch (e) {
      print(e);
      return null;
    }
  }

/////////////////get UserType//////////////////////////////////////
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
      // print("body ${body}");
      List map = jsonDecode(response.body);
      print("map ${map}");

      for (var user in map) {
        // print("staff----${staff}");
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

////////////////////// Staff Area ///////////////////////////////////
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

  ////////////////////////// wallet///////////////////////////////////////
  Future<WalletModal?> getWallet(BuildContext context) async {
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
          // print("compny----${company_code}");
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
          isLoading = false;
          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

  ////////////////////////////////////////////////////////////////////////////////////////
  fetchwallet() async {
    walletList.clear();
    var res = await OrderAppDB.instance.selectAllcommon('walletTable', "");
    for (var item in res) {
      walletList.add(item);
    }
    print("fetch wallet-----$walletList");
  }

  ///////////////////////////////////account head////////////////////////////////////////////
  Future<AccountHead?> getaccountHeadsDetails(
    String cid,
  ) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_achead.php");
      Map body = {
        'cid': cid,
      };

      isLoading = true;
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

      isLoading = false;
      notifyListeners();

      // return accountHead;
    } catch (e) {
      print(e);
      return null;
    }
  }

  ///////////////////////////////////////////////////////////
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

  ///////////////////////////////////////////////////////////////
  Future<ProductDetails?> getProductDetails(
    String cid,
  ) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_prod.php");
      Map body = {
        'cid': cid,
      };
      print("compny----${cid}");

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

      isLoading = false;
      notifyListeners();
      /////////////// insert into local db /////////////////////
    } catch (e) {
      print(e);
      return null;
    }
  }

  /////////////////////////////product category//////////////////////////////
  Future<ProductsCategoryModel?> getProductCategory(
    String cid,
  ) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_cat.php");
      Map body = {
        'cid': cid,
      };
      print("compny----${cid}");

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

  ////////////////////////////////get company//////////////////////////////////
  Future<ProductCompanymodel?> getProductCompany(
    String cid,
  ) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_com.php");
      Map body = {
        'cid': cid,
      };
      print("compny----${cid}");

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
      isLoading = false;
      notifyListeners();
      /////////////// insert into local db /////////////////////
    } catch (e) {
      print(e);
      return null;
    }
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

  //////////////////////////////////////////////////////
  getArea(String sid) async {
    String areaName;
    areDetails.clear();
    print("staff...............${sid}");
    try {
      areaList = await OrderAppDB.instance.getArea(sid);
      print("areaList----${areaList}");
      print("areaList before ----${areDetails}");
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

  /////////////////////////////////////////////////////
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

  /////////////////////////////////////////////////////
  customerListClear() {
    customerList.clear();
    notifyListeners();
  }

  setSplittedCode(String splitted) {
    splittedCode = splitted;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////
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

  selectedSet() {
    var length = productName.length;
    qty = List.generate(length, (index) => TextEditingController());

    selected = List.generate(length, (index) => false);
  }

/////////////////////////////////////////////////////////////
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

////////////////////////////////////////////////////////////
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

  /////////////////////////////////////
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

////////////////////////////////
  generateTextEditingController() {
    var length = bagList.length;
    print("text length----$length");
    controller = List.generate(length, (index) => TextEditingController());
    print("length----$length");
    // notifyListeners();
  }

  /////////////////////////////////
  calculateAmt(String rate, String _controller) {
    amt = double.parse(rate) * double.parse(_controller);
    // notifyListeners();
  }

  ////////////////////////////////////
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
    generateTextEditingController();
    print("bagList vxdvxd----$bagList");

    isLoading = false;
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
    generateTextEditingController();
    notifyListeners();
  }

  /////////////////////////////updateqty/////////////////////
  updateQty(String qty, int cartrowno, String customerId, String rate) async {
    // print("qty-----${qty}");
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

  /////////calculate total////////////////
  calculateTotal(String os, String customerId) async {
    orderTotal = await OrderAppDB.instance.gettotalSum(os, customerId);
    print("orderTotal---$orderTotal");
    notifyListeners();
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
    print("table--customerId-$table-$customerId");
    count = await OrderAppDB.instance
        .countCommonQuery(table, "os='${os}' AND customerid='${customerId}'");
    isLoading = false;

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
      double total_price) async {
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
          1,
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
            1,
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

  ///////////////////////////////////////////////////////////////////////////
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
          1,
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
            1,
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

///////////////////////////////////////////////////////////////////////////////
  searchProcess(String customerId, String os) async {
    print("searchkey----$searchkey");
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
      List<Map<String, dynamic>> result = await OrderAppDB.instance.searchItem(
          'productDetailsTable', searchkey!, 'item', 'code', 'categoryId');
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

      print("text length----$length");

      print("selected[item]-----${selected}");

      // notifyListeners();
    }

    print("nw list---$newList");
    notifyListeners();
  }

  //////////////////staff log details insertion//////////////////////
  insertStaffLogDetails(String sid, String sname, String datetime) async {
    var logdata =
        await OrderAppDB.instance.insertStaffLoignDetails(sid, sname, datetime);
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

  ////////////////////////////////////////////////////////////////
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

  ///////////////////////
  ///
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
    print("total pri-----$returntotalPrice");
    notifyListeners();
  }

  setisVisible(bool isvis) {
    isVisible = isvis;
    notifyListeners();
  }

  //////getHistory/////////////////////////////
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

  /////////////////////////////////////////////
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

  //////////////////order save and send/////////////////////////
  saveOrderDetails(
      String cid, List<Map<String, dynamic>> om, BuildContext context) async {
    try {
      print("haiii");
      Uri url = Uri.parse("http://trafiqerp.in/order/fj/order_save.php");
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
      print("response----${map}");

      for (var item in map) {
        if (item["order_id"] != null) {
          await OrderAppDB.instance.upadteCommonQuery("orderMasterTable",
              "status='${item["order_id"]}'", "id='${item["id"]}'");
        }
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

///////////////////////////upload order data//////////////////////////////////////////
  uploadOrdersData(String cid, BuildContext context) async {
    List<Map<String, dynamic>> resultQuery = [];
    List<Map<String, dynamic>> om = [];
    var result = await OrderAppDB.instance.selectMasterTable();
    print("output------$result");
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
      saveOrderDetails(cid, om, context);
    } else {
      snackbar.showSnackbar(context, "Nothing to upload!!!");
    }
    print("om----$om");
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

//////////////////////////////////////////////////////////
  selectReportFromOrder(
      BuildContext context, String userId, String date) async {
    print("report userId----$userId");
    reportData.clear();
    reportOriginalList.clear();
    Map map = {};
    isLoading = true;
    // notifyListeners();
    var res = await OrderAppDB.instance
        .getReportDataFromOrderDetails(userId, date, context);
    if (res != null && res.length > 0) {
      for (var item in res) {
        reportData.add(item);
      }
    } else {
      noreportdata = true;
      notifyListeners();
      // snackbar.showSnackbar(context, "please download customers !!!");
    }
    isLoading = false;
    notifyListeners();
  }

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
  searchfromreport() async {
    print("searchkey----$reportSearchkey");
    newreportList.clear();

    if (reportSearchkey!.isEmpty) {
      // isreportSearch = false;
      newreportList = reportData;
    } else {
      print("re----$reportData");
      newreportList = reportData
          .where((element) => element["name"]
              .toLowerCase()
              .contains(reportSearchkey!.toLowerCase()))
          .toList();
      print("new---$newreportList");
    }
  }

///////////////// dashboard summery /////////////
  Future<dynamic> dashboardSummery(
      String sid, String date, String aid, BuildContext context) async {
    print("stafff  iddd $sid");
    var res = await OrderAppDB.instance.dashboardSummery(sid, date, aid);
    var result = await OrderAppDB.instance.countCustomer(areaidFrompopup);
    print("resultresult-- $aid");
    if (result.length > 0) {
      customerCount = result.length;
    }

    print("customerCount----$customerCount");
    orderCount = res[0]["ordCnt"].toString();
    collectionCount = res[0]["colCnt"].toString();
    remarkCount = res[0]["rmCnt"].toString();
    ret_count = res[0]["retCnt"].toString();

    collectionAmount = res[0]["colVal"].toString();
    ordrAmount = res[0]["ordVal"].toString();
    returnAmount = res[0]["retVal"].toString();

    shopVisited = res[0]["cusCount"];
    if (customerCount == null) {
      snackbar.showSnackbar(context, "Please download Customers");
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
    returnList.add(value);
    returnCount = returnList.length;
    print("return List----$returnList");
    notifyListeners();
  }

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
        returnList[i]["total"] = rate.toString();
        notifyListeners();
      }
    }
    notifyListeners();
  }

/////////////////////////////////////////////////////////////////////////
  getShopVisited(String userId, String date) async {
    shopVisited = await OrderAppDB.instance.getShopsVisited(userId, date);
    var res = await OrderAppDB.instance.countCustomer(areaidFrompopup);
    print("col--ret-- $collectionCount--$orderCount--$remarkCount--$ret_count");
    if (res != null) {
      customerCount = res.length;
    }
    if (collectionCount == 0 &&
        orderCount == 0 &&
        remarkCount == null &&
        ret_count == null) {
      print("collection--");
      noshopVisited = customerCount;
    } else {
      noshopVisited = customerCount! - shopVisited!;
    }
    notifyListeners();
  }

  /////////////////////////save return details////////////////////////////////////
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
      print("response----${map}");

      for (var item in map) {
        if (item["stock_r_id"] != null) {
          await OrderAppDB.instance.upadteCommonQuery("returnMasterTable",
              "status='${item["stock_r_id"]}'", "id='${item["id"]}'");
        }
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

///////////////////////////upload order data//////////////////////////////////////////
  uploadReturnData(String cid, BuildContext context) async {
    List<Map<String, dynamic>> resultQuery = [];
    List<Map<String, dynamic>> om = [];
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
    } else {
      snackbar.showSnackbar(context, "Nothing to upload!!!");
    }
    print("om----$om");
    notifyListeners();
  }

  //////////////////////////////////////////////////////////////////
  adminDashboard(
    String cid,
  ) async {
    gridHeader.clear();
    adminDashboardList = [
      {
        "heading": "helloo",
        "data": [
          {"caption": "sales", "value": "10"}
        ]
      },
      {
        "heading": "haiiii",
        "data": [
          {"caption": "sales", "value": "10"}
        ]
      }
    ];
     

    // var jsonDecod=jsonDecode(json); 

  //   for(var item in json){
  //     print("item--head--${item['heading']}");
  //     gridHeader.add("${item['heading']}");
  //     adminDashboardList.add(item['data']);
  //   }
  //  print("grid----$gridHeader");

  //  for(var item in gridHeader){
  //   if(item == )
  //  }
    try {
    //   Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_today.php");
    //   Map body = {
    //     'cid': cid,
    //   };
    //   // print("compny----${cid}");
    //   http.Response response = await http.post(
    //     url,
    //     body: body,
    //   );
    //   var map = jsonDecode(response.body);

      // var jsonD=jsonDecode(json);
      // print("map ${map["TODAYS COUNTS"]}");
      // print(map.elementAt(1));
      // print("adminDashboardList---$adminDashboardList");
      // /////////////// insert into local db /////////////////////
      // notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

  //////////////////////////////////////////////////////////////////
  uploadCustomers() async {
    var result = await OrderAppDB.instance.selectAllcommon('customerTable', "");
    if (res.length > 0) {
      //////upload customer////
      await OrderAppDB.instance.deleteFromTableCommonQuery("customerTable", "");
    }
  }
}
