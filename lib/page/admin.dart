import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../povider/appdata.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<Appdata>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Admin Page')),
      body: Center(
        child: Column(
          children: [
            Text(appData.profile.email),
            Text(appData.profile.id.toString()),
          ],
        ) 
      ),
    );
  }
}