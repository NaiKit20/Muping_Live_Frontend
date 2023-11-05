import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../povider/appdata.dart';
import 'package:minipro/Service.dart';

class LoginPage extends StatelessWidget {
  Service api = Service();

  String email = "korrawich@email.com";
  TextEditingController emailController = TextEditingController();

  String password = "korrawich123";
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<Appdata>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('HAMUTARO CAFE'),
          backgroundColor: Color.fromARGB(255, 179, 136, 57),
        ),
        body: Center(
          child: Column(
            children: [
              Image.network(
                'https://travel.marumura.com/wp-content/uploads/2020/07/Hamtaro-Cafe-2020-8.jpg', // Replace with your image URL
                width: 250, // Adjust the width as needed
                height: 250, // Adjust the height as needed
              ),
              const Text(
                'ลงชื่อเข้าใช้',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // Add Image.network widget here
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'อีเมล',
                    ),
                    onChanged: (text) {
                      email = emailController.text;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'รหัสผ่าน',
                    ),
                    onChanged: (text) {
                      password = passwordController.text;
                    },
                  ),
                ),
              ),
              FilledButton(
                onPressed: () {
                  api.login(email, password).then((loginResult) {
                    // เช้คว่ามีข้อมูล user ไหม
                    if (loginResult == "c") {
                      api.getCustomer(email).then((value) {
                        // ถ้ามี select ข้อมูลของ Customer
                        appData.profile.id = value[0]['cusID'];
                        appData.profile.name = value[0]['name'].toString();
                        appData.profile.email = value[0]['email'].toString();
                        appData.profile.phone = value[0]['phone'];
                        appData.profile.address =
                            value[0]['address'].toString();

                        Navigator.pushReplacementNamed(context, '/customer');
                      });
                    } else if (loginResult == "a") {
                      api.getAdmin(email).then((value) {
                        // ถ้ามี select ข้อมูลของ Admin
                        appData.profile.id = value[0]['adminID'];
                        appData.profile.name = value[0]['name'].toString();
                        appData.profile.email = value[0]['email'].toString();
                        Navigator.pushReplacementNamed(context, '/admin');
                      });
                    } else {
                      emailController.clear();
                      passwordController.clear();
                    }
                  });
                },
                child: const Text('เข้าสู่ระบบ'),
              )
            ],
          ),
        ));
  }
}
