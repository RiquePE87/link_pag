import 'package:flutter/material.dart';
import 'package:testando/payment_screen.dart';
import 'package:testando/payment_link_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Link de Pagamento'),),
        body: PaymentScreen(),
      )
    );
   
  }
}

