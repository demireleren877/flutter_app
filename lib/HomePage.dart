import 'package:deneme/Profil.dart';
import 'package:deneme/Siparisler.dart';
import 'package:deneme/UrunListesi.dart';
import 'package:deneme/loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  String usermail;
  HomePage({this.usermail});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  closeDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Material(
          color: Color.fromRGBO(40, 60, 70, 1),
          child: ListView(
            padding: padding,
            children: [
              SizedBox(
                height: 50,
              ),
              Image.network(
                "https://image.flaticon.com/icons/png/512/147/147144.png",
                height: 130,
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (r) => ProfilPage()));
                    closeDrawer();
                  },
                  child: Text(
                    widget.usermail,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 38,
              ),
              ListTile(
                leading: Icon(
                  Icons.people,
                  color: Colors.white,
                ),
                title: Text(
                  "Kullanıcılar",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  closeDrawer();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.dashboard_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  "Panel",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  closeDrawer();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.reorder_rounded,
                  color: Colors.white,
                ),
                title: Text(
                  "Siparişler",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (r) => Siparisler()));
                  closeDrawer();
                },
              ),
              Container(
                child: ListTile(
                  leading: Icon(
                    Icons.directions_car,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Ürünler",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    closeDrawer();
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Listele()));
                  },
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                title: Text(
                  "Ayarlar",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  closeDrawer();
                },
              ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.logout),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => loginpage()),
                        (route) => false);
                  },
                ),
                alignment: Alignment.bottomRight,
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("Ana Sayfa"),
      ),
    );
  }

  buildMenuItem({String text, IconData icon}) {
    final color = Colors.white;
    final hovercolor = Colors.white70;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      hoverColor: hovercolor,
      onTap: () {},
    );
  }
}
