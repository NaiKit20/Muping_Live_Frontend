import 'package:flutter/material.dart';
import 'package:minipro/models/index.dart';
import 'package:minipro/service.dart';
import 'package:provider/provider.dart';

import '../page/orderAmount.dart';
import '../povider/appdata.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderStatePage();
}

class _OrderStatePage extends State<OrderPage> {
  Service api = Service();

  List<Iorder> iorders = [];

  @override
  void initState() {
    super.initState();
    // เรียกข้อมูลใน povider เพื่อเอา cusID
    final appdata = Provider.of<Appdata>(context, listen: false);

    api.getOrder(appdata.profile.id).then((value) {
      setState(() {
        iorders = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return iorders.isEmpty
    ? const Center(
            child:
              CircularProgressIndicator())
    : Column(
          children: <Widget>[
            list()
          ]
        );
  }

  Widget list() {
  return Expanded(
    child: ListView.builder(
          itemCount: iorders.length,
          itemBuilder: (context, index) {
            final iorder = iorders[index];
            return Card(
              child: InkWell(
                child: ListTile(
                  leading: Text('${index+1}'),
                  title: Text(iorder.time),
                  subtitle: Text('ยอดรวม: ${iorder.total}'),
                  trailing: iorder.status == 1
                  ? const Text('ยังไม่ทำการจัดส่ง')
                  : const Text('จัดส่งสำเร็จ')
                ),
                onTap: () {
                  // print('${iorder.oid}');
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OrderAmountPage(
                      oid: iorder.oid.toInt(),
                    )
                  ));
                },
              )
            );
          },
          )
    );
  }
}