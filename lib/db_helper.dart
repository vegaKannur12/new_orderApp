// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';

import 'package:orderapp/model/accounthead_model.dart';
import 'package:orderapp/model/productdetails_model.dart';
import 'package:orderapp/model/productsCategory_model.dart';
import 'package:orderapp/model/userType_model.dart';
import 'package:orderapp/model/wallet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model/productCompany_model.dart';
import 'model/registration_model.dart';
import 'model/staffarea_model.dart';
import 'model/staffdetails_model.dart';

class OrderAppDB {
  DateTime date = DateTime.now();
  String? formattedDate;
  var aidsplit;
  // String? areaidfromStaff;
  static final OrderAppDB instance = OrderAppDB._init();
  static Database? _database;
  OrderAppDB._init();
  /////////registration fields//////////
  static final id = 'id';
  static final cid = 'cid';
  static final fp = 'fp';
  static final os = 'os';
  static final c_d = 'c_d';
  static final cpre = 'cpre';
  static final ctype = 'ctype';
  static final hoid = 'hoid';
  static final cnme = 'cnme';
  static final ad1 = 'ad1';
  static final ad2 = 'ad2';
  static final pcode = 'pcode';
  static final ad3 = 'ad3';
  static final land = 'land';
  static final mob = 'mob';
  static final em = 'em';
  static final gst = 'gst';
  static final ccode = 'ccode';
  static final scode = 'scode';
  static final msg = 'msg';

/////////// staff details /////////////
  static final sid = 'sid';
  static final sname = 'sname';
  static final uname = 'uname';
  static final pwd = 'pwd';
  static final ph = 'ph';
  static final area = 'area';
  static final datetime = 'datetime';

  // int DB_VERSION = 2;

  //////////////Staff area details////////////////////////
  static final aid = 'aid';
  static final aname = 'aname';

  //////////////account heads///////////////////////////////
  static final ac_code = 'ac_code';
  static final hname = 'hname';
  static final gtype = 'gtype';
  static final ac_ad1 = 'ac_ad1';
  static final ac_ad2 = 'ac_ad2';
  static final ac_ad3 = 'ac_ad3';
  static final area_id = 'area_id';
  static final phn = 'phn';
  static final ba = 'ba';
  static final ri = 'ri';
  static final rc = 'rc';
  static final ht = 'ht';
  static final mo = 'mo';
  static final ac_gst = 'ac_gst';
  static final ac = 'ac';
  static final cag = 'cag';
  /////////////////userTable/////////
  static final uid = 'uid';
  static final u_name = 'u_name';
  static final upwd = 'upwd';
  // static final status = 'cag';

  ///////////customr table///////////////
  // static final ac_code = 'uid';

  /////////////productdetails//////////
  static final code = 'code';
  static final ean = 'ean';
  static final item = 'item';
  static final unit = 'unit';
  static final categoryId = 'categoryId';
  static final companyId = 'companyId';
  static final stock = 'stock';
  static final hsn = 'hsn';
  static final tax = 'tax';
  static final prate = 'prate';
  static final mrp = 'mrp';
  static final cost = 'cost';
  static final rate1 = 'rate1';
  static final rate2 = 'rate2';
  static final rate3 = 'rate3';
  static final rate4 = 'rate4';
  static final priceflag = 'priceflag';

  ////////////////prooduct category///////////////
  static final cat_id = 'cat_id';
  static final cat_name = 'cat_name';
  ////////////////// product company ////////////////
  static final comid = 'comid';
  static final comanme = 'comanme';
///////////////// ORDER MASTER ////////////////////
  static final order_id = 'order_id';

  static final ordernum = 'ordernum';
  static final orderdate = 'orderdate';
  static final ordertime = 'ordertime';

  static final customerid = 'customerid';
  static final userid = 'userid';
  static final areaid = 'areaid';
  static final status = 'status';
  static final total_price = 'total_price';
/////////////////////// return master //////
  static final return_id = 'return_id';
  static final return_date = 'return_date';
  static final return_time = 'return_time';
  static final reason = 'reason';
  static final reference_no = 'reference_no';

/////////////////// cart table/////////////
  static final cartdate = 'cartdate';
  static final carttime = 'carttime';
  static final cartrowno = 'cartrowno';
  static final qty = 'qty';
  static final rate = 'rate';
  static final totalamount = 'totalamount';
  static final cstatus = 'cstatus';
  static final row_num = 'row_num';
  static final itemName = 'itemName';
  static final numberof_items = 'numberof_items';

////////////////////menu table////////////////
  static final menu_index = 'menu_index';
  static final menu_name = 'menu_name';
  static final user = 'user';

  ////////////settings//////////////////////
  static final options = 'options';
  static final value = 'value';
/////////wallet table//////////////////
  static final waid = 'waid';
  static final wname = 'wname';
////////////collection table///////////////
  static final rec_date = 'rec_date';
  static final rec_cusid = 'rec_cusid';
  static final rec_series = 'rec_series';
  static final rec_mode = 'rec_mode';
  static final rec_amount = 'rec_amount';
  static final rec_row_num = 'rec_row_num';
  static final rec_disc = 'rec_disc';
  static final rec_note = 'rec_note';
  static final rec_staffid = 'rec_staffid';
  static final rec_cancel = 'rec_cancel';
  static final rec_status = 'rec_status';
  static final rec_time = 'rec_time';
///////remark table//////////////////////

  static final rem_date = 'rem_date';
  static final rem_cusid = 'rem_cusid';
  static final rem_series = 'rem_series';
  static final rem_text = 'rem_text';
  static final rem_staffid = 'rem_staffid';
  static final rem_row_num = 'rem_row_num';
  static final rem_cancel = 'rem_cancel';
  static final rem_status = 'rem_status';
  static final rem_time = 'rem_time';

  //////////////////sales bag//////////////////
  static final method = 'method';
  static final discount = 'discount';
  ///////////////// sales details /////////
  static final item_name = 'item_name';
  static final hsn_code = 'hsn_code';
  static final gross_amount = 'gross_amount';
  static final tax_per = 'tax_per';
  static final tax_amt = 'tax_amt';
  static final ces_per = 'ces_per';
  static final ces_amt = 'ces_amt';
  static final dis_amt = 'dis_amt';
  static final dis_per = 'dis_per';
  static final net_amt = 'net_amt';
  static final sales_id = 'sales_id';
  ///////////// salesmastertable////////
  static final salestime = 'salestime';
  static final salesdate = 'salesdate';
  static final cus_type = 'cus_type';
  static final customer_id = 'customer_id';
  static final staff_id = 'staff_id';
  static final cgst = 'cgst';
  static final sgst = 'sgst';
  static final total_qty = 'total_qty';
  static final payment_mode = 'payment_mode';
  static final credit_option = 'credit_option';
  static final bill_no = 'bill_no';

  Future<Database> get database async {
    print("bjhs");
    if (_database != null) return _database!;
    // if (_database != null) {
    //   print("fkdjshkj");
    //   _upgradeDB(_database!, 4, 5);
    //   return _database!;
    // }

    _database = await _initDB("orderapp.db");
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    print("db---");
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return await openDatabase(
      path,
      version: 1, onCreate: _createDB,
      //  onUpgrade: _upgradeDB
    );
  }

  // _upgradeDB(Database db, int oldVersion, int newVersion) {
  //   print("hszbds");
  //   // var batch = db.batch();
  //   print("old-----$oldVersion---$newVersion");

  //   if (oldVersion == 2) {
  //     print("yes");
  //     alterUserTable(db);
  //   }
  //   if (oldVersion == 4) {
  //     print("yes 4");
  //     alterstaffDetailsTable(db);
  //   }
  //   // batch.commit();
  // }

  // alterUserTable(Database db) {
  //   print("batch");
  //   db.execute('alter table userTable add column newClumn text;');
  //   //  batch.commit();
  // }

  // alterstaffDetailsTable(Database db) {
  //   print("batch 4");
  //   db.execute('alter table staffDetailsTable add column newClumn text;');
  //   //  batch.commit();
  // }

