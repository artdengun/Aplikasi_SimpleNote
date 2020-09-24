import 'dart:ui';

import 'package:flutter/material.dart';
import './NotePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Note',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // #Pengaturan 1
        // ini untuk bagian header
        centerTitle: true,
        leading: Container( // ini pembungkus si icon
          padding: EdgeInsets.all(4.0),
            child: Image.asset('images/stack.png')),
        title: Text("Simple Note", style: TextStyle(color: Colors.white,fontSize: 25,
        fontWeight: FontWeight.bold),),
      ),
      backgroundColor: Colors.white70, // background

      // #Pengaturan 2
      // bagian tombol tambah
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_circle_outline),
          backgroundColor: Colors.pink,
          onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> new NotePage(null,true))), ),
          // on press ini memberikan efek tombol di pencet
    );
  }
}
