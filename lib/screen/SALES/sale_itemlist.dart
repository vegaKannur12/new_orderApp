import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/components/customSearchTile.dart';
import 'package:orderapp/components/customSnackbar.dart';
import 'package:orderapp/components/showMoadal.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:orderapp/screen/ORDER/8_cartList.dart';
import 'package:orderapp/screen/ORDER/filterProduct.dart';
import 'package:orderapp/screen/SALES/saleFilteredProductList.dart';
import 'package:orderapp/screen/SALES/sale_cart.dart';

import 'package:provider/provider.dart';

class SalesItem extends StatefulWidget {
  // List<Map<String,dynamic>>  products;
  String customerId;
  String os;
  String areaId;
  String areaName;
  String type;
  bool _isLoading = false;

  SalesItem({
    required this.customerId,
    required this.areaId,
    required this.os,
    required this.areaName,
    required this.type,
  });

  @override
  State<SalesItem> createState() => _SalesItemState();
}

class _SalesItemState extends State<SalesItem> {
  String rate1 = "1";
  TextEditingController searchcontroll = TextEditingController();
  ShowModal showModal = ShowModal();
  List<Map<String, dynamic>> products = [];
  // List<Map<String, dynamic>> p = [
  //   {"a": "jdszn","id":"hj"},
  //   {"a": "njxd","id":"ht"}
  // ];

  // int? selected;
  SearchTile search = SearchTile();
  // RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);
  DateTime now = DateTime.now();
  // CustomSnackbar snackbar = CustomSnackbar();
  List<String> s = [];
  String? date;
  bool loading = true;
  bool loading1 = false;
  CustomSnackbar snackbar = CustomSnackbar();
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    searchcontroll.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("customer id........${widget.customerId}");
    products = Provider.of<Controller>(context, listen: false).productName;
    print("products---${products}");