  Future _createDB(Database db, int version) async {
    print("table created");
    ///////////////orderapp store table ////////////////
    await db.execute('''
          CREATE TABLE registrationTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $cid TEXT NOT NULL,
            $fp TEXT NOT NULL,
            $os TEXT NOT NULL,
            $cpre TEXT,
            $ctype TEXT,
            $cnme TEXT,
            $ad1 TEXT,
            $ad2 TEXT,
            $ad3 TEXT,
            $pcode TEXT,
            $land TEXT,
            $mob TEXT,
            $em TEXT,
            $gst TEXT,
            $ccode TEXT,
            $scode TEXT,
            $msg TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE staffDetailsTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $sid TEXT NOT NULL,
            $sname TEXT,
            $uname TEXT,
            $pwd TEXT,
            $ad1 TEXT,
            $ad2 TEXT,
            $ad3 TEXT,
            $ph TEXT,
            $area TEXT     
          )
          ''');
    await db.execute('''
      CREATE TABLE userTable (
        $id INTEGER PRIMARY KEY AUTOINCREMENT,
        $uid TEXT NOT NULL,
        $u_name TEXT,
        $upwd TEXT,
        $status INTEGER
         )
         ''');
    await db.execute('''
          CREATE TABLE staffLoginDetailsTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $sid TEXT NOT NULL,
            $sname TEXT,
            $datetime TEXT     
          )
          ''');
    await db.execute('''
          CREATE TABLE areaDetailsTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $aid TEXT NOT NULL,
            $aname TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE customerTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $ac_code TEXT NOT NULL 
         )
         ''');
    ////////////////account_haed table///////////////////
    await db.execute('''
          CREATE TABLE accountHeadsTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $ac_code TEXT NOT NULL,
            $hname TEXT NOT NULL,
            $gtype TEXT NOT NULL,
            $ac_ad1 TEXT,
            $ac_ad2 TEXT,
            $ac_ad3 TEXT,
            $area_id TEXT,
            $phn TEXT, 
            $ba REAL,
            $ri TEXT,
            $rc TEXT,
            $ht TEXT,
            $mo TEXT,
            $ac_gst TEXT,
            $ac TEXT,
            $cag TEXT
          )
          ''');

    await db.execute('''
          CREATE TABLE productDetailsTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $code TEXT NOT NULL,
            $ean TEXT,
            $item TEXT,
            $unit TEXT,
            $categoryId TEXT,
            $companyId TEXT,
            $stock TEXT,
            $hsn TEXT,
            $tax TEXT,
            $prate TEXT,
            $mrp TEXT,
            $cost TEXT,
            $rate1 TEXT,
            $rate2 TEXT,
            $rate3 TEXT,
            $rate4 TEXT,
            $priceflag TEXT

          )
          ''');
    //////////////////////////products category////////////////////
    await db.execute('''
          CREATE TABLE productsCategory (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $cat_id TEXT NOT NULL,
            $cat_name TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE companyTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $comid TEXT NOT NULL,
            $comanme TEXT
          )
          ''');
    /////////////// order master table//////////
    await db.execute('''
          CREATE TABLE orderMasterTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $order_id INTEGER,
            $orderdate TEXT,
            $ordertime TEXT,
            $os TEXT NOT NULL,
            $customerid TEXT,
            $userid TEXT,
            $areaid TEXT,
            $status INTEGER,
            $total_price REAL
          )
          ''');
    ///////////// sales master table //////////////////
    await db.execute('''
          CREATE TABLE salesMasterTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $sales_id INTEGER,
            $salesdate TEXT,
            $salestime TEXT,
            $os TEXT NOT NULL,
            $cus_type TEXT,
            $bill_no TEXT,
            $customer_id TEXT,
            $staff_id TEXT,
            $areaid TEXT,
            $total_qty INTEGER,
            $cgst TEXT,
            $sgst TEXT,
            $payment_mode TEXT,
            $credit_option TEXT,
            $status INTEGER,
            $total_price REAL
          )
          ''');
    await db.execute('''
          CREATE TABLE orderDetailTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $item TEXT,
            $os TEXT NOT NULL,
            $order_id INTEGER,
            $row_num INTEGER,
            $code TEXT,
            $qty INTEGER,
            $unit TEXT,
            $rate REAL  
          )
          ''');
    ///////////////////////////////
    await db.execute('''
          CREATE TABLE salesDetailTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $os TEXT NOT NULL,
            $sales_id INTEGER,
            $row_num INTEGER,
            $item_name TEXT,
            $code TEXT,
            $qty INTEGER,
            $unit TEXT,
            $gross_amount REAL,
            $dis_amt REAL,
            $dis_per REAL,
            $tax_amt REAL,
            $tax_per REAL,
            $ces_amt REAL,
            $ces_per REAL,
            $net_amt REAL,
            $rate REAL  
          )
          ''');
    await db.execute(''' 
          CREATE TABLE orderBagTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $itemName TEXT NOT NULL,
            $cartdate TEXT,
            $carttime TEXT,
            $os TEXT NOT NULL,
            $customerid TEXT,
            $cartrowno INTEGER,
            $code TEXT,
            $qty INTEGER,
            $rate TEXT,
            $totalamount TEXT,
            $cstatus INTEGER
          )
          ''');
    ////////////////////////////////////////
    await db.execute(''' 
          CREATE TABLE salesBagTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $itemName TEXT NOT NULL,
            $cartdate TEXT,
            $carttime TEXT,
            $os TEXT NOT NULL,
            $customerid TEXT,
            $cartrowno INTEGER,
            $code TEXT,
            $qty REAL,
            $rate TEXT,
            $totalamount TEXT,
            $method TEXT,
            $hsn TEXT,
            $tax_per REAL,
            $tax REAl,
            $discount TEXT,
            $ces_per TEXT,
            $cstatus INTEGER,
            $net_amt REAL
          )
          ''');
    /////////////////////////////////////////
    await db.execute('''
          CREATE TABLE menuTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $menu_index TEXT NOT NULL,
            $menu_name TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE settings (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $options TEXT NOT NULL,
            $value INTEGER
          )
          ''');
    await db.execute('''
          CREATE TABLE walletTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $waid TEXT NOT NULL,
            $wname TEXT
          )
          ''');
    await db.execute(''' 
      CREATE TABLE collectionTable (
        $id INTEGER PRIMARY KEY AUTOINCREMENT,
        $rec_date TEXT NOT NULL,
        $rec_time TEXT,
        $rec_cusid TEXT,
        $rec_row_num INTEGER,
        $rec_series TEXT NOT NULL,
        $rec_mode TEXT,
        $rec_amount REAL,
        $rec_disc TEXT,
        $rec_note TEXT,
        $rec_staffid TEXT,
        $rec_cancel INTEGER,
        $rec_status INTEGER
      )
      ''');
    await db.execute(''' 
      CREATE TABLE remarksTable (
        $id INTEGER PRIMARY KEY AUTOINCREMENT,
        $rem_date TEXT NOT NULL,
        $rem_time TEXT,
        $rem_cusid TEXT,
        $rem_series TEXT NOT NULL,
        $rem_text TEXT,
        $rem_staffid TEXT,
        $rem_row_num INTEGER,
        $rem_cancel INTEGER,
        $rem_status INTEGER
      )
      ''');
    await db.execute('''
          CREATE TABLE returnMasterTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $return_id INTEGER,
            $return_date TEXT,
            $return_time TEXT,
            $os TEXT NOT NULL,
            $customerid TEXT,
            $userid TEXT,
            $areaid TEXT,
            $status TEXT,
            $reason TEXT,
            $reference_no TEXT,
            $total_price REAL
          )
          ''');
    await db.execute('''
          CREATE TABLE returnDetailTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $item TEXT,
            $os TEXT NOT NULL,
            $return_id INTEGER,
            $row_num INTEGER,
            $code TEXT,
            $qty INTEGER,
            $unit TEXT,
            $rate REAL  
          )
          ''');
  }

  ////////////////////////company details select///////////////////////////////////
  selectCompany(String? condition) async {
    List result;
    Database db = await instance.database;

    result =
        await db.rawQuery('select * from registrationTable where $condition');

    print("select * from registrationTable where $condition");

    print("company deta-=-$result");
    if (result.length > 0) {
      return result;
    } else {
      return null;
    }
  }

  //////////////////////////////////////////////
  Future insertorderBagTable(
    String itemName,
    String cartdate,
    String carttime,
    String os,
    String customerid,
    int cartrowno,
    String code,
    int qty,
    String rate,
    String totalamount,
    int cstatus,
  ) async {
    print("qty--$qty");
    print("code...........$code");
    final db = await database;
    var res;
    var query3;
    var query2;
    List<Map<String, dynamic>> res1 = await db.rawQuery(
        'SELECT  * FROM orderBagTable WHERE customerid="${customerid}" AND os = "${os}" AND code="${code}"');
    print("SELECT from ---$res1");
    if (res1.length == 1) {
      int qty1 = res1[0]["qty"];
      int updatedQty = qty1 + qty;
      double amount = double.parse(res1[0]["totalamount"]);
      print("res1.length----${res1.length}");

      print("upadted qty-----$updatedQty");
      double amount1 = double.parse(totalamount);
      double updatedAmount = amount + amount1;
      var res = await db.rawUpdate(
          'UPDATE orderBagTable SET qty=$updatedQty , totalamount="${updatedAmount}" WHERE customerid="${customerid}" AND os = "${os}" AND code="${code}"');
      print("response-------$res");
    } else {
      query2 =
          'INSERT INTO orderBagTable (itemName, cartdate, carttime , os, customerid, cartrowno, code, qty, rate, totalamount, cstatus) VALUES ("${itemName}","${cartdate}","${carttime}", "${os}", "${customerid}", $cartrowno, "${code}", $qty, "${rate}", "${totalamount}", $cstatus)';
      var res = await db.rawInsert(query2);
    }

    print("insert query result $res");
    print("insert-----$query2");
    return res;
  }

////////////////////////// insert into sales bag table /////////////////
  Future insertsalesBagTable(
    String itemName,
    String cartdate,
    String carttime,
    String os,
    String customerid,
    int cartrowno,
    String code,
    double qty,
    String rate,
    String totalamount,
    String method,
    String hsn,
    double tax_per,
    double tax,
    double discount,
    double ces_per,
    int cstatus,
    double net_amt,
  ) async {
    print("qty--$qty");
    print("code...........$code");
    final db = await database;
    var res;
    var query3;
    var query2;
    List<Map<String, dynamic>> res1 = await db.rawQuery(
        'SELECT  * FROM salesBagTable WHERE customerid="${customerid}" AND os = "${os}" AND code="${code}"');
    print("SELECT from ---$res1");
    if (res1.length == 1) {
      double qty1 = res1[0]["qty"];
      double updatedQty = qty1 + qty;
      print("totalamount---${res1[0]["totalamount"]}");
      double amount = double.parse(res1[0]["totalamount"]);
      print("res1.length----${res1.length}");

      print("upadted qty-----$updatedQty");
      double amount1 = double.parse(totalamount);
      double updatedAmount = amount + amount1;
      var res = await db.rawUpdate(
          'UPDATE salesBagTable SET qty=$updatedQty , totalamount="${updatedAmount}" WHERE customerid="${customerid}" AND os = "${os}" AND code="${code}"');
      print("response-------$res");
    } else {
      query2 =
          'INSERT INTO salesBagTable (itemName, cartdate, carttime , os, customerid, cartrowno, code, qty, rate, totalamount, method, hsn,tax_per, tax, discount, ces_per, cstatus,net_amt) VALUES ("${itemName}","${cartdate}","${carttime}", "${os}", "${customerid}", $cartrowno, "${code}", $qty, "${rate}", "${totalamount}","${method}", "${hsn}",${tax_per}, ${tax}, ${discount}, ${ces_per}, $cstatus,"$net_amt")';
      var res = await db.rawInsert(query2);
    }

    print("insert query result $res");
    print("insert-----$query2");
    return res;
  }

  /////////////////////// order master table insertion//////////////////////
  Future insertorderMasterandDetailsTable(
      String item,
      int order_id,
      int? qty,
      double rate,
      String? code,
      String orderdate,
      String ordertime,
      String os,
      String customerid,
      String userid,
      String areaid,
      int status,
      String unit,
      int rowNum,
      String table,
      double total_price) async {
    final db = await database;
    var res2;
    var res3;

    if (table == "orderDetailTable") {
      var query2 =
          'INSERT INTO orderDetailTable(order_id, row_num,os,code, item, qty, rate, unit) VALUES(${order_id},${rowNum},"${os}","${code}","${item}", ${qty}, $rate, "${unit}")';
      print(query2);
      res2 = await db.rawInsert(query2);
    } else if (table == "orderMasterTable") {
      var query3 =
          'INSERT INTO orderMasterTable(order_id, orderdate, ordertime, os, customerid, userid, areaid, status, total_price) VALUES("${order_id}", "${orderdate}", "${ordertime}", "${os}", "${customerid}", "${userid}", "${areaid}", ${status},${total_price})';
      res2 = await db.rawInsert(query3);
      print(query3);
    }
  }

  //////////// Insert into sales master and sales details table/////////////
  Future insertsalesMasterandDetailsTable(
    int sales_id,
    double? qty,
    double rate,
    String? code,
    String salesdate,
    String salestime,
    String os,
    String customer_id,
    String cus_type,
    String bill_no,
    String staff_id,
    String areaid,
    int total_qty,
    String cgst,
    String sgst,
    String payment_mode,
    String credit_option,
    String unit,
    int rowNum,
    String table,
    String item_name,
    double gross_amount,
    double dis_amt,
    double dis_per,
    double tax_amt,
    double tax_per,
    double ces_amt,
    double ces_per,
    double net_amt,
    double total_price,
    int status,
  ) async {
    final db = await database;
    var res2;
    var res3;

    if (table == "salesDetailTable") {
      var query2 =
          'INSERT INTO salesDetailTable(os, sales_id, row_num, item_name , code, qty, unit , gross_amount, dis_amt, dis_per, tax_amt, tax_per, ces_amt, ces_per, net_amt, rate) VALUES("${os}", ${sales_id}, ${rowNum}, "${item_name}", "${code}", ${qty}, "${unit}", $gross_amount, $dis_amt, ${dis_per}, $tax_amt, $tax_per, $ces_amt, $ces_per, $net_amt, $rate)';
      print("insert salesdetails $query2");
      res2 = await db.rawInsert(query2);
    } else if (table == "salesMasterTable") {
      var query3 =
          'INSERT INTO salesMasterTable(sales_id, salesdate, salestime, os, cus_type, bill_no, customer_id, staff_id, areaid, total_qty, cgst, sgst, payment_mode, credit_option, status, total_price) VALUES("${sales_id}", "${salesdate}", "${salestime}", "${os}", "${cus_type}", "${bill_no}", "${customer_id}", "${staff_id}", "${areaid}", $total_qty, "${cgst}", "${sgst}", "${payment_mode}", "${credit_option}", ${status}, ${total_price.toStringAsFixed(2)})';
      res2 = await db.rawInsert(query3);
      print("insertsalesmaster$query3");
    }
  }

  ////////////////////insert to return table/////////////////////////////////
  Future insertreturnMasterandDetailsTable(
      String item,
      int return_id,
      int? qty,
      double rate,
      String? code,
      String return_date,
      String return_time,
      String os,
      String customerid,
      String userid,
      String areaid,
      int status,
      String unit,
      int rowNum,
      String table,
      double total_price,
      String reason,
      String refNo) async {
    final db = await database;
    var res2;
    var res3;

    if (table == "returnDetailTable") {
      var query2 =
          'INSERT INTO returnDetailTable(return_id, row_num,os,code, item, qty, rate, unit) VALUES(${return_id},${rowNum},"${os}","${code}","${item}", ${qty}, $rate, "${unit}")';
      print(query2);
      res2 = await db.rawInsert(query2);
    } else if (table == "returnMasterTable") {
      var query3 =
          'INSERT INTO returnMasterTable(return_id, return_date, return_time, os, customerid, userid, areaid, status, total_price, reference_no, reason) VALUES("${return_id}", "${return_date}", "${return_time}", "${os}", "${customerid}", "${userid}", "${areaid}", ${status},${total_price},"${refNo}", "${reason}")';
      res2 = await db.rawInsert(query3);
      print(query3);
    }
  }

  //////////////////////////menu table//////////////////////////////////////////
  Future insertMenuTable(String menu_prefix, String menu_name) async {
    print("menu_prefix  menu_name ");
    final db = await database;
    // deleteFromTableCommonQuery('menuTable', "");
    var query1 =
        'INSERT INTO menuTable(menu_index,menu_name) VALUES("${menu_prefix}", "${menu_name}")';
    var res = await db.rawInsert(query1);
    print("menu----${query1}");
    print("menu----${res}");
    // print(res);
    return res;
  }

  /////////////////////////customer table insertion/////////////////////////////
  Future insertCustomerTable(String ac_code) async {
    final db = await database;
    // deleteFromTableCommonQuery('menuTable', "");
    var query1 = 'INSERT INTO customerTable(ac_code) VALUES("${ac_code}")';
    var res = await db.rawInsert(query1);
    // print("menu----${query1}");
    print("customerTable----${res}");
    // print(res);
    return res;
  }

  //////////////////////////wallet table/////////////////////////////////////
  Future insertwalletTable(WalletModal wallet) async {
    final db = await database;
    var query1 =
        'INSERT INTO walletTable(waid,wname) VALUES("${wallet.waid}", "${wallet.wanme}")';
    var res = await db.rawInsert(query1);
    print("wallet----${res}");
    // print(res);
    return res;
  }

  ////////////////////////settings insertion///////////////////////////////////
  Future insertsettingsTable(String options, int value) async {
    final db = await database;
    // deleteFromTableCommonQuery('menuTable', "");
    var query1 =
        'INSERT INTO settings(options,value) VALUES("${options}", ${value})';
    var res = await db.rawInsert(query1);
    // print("menu----${query1}");
    print("settingzz---${query1}");
    // print(res);
    return res;
  }

  ///////////////////// registration details insertion //////////////////////////
  Future insertRegistrationDetails(RegistrationData data) async {
    final db = await database;
    var query1 =
        'INSERT INTO registrationTable(cid, fp, os, cpre, ctype, cnme, ad1, ad2, ad3, pcode, land, mob, em, gst, ccode, scode, msg) VALUES("${data.cid}", "${data.fp}", "${data.os}","${data.c_d![0].cpre}", "${data.c_d![0].ctype}", "${data.c_d![0].cnme}", "${data.c_d![0].ad1}", "${data.c_d![0].ad2}", "${data.c_d![0].ad3}", "${data.c_d![0].pcode}", "${data.c_d![0].land}", "${data.c_d![0].mob}", "${data.c_d![0].em}", "${data.c_d![0].gst}", "${data.c_d![0].ccode}", "${data.c_d![0].scode}", "${data.msg}" )';
    var res = await db.rawInsert(query1);
    // print(query1);
    // print(res);
    return res;
  }

////////////////////select from orderBagTable//////////////////////

  Future<List<Map<String, dynamic>>> getOrderBagTable(
      String customerId, String os) async {
    print("enteredcustomerId---${customerId}");
    // .of<Controller>(context, listen: false).customerList.clear();
    Database db = await instance.database;
    var res = await db.rawQuery(
        'SELECT  * FROM orderBagTable WHERE customerid="${customerId}" AND os = "${os}"');
    print(
        'SELECT  * FROM orderBagTable WHERE customerid="${customerId}" AND os = "${os}"');
    print(res);
    return res;
  }

