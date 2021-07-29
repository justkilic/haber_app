import 'dart:convert';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:xml/xml.dart' as xml;
import 'drawer.dart';
import 'haber_vm.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Haber 8'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HaberVm haberVm = HaberVm();
  Future<HaberVm> fetchAlbum() async {
    final response = await http.get(
      Uri.parse(
          'https://api.collectapi.com/news/getNews?country=tr&padding=1&tag=general'),
      headers: {
        HttpHeaders.authorizationHeader:
            'apikey 0RMx9mG1G5yDKTiX2TkMqI:6i2T1OcjtkU9yz6e7LuF3V',
      },
    );

    if (response.statusCode == 200) {
      haberVm = HaberVm.fromJson(jsonDecode(response.body));
      return haberVm;
    } else if (response.statusCode == 401) {
      throw Exception('yetkin yok');
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future haberGetiren() async {
    await fetchAlbum();
    setState(() {});
  }

  @override
  void initState() {
    haberGetiren();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffold,
      drawer: YanMenu(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _scaffold.currentState.openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                haberVm.result == null
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Center(child: CircularProgressIndicator()))
                    : Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: haberVm.result == null
                                ? 0
                                : haberVm.result.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return InkWell(
                                onTap: () async {
                                  await launch(haberVm.result[index].url);
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Image.network(
                                            haberVm.result[index].image,
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace stackTrace) {
                                          return Text('Resim Yüklenemedi :(');
                                        }, fit: BoxFit.fill),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Text(
                                          haberVm.result[index].name,
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Text(
                                          haberVm.result[index].description,
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        child: Text(
                                          haberVm.result[index].source,
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 5, 5, 10),
                                      child: Container(
                                        height: 1.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
