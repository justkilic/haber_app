import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'haber_vm.dart';

class Health extends StatefulWidget {
  @override
  _SportState createState() => _SportState();
}

class _SportState extends State<Health> {
  HaberVm haberVm = HaberVm();
  Future<HaberVm> fetchAlbum() async {
    final response = await http.get(
      Uri.parse(
          'https://api.collectapi.com/news/getNews?country=tr&padding=1&tag=health'),
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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Spor"),
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
                                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
        )));
  }
}