  Future<List<Map<String, dynamic>>> getSaleBagTable(
      String customerId, String os) async {
    print("enteredcustomerId---${customerId}");
    // .of<Controller>(context, listen: false).customerList.clear();
    Database db = await instance.database;
    var res = await db.rawQuery(
        'SELECT  * FROM salesBagTable WHERE customerid="${customerId}" AND os = "${os}"');
    print(
        'SELECT  * FROM salesBagTable WHERE customerid="${customerId}" AND os = "${os}"');
    print("result sale cart...$res");
    return res;
  }

////////////////////// staff details insertion /////////////////////
  Future insertStaffDetails(StaffDetails sdata) async {
    final db = await database;
    var query2 =
        'INSERT INTO staffDetailsTable(sid, sname, uname, pwd, ad1, ad2, ad3, ph, area) VALUES("${sdata.sid}", "${sdata.sname}", "${sdata.unme}", "${sdata.pwd}", "${sdata.ad1}", "${sdata.ad2}", "${sdata.ad3}", "${sdata.ph}", "${sdata.area}")';
    var res = await db.rawInsert(query2);
    print(query2);
    // print(res);
    return res;
  }

///////////////userType/////////////////////////////////////////
  Future insertUserType(UserTypeModel udata) async {
    final db = await database;
    var query2 =
        'INSERT INTO userTable(uid, u_name, upwd, status) VALUES("${udata.uid}", "${udata.unme}", "${udata.upwd}",${udata.status})';
    var res = await db.rawInsert(query2);
    print(query2);
    // print(res);
    return res;
  }

////////////////////////staff login details table insert ////////////////
  Future insertStaffLoignDetails(
      String sid, String sname, String datetime) async {
    final db = await database;
    var query2 =
        'INSERT INTO staffLoginDetailsTable(sid, sname, datetime) VALUES("${sid}", "${sname}", "${datetime}")';
    var res = await db.rawInsert(query2);
    print("stafflog....$query2");
    // print(res);
    return res;
  }

////////////////////// staff area details insertion /////////////////////
  Future insertStaffAreaDetails(StaffArea adata) async {
    final db = await database;
    var query3 =
        'INSERT INTO areaDetailsTable(aid, aname) VALUES("${adata.aid}", "${adata.anme}")';
    var res = await db.rawInsert(query3);
    print(query3);
    print(res);
    return res;
  }

//////////////////////////product details ///////////////////////////////////////////
  Future insertProductDetails(ProductDetails pdata) async {
    final db = await database;
    var query3 =
        'INSERT INTO productDetailsTable(code, ean, item, unit, categoryId, companyId, stock, hsn, tax, prate, mrp, cost, rate1, rate2, rate3, rate4, priceflag) VALUES("${pdata.code}", "${pdata.ean}", "${pdata.item}", "${pdata.unit}", "${pdata.categoryId}", "${pdata.companyId}", "${pdata.stock}", "${pdata.hsn}", "${pdata.tax}", "${pdata.prate}", "${pdata.mrp}", "${pdata.cost}", "${pdata.rate1}", "${pdata.rate2}", "${pdata.rate3}", "${pdata.rate4}", "${pdata.priceFlag}")';
    var res = await db.rawInsert(query3);
    // print(query3);
    // print(res);
    return res;
  }

  Future close() async {
    final _db = await instance.database;
    _db.close();
  }

  /////////////////////////ustaff login authentication////////////
  selectStaff(String uname, String pwd) async {
    String result = "";
    List<String> resultList = [];
    String? sid;
    print("uname---Password----${uname}--${pwd}");
    resultList.clear();
    print("before kkkk $resultList");
    Database db = await instance.database;
    List<Map<String, dynamic>> list =
        await db.rawQuery('SELECT * FROM staffDetailsTable');
    for (var staff in list) {
      // print(
      //     "staff['uname'] & staff['pwd']------------------${staff['uname']}--${staff['pwd']}");
      if (uname.toLowerCase() == staff["uname"].toLowerCase() &&
          pwd == staff["pwd"]) {
        print("match");
        sid = staff['sid'];
        result = "success";
        print("staffid..$sid");
        print("ok");
        resultList.add(result);
        resultList.add(sid!);
        break;
      } else {
        print("No match");
        result = "failed";
        sid = "";
        // resultList.add(result);
        // resultList.add(sid);
      }
    }
    print("res===${resultList}");

    print("all data ${list}");

    return resultList;
  }

  /////////////////////////////////////////////////////////////////////////////
  selectUser(String uname, String pwd) async {
    String result = "";
    List<String> resultList = [];
    String? uid;
    print("uname---Password----${uname}--${pwd}");
    resultList.clear();
    print("before kkkk $resultList");
    Database db = await instance.database;
    List<Map<String, dynamic>> list =
        await db.rawQuery('SELECT * FROM userTable');
    print("listttt---$list");

    for (var user in list) {
      if (user["u_name"].toLowerCase() == uname.toLowerCase() &&
          pwd == user["upwd"]) {
        uid = user['uid'].toString();
        result = "success";
        print("staffid..$sid");
        print("ok");
        resultList.add(result);
        resultList.add(uid);
        break;
      } else {
        result = "failed";
        uid = "";
      }
    }

    print("res===${resultList}");

    print("all data ${list}");

    return resultList;
  }

  /////////////////////////account heads insertion///////////////////////////////
  Future insertAccoundHeads(AccountHead accountHead) async {
    final db = await database;
    var query =
        'INSERT INTO accountHeadsTable(ac_code, hname, gtype, ac_ad1, ac_ad2, ac_ad3, area_id, phn, ba, ri, rc, ht, mo, ac_gst, ac, cag) VALUES("${accountHead.code}", "${accountHead.hname}", "${accountHead.gtype}", "${accountHead.ad1}", "${accountHead.ad2}", "${accountHead.ad3}", "${accountHead.aid}", "${accountHead.ph}", ${accountHead.ba}, "${accountHead.ri}", "${accountHead.rc}", "${accountHead.ht}", "${accountHead.mo}", "${accountHead.gst}", "${accountHead.ac}", "${accountHead.cag}")';
    var res = await db.rawInsert(query);
    print(query);
    print(res);
    return res;
  }

/////////////////////customer/////////////////////////////////////////
  Future createCustomer(
      String ac_code,
      String hname,
      String gtype,
      String ac_ad1,
      String ac_ad2,
      String ac_ad3,
      String area_id,
      String phn,
      String ri,
      double ba,
      String rc,
      String ht,
      String mo,
      String ac_gst,
      String ac,
      String cag) async {
    final db = await database;
    var query =
        'INSERT INTO accountHeadsTable(ac_code, hname, gtype, ac_ad1, ac_ad2, ac_ad3, area_id, phn, ba, ri, rc, ht, mo, ac_gst, ac, cag) VALUES("${ac_code}", "${hname}", "${gtype}", "${ac_ad1}", "${ac_ad2}", "${ac_ad3}", "${area_id}", "${ph}", ${ba}, "${ri}", "${rc}", "${ht}", "${mo}", "${gst}", "${ac}", "${cag}")';
    var res = await db.rawInsert(query);
    print(query);
    // print(res);
    return res;
  }

  ////////////////////////////product category insertion//////////////
  Future insertProductCategory(
      ProductsCategoryModel productsCategoryModel) async {
    final db = await database;
    var query =
        'INSERT INTO productsCategory(cat_id, cat_name) VALUES("${productsCategoryModel.cid}", "${productsCategoryModel.canme}")';
    var res = await db.rawInsert(query);
    print(query);
    // print(res);
    return res;
  }

////////////////////////////////// product company ///////////////////////
  Future insertProductCompany(ProductCompanymodel productsCompanyModel) async {
    final db = await database;
    var query =
        'INSERT INTO companyTable(comid, comanme) VALUES("${productsCompanyModel.comid}", "${productsCompanyModel.comanme}")';
    var res = await db.rawInsert(query);
    print(query);
    // print(res);
    return res;
  }

/////////////////////////collectionTable/////////////////////////////
  Future insertCollectionTable(
      String rec_date,
      String rec_time,
      String rec_cusid,
      int rec_row_num,
      String ser,
      String mode,
      String amtString,
      String disc,
      String note,
      String sttid,
      int cancel,
      int status) async {
    double amt = 0.0;
    final db = await database;
    print("amt---- $amtString---$disc");
    if (amtString == "") {
      // print("nullll");
      amt = 0.0;
      // double.parse(amtString);
    } else {
      amt = double.parse(amtString);
    }
    var query =
        'INSERT INTO collectionTable(rec_date, rec_time, rec_cusid, rec_row_num, rec_series, rec_mode, rec_amount, rec_disc, rec_note, rec_staffid, rec_cancel, rec_status) VALUES("${rec_date}","${rec_time}","${rec_cusid}", $rec_row_num, "${ser}", "${mode}", $amt, "${disc}", "${note}", "${sttid}", ${cancel}, ${status})';
    var res = await db.rawInsert(query);
    print(query);

    List<Map<String, dynamic>> balance =
        await selectAllcommon('accountHeadsTable', "ac_code='${rec_cusid}'");
    print("jhjkdxj----$balance");
    print('bal---${balance[0]["ba"]}');
    // double bal=double.parse(balance[0]["ba"]);
    double update_bal = balance[0]["ba"] - amt;
    upadteCommonQuery(
        'accountHeadsTable', "ba=${update_bal}", "ac_code='${rec_cusid}'");
    // print(res);
    return res;
  }

////////////////////////insert remark/////////////////////////////////
  Future insertremarkTable(
    String rem_date,
    String rem_time,
    String rem_cusid,
    String ser,
    String text,
    String sttid,
    int row_num,
    int cancel,
    int status,
  ) async {
    final db = await database;
    var query =
        'INSERT INTO remarksTable(rem_date, rem_time, rem_cusid, rem_series, rem_text, rem_staffid, rem_row_num, rem_cancel, rem_status) VALUES("${rem_date}", "${rem_time}","${rem_cusid}", "${ser}", "${text}","${sttid}",${row_num},${cancel},${status})';
    var res = await db.rawInsert(query);
    print(query);
    // print(res);
    return res;
  }

  ////////////////////////////////////////////////////////////////////
  getListOfTables() async {
    Database db = await instance.database;
    var list = await db.query('sqlite_master', columns: ['type', 'name']);
    print(list);
    list.map((e) => print(e["name"])).toList();
    return list;
    // list.forEach((row) {
    //   print(row.values);
    // });
  }

  getTableData(String tablename) async {
    Database db = await instance.database;
    print(tablename);
    var list = await db.rawQuery('SELECT * FROM $tablename');
    print(list);
    return list;
    // list.map((e) => print(e["name"])).toList();
    // return list;
    // list.forEach((row) {
    //   print(row.values);
    // });
  }

  //////////////////////////////////////////////////////////
  Future<List<Map<String, dynamic>>> getArea(String? sid) async {
    List<Map<String, dynamic>> list = [];
    String areaidfromStaff;
    List<Map<String, dynamic>> area = [];
    // String result = "";
    print("sid---${sid}");
    Database db = await instance.database;
    if (sid == " ") {
      list = await db.rawQuery('SELECT * FROM areaDetailsTable');
    } else {
      area = await db
          .rawQuery('SELECT area FROM staffDetailsTable WHERE sid="${sid}"');
      areaidfromStaff = area[0]["area"];
      aidsplit = areaidfromStaff.split(",");
      print("hudhuh---$aidsplit");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("areaidfromStaff", areaidfromStaff);
      if (areaidfromStaff == "") {
        list = await db.rawQuery('SELECT aname,aid FROM areaDetailsTable');
      } else {
        list = await db.query(
          'areaDetailsTable',
          where: "aid IN (${aidsplit.join(',')})",
        );
        // list = await db.rawQuery(
        //     'SELECT aname,aid FROM areaDetailsTable where aid=${areaid}');
      }
    }
    // print("res===${result}");
    print("area===${area}");
    print("area---List ${list}");
    return list;
  }

  //////////////////////////countCustomer////////////////
  countCustomer(String? areaId) async {
    var list;
    // print("aidsplit---${areaidfromStaff}");
    Database db = await instance.database;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? areaidfromStaff = prefs.getString("areaidfromStaff");
    if (areaidfromStaff == null || areaidfromStaff.isEmpty) {
      if (areaId == null) {
        list = await db.rawQuery('SELECT  * FROM accountHeadsTable ');
      } else {
        list = await db.rawQuery(
            'SELECT  * FROM accountHeadsTable where area_id="$areaId"');
      }
    } else if (areaId == null && areaidfromStaff != null) {
      list = await db.query(
        'accountHeadsTable',
        where: "area_id IN (${aidsplit.join(',')})",
      );
    } else {
      list = await db
          .rawQuery('SELECT  * FROM accountHeadsTable where area_id="$areaId"');
    }

    print("customr----${list.length}");
    return list;
  }

  //////////////////////////////////////////////////////
  Future<List<Map<String, dynamic>>> getCustomer(String aid) async {
    print("enteredaid---${aid}");
    // Provider.of<Controller>(context, listen: false).customerList.clear();
    Database db = await instance.database;
    var hname = await db.rawQuery(
        'SELECT  hname,ac_code FROM accountHeadsTable WHERE area_id="${aid}"');
    print('SELECT  hname,ac_code FROM accountHeadsTable WHERE area_id="${aid}');
    print("hname===${hname}");
    return hname;
  }

  ///////////////////////////////////////////////////////////////

  getItems(String product) async {
    print("product---${product}");
    Database db = await instance.database;
    var res = await db.rawQuery(
        "SELECT A.item, A.ean, A.rate1,A.code FROM productDetailsTable A WHERE A.code || A.item LIKE '%$product%'");

    print("SELECT * FROM productDetailsTable WHERE item LIKE '$product%'");
    print("items=================${res}");
    return res;
  }

  //////////////////////////////////////////////////////////////
  getOrderNo() async {
    Database db = await instance.database;
    var res = await db.rawQuery("SELECT os FROM registrationTable");
    print(res);
    print("SELECT os FROM registrationTable");
    return res;
  }

///////////////////////////////////////
  setStaffid(String sname) async {
    print("Sname.......$sname");
    Database db = await instance.database;
    var res = await db
        .rawQuery("SELECT sid FROM staffDetailsTable WHERE sname = '$sname'");
    print("sid result......$res");
    return res;
  }
  /////////////////////////max of from table//////////////////////
  // getMaxOfFieldValue(String os, String customerId) async {
  //   var res;
  //   int max;
  //   print("customerid---$customerId");
  //   Database db = await instance.database;
  //   var result = await db.rawQuery(
  //       "SELECT * FROM orderBagTable WHERE os='$os' AND customerid='$customerId'");
  //   print("result---$result");
  //   if (result != null && result.isNotEmpty) {
  //     print("if");
  //     res = await db.rawQuery(
  //         "SELECT MAX(cartrowno) max_val FROM orderBagTable WHERE os='$os' AND customerid='$customerId'");
  //     max = res[0]["max_val"] + 1;
  //     print(
  //         "SELECT MAX(cartrowno) max_val FROM orderBagTable WHERE os='$os' AND customerid='$customerId'");
  //   } else {
  //     print("else");
  //     max = 1;
  //   }
  //   print(res);
  //   return max;
  //   // Database db = await instance.database;
  //   // var res=db.rawQuery("SELECT (IFNULL(MAX($field),0) +1) FROM $table WHERE os='LF'");
  //   // print(res);
  //   // return res;
  // }

  ////////////////////////////sum of the product /////////////////////////////////
  gettotalSum(String os, String customerId) async {
    // double sum=0.0;
    String sum;
    Database db = await instance.database;
    var result = await db.rawQuery(
        "SELECT * FROM orderBagTable WHERE os='$os' AND customerid='$customerId'");

    if (result != null && result.isNotEmpty) {
      List<Map<String, dynamic>> res = await db.rawQuery(
          "SELECT SUM(totalamount) s FROM orderBagTable WHERE os='$os' AND customerid='$customerId'");
      sum = res[0]["s"].toString();
      print("sum from db----$sum");
    } else {
      sum = "0.0";
    }

    return sum;
  }

  /////////////////////sales product sum ////////////////////
  getsaletotalSum(String os, String customerId) async {
    // double sum=0.0;
    String net_amount;
    String gross;
    String count;
    String taxval;
    String discount;
    String cesamount;
    Database db = await instance.database;
    var result = await db.rawQuery(
        "SELECT * FROM salesBagTable WHERE os='$os' AND customerid='$customerId'");

    if (result != null && result.isNotEmpty) {
      List<Map<String, dynamic>> res = await db.rawQuery(
          "SELECT SUM(totalamount) gr, SUM(net_amt) s, COUNT(cartrowno) c, SUM(tax) t, SUM(discount) d, SUM(ces_per) ces FROM salesBagTable WHERE os='$os' AND customerid='$customerId'");
      print("result sale db........$res");
      net_amount = res[0]["s"].toStringAsFixed(2);
      gross = res[0]["gr"].toStringAsFixed(2);
      count = res[0]["c"].toString();
      taxval = res[0]["t"].toStringAsFixed(2);
      discount = res[0]["d"].toStringAsFixed(2);
      cesamount = res[0]["ces"].toStringAsFixed(2);
      print(
          "gross..netamount..taxval..dis..ces ......$gross...$net_amt....$taxval..$discount..$cesamount");
    } else {
      net_amount = "0.00";
      count = "0.00";
      taxval = "0.00";
      discount = "0.00";
      cesamount = "0.00";
      gross = "0.0";
    }
    return [net_amount, count, taxval, discount, cesamount, gross];
  }

  ////////////// delete//////////////////////////////////////
  deleteFromOrderbagTable(int cartrowno, String customerId) async {
    var res1;
    Database db = await instance.database;
    print("DELETE FROM 'orderBagTable' WHERE cartrowno = $cartrowno");
    var res = await db.rawDelete(
        "DELETE FROM 'orderBagTable' WHERE cartrowno = $cartrowno AND customerid='$customerId'");
    if (res == 1) {
      res1 = await db.rawQuery(
          "SELECT * FROM orderBagTable WHERE customerid='$customerId'");
      print(res1);
    }
    return res1;
  }

///////////////////////////////////////////////////////////////////////
  ////////////// delete from sales bag table/ /////////////////////////////////////
  deleteFromSalesagTable(int cartrowno, String customerId) async {
    var res1;
    Database db = await instance.database;
    print("DELETE FROM 'salesBagTable' WHERE cartrowno = $cartrowno");
    var res = await db.rawDelete(
        "DELETE FROM 'salesBagTable' WHERE cartrowno = $cartrowno AND customerid='$customerId'");
    if (res == 1) {
      res1 = await db.rawQuery(
          "SELECT * FROM salesBagTable WHERE customerid='$customerId'");
      print(res1);
    }
    return res1;
  }

  /////////////////////////update qty///////////////////////////////////
  updateQtyOrderBagTable(
      String qty, int cartrowno, String customerId, String rate) async {
    Database db = await instance.database;
    var res1;
    double rate1 = double.parse(rate);
    int updatedQty = int.parse(qty);
    double amount = (rate1 * updatedQty);
    print("amoiunt---$cartrowno-$customerId---$rate--$amount");
    print("updatedqty----$updatedQty");
    // gettotalSum(String os, String customerId);
    var res = await db.rawUpdate(
        'UPDATE orderBagTable SET qty=$updatedQty , totalamount="${amount}" , rate="${rate}" WHERE cartrowno=$cartrowno AND customerid="$customerId"');
    print("response-------$res");

    if (res == 1) {
      res1 = await db.rawQuery(
          "SELECT * FROM orderBagTable WHERE customerid='$customerId'");
      print(res1);
    }

    return res1;
  }

  ////////////////////////////////////////////////
  /////////////////////////update qty///////////////////////////////////
  updateQtySalesBagTable(
      String qty, int cartrowno, String customerId, String rate) async {
    Database db = await instance.database;
    var res1;
    double rate1 = double.parse(rate);
    double updatedQty = double.parse(qty);
    double amount = (rate1 * updatedQty);
    print("amoiunt---$cartrowno-$customerId---$rate--$amount");
    print("updatedqty----$updatedQty");
    // gettotalSum(String os, String customerId);
    var res = await db.rawUpdate(
        'UPDATE salesBagTable SET qty=$updatedQty , totalamount="${amount}" , rate="${rate}" WHERE cartrowno=$cartrowno AND customerid="$customerId"');
    print("response-------$res");

    if (res == 1) {
      res1 = await db.rawQuery(
          "SELECT * FROM salesBagTable WHERE customerid='$customerId'");
      print(res1);
    }

    return res1;
  }

