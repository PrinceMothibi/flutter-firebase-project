import 'package:flutter/material.dart';
import 'package:fuel_app/model/fuel_price.dart';
import 'package:fuel_app/pages/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel4U',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (context) => FuelPriceModel(),
        child: const MyHomePage(title: 'Fuel4U'),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