    Provider.of<Controller>(context, listen: false).getOrderno();
    date = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    s = date!.split(" ");
    Provider.of<Controller>(context, listen: false)
        .getSaleProductList(widget.customerId);
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Opacity(
      opacity: 1.0,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Provider.of<Controller>(context, listen: false).filterCompany =
                  false;
              Provider.of<Controller>(context, listen: false)
                  .filteredProductList
                  .clear();
              Provider.of<Controller>(context, listen: false).searchkey = "";
              Provider.of<Controller>(context, listen: false).newList =
                  products;
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
          backgroundColor: P_Settings.salewaveColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () async {
                if (widget.customerId == null || widget.customerId.isEmpty) {
                } else {
                  FocusManager.instance.primaryFocus?.unfocus();

                  Provider.of<Controller>(context, listen: false)
                      .getSaleBagDetails(widget.customerId, widget.os);

                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false, // set to false
                      pageBuilder: (_, __, ___) => SaleCart(
                        areaId: widget.areaId,
                        custmerId: widget.customerId,
                        os: widget.os,
                        areaname: widget.areaName,
                      ),
                    ),
                  );
                }
              },
            ),
            Consumer<Controller>(
              builder: (context, _value, child) {
                return PopupMenuButton<String>(
                  onSelected: (value) {
                    //  Provider.of<Controller>(context, listen: false)
                    //     .filteredeValue = value;

                    // if (value == "0") {
                    //   setState(() {
                    //     Provider.of<Controller>(context, listen: false)
                    //         .filterCompany = false;
                    //   });

                    //   Provider.of<Controller>(context, listen: false)
                    //       .filteredProductList
                    //       .clear();
                    //   Provider.of<Controller>(context, listen: false)
                    //       .getProductList(widget.customerId);
                    // } else {
                    //   print("value---$value");
                    //   Provider.of<Controller>(context, listen: false)
                    //         .filterCompany = true;
                    //   Provider.of<Controller>(context, listen: false)
                    //       .filterwithCompany(widget.customerId, value,"sale order");
                    // }///////////////

                    Provider.of<Controller>(context, listen: false)
                        .salefilteredeValue = value;
                    if (value == "0") {
                      setState(() {
                        Provider.of<Controller>(context, listen: false)
                            .salefilterCompany = false;
                      });

                      Provider.of<Controller>(context, listen: false)
                          .salefilteredProductList
                          .clear();
                      Provider.of<Controller>(context, listen: false)
                          .getSaleProductList(widget.customerId);
                    } else {
                      print("value---$value");
                      Provider.of<Controller>(context, listen: false)
                          .salefilterCompany = true;
                      Provider.of<Controller>(context, listen: false)
                          .filterwithCompany(widget.customerId, value, "sales");
                    }
                  },
                  itemBuilder: (context) => _value.productcompanyList
                      .map((item) => PopupMenuItem<String>(
                            value: item["comid"],
                            child: Text(
                              item["comanme"],
                            ),
                          ))
                      .toList(),
                );
              },
            ),
          ],
        ),
        body: Consumer<Controller>(
          builder: (context, value, child) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Provider.of<Controller>(context, listen: false)
                        .getSaleBagDetails(widget.customerId, widget.os);
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false, // set to false
                        pageBuilder: (_, __, ___) => SaleCart(
                          areaId: widget.areaId,
                          custmerId: widget.customerId,
                          os: widget.os,
                          areaname: widget.areaName,
                        ),
                      ),
                    );
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: size.height * 0.045,
                      width: size.width * 0.2,
                      child: value.isLoading
                          ? Center(
                              child: SpinKitThreeBounce(
                              color: P_Settings.salewaveColor,
                              size: 15,
                            ))
                          : Text(
                              "${value.count}",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                      decoration: BoxDecoration(
                        color: P_Settings.saleroundedButtonColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      )),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: size.width * 0.95,
                    height: size.height * 0.09,
                    child: TextField(
                      controller: searchcontroll,
                      onChanged: (value) {
                        Provider.of<Controller>(context, listen: false)
                            .setisVisible(true);
                        // Provider.of<Controller>(context, listen: false).isSearch=true;

                        // Provider.of<Controller>(context, listen: false)
                        //     .searchkey = value;

                        // Provider.of<Controller>(context, listen: false)
                        //     .searchProcess(widget.customerId, widget.os);
                        value = searchcontroll.text;
                      },
                      decoration: InputDecoration(
                        hintText: "Search with  Product code/Name/category",
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey),
                        suffixIcon: value.isVisible
                            ? Wrap(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.done,
                                        size: 20,
                                      ),
                                      onPressed: () async {
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .getSaleBagDetails(
                                                widget.customerId, widget.os);
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .searchkey = searchcontroll.text;
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .setIssearch(true);
                                        Provider.of<Controller>(context,
                                                    listen: false)
                                                .salefilterCompany
                                            ? Provider.of<Controller>(context,
                                                    listen: false)
                                                .searchProcess(
                                                    widget.customerId,
                                                    widget.os,
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .salefilteredeValue!,
                                                    "sales")
                                            : Provider.of<Controller>(context,
                                                    listen: false)
                                                .searchProcess(
                                                    widget.customerId,
                                                    widget.os,
                                                    "",
                                                    "sales");
                                      }),
                                  IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .getSaleProductList(
                                                widget.customerId);
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .setIssearch(false);

                                        value.setisVisible(false);
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .newList
                                            .clear();

                                        searchcontroll.clear();
                                      }),
                                ],
                              )
                            : Icon(
                                Icons.search,
                                size: 20,
                              ),
                      ),
                    ),
                  ),
                ),
                value.isLoading
                    ? Container(
                        child: CircularProgressIndicator(
                        color: P_Settings.salewaveColor,
                      ))
                    : value.prodctItems.length == 0
                        ? _isLoading
                            ? CircularProgressIndicator()
                            : Container(
                                height: size.height * 0.6,
                                child: Text(
                                  "No Products !!!",
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                        : Expanded(
                            child: value.isSearch
                                ? value.isListLoading
                                    ? Center(
                                        child: SpinKitCircle(
                                          color: P_Settings.salewaveColor,
                                          size: 40,
                                        ),
                                      )
                                    : value.newList.length == 0
                                        ? Container(
                                            child: Text("No data Found!!!!"),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: value.newList.length,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0.4, right: 0.4),
                                                child: ListTile(
                                                  title: Text(
                                                    '${value.newList[index]["code"]}' +
                                                        '-' +
                                                        '${value.newList[index]["item"]}',
                                                    style: TextStyle(
                                                        // color: value.selected[index]
                                                        //     ? Colors.green
                                                        //     : Colors.grey[700],
                                                        color: value
                                                                .selected[index]
                                                            ? Colors.green
                                                            : Colors.grey[700],
                                                        fontSize: 16),
                                                  ),
                                                  subtitle: Row(
                                                    children: [
                                                      Text(
                                                        '\u{20B9}${value.newList[index]["rate1"]}',
                                                        style: TextStyle(
                                                          color: P_Settings
                                                              .ratecolor,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            size.width * 0.055,
                                                      ),
                                                      Text(
                                                        'tax: \u{20B9}${value.newList[index]["tax"]}',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  trailing: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                          width:
                                                              size.width * 0.06,
                                                          child: TextFormField(
                                                            controller: value
                                                                .qty[index],
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "1"),
                                                          )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.add,
                                                        ),
                                                        onPressed: () async {
                                                          setState(() {
                                                            if (value.selected[
                                                                    index] ==
                                                                false) {
                                                              value.selected[
                                                                  index] = !value
                                                                      .selected[
                                                                  index];
                                                              // selected = index;
                                                            }

                                                            if (value.qty[index]
                                                                        .text ==
                                                                    null ||
                                                                value
                                                                    .qty[index]
                                                                    .text
                                                                    .isEmpty) {
                                                              value.qty[index]
                                                                  .text = "1";
                                                            }
                                                          });

                                                          int max = await OrderAppDB
                                                              .instance
                                                              .getMaxCommonQuery(
                                                                  'salesBagTable',
                                                                  'cartrowno',
                                                                  "os='${value.ordernum[0]["os"]}' AND customerid='${widget.customerId}'");

                                                          print(
                                                              "sales max----$max");
                                                          // print("value.qty[index].text---${value.qty[index].text}");

                                                          rate1 = value.newList[
                                                              index]["rate1"];
                                                          var total = int.parse(
                                                                  rate1) *
                                                              int.parse(value
                                                                  .qty[index]
                                                                  .text);
                                                          print(
                                                              "total rate $total");
                                                          String result = Provider.of<
                                                                      Controller>(
                                                                  context,
                                                                  listen: false)
                                                              .rawCalculation(
                                                                  double.parse(value
                                                                              .newList[
                                                                          index]
                                                                      [
                                                                      "rate1"]),
                                                                  double.parse(
                                                                    value
                                                                        .qty[
                                                                            index]
                                                                        .text,
                                                                  ),
                                                                  0.0,
                                                                  100,
                                                                  double.parse(
                                                                      value.newList[index]
                                                                          ["tax"]),
                                                                  0.0,
                                                                  "0",
                                                                  0,
                                                                  index,false,"");

                                                          if (result ==
                                                              "success") {
                                                            var res = await OrderAppDB
                                                                .instance
                                                                .insertsalesBagTable(
                                                                    value.newList[index]
                                                                        [
                                                                        "item"],
                                                                    s[0],
                                                                    s[1],
                                                                    value.ordernum[0]
                                                                        ["os"],
                                                                    widget
                                                                        .customerId,
                                                                    max,
                                                                    value.newList[
                                                                            index]
                                                                        [
                                                                        "code"],
                                                                    double.parse(value
                                                                        .qty[
                                                                            index]
                                                                        .text),
                                                                    rate1,
                                                                    total
                                                                        .toString(),
                                                                    "0",
                                                                    value.newList[
                                                                            index]
                                                                        ["hsn"],
                                                                    double.parse(
                                                                      value.newList[
                                                                              index]
                                                                          [
                                                                          "tax"],
                                                                    ),
                                                                    value.tax,
                                                                    0.0,
                                                                    100,
                                                                    0.0,
                                                                    0,
                                                                    value.net_amt);
                                                            snackbar.showSnackbar(
                                                                context,
                                                                "${value.newList[index]["code"] + value.newList[index]['item']} - Added to cart");
                                                            Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .countFromTable(
                                                              "salesBagTable",
                                                              widget.os,
                                                              widget.customerId,
                                                            );
                                                          }

                                                          /////////////////////////
                                                          (widget.customerId
                                                                          .isNotEmpty ||
                                                                      widget.customerId !=
                                                                          null) &&
                                                                  (products[index]["code"]
                                                                          .isNotEmpty ||
                                                                      products[index]["code"] !=
                                                                          null)
                                                              ? Provider.of<Controller>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .calculatesalesTotal(
                                                                      value.ordernum[0]
                                                                          [
                                                                          'os'],
                                                                      widget
                                                                          .customerId)
                                                              : Text("No data");

                                                          // Provider.of<Controller>(context,
                                                          //         listen: false)
                                                          //     .getProductList(
                                                          //         widget.customerId);
                                                        },
                                                        color: Colors.black,
                                                      ),
                                                      IconButton(
                                                          icon: Icon(
                                                            Icons.delete,
                                                            size: 18,
                                                            // color: Colors.redAccent,
                                                          ),
                                                          onPressed: value.newList[
                                                                          index]
                                                                      [
                                                                      "cartrowno"] ==
                                                                  null
                                                              ? value.selected[
                                                                      index]
                                                                  ? () async {
                                                                      String
                                                                          item =
                                                                          value.newList[index]["code"] +
                                                                              value.newList[index]["item"];

                                                                      showModal.showMoadlBottomsheet(
                                                                          widget
                                                                              .os,
                                                                          widget
                                                                              .customerId,
                                                                          item,
                                                                          size,
                                                                          context,
                                                                          "newlist just added",
                                                                          value.newList[index]
                                                                              [
                                                                              "code"],
                                                                          index,
                                                                          "no filter",
                                                                          "",
                                                                          value.qty[
                                                                              index],
                                                                          "sales");
                                                                    }
                                                                  : null
                                                              : () async {
                                                                  String item = value
                                                                              .newList[index]
                                                                          [
                                                                          "code"] +
                                                                      value.newList[
                                                                              index]
                                                                          [
                                                                          "item"];

                                                                  showModal.showMoadlBottomsheet(
                                                                      widget.os,
                                                                      widget
                                                                          .customerId,
                                                                      item,
                                                                      size,
                                                                      context,
                                                                      "newlist already in cart",
                                                                      value.newList[
                                                                              index]
                                                                          [
                                                                          "code"],
                                                                      index,
                                                                      "no filter",
                                                                      "",
                                                                      value.qty[
                                                                          index],
                                                                      "sales");
                                                                })
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })
                                : value.salefilterCompany
                                    ? SaleFilteredProduct(
                                        type: widget.type,
                                        customerId: widget.customerId,
                                        os: widget.os,
                                        s: s,
                                        value: Provider.of<Controller>(context,
                                                listen: false)
                                            .salefilteredeValue,
                                      )
                                    : value.isLoading
                                        ? CircularProgressIndicator()
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: value.productName.length,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0.4, right: 0.4),
                                                child: ListTile(
                                                  title: Text(
                                                    '${value.productName[index]["code"]}' +
                                                        '-' +
                                                        '${value.productName[index]["item"]}',
                                                    style: TextStyle(
                                                        color: value.productName[
                                                                        index][
                                                                    "cartrowno"] ==
                                                                null
                                                            ? value.selected[
                                                                    index]
                                                                ? Colors.green
                                                                : Colors
                                                                    .grey[700]
                                                            : Colors.green,
                                                        fontSize: 16),
                                                  ),
                                                  subtitle: Row(
                                                    children: [
                                                      Text(
                                                        '\u{20B9}${value.productName[index]["rate1"]}',
                                                        style: TextStyle(
                                                          color: P_Settings
                                                              .ratecolor,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            size.width * 0.055,
                                                      ),
                                                      Text(
                                                        '(tax: \u{20B9}${value.productName[index]["tax"]})',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  trailing: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                          width:
                                                              size.width * 0.06,
                                                          child: TextFormField(
                                                            controller: value
                                                                .qty[index],
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "1"),
                                                          )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.add,
                                                        ),
                                                        onPressed: () async {
                                                          setState(() {
                                                            if (value.selected[
                                                                    index] ==
                                                                false) {
                                                              value.selected[
                                                                  index] = !value
                                                                      .selected[
                                                                  index];
                                                              // selected = index;
                                                            }

                                                            if (value.qty[index]
                                                                        .text ==
                                                                    null ||
                                                                value
                                                                    .qty[index]
                                                                    .text
                                                                    .isEmpty) {
                                                              value.qty[index]
                                                                  .text = "1";
                                                            }
                                                          });

                                                          int max = await OrderAppDB
                                                              .instance
                                                              .getMaxCommonQuery(
                                                                  'salesBagTable',
                                                                  'cartrowno',
                                                                  "os='${value.ordernum[0]["os"]}' AND customerid='${widget.customerId}'");

                                                          print("max----$max");
                                                          // print("value.qty[index].text---${value.qty[index].text}");

                                                          rate1 = value
                                                                  .productName[
                                                              index]["rate1"];
                                                          var total = int.parse(
                                                                  rate1) *
                                                              int.parse(value
                                                                  .qty[index]
                                                                  .text);
                                                          print(
                                                              "total rate $total");

                                                          //                                         value.salesqty[index].text = qty.toString();
                                                          // value.discount_prercent[index].text = value.disc_per.toString();
                                                          // value.discount_amount[index].text = disc_amt.toString();

                                                          String result = Provider.of<
                                                                      Controller>(
                                                                  context,
                                                                  listen: false)
                                                              .rawCalculation(
                                                                  double.parse(value
                                                                              .productName[
                                                                          index]
                                                                      [
                                                                      "rate1"]),
                                                                  double.parse(
                                                                    value
                                                                        .qty[
                                                                            index]
                                                                        .text,
                                                                  ),
                                                                  0.0,
                                                                  100,
                                                                  double.parse(
                                                                      value.productName[index]
                                                                          ["tax"]),
                                                                  0.0,
                                                                  "0",
                                                                  0,
                                                                  index,false,"");
                                                          print(
                                                              "result----$result");
                                                          if (result ==
                                                              "success") {
                                                            // value
                                                            //         .discount_prercent[
                                                            //             index]
                                                            //         .text =
                                                            //     value.disc_per
                                                            //         .toString();
                                                            // value
                                                            //         .discount_amount[
                                                            //             index]
                                                            //         .text =
                                                            //     value.disc_amt
                                                            //         .toString();
                                                            // value
                                                            //         .salesqty[index]
                                                            //         .text =
                                                            //     value.qty[index]
                                                            //         .text
                                                            //         .toString();
                                                            // value.discount_prercent[index].text = value.disc_per.toString();
                                                            
                                                            var res = await OrderAppDB
                                                                .instance
                                                                .insertsalesBagTable(
                                                                    products[index]
                                                                        [
                                                                        "item"],
                                                                    s[0],
                                                                    s[1],
                                                                    value.ordernum[
                                                                            0][
                                                                        "os"],
                                                                    widget
                                                                        .customerId,
                                                                    max,
                                                                    products[
                                                                            index]
                                                                        [
                                                                        "code"],
                                                                    double.parse(value
                                                                        .qty[
                                                                            index]
                                                                        .text),
                                                                    rate1,
                                                                    total
                                                                        .toString(),
                                                                    "0",
                                                                    products[
                                                                            index]
                                                                        ["hsn"],
                                                                    double
                                                                        .parse(
                                                                      products[
                                                                              index]
                                                                          [
                                                                          "tax"],
                                                                    ),
                                                                    value.tax,0.0,
                                                                    100,
                                                                    0.0,
                                                                    0,
                                                                    value
                                                                        .net_amt);

                                                            snackbar.showSnackbar(
                                                                context,
                                                                "${products[index]["code"] + products[index]['item']} - Added to cart");
                                                            Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .countFromTable(
                                                              "salesBagTable",
                                                              widget.os,
                                                              widget.customerId,
                                                            );
                                                          }

                                                          /////////////////////////
                                                          (widget.customerId
                                                                          .isNotEmpty ||
                                                                      widget.customerId !=
                                                                          null) &&
                                                                  (products[index]["code"]
                                                                          .isNotEmpty ||
                                                                      products[index]["code"] !=
                                                                          null)
                                                              ? Provider.of<Controller>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .calculatesalesTotal(
                                                                      value.ordernum[0]
                                                                          [
                                                                          'os'],
                                                                      widget
                                                                          .customerId)
                                                              : Text("No data");
                                                        },
                                                        color: Colors.black,
                                                      ),
                                                      IconButton(
                                                          icon: const Icon(
                                                            Icons.delete,
                                                            size: 18,
                                                            // color: Colors.redAccent,
                                                          ),
                                                          onPressed: value.productName[
                                                                          index]
                                                                      [
                                                                      "cartrowno"] ==
                                                                  null
                                                              ? value.selected[
                                                                      index]
                                                                  ? () async {
                                                                      String
                                                                          item =
                                                                          products[index]["code"] +
                                                                              products[index]["item"];
                                                                      showModal.showMoadlBottomsheet(
                                                                          widget
                                                                              .os,
                                                                          widget
                                                                              .customerId,
                                                                          item,
                                                                          size,
                                                                          context,
                                                                          "just added",
                                                                          products[index]
                                                                              [
                                                                              "code"],
                                                                          index,
                                                                          "no filter",
                                                                          "",
                                                                          value.qty[
                                                                              index],
                                                                          "sales");
                                                                    }
                                                                  : null
                                                              : () async {
                                                                  String item = products[
                                                                              index]
                                                                          [
                                                                          "code"] +
                                                                      products[
                                                                              index]
                                                                          [
                                                                          "item"];
                                                                  showModal.showMoadlBottomsheet(
                                                                      widget.os,
                                                                      widget
                                                                          .customerId,
                                                                      item,
                                                                      size,
                                                                      context,
                                                                      "already in cart",
                                                                      products[
                                                                              index]
                                                                          [
                                                                          "code"],
                                                                      index,
                                                                      "no filter",
                                                                      "",
                                                                      value.qty[
                                                                          index],
                                                                      "sales");
                                                                })
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                          ),
              ],
            );
          },
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////////
}
