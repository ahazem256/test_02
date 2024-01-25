import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late ScrollController scroller;
  @override
  void initState() {
    scroller = ScrollController();
    scroller.addListener(() {
      print("${scroller.offset}");
    });
    super.initState();
  }

  @override
  void dispose() {
    scroller = ScrollController();
    super.dispose();
  }

  List data = [];
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("scroll"),
          ),
          body: ListView(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: MaterialButton(child: Text("http request"),
                    color: Colors.blueAccent,
                    textColor: Colors.black,
                   
                    onPressed: () async {
                       loading=true;
                       setState(() {});
                      var respond = await get(Uri.parse(
                          "https://jsonplaceholder.typicode.com/photos"));
                      var respondbody = jsonDecode(respond.body);
                      data.addAll(respondbody);
                      loading=false;
                      setState(() {});
                    },
                  )),
                  if(loading==true)const Center(child: CircularProgressIndicator(),),
                  ...List.generate(data.length, (index) => Card(child: ListTile(title: Text("${data[index]}"),),))
            ],
            
          )),
    );
  }
}
