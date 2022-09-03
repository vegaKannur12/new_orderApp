import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/components/customSearchTile.dart';
import 'package:orderapp/components/customSnackbar.dart';
import 'package:orderapp/components/showMoadal.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
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
  String gtype;

  SalesItem(
      {required this.customerId,
      required this.areaId,
      required this.os,
      required this.areaName,
      required this.type,
      required this.gtype});

  @override
  State<SalesItem> createState() => _SalesItemState();
}

class _SalesItemState extends State<SalesItem> {
  String rate1 = "1";
  String? selected;
  TextEditingController searchcontroll = TextEditingController();
  ShowModal showModal = ShowModal();
  List<Map<String, dynamic>> products = [];
  SearchTile search = SearchTile();
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

    print("customer id....os....${widget.customerId}--${widget.os}");
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
    return Scaffold(
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
            Provider.of<Controller>(context, listen: false).newList = products;
            Provider.of<Controller>(context, listen: false).fetchwallet();
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        backgroundColor: P_Settings.salewaveColor,
        actions: <Widget>[
          Badge(
            animationType: BadgeAnimationType.scale,
            toAnimate: true,
            badgeColor: Colors.white,
            badgeContent: Consumer<Controller>(
              builder: (context, value, child) {
                if (value.count == null) {
                  return SpinKitChasingDots(
                      color: P_Settings.wavecolor, size: 9);
                } else {
                  return Text(
                    "${value.count}",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  );
                }
              },
            ),
            position: const BadgePosition(start: 33, bottom: 25),
            child: IconButton(
              onPressed: () async {
                if (widget.customerId == null || widget.customerId.isEmpty) {
                } else {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Provider.of<Controller>(context, listen: false).selectSettings(
                      "set_code in ('SL_RATE_EDIT','SL_TAX_CALC','SL_UPLOAD_DIRECT') ");

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
                        type: widget.type,
                      ),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.shopping_cart),
            ),
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
                      hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
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
                                              .searchProcess(widget.customerId,
                                                  widget.os, "", "sales");
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
                                          itemExtent: 55.0,
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
                                                      width: size.width * 0.05,
                                                    ),
                                                    Text(
                                                      '(tax: \u{20B9}${value.newList[index]["tax"]})',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: size.width * 0.05,
                                                    ),
                                                    Text(
                                                      '(unit: \u{20B9}${value.newList[index]["unit"]})',
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
                                                          controller:
                                                              value.qty[index],
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
                                                        // value.qtyups(index);
                                                        Provider.of<Controller>(
                                                                context,
                                                                listen: false)
                                                            .selectSettings(
                                                                "set_code in ('SL_RATE_EDIT','SL_TAX_CALC','SL_UPLOAD_DIRECT') ");
                                                        // String os="S"+"${value.ordernum[0]["os"]}";
                                                        setState(() {
                                                          if (value.selected[
                                                                  index] ==
                                                              false) {
                                                            value.selected[
                                                                    index] =
                                                                !value.selected[
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
                                                                "os='${widget.os}' AND customerid='${widget.customerId}'");

                                                        print(
                                                            "sales max----$max");

                                                        rate1 =
                                                            value.newList[index]
                                                                ["rate1"];
                                                        var total = double
                                                                .parse(rate1) *
                                                            double.parse(value
                                                                .qty[index]
                                                                .text);
                                                        print(
                                                            "total rate $total");
                                                        double qtyNew = 0.0;
                                                        double discounamttNew =
                                                            0.0;
                                                        double discounpertNew =
                                                            0.0;
                                                        double cesspertNew =
                                                            0.0;

                                                        List qtyNewList =
                                                            await OrderAppDB
                                                                .instance
                                                                .selectAllcommon(
                                                                    'salesBagTable',
                                                                    "os='${widget.os}' AND customerid='${widget.customerId}' AND code='${value.newList[index]["code"]}'");
                                                        if (qtyNewList.length >
                                                            0) {
                                                          qtyNew = qtyNewList[0]
                                                              ["qty"];
                                                          discounamttNew =
                                                              qtyNewList[0][
                                                                  "discount_amt"];
                                                          discounpertNew =
                                                              qtyNewList[0][
                                                                  "discount_per"];
                                                          cesspertNew =
                                                              qtyNewList[0]
                                                                  ["ces_per"];
                                                        }

                                                        double qtyww = qtyNew +
                                                            double.parse(value
                                                                .qty[index]
                                                                .text);
                                                        print(
                                                            "qtynew----$qtyww");

                                                        String result = Provider
                                                                .of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                            .rawCalculation(
                                                                double.parse(value
                                                                        .newList[index]
                                                                    ["rate1"]),
                                                                qtyww,
                                                                discounpertNew,
                                                                discounamttNew,
                                                                double.parse(value
                                                                        .newList[index]
                                                                    ["tax"]),
                                                                0.0,
                                                                // value.settingsList[0]
                                                                //     ['set_value'],
                                                                value
                                                                    .settingsList1[1]
                                                                        ['set_value']
                                                                    .toString(),
                                                                int.parse(widget.gtype),
                                                                index,
                                                                false,
                                                                "");

                                                        if (result ==
                                                            "success") {
                                                          var res = await OrderAppDB
                                                              .instance
                                                              .insertsalesBagTable(
                                                                  value.newList[
                                                                          index]
                                                                      ["item"],
                                                                  s[0],
                                                                  s[1],
                                                                  widget.os,
                                                                  widget
                                                                      .customerId,
                                                                  max,
                                                                  value.newList[
                                                                          index]
                                                                      ["code"],
                                                                  double.parse(value
                                                                      .qty[
                                                                          index]
                                                                      .text),
                                                                  rate1,
                                                                  value
                                                                      .taxable_rate,
                                                                  total
                                                                      .toString(),
                                                                  "0",
                                                                  value.newList[
                                                                          index]
                                                                      ["hsn"],
                                                                  double.parse(
                                                                    value.newList[
                                                                            index]
                                                                        ["tax"],
                                                                  ),
                                                                  value.tax,
                                                                  value
                                                                      .cgst_per,
                                                                  value
                                                                      .cgst_amt,
                                                                  value
                                                                      .sgst_per,
                                                                  value
                                                                      .sgst_amt,
                                                                  value
                                                                      .igst_per,
                                                                  value
                                                                      .igst_amt,
                                                                  discounpertNew,
                                                                  discounamttNew,
                                                                  0.0,
                                                                  value.cess,
                                                                  0,
                                                                  value
                                                                      .net_amt);
                                                          //     int qtysale =
                                                          //     int.parse(value
                                                          //         .qty[index]
                                                          //         .text);
                                                          // Provider.of<Controller>(
                                                          //         context,
                                                          //         listen: false)
                                                          //     .quantitiChange(
                                                          //         qtysale,
                                                          //         index);
                                                          snackbar.showSnackbar(
                                                              context,
                                                              "${value.newList[index]["code"] + value.newList[index]['item']} - Added to cart",
                                                              "sales");
                                                          Provider.of<Controller>(
                                                                  context,
                                                                  listen: false)
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
                                                                (products[index][
                                                                            "code"]
                                                                        .isNotEmpty ||
                                                                    products[index]
                                                                            [
                                                                            "code"] !=
                                                                        null)
                                                            ? Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .calculatesalesTotal(
                                                                    widget.os,
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
                                                                        index][
                                                                    "cartrowno"] ==
                                                                null
                                                            ? value.selected[
                                                                    index]
                                                                ? () async {
                                                                    String item = value.newList[index]
                                                                            [
                                                                            "code"] +
                                                                        value.newList[index]
                                                                            [
                                                                            "item"];

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
                                      gtype: widget.gtype,
                                    )
                                  : value.isLoading
                                      ? CircularProgressIndicator()
                                      : ListView.builder(
                                          itemExtent: 70,
                                          shrinkWrap: true,
                                          itemCount: value.productName.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.4,
                                                  right: 0.4,
                                                  bottom: 0.2),
                                              child: Card(
                                                child: ListTile(
                                                  onTap: () {
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .fetchProductUnits(
                                                            value.productName[
                                                                index]["pid"]);
                                                    buildPopupDialog(
                                                        context, size);
                                                  },
                                                  dense: true,
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
                                                        fontSize: 14),
                                                  ),
                                                  subtitle: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '\u{20B9}${value.productName[index]["rate1"]}',
                                                            style: TextStyle(
                                                              color: P_Settings
                                                                  .ratecolor,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: size.width *
                                                                0.055,
                                                          ),
                                                          Text(
                                                            '(tax: \u{20B9}${value.productName[index]["tax"]})',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: size.width *
                                                                0.05,
                                                          ),
                                                          Text(
                                                            '(unit: \u{20B9}${value.productName[index]["unit"]})',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                            ),
                                                          ),
                                                          //   Text(
                                                          //   '(unit: \u{20B9}${value.productName[index]["unit"]})',
                                                          //   style: TextStyle(
                                                          //     color:
                                                          //         Colors.grey,
                                                          //     fontStyle:
                                                          //         FontStyle
                                                          //             .italic,
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Select Packing",
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.grey,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                      // SizedBox(
                                                      //     height: size.height *
                                                      //         0.02),
                                                      // Row(
                                                      //   children: [
                                                      //     // Text(
                                                      //     //     "Select Packing"),

                                                      //     Flexible(
                                                      //       child: Container(
                                                      //         color: Colors
                                                      //             .grey[200],
                                                      //         height:
                                                      //             size.height *
                                                      //                 0.04,
                                                      //         width:
                                                      //             size.width *
                                                      //                 0.3,
                                                      //         child:
                                                      //             DropdownButton<
                                                      //                 String>(
                                                      //           value: selected,
                                                      //           hint: Text(
                                                      //               "Paking"),
                                                      //           isExpanded:
                                                      //               true,
                                                      //           // autofocus: false,
                                                      //           underline:
                                                      //               SizedBox(),
                                                      //           elevation: 0,
                                                      //           items: value
                                                      //               .walletList
                                                      //               .map((item) => DropdownMenuItem<
                                                      //                       String>(
                                                      //                   value: item["waid"]
                                                      //                       .toString(),
                                                      //                   child:
                                                      //                       Container(
                                                      //                     width:
                                                      //                         size.width * 0.5,
                                                      //                     child: Padding(
                                                      //                         padding: EdgeInsets.all(5.0),
                                                      //                         child: Text(
                                                      //                           item["wname"].toString(),
                                                      //                           style: TextStyle(fontSize: 13),
                                                      //                         )),
                                                      //                   )))
                                                      //               .toList(),
                                                      //           onChanged:
                                                      //               (item) {
                                                      //             print(
                                                      //                 "clicked");

                                                      //             if (item !=
                                                      //                 null) {
                                                      //               setState(
                                                      //                   () {
                                                      //                 selected =
                                                      //                     item;
                                                      //               });
                                                      //               print(
                                                      //                   "se;ected---$item");
                                                      //             }
                                                      //           },

                                                      //           // disabledHint: Text(selected ?? "null"),
                                                      //         ),
                                                      //       ),
                                                      //     ),
                                                      //     //  });
                                                      //   ],
                                                      // ),
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
                                                          controller:
                                                              value.qty[index],
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
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.add,
                                                        ),
                                                        onPressed: () async {
                                                          // value.qtyups(index);
                                                          Provider.of<Controller>(
                                                                  context,
                                                                  listen: false)
                                                              .selectSettings(
                                                                  "set_code in ('SL_RATE_EDIT','SL_TAX_CALC','SL_UPLOAD_DIRECT') ");
                                                          String os = "S" +
                                                              "${value.ordernum[0]["os"]}";
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

                                                            // int.parse(value.qty[index].text )+ 1;
                                                          });

                                                          int max = await OrderAppDB
                                                              .instance
                                                              .getMaxCommonQuery(
                                                                  'salesBagTable',
                                                                  'cartrowno',
                                                                  "os='${os}' AND customerid='${widget.customerId}'");

                                                          print("max----$max");
                                                          // print("value.qty[index].text---${value.qty[index].text}");
                                                          // Provider.of<Controller>(
                                                          //         context,
                                                          //         listen: false)
                                                          //     .keyContainsListcheck(
                                                          //         products[
                                                          //                 index]
                                                          //             ["code"],
                                                          //         index);

                                                          rate1 = value
                                                                  .productName[
                                                              index]["rate1"];
                                                          var total = double
                                                                  .parse(
                                                                      rate1) *
                                                              double.parse(value
                                                                  .qty[index]
                                                                  .text);
                                                          print(
                                                              "total rate $total");

                                                          double qtyNew = 0.0;
                                                          double
                                                              discounamttNew =
                                                              0.0;
                                                          double
                                                              discounpertNew =
                                                              0.0;
                                                          double cesspertNew =
                                                              0.0;

                                                          List qtyNewList =
                                                              await OrderAppDB
                                                                  .instance
                                                                  .selectAllcommon(
                                                                      'salesBagTable',
                                                                      "os='${os}' AND customerid='${widget.customerId}' AND code='${value.productName[index]["code"]}'");
                                                          if (qtyNewList
                                                                  .length >
                                                              0) {
                                                            qtyNew =
                                                                qtyNewList[0]
                                                                    ["qty"];

                                                            discounamttNew =
                                                                qtyNewList[0][
                                                                    "discount_amt"];
                                                            discounpertNew =
                                                                qtyNewList[0][
                                                                    "discount_per"];
                                                            cesspertNew =
                                                                qtyNewList[0]
                                                                    ["ces_per"];
                                                          }

                                                          double qtyww = qtyNew +
                                                              double.parse(value
                                                                  .qty[index]
                                                                  .text);
                                                          print(
                                                              "qtynew----$qtyww");
                                                          // Provider.of<Controller>(
                                                          //         context,
                                                          //         listen: false)
                                                          //     .selectFromSettings(
                                                          //         'SL_TAX_CALC');
                                                          String result = Provider.of<
                                                                      Controller>(
                                                                  context,
                                                                  listen: false)
                                                              .rawCalculation(
                                                                  double.parse(
                                                                      value.productName[index][
                                                                          "rate1"]),
                                                                  qtyww,
                                                                  discounpertNew,
                                                                  discounamttNew,
                                                                  double.parse(value.productName[index]
                                                                      ["tax"]),
                                                                  cesspertNew,
                                                                  value.settingsList1[1]
                                                                          ['set_value']
                                                                      .toString(),
                                                                  int.parse(widget.gtype),
                                                                  index,
                                                                  false,
                                                                  "");

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
                                                                    widget.os,
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
                                                                    value
                                                                        .taxable_rate,
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
                                                                    value.tax,
                                                                    value
                                                                        .cgst_per,
                                                                    value
                                                                        .cgst_amt,
                                                                    value
                                                                        .sgst_per,
                                                                    value
                                                                        .sgst_amt,
                                                                    value
                                                                        .igst_per,
                                                                    value
                                                                        .igst_amt,
                                                                    discounpertNew,
                                                                    discounamttNew,
                                                                    0.0,
                                                                    value.cess,
                                                                    0,
                                                                    value
                                                                        .net_amt);
                                                            //     int qtysale =
                                                            //     int.parse(value
                                                            //         .qty[index]
                                                            //         .text);
                                                            // Provider.of<Controller>(
                                                            //         context,
                                                            //         listen: false)
                                                            //     .quantitiChange(
                                                            //         qtysale,
                                                            //         index);
                                                            // Provider.of<Controller>(
                                                            //         context,
                                                            //         listen: false)
                                                            //     .getSaleBagDetails(
                                                            //         widget
                                                            //             .customerId,
                                                            //         widget.os);
                                                            // Provider.of<Controller>(
                                                            //         context,
                                                            //         listen: false)
                                                            //     .getSaleBagDetails(
                                                            //         widget
                                                            //             .customerId,
                                                            //         widget.os);
                                                            snackbar.showSnackbar(
                                                                context,
                                                                "${products[index]["code"] + products[index]['item']} - Added to cart",
                                                                "sales");
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
                                                                  (products[index]
                                                                              [
                                                                              "code"]
                                                                          .isNotEmpty ||
                                                                      products[index]
                                                                              [
                                                                              "code"] !=
                                                                          null)
                                                              ? Provider.of<Controller>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .calculatesalesTotal(
                                                                      widget.os,
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
                                              ),
                                            );
                                          },
                                        ),
                        ),
            ],
          );
        },
      ),
    );
  }

  buildPopupDialog(BuildContext context, Size size) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              content: Consumer<Controller>(builder: (context, value, child) {
                if (value.isLoading) {
                  return CircularProgressIndicator();
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Colors.grey[200],
                        height: size.height * 0.04,
                        child: DropdownButton<String>(
                          value: selected,
                          // isDense: true,
                          hint: Text("Select package"),
                          // isExpanded: true,
                          autofocus: false,
                          underline: SizedBox(),
                          elevation: 0,
                          items: value.productUnitList
                              .map((item) => DropdownMenuItem<String>(
                                  value: item["pid"].toString(),
                                  child: Container(
                                    width: size.width * 0.5,
                                    child: Text(
                                      item["unit_name"].toString(),
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  )))
                              .toList(),
                          onChanged: (item) {
                            print("clicked");

                            if (item != null) {
                              setState(() {
                                selected = item;
                              });
                              print("se;ected---$item");
                            }
                          },
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            // if (selected != null) {
                            //   Provider.of<Controller>(context, listen: false)
                            //       .areaId = selected;
                            //   Provider.of<Controller>(context, listen: false)
                            //       .areaSelection(selected!);
                            //   Provider.of<Controller>(context, listen: false)
                            //       .dashboardSummery(
                            //           sid!, s[0], selected!, context);
                            //   String? gen_area = Provider.of<Controller>(
                            //           context,
                            //           listen: false)
                            //       .areaidFrompopup;
                            //   if (gen_area != null) {
                            //     gen_condition =
                            //         " and accountHeadsTable.area_id=$gen_area";
                            //   } else {
                            //     gen_condition = " ";
                            //   }
                            //   Provider.of<Controller>(context, listen: false)
                            //       .getCustomer(gen_area!);
                            //   Provider.of<Controller>(context, listen: false)
                            //       .todayOrder(s[0], gen_condition!);
                            //   Provider.of<Controller>(context, listen: false)
                            //       .todayCollection(s[0], gen_condition!);
                            //   Provider.of<Controller>(context, listen: false)
                            //       .todaySales(s[0], gen_condition!);
                            //   Provider.of<Controller>(context, listen: false)
                            //       .selectReportFromOrder(
                            //           context, sid!, s[0], "");
                            // }

                            Navigator.pop(context);
                          },
                          child: Text("save"))
                    ],
                  );
                }
              }),
            );
          });
        });
  }

  //////////////////////////////////////////////////////////////////////////////////
}
