import 'package:flutter/material.dart';
import 'package:haber_app/economy.dart';
import 'package:haber_app/general.dart';
import 'package:haber_app/health.dart';
import 'package:haber_app/sport.dart';
import 'package:haber_app/technology.dart';

class YanMenu extends StatefulWidget {
  @override
  _YanMenuState createState() => _YanMenuState();
}

class _YanMenuState extends State<YanMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.blueGrey.shade50,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Image.asset("assets/haber8.png"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => General()));
                },
                child: Text(
                  "Haber",
                  style: TextStyle(fontSize: 22),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50)),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Sport()));
                },
                child: Text(
                  "Spor",
                  style: TextStyle(fontSize: 22),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50)),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Economy()));
                },
                child: Text(
                  "Ekonomi",
                  style: TextStyle(fontSize: 22),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50)),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Technology()));
                },
                child: Text(
                  "Teknoloji",
                  style: TextStyle(fontSize: 22),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50)),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Health()));
                },
                child: Text("Sağlık", style: TextStyle(fontSize: 22),),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width , 50)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
