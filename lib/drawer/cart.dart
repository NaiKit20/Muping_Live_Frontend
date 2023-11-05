import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:minipro/models/index.dart';
import 'package:minipro/service.dart';
import 'package:http/http.dart' as http;
import '../povider/appdata.dart';

class CartPage extends StatefulWidget {
  // รับ oid มาจาก constructor
  // final int oid;
  // const CartPage({Key? key, required this.oid}) : super(key: key);
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartStatePage();
}

class _CartStatePage extends State<CartPage> {
  Service api = Service();
  String ip = "192.168.0.66";

  int total = 0;

  // รายการสินค้าที่อยู่ในตะกร้า
  List<ProductInCart> products = [];

  @override
  void initState() {
    super.initState();

    // ดึงสินค้าที่อยู่ในตะกร้า
    updateProductTotal();
  }

  @override
  Widget build(BuildContext context) {
    final appdata = Provider.of<Appdata>(context);

    return products.isEmpty
        ? const Center(
            child:
              Text('ตะกร้าว่างเปล่า'))
        : Column(
          children: <Widget>[
            Row(
              children: [
                Text('ยอดรวม: $total'),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                  onPressed: () {
                    // print(DateTime.now());
                    pay(appdata.profile.oid, DateTime.now().toString(), total);
                  },
                  child: const Text('ชำระเงิน'),
                )
              ],
            ),
            list()
          ]
        );
  }

  Widget list() {
    final appData = Provider.of<Appdata>(context);

    return Expanded(
      child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
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
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_shopping_cart),
                        onPressed: () {
                          // ลบสินค้าออกจากตะกร้า
                          removeProductInCart(appData.profile.oid, product.proID.toInt());
                        },
                      )
                    )
                  );
            },
          )
    );
  }

  updateProductTotal() {
    // เรียกข้อมูลใน povider เพื่อเอา oid
    final appdata = Provider.of<Appdata>(context, listen: false);    
    api.getProductsInCart(appdata.profile.oid).then((value) {
      setState(() {
        products = value;
        total = 0;
        for (var product in products) {
          total += product.amount.toInt() * product.price.toInt();
        }
      });
    });
  }

  // call API ------------------------------------------------------------------------------------------------------------------------------|
  // callAPI ลบสินค้าออกจากตะกร้า
  Future removeProductInCart(int oid, int proID) async {
    await http.delete(Uri.parse("http://$ip/api/iorder/$oid/$proID"));

    updateProductTotal();
  }

  // จ่ายเงิน
  Future pay(int oid, String time, int total) async {
    final appdata = Provider.of<Appdata>(context, listen: false);

    await http.put(Uri.parse("http://$ip/api/iorder/$oid/1/$total/$time"));
    // รีค่าเริ่มต้นของ oid ให้เป็น 0
    appdata.profile.oid = 0;
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/customer');
  }
}
