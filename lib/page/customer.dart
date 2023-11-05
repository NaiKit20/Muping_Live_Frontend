import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:minipro/service.dart';
import '../drawer/cart.dart';
import '../drawer/order.dart';
import '../drawer/product.dart';
import '../povider/appdata.dart';

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  Service api = Service();
  
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ProductPage(),
    const CartPage(),
    const OrderPage(),
  ];

  @override
  void initState() {
    super.initState();

    // เรียกข้อมูลใน povider
    final appdata = Provider.of<Appdata>(context, listen: false);

    // callAPI ดึง order สถานะ 0
    api.getIorder0(appdata.profile.id).then((value) {
      if (value != 0) { // มี order ที่มีสถานะเป้นตะกร้าและเก็บ oid ลงใน povider
        setState(() {
          appdata.profile.oid = value;
        });
      } else { // ไม่มี order ที่มีสถานะเป้นตะกร้า
        // สร้าง order ใหม่
        api.postIorder0(appdata.profile.id); // callAPI สร้าง order สถานะ 0
        api.getIorder0(appdata.profile.id).then((value) {
          // select order ที่สถานะเป็น 0 และเก็บ oid ลงใน povider
          setState(() {
            appdata.profile.oid = value;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<Appdata>(context);

    return appData.profile.oid == 0
    ? const Center(
            child:
                CircularProgressIndicator()) // ถ้า oid ยังถูกดึงมาไม่เสร็จให้แสดงหน้า loading
    : Scaffold(
      appBar: AppBar(
        title: const Text('Muping Shop'),
        backgroundColor: const Color.fromARGB(255, 168, 128, 196),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  children: [
                    Text(
                      appData.profile.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      appData.profile.email,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '${appData.profile.oid}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      appData.profile.address,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                )),
            ListTile(
              leading: const Icon(Icons.storefront),
              title: const Text('รายการสินค้า'),
              onTap: () {
                _changePage(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('ตะกร้าสินค้า'),
              onTap: () {
                _changePage(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.paid),
              title: const Text('รายการสั่งซื้อ'),
              onTap: () {
                _changePage(2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('ออกจากระบบ'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
    );
  }

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
      Navigator.pop(context); // ปิด Drawer
    });
  }
}
