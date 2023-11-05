import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:minipro/models/index.dart';

class Service {

  String ip = "192.168.0.66";

  Future<String> login(String email, String password) async {
    try {
      final response = await http.get(Uri.parse("http://$ip/api/login/$email/$password"));
      if (200 == response.statusCode) {
        final List<dynamic> dataList = json.decode(response.body);
        print(dataList);
        return dataList[0];
      }
      else {
        return "error";
      }
    } catch (e) {
      return "error";
    } 
  }

  Future<List<Map<String, dynamic>>> getCustomer(String email) async {
    final response = await http.get(Uri.parse("http://$ip/api/customer/$email"));
    final jsonData = json.decode(response.body).cast<Map<String, dynamic>>();
    return jsonData;
  }

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse("http://$ip/api/products"));
    final jsonData = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Product> products = jsonData.map<Product>((json) => Product.fromJson(json)).toList();
    return products;
  }

  Future<List<Map<String, dynamic>>> getAdmin(String email) async {
    final response = await http.get(Uri.parse("http://$ip/api/admin/$email"));
    final jsonData = json.decode(response.body).cast<Map<String, dynamic>>();
    return jsonData;
  }

  // ดึงออเดอร์ที่มีสถานะเป็น 0 หรือตะกร้าจากรหัสลูกค้า
  Future<int> getIorder0(int cusID) async {
    final response = await http.get(Uri.parse("http://$ip/api/iorder/$cusID"));
    final jsonData = json.decode(response.body).cast<Map<String, dynamic>>();
    // List<Iorder> iorder = jsonData.map<Iorder>((json) => Iorder.fromJson(json)).toList();
    if(jsonData.length > 0) {
      return jsonData[0]['oid'];
    }
    else {
      return jsonData.length;
    }
  }

  // สร้าง order ขึ้นมาใหม่โดยจะสร้างก็ต่อเมื่อลูกค้า login เข้ามาแล้วไม่พบ order ที่สถานะเป็น 0 หรือตะกร้า
  Future postIorder0(int cusID) async {
    await http.post(Uri.parse("http://$ip/api/iorder/$cusID"));
  }

  // เพิ่มสินค้าลงในตะกร้า
  Future addProductToCart(int oid, int proID) async {
    await http.post(Uri.parse("http://$ip/api/iorder/$oid/$proID/1"));
  }

  // ลบสินค้าออกจากตะกร้า
  // static Future removeProductToCart(int oid, int proID) async {
  //   final response = await http.delete(Uri.parse("http://localhost/api/iorder/$oid/$proID"));
  // }

  // ดึงรายการสินค้าที่อยู่ในตะกร้า
  Future<List<ProductInCart>> getProductsInCart(int oid) async {
    List<ProductInCart> products = [];

    final response = await http.get(Uri.parse("http://$ip/api/iorder/amount/$oid"));
    final jsonData = json.decode(response.body).cast<Map<String, dynamic>>();
    products = jsonData.map<ProductInCart>((json) => ProductInCart.fromJson(json)).toList();
    return products;
  }

  // ดึงรายการสินค้าที่จ่ายเงินแล้ว
  Future<List<Iorder>> getOrder(int cusID) async {
    List<Iorder> iorders = [];

    final response = await http.get(Uri.parse("http://$ip/api/iorder/by/$cusID"));
    final jsonData = json.decode(response.body).cast<Map<String, dynamic>>();
    // print(jsonData);
    iorders = jsonData.map<Iorder>((json) => Iorder.fromJson(json)).toList();
    return iorders;
  }
}