  ///////////////////////////////////////////////////////////////////
  // updateRemarks(String custmerId, String remark) async {
  //   Database db = await instance.database;
  //   print("remark.....${custmerId}${remark}");

  //   var res1;
  //   var res;
  //   if (res !=null) {
  //     res = await db.rawUpdate(
  //         'UPDATE remarksTable SET rem_text="$remark" WHERE  rem_cusid="$custmerId"');

  //     print("response-------$res");

  //     res1 = await db
  //         .rawQuery("SELECT * FROM remarksTable WHERE customerid='$custmerId'");
  //     print(res1);
  //   }
  //   return res1;
  // }

  /////////////////////////////////////////////////////////////////////
  deleteFromTableCommonQuery(String table, String? condition) async {
    print("table--condition -$table---$condition");
    Database db = await instance.database;
    if (condition == null || condition.isEmpty || condition == "") {
      print("no condition");
      await db.delete('$table');
    } else {
      print("condition");

      await db.rawDelete('DELETE FROM "$table" WHERE $condition');
    }
  }

//////////////////////////////selectCommonQuery///////////////////
  // selectCommonquery(String table, String? condition) async {
  //   List<Map<String, dynamic>> result;
  //   Database db = await instance.database;
  //   print("----condition---table -------${condition}----${table}");
  //   if (condition == null || condition.isEmpty) {
  //     result = await db.rawQuery("SELECT * FROM '$table'");
  //   } else {
  //     result = await db.rawQuery("SELECT * FROM '$table' WHERE $condition");
  //   }
  //   print("result----$result");
  //   return result;
  // }
//////////////////////////////select left join/////////////////////
  selectfromOrderbagTable(String customerId) async {
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    result = await db.rawQuery(
        "SELECT productDetailsTable.* , orderBagTable.cartrowno FROM 'productDetailsTable' LEFT JOIN 'orderBagTable' ON productDetailsTable.code = orderBagTable.code AND orderBagTable.customerid='$customerId' ORDER BY cartrowno DESC");
    print("leftjoin result----$result");
    print("length---${result.length}");
    return result;
  }

  selectfromsalebagTable(String customerId) async {
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    result = await db.rawQuery(
        "SELECT productDetailsTable.* , salesBagTable.cartrowno FROM 'productDetailsTable' LEFT JOIN 'salesBagTable' ON productDetailsTable.code = salesBagTable.code AND salesBagTable.customerid='$customerId' ORDER BY cartrowno DESC");
    print("leftjoin result----$result");
    print("length---${result.length}");
    return result;
  }

  selectfrombagandfilterList(String customerId, String comId) async {
    print("comid---$comId");
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    result = await db.rawQuery(
        "SELECT productDetailsTable.* , orderBagTable.cartrowno FROM 'productDetailsTable' LEFT JOIN 'orderBagTable' ON productDetailsTable.code = orderBagTable.code AND orderBagTable.customerid='$customerId' where  productDetailsTable.companyId='${comId}' ORDER BY cartrowno DESC");
    print("leftjoin result- company---$result");
    print("length---${result.length}");
    return result;
  }

//////////////////////////////////////////////////////////////////////////
  selectfromsalesbagandfilterList(String customerId, String comId) async {
    print("comid---$comId");
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    result = await db.rawQuery(
        "SELECT productDetailsTable.* , salesBagTable.cartrowno FROM 'productDetailsTable' LEFT JOIN 'salesBagTable' ON productDetailsTable.code = salesBagTable.code AND salesBagTable.customerid='$customerId' where  productDetailsTable.companyId='${comId}' ORDER BY cartrowno DESC");
    print("leftjoin result- company---$result");
    print("length---${result.length}");
    return result;
  }

//////////////count from table/////////////////////////////////////////
  countCommonQuery(String table, String? condition) async {
    String count = "0";
    Database db = await instance.database;
    final result =
        await db.rawQuery("SELECT COUNT(*) c FROM '$table' WHERE $condition");
    count = result[0]["c"].toString();
    print("result---count---$result");
    return count;
  }

//////////////////////////////////////////////////////////////////
  getMaxCommonQuery(String table, String field, String? condition) async {
    var res;
    int max;
    var result;
    Database db = await instance.database;
    print("condition---${condition}");
    if (condition == " ") {
      result = await db.rawQuery("SELECT * FROM '$table'");
    } else {
      result = await db.rawQuery("SELECT * FROM '$table' WHERE $condition");
    }
    // print("result max---$result");
    if (result != null && result.isNotEmpty) {
      print("if");

      if (condition == " ") {
        res = await db.rawQuery("SELECT MAX($field) max_val FROM '$table'");
      } else {
        res = await db.rawQuery(
            "SELECT MAX($field) max_val FROM '$table' WHERE $condition");
      }

      print('res[0]["max_val"] ----${res[0]["max_val"]}');
      // int convertedMax = int.parse(res[0]["max_val"]);
      max = res[0]["max_val"] + 1;
      print("max value.........$max");
      print("SELECT MAX($field) max_val FROM '$table' WHERE $condition");
    } else {
      print("else");
      max = 1;
    }
    print("max common-----$res");

    print(res);
    return max;
  }

  /////////////////////search////////////////////////////////
  searchItem(String table, String key, String field1, String? field2,
      String? field3, String condition) async {
    Database db = await instance.database;
    print("table key field---${table},${key},${field1}---$condition");

    var query =
        "SELECT * FROM '$table'  where ($field1  || $field2 || $field3  LIKE  '%$key%') $condition";
    var result = await db.rawQuery(query);

    print("querty0---$query");
    // List<Map<String, dynamic>> result = await db.query(
    //   '$table',
    //   where: '$field1 LIKE ? OR $field2 LIKE ? OR $field3 LIKE ? ',
    //   whereArgs: [
    //     '$key%',
    //     '$key%',
    //     '$key%',
    //   ],
    // );

    print("search result----$result");
    return result;
  }

///////////////////search account heads/////////////////////
  accountHeadsSearch(String key) async {
    print("key--hai---$key");
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      'accountHeadsTable',
      where: 'hname LIKE ?',
      whereArgs: [
        '$key%',
      ],
    );
    print("search result-----$result");
    return result;
  }
////////////////////////left join///////////////////////////

  Future<dynamic> todayOrder(String date, String condition) async {
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    var query =
        'select accountHeadsTable.hname as cus_name,orderMasterTable.order_id, orderMasterTable.os  || orderMasterTable.order_id as Order_Num,orderMasterTable.customerid Cus_id,orderMasterTable.orderdate Date, count(orderDetailTable.row_num) count, orderMasterTable.total_price  from orderMasterTable inner join orderDetailTable on orderMasterTable.order_id=orderDetailTable.order_id inner join accountHeadsTable on accountHeadsTable.ac_code= orderMasterTable.customerid where orderMasterTable.orderdate="${date}"  $condition group by orderMasterTable.order_id';
    print("query---$query");

    result = await db.rawQuery(query);
    if (result.length > 0) {
      print("inner result------$result");
      return result;
    } else {
      return null;
    }
  }

  ////////////////////////////////////////////////////////////////
  Future<dynamic> todayCollection(String date, String condition) async {
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    print("jhsjh----$condition");
    result = await db.rawQuery(
        'select accountHeadsTable.hname as cus_name,collectionTable.rec_cusid,collectionTable.rec_cusid,collectionTable.rec_date,collectionTable.rec_amount,collectionTable.rec_note from collectionTable inner join accountHeadsTable on accountHeadsTable.ac_code = collectionTable.rec_cusid where collectionTable.rec_date="${date}" $condition and collectionTable.rec_cancel=0  order by collectionTable.id DESC');
    // if (result.length > 0) {
    print("inner collc result------$result");
    return result;
    // } else {
    //   return null;
    // }
  }

  //////////////////////////////////////////////////////////////////
  Future<dynamic> todaySales(String date, String condition) async {
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    var query =
        'select accountHeadsTable.hname as cus_name,salesMasterTable.sales_id sales_id, salesMasterTable.os  || salesMasterTable.sales_id as sale_Num,salesMasterTable.customer_id Cus_id,salesMasterTable.salesdate Date, count(salesDetailTable.row_num) count, salesMasterTable.total_price  from salesMasterTable inner join salesDetailTable on salesMasterTable.sales_id=salesDetailTable.sales_id inner join accountHeadsTable on accountHeadsTable.ac_code= salesMasterTable.customer_id where salesMasterTable.salesdate="${date}"  $condition group by salesMasterTable.sales_id';
    print("query---$query");

    result = await db.rawQuery(query);
    if (result.length > 0) {
      print("inner result------$result");
      return result;
    } else {
      return null;
    }
  }
  //////////////select total amount form ordermasterTable ////////////

  selectCommonQuery(String table, String? condition) async {
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    if (condition == null) {
      result = await db.rawQuery("SELECT * FROM '$table'");
    } else {
      result = await db
          .rawQuery("SELECT code,item,qty,rate FROM '$table' WHERE $condition");
    }

    print("naaknsdJK-----$result");
    return result;
  }

///////////////////////////////////////////////////////////
  selectAllcommon(String table, String? condition) async {
    print("haiiiii");
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    var query = "SELECT * FROM '$table' WHERE $condition";
    print("company query----$query");
    if (condition == null || condition.isEmpty) {
      result = await db.rawQuery("SELECT * FROM '$table'");
    } else {
      result = await db.rawQuery(query);
    }

    print("result menu common----$result");
    return result;
  }

  //////////////////////////////////////////////////////////
  executeGeneralQuery(String query) async {
    print("haiiiii");
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    print("general query---$query");
    result = await db.rawQuery(query);

    print("result general----$result");
    return result;
  }

//////////////////////////inner join///////////////////////
  getDataFromMasterAndDetail(int order_id) async {
    List<Map<String, dynamic>> result;
    List<Map<String, dynamic>> result2;
    Database db = await instance.database;
    result = await db.rawQuery(
        'select id,order_id,orderdate,customerid,userid,areaid from orderMasterTable');
    result2 = await db.rawQuery('select * from orderDetailTable');

    // result = await db.rawQuery(
    //     'select orderMasterTable.id as id, orderMasterTable.os  || orderMasterTable.order_id as ser,orderMasterTable.order_id ,orderMasterTable.customerid Cus_id, orderMasterTable.orderdatetime Date, orderMasterTable.userid as staff_id,orderMasterTable.areaid as area_id, orderDetailTable.code, orderDetailTable.qty, orderDetailTable.rate from orderMasterTable inner join  orderDetailTable on orderMasterTable.order_id = orderDetailTable.order_id  where  orderMasterTable.order_id =${order_id} order by  orderMasterTable.order_id,orderDetailTable.row_num ');
    if (result.length > 0) {
      print("inner join result------$result");
      return {result, result2};
    } else {
      return null;
    }
  }

  /////////////////////////////////////////////
  getDataFromMasterAndDetails(int order_id) async {
    List<Map<String, dynamic>> result;
    Database db = await instance.database;

    result = await db.rawQuery('select * from orderMasterTable');
    if (result.length > 0) {
      // print("inner join result------$result");
      return result;
    } else {
      return null;
    }
  }

///////////////////////////////////////////////////////////
  selectMasterTable() async {
    Database db = await instance.database;
    var result;
    var res = await db.rawQuery("SELECT  * FROM  orderMasterTable");
    print("hhs----$res");
    if (res.length > 0) {
      result = await db.rawQuery(
          "SELECT orderMasterTable.id as id, orderMasterTable.os  || orderMasterTable.order_id as ser,orderMasterTable.order_id as oid,orderMasterTable.customerid cuid, orderMasterTable.orderdate  || ' '  ||orderMasterTable.ordertime odate, orderMasterTable.userid as sid,orderMasterTable.areaid as aid  FROM orderMasterTable");
    }
    print("result upload----$result");
    return result;
  }

  ////////////////////////////////////////////////////////
  selectReturnMasterTable() async {
    Database db = await instance.database;

    var result = await db.rawQuery(
        "SELECT returnMasterTable.id as id, returnMasterTable.os  || returnMasterTable.return_id as ser,returnMasterTable.return_id as srid,returnMasterTable.customerid cuid,returnMasterTable.return_date  || ' '  ||returnMasterTable.return_time return_date, returnMasterTable.userid as sid,returnMasterTable.areaid as aid  FROM returnMasterTable");
    return result;
  }

////////////////////upload remark data////////////////////////
  uploadRemark() async {
    Database db = await instance.database;
    var result = await db.rawQuery(
        "SELECT remarksTable.id as rid, remarksTable.rem_row_num as phid, remarksTable.rem_cusid as cid,remarksTable.rem_date as rdate,remarksTable.rem_text as rtext,remarksTable.rem_staffid as sid,remarksTable.rem_cancel as cflag,remarksTable.rem_status as dflag,remarksTable.rem_date || ' '  || remarksTable.rem_time as edate FROM remarksTable");
    print("remark select result.........$result");
    return result;
  }

  ////////////////////upload collection data////////////////////////
  uploadCollections() async {
    print("collectionnn");
    Database db = await instance.database;
    var result = await db.rawQuery(
        // "SELECT * FROM collectionTable");
        "SELECT collectionTable.id as colid, collectionTable.rec_row_num as phid, collectionTable.rec_cusid as cid,collectionTable.rec_date as cdate,collectionTable.rec_series || collectionTable.rec_row_num as cseries,collectionTable.rec_mode as cmode,collectionTable.rec_amount as camt,collectionTable.rec_disc as cdisc,collectionTable.rec_note as cremark, collectionTable.rec_staffid as sid,collectionTable.rec_cancel as cflag,collectionTable.rec_cancel as dflag,collectionTable.rec_date || ' ' || collectionTable.rec_time as edate FROM collectionTable");
    print("collectionTable select result.........$result");
    return result;
  }

////////////////////////////////////////////
  selectDetailTable(int order_id) async {
    Database db = await instance.database;

    var result = await db.rawQuery(
        "SELECT orderDetailTable.code as code,orderDetailTable.item as item, orderDetailTable.qty as qty, orderDetailTable.rate as rate from orderDetailTable  where  orderDetailTable.order_id=${order_id}");
    return result;
  }

  selectReturnDetailTable(int return_id) async {
    Database db = await instance.database;

    var result = await db.rawQuery(
        "SELECT returnDetailTable.code as code,returnDetailTable.item as item, returnDetailTable.qty as qty, returnDetailTable.rate as rate from returnDetailTable  where  returnDetailTable.return_id=${return_id}");
    return result;
  }

  ///////////////////////////////////////////////////////
  upadteCommonQuery(String table, String fields, String condition) async {
    Database db = await instance.database;
    var res = await db.rawUpdate('UPDATE $table SET $fields WHERE $condition ');
    print("UPDATE $table SET $fields WHERE $condition");
    print("response-------$res");
    return res;
  }

  ////////////////// today order total //////////////////////////////////

  sumCommonQuery(String field, String table, String condition) async {
    String sum;
    Database db = await instance.database;
    var result = await db
        .rawQuery("SELECT sum($field) as S FROM $table WHERE $condition");
    print("result sum----$result");
    sum = result[0]["S"].toString();

    print("sum--$sum");
    return sum;
  }

///////////////////////////////////////////////////////
  getReportDataFromOrderDetails(String userId, String date,
      BuildContext context, String likeCondition) async {
    List<Map<String, dynamic>> result;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? areaidfromStaff = prefs.getString("areaidfromStaff");
    print("aredhgsh----$areaidfromStaff");
    String condition = " ";
    if (areaidfromStaff != null || areaidfromStaff!.isNotEmpty) {
      if (areaidfromStaff == "") {
        if (likeCondition == "") {
          condition = "";
        } else {
          condition = " where $likeCondition";
        }
      } else {
        if (likeCondition == "") {
          condition = " where A.area_id in ($areaidfromStaff) ";
        } else {
          condition =
              " where A.area_id in ($areaidfromStaff) and $likeCondition";
        }
      }
    }

    // String? gen_area =
    //     Provider.of<Controller>(context, listen: false).areaidFrompopup;
    // if (gen_area != null) {
    //   gen_condition1 = " and O.areaid=$gen_area";
    //   gen_condition2= " and R.areaid=$gen_area ";
    // } else {
    //   gen_condition = " ";
    // }
    Database db = await instance.database;
    String query2 = "";
    String query1 = "";
    query2 = query2 +
        " select A.ac_code  as cusid, A.hname as name," +
        " A.ac_ad1 as ad1,A.mo as mob ," +
        " A.ba as bln, Y.ord  as order_value," +
        " Y.remark as remark_count , Y.col as collection_sum" +
        " from accountHeadsTable A " +
        " left join (select cid,sum(Ord) as ord," +
        " sum(remark) as remark ,sum(col) as col from (" +
        " select O.customerid cid, sum(O.total_price) Ord," +
        " 0 remark,0 col from orderMasterTable O" +
        " where O.userid='$userId' and O.orderdate = '$date' group by O.customerid" +
        " union all " +
        " select R.rem_cusid cid, 0 Ord, count(R.rem_cusid) remark ," +
        " 0 col from remarksTable R where R.rem_staffid='$userId' and R.rem_date  = '$date' and R.rem_cancel=0 " +
        " group by R.rem_cusid" +
        " union all" +
        " select C.rec_cusid cid, 0 Ord , 0 remark," +
        " sum(C.rec_amount) col" +
        " from collectionTable C where C.rec_staffid='$userId' and C.rec_date  = '$date' and C.rec_cancel=0 " +
        " group by C.rec_cusid) x group by cid ) Y on Y.cid=A.ac_code" +
        " $condition " +
        " order by Y.ord+ Y.remark+ Y.col desc ;";
    print("query2----$query2");
    result = await db.rawQuery(query2);

    print("result.length-${result.length}");
    return result;
    // if (result.length > 0) {
    //   print("result-order-----$result");
    //   return result;
    // } else {
    //   return [];
    // }
  }

