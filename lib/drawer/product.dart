import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:minipro/models/index.dart';
import 'package:minipro/service.dart';

import '../povider/appdata.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Service api = Service();

  // เก็บข้อมูล Products ทั้งหมดที่รับมาจาก api
  List<Product> products = [];

  @override
  void initState() {
    super.initState();

    // callAPI ดึง Products มาแสดง
    api.getProducts().then((products) {
      this.products = products;
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<Appdata>(context);
    
    return products.isEmpty
        ? const Center(
            child:
                CircularProgressIndicator()) // ถ้า products ยังว่างให้แสดงหน้า loading
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.6),
            itemBuilder: (context, index) {
              Product product =
                  products[index]; // ดึงข้อมูลจริงจาก List หรือตัวแปรอื่น ๆ
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 500,
                  width: 150,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image.network(product.image),
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(10), // ปรับความโค้งขอบ
                            child: Image(
                              image: NetworkImage(product.image),
                              width: 190, // ตั้งค่าความกว้างของรูปภาพ
                              height: 150, // ตั้งค่าความสูงของรูปภาพ
                              fit: BoxFit.cover, // ตั้งค่าการปรับขนาด (fit) ของรูปภาพ
                            ),
                          ),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            product.name,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            '${product.price}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 18,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons
                                .shopping_cart), // กำหนดไอคอนที่จะแสดงในปุ่ม
                            onPressed: () {
                              // callAPI เพิ่มสินค้าลงในตะกร้าที่ละ 1
                              api.addProductToCart(appData.profile.oid, product.proID.toInt());
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: products.length, // จำนวนรายการข้อมูลจริง
          );
  }
}
