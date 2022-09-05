import "package:flutter/material.dart";
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';

class QueryResultScreen extends StatefulWidget {
  const QueryResultScreen({Key? key}) : super(key: key);

  @override
  State<QueryResultScreen> createState() => _QueryResultScreenState();
}

class _QueryResultScreenState extends State<QueryResultScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String cusid = "VGMHD5";
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: size.height * 0.1,
              width: size.width * 1.2,
              child: Card(
                child: TextField(
                  controller: controller,
                ),
              ),
            ),
            Container(
              height: size.height * 0.04,
              child: ElevatedButton(
                  onPressed: () {
                    // // controller.text="select convert(integer,value) con from maxSeriesTable";
                    // controller.text =
                    //     "SELECT MAX(x) maxVal from ( SELECT value as x FROM maxSeriesTable WHERE prefix = 'ORP' UNION ALL SELECT MAX(order_id)+1 as x FROM orderMasterTable )";
                    String qryyy = "SELECT pd.pid,pd.code,pd.ean,pd.item,pd.unit,pd.categoryId,pd.companyId,pd.stock,pd.hsn, " +
                        "pd.tax,pd.prate,pd.mrp,pd.cost,pd.rate1,pd.rate2,pd.rate3,pd.rate4,pd.priceflag, " +
                        "b.itemName,b.cartdate,b.carttime,b.os,b.customerid,b.cartrowno,b.code bagCode, " +
                        "b.qty bagQty,b.rate bagRate,b.unit_rate bagUnitRate,b.totalamount bagTotal," +
                        "b.method,b.hsn,b.tax_per,b.tax_amt,b.cgst_per,b.cgst_amt,b.sgst_per,b.sgst_amt," +
                        "b.igst_per,b.igst_amt,b.discount_per,b.discount_amt,b.ces_per,b.ces_amt,b.cstatus," +
                        "b.net_amt,b.pid bagPid,b.unit_name bagUnitName,b.package bagPackage,b.baserate," +
                        "u.pid unitPid,u.package unitPackage,u.unit_name unitUnit_name " +
                        "FROM 'productDetailsTable' pd " +
                        "LEFT JOIN 'productUnits' u ON pd.pid = u.pid " +
                        "LEFT JOIN 'salesBagTable' b ON pd.code = b.code AND  pd.pid = b.pid  " +
                        "AND b.customerid='$cusid' " +
                        "AND b.unit_name =  u.unit_name " +
                        "where pd.pid >0 " +
                        "ORDER BY u.pid, b.cartrowno DESC" +
                        "          ";
                    controller.text = "$qryyy";
                    Provider.of<Controller>(context, listen: false)
                        .queryExecuteResult(controller.text);
                  },
                  child: Text("execute")),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              height: size.height * 0.6,
              child: Consumer<Controller>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.queryResult.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                            title: SelectableText(
                          value.queryResult.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(),
                        )
                            // Text(
                            //   value.queryResult.toString(),
                            // ),
                            ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