//////////////////////shops not visited///////////////////////
  dashboardSummery(String userId, String date, String aid) async {
    Database db = await instance.database;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? areaidfromStaff = prefs.getString("areaidfromStaff");
    String condition = " ";
    int? area;
    print("userrr---$userId");
    if (aid != "") {
      area = int.parse(aid);
    } else {
      area = 0;
    }
    print("kjdkzjk--areaidfromStaff--$area--$areaidfromStaff");

    if (areaidfromStaff != "") {
      if (area == 0) {
        condition = " where A.area_id in ($areaidfromStaff) ";
      } else {
        condition = " where A.area_id in ($area) ";
      }
    } else {
      if (area == 0) {
        condition = "";
      } else {
        condition = " where A.area_id in ($area) ";
      }
    }
    List<Map<String, dynamic>> result;
    String query = "";
    query = query +
        "Select " +
        " count(Distinct X.cid) cusCount," +
        " sum(X.ordCnt) ordCnt,sum(X.ordVal) ordVal,sum(X.rmCnt) rmCnt," +
        " sum(X.colCnt) colCnt,sum(X.colVal) colVal, sum(X.saleCnt) saleCnt ,sum(X.saleVal) saleVal,sum(X.retCnt) retCnt ,sum(X.retVal) retVal" +
        " from accountHeadsTable A  " +
        " inner join (" +
        " Select O.customerid cid , Count(O.id) ordCnt,Sum(O.total_price) ordVal,0 rmCnt,0 colCnt,0 colVal,0 saleCnt,0 saleVal,0 retCnt,0 retVal" +
        " From orderMasterTable O where O.orderdate='$date' and  O.userid='$userId'" +
        " group by O.customerid" +
        " union all" +
        " Select R.rem_cusid cid , 0 ordCnt,0 ordVal,Count(R.id) rmCnt,0 colCnt,0 colVal,0 saleCnt,0 saleVal,0 retCnt,0 retVal" +
        " From remarksTable R where R.rem_date='$date' and R.rem_staffid='$userId' and R.rem_cancel=0" +
        " group by R.rem_cusid" +
        " union all" +
        " Select C.rec_cusid cid , 0 ordCnt,0 ordVal,0 rmCnt,Count(C.id) colCnt,Sum(C.rec_amount) colVal,0 saleCnt,0 saleVal,0 retCnt,0 retVal" +
        " From collectionTable C  where C.rec_date='$date' and C.rec_staffid='$userId' and C.rec_cancel=0" +
        " group by C.rec_cusid" +
        " union all" +
        " Select RT.customerid cid , 0 ordCnt,0 ordVal,0 rmCnt,0 colCnt,0 colVal,0 saleCnt,0 saleVal,Count(RT.id) retCnt,Sum(RT.total_price) retVal" +
        " From returnMasterTable RT   where RT.return_date='$date' and RT.userid='$userId'" +
        " group by RT.customerid" +
        " union all" +
        " Select S.customer_id cid , 0 ordCnt,0 ordVal,0 rmCnt,0 colCnt,0 colVal,Count(S.id) saleCnt,Sum(S.total_price) saleVal,0 retCnt,0 retVal" +
        " From salesMasterTable S   where S.salesdate='$date' and S.staff_id='$userId'" +
        " group by S.customer_id" +
        " ) X ON X.cid=A.ac_code" +
        " $condition;";

    result = await db.rawQuery(query);
    // print("dashboard sum-$condition");
    print("result--dashboard----$result");
    return result;
  }

//////////////////////////////////////////////////////////////
  getShopsVisited(String userId, String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? areaidfromStaff = prefs.getString("areaidfromStaff");
    String condition = " ";
    print("userId kjdfkljfkml---$areaidfromStaff");
    List<Map<String, dynamic>> result;
    if (areaidfromStaff != null) {
      condition = " and area_id in ($areaidfromStaff)";
    }

    int count;
    Database db = await instance.database;
    String query = "";
    query = query +
        "select count(distinct cid) cnt from accountHeadsTable A  inner join  (" +
        " select O.customerid cid from orderMasterTable O " +
        "where O.userid='$userId' and orderdate='$date' " +
        " group by O.customerid " +
        "union all " +
        " select R.rem_cusid cid " +
        "from remarksTable R " +
        " where R.rem_staffid='$userId' and rem_date='$date' and R.rem_cancel=0 " +
        " group by R.rem_cusid " +
        "union all " +
        "select C.rec_cusid cid   " +
        " from collectionTable C " +
        "where C.rec_staffid='$userId' and rec_date='$date' and C.rec_cancel=0 " +
        "group by C.rec_cusid " +
        " UNION ALL " +
        "select RT.customerid " +
        "from returnMasterTable RT " +
        "where RT.userid='$userId' and return_date='$date' " +
        "group by RT.customerid) x on A.ac_code = x.cid $condition;";
    print(query);
    result = await db.rawQuery(query);
    print("result.length-${result.length}");
    if (result.length > 0) {
      count = result[0]["cnt"];
      print("result shop visited-----$result");
      return count;
    } else {
      return null;
    }
  }

//////////////////////select  collection///////////////////////
  selectAllcommonwithdesc(String table, String? condition) async {
    print("haiiiii");
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    if (condition == null || condition.isEmpty) {
      result = await db.rawQuery("SELECT * FROM '$table' ORDER BY id DESC");
    } else {
      result = await db
          .rawQuery("SELECT * FROM '$table' WHERE $condition ORDER BY id DESC");
    }
    print("result menu common----$result");
    return result;
  }
  ////////////////////////DELETE TABLE ////////////////////////////////////

  // getReportRemarkOrderDetails() async {
  //   List<Map<String, dynamic>> result;

  //   Database db = await instance.database;
  //   result = await db.rawQuery(
  //       'select A.ac_code  as cusid, A.hname as name,A.ac_ad1 as ad1,A.mo as mob , A.ba as bln, Y.ord  as order_value, Y.remark as remark_count , Y.col as collection_sum from accountHeadsTable A  left join (select cid,sum(Ord) as ord, sum(remark) as remark ,sum(col) as col from (select O.customerid cid, sum(O.total_price) Ord,0 remark,0 col from orderMasterTable O group by O.customerid union all select R.rem_cusid cid, 0 Ord, count(R.rem_cusid) remark , 0 col from remarksTable R group by R.rem_cusid union all select C.rec_cusid cid, 0 Ord , 0 remark, sum(C.rec_amount) col  from collectionTable C group by C.rec_cusid) x group by cid ) Y on Y.cid=A.ac_code order by Y.ord+ Y.remark+ Y.col+ Y.remark_count desc');
  //   if (result.length > 0) {
  //     print("result-order-----$result");
  //     return result;
  //   } else {
  //     return null;
  //   }
  // }

  // getReportDataFromOrderDetails() async {
  //   List<Map<String, dynamic>> result;
  //   Database db = await instance.database;

  //   result = await db.rawQuery(
  //       'select orderMasterTable.customerid as cusid, orderMasterTable.total_price  as total,accountHeadsTable.hname as name,accountHeadsTable.ac_ad1 as ad1,accountHeadsTable.mo as mob , accountHeadsTable.ba as bln from orderMasterTable inner join accountHeadsTable on orderMasterTable.customerid=accountHeadsTable.code');
  //   if (result.length > 0) {
  //     // print("result-order-----$result");
  //     return result;
  //   } else {
  //     return null;
  //   }
  // }

  // getReportDataFromRemarksTable() async {
  //   List<Map<String, dynamic>> result;
  //   Database db = await instance.database;

  //   result = await db.rawQuery(
  //       'select remarksTable.rem_cusid as cusid, accountHeadsTable.hname as name,accountHeadsTable.ac_ad1 as ad1, accountHeadsTable.ba as bln from remarksTable inner join accountHeadsTable on remarksTable.rem_cusid=accountHeadsTable.code');
  //   if (result.length > 0) {
  //     // print("result---remrk---$result");
  //     return result;
  //   } else {
  //     return null;
  //   }
  // }

  // getReportDataFromCollectionTable() async {
  //   List<Map<String, dynamic>> result;
  //   Database db = await instance.database;

  //   result = await db.rawQuery(
  //       'select collectionTable.rec_cusid as cusid, collectionTable.rec_mode as mode ,accountHeadsTable.hname as name,accountHeadsTable.ac_ad1 as ad1, accountHeadsTable.ba as bln from collectionTable inner join accountHeadsTable on collectionTable.rec_cusid=accountHeadsTable.code');
  //   if (result.length > 0) {
  //     // print("result---cooll---$result");
  //     return result;
  //   } else {
  //     return null;
  //   }
  // }

////////////////////////////////////////////////////
  // selectFrommasterQuery(String table, String? condition) async {
  //   List<Map<String, dynamic>> result;
  //   Database db = await instance.database;
  //   if (condition == null) {
  //     result = await db.rawQuery("SELECT * FROM '$table'");
  //   } else {
  //     result = await db.rawQuery(
  //         "SELECT id, os || order_id as ser, order_id as oid, customerid as cuid, orderdatetime as odate, userid as staff_id, areaid as aid FROM '$table' WHERE $condition");
  //   }

  //   // print("naaknsdJK-----$result");
  //   return result;
  // }

  // selectFromDetailTable(String table, String? condition) async {
  //   List<Map<String, dynamic>> result;
  //   Database db = await instance.database;
  //   if (condition == null) {
  //     result = await db.rawQuery("SELECT * FROM '$table'");
  //   } else {
  //     result = await db
  //         .rawQuery("SELECT code , qty, rate FROM '$table' WHERE $condition");
  //   }

  //   // print("naaknsdJK-----$result");
  //   return result;
  // }

  uploadCustomer() async {
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    String query = "";
    query = query +
        " select accountHeadsTable.ac_code as hcd," +
        " accountHeadsTable.hname as nme,accountHeadsTable.ac_ad1 as ad1," +
        " accountHeadsTable.ac_ad2 as ad2,accountHeadsTable.ac_ad3 as ad3," +
        " accountHeadsTable.area_id as aid,accountHeadsTable.gtype as gtype," +
        " accountHeadsTable.phn as ph,accountHeadsTable.mo as mo " +
        " from accountHeadsTable inner join customerTable " +
        " on customerTable.ac_code=accountHeadsTable.ac_code";

    print("query---$query");
    result = await db.rawQuery(query);
    if (result.length > 0) {
      print("inner result------$result");
      return result;
    } else {
      return null;
    }
  }
}

//////////////////////////////////////////////////////////////
