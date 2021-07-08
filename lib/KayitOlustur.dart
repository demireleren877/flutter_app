import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'HomePage.dart';

class KayitSayfasi extends StatefulWidget {
  const KayitSayfasi({Key key}) : super(key: key);

  @override
  _KayitSayfasiState createState() => _KayitSayfasiState();
}

class _KayitSayfasiState extends State<KayitSayfasi> {
  String ad, soyad, telno, email, sifre;
  bool isPasswordVisible = true;
  var _formAnahtari = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Hesap Oluşturma Ekranı"),
      ),
      body: Form(
        key: _formAnahtari,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (alinanAd) {
                    setState(() {
                      ad = alinanAd;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Ad",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (alinanSoyad) {
                    setState(() {
                      soyad = alinanSoyad;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Soyad",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (alinanTelno) {
                    setState(() {
                      telno = alinanTelno;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Telefon Numarası",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (alinanMail) {
                    setState(() {
                      email = alinanMail;
                    });
                  },
                  validator: (alinanMail) {
                    return alinanMail.contains("@") ? null : "Geçersiz Mail.";
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "E-Mail",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (alinanSifre) {
                    setState(() {
                      sifre = alinanSifre;
                    });
                  },
                  validator: (alinanSifre) {
                    return alinanSifre.length >= 6
                        ? null
                        : "Şifreniz En Az 6 Karakter İçermek Zorundadır.";
                  },
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    suffixIcon: IconButton(
                      icon: isPasswordVisible
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  obscureText: isPasswordVisible,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 350,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shadowColor: Colors.blue,
                    ),
                    onPressed: () {
                      kayitEkle();
                    },
                    child: Text(
                      "Kaydol",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  kayitEkle() {
    if (_formAnahtari.currentState.validate()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: sifre)
          .then((user) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => HomePage()),
            (Route<dynamic> route) => false);
      }).catchError((hata) {
        Fluttertoast.showToast(msg: "Hata!");
      });
    }
  }
}
