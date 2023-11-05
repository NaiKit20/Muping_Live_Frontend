import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minipro/models/index.dart';
import 'package:http/http.dart' as http;

class OrderAmountPage extends StatefulWidget {
  // รับ oid มาจาก constructor
  final int oid;
  const OrderAmountPage({Key? key, required this.oid}) : super(key: key);

  @override
  State<OrderAmountPage> createState() => _OrderAmountStatePage(oid);
}

class _OrderAmountStatePage extends State<OrderAmountPage> {
  // รับค่าตัวแปล oid จาก OrderAmountPage โดยส่งผ่าน constructor
  final int oid;
  _OrderAmountStatePage(this.oid);

  String ip = "192.168.0.66";

  List<OrderAmount> orderAmount = [];

  @override
  void initState() {
    super.initState();

    getOrderAmount(oid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$oid'),
        backgroundColor: const Color.fromARGB(255, 168, 128, 196),
      ),
      body: orderAmount.isEmpty
      ? const Center(
            child:
              CircularProgressIndicator())
        : Column(
          children: <Widget>[
            list()
          ],
        )
    );
  }

  Widget list() {
    return Expanded(
      child: ListView.builder(
            itemCount: orderAmount.length,
            itemBuilder: (context, index) {
              final product = orderAmount[index];
              return Card(
                  child: ListTile(
                      leading: Image(
                        image: NetworkImage(product.image),
                        width: 100, 
                        height: 150, 
                        fit: BoxFit.cover, // ตั้งค่าการปรับขนาด (fit) ของรูปภาพ
                      ),
                      title: Text(product.name),
                      subtitle: Text('${product.amount}'),
                    )
                  );
            },
          )
    );
  }

  // ดึงรายการสินค้าที่อยู่ใน order
  Future getOrderAmount(int oid) async {
    final response = await http.get(Uri.parse("http://$ip/api/iorder/amount/$oid"));
    final jsonData = json.decode(response.body).cast<Map<String, dynamic>>();
    setState(() {
      orderAmount = jsonData.map<OrderAmount>((json) => OrderAmount.fromJson(json)).toList();
    });
  }
}