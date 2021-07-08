import 'package:deneme/HomePage.dart';
import 'package:deneme/KayitOlustur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key key}) : super(key: key);

  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController t1 = TextEditingController();
  bool isPasswordVisible = true;
  String email, sifre;
  var _formAnahtari = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formAnahtari,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                ),
                CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(
                      "https://image.flaticon.com/icons/png/512/295/295128.png"),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: t1,
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
                    prefixIcon: Icon(Icons.email),
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
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Password",
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
                      girisYap();
                    },
                    child: Text(
                      "Giriş Yap",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => KayitSayfasi()));
                      },
                      child: Text(
                        "Yeni Hesap Oluştur.",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void girisYap() {
    if (_formAnahtari.currentState.validate()) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: sifre)
          .then((user) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => HomePage(
                      usermail: t1.text,
                    )),
            (route) => false);
      }).catchError((hata) {
        Fluttertoast.showToast(msg: hata);
      });
    }
  }
}
