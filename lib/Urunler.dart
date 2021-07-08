import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'UrunListesi.dart';

class Urunler extends StatefulWidget {
  String gelenid, gelenad, gelenmarka, gelenstok, gelenfiyat;
  Urunler(
      {this.gelenid,
      this.gelenad,
      this.gelenmarka,
      this.gelenstok,
      this.gelenfiyat});
  @override
  _UrunlerState createState() => _UrunlerState();
}

class _UrunlerState extends State<Urunler> {
  final _formAnahtari = GlobalKey<FormState>();
  String ad, id, marka, fiyat, stok;
  final textField = TextEditingController();
  final textField1 = TextEditingController();
  final textField2 = TextEditingController();
  final textField3 = TextEditingController();
  final textField4 = TextEditingController();
  clearAll() {
    textField.clear();
    textField1.clear();
    textField2.clear();
    textField3.clear();
    textField4.clear();
  }

  idAl(idTutucu) {
    this.id = idTutucu;
  }

  adAl(adTutucu) {
    this.ad = adTutucu;
  }

  markaAl(markaTutucu) {
    this.marka = markaTutucu;
  }

  stokAl(stokTutucu) {
    this.stok = stokTutucu;
  }

  fiyatAl(fiyatTutucu) {
    this.fiyat = fiyatTutucu;
  }

  @override
  Widget build(BuildContext context) {
    String lt, ht;
    textField1.text = widget.gelenad;
    textField2.text = widget.gelenmarka;
    textField3.text = widget.gelenstok;
    textField4.text = widget.gelenfiyat;
    if (widget.gelenid == null) {
      lt = "Id";
    } else {
      lt = null;
      ht = "ID GİRİNİZ!!!";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün İşlemleri"),
      ),
      body: Form(
        key: _formAnahtari,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(120, 150, 0, 0),
                      height: 40,
                      child: FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.add),
                      ),
                    ),
                    radius: 100,
                    backgroundImage: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: textField,
                  onChanged: (String idTutucu) {
                    idAl(idTutucu);
                  },
                  decoration: InputDecoration(
                    helperText: ht,
                    helperStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent),
                    labelText: lt,
                    hintText: widget.gelenid,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: textField1,
                  onChanged: (String adTutucu) {
                    adAl(adTutucu);
                  },
                  decoration: InputDecoration(
                    labelText: "Ürün Adı",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: textField2,
                  onChanged: (String markaTutucu) {
                    markaAl(markaTutucu);
                  },
                  decoration: InputDecoration(
                    labelText: "Marka",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: textField3,
                  onChanged: (String stokTutucu) {
                    stokAl(stokTutucu);
                  },
                  decoration: InputDecoration(
                    labelText: "Stok Sayısı",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: textField4,
                  onChanged: (String fiyatTutucu) {
                    fiyatAl(fiyatTutucu);
                  },
                  decoration: InputDecoration(
                    labelText: "Fiyat",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          return textField.text == "" ||
                                  textField1.text == "" ||
                                  textField2.text == "" ||
                                  textField3.text == "" ||
                                  textField4.text == ""
                              ? Fluttertoast.showToast(
                                  msg: "Eksik Bilgi Girişi Yaptınız!")
                              : VeriEkle();
                        },
                        child: Text("Ekle"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green, shadowColor: Colors.green),
                      ),
                    ],
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

  void VeriEkle() {
    DocumentReference veriYolu =
        FirebaseFirestore.instance.collection("Deneme").doc(id);
    Map<String, dynamic> kitaplar = {
      "urunId": id,
      "urunAd": ad,
      "urunMarka": marka,
      "urunStok": stok.toString(),
      "urunFiyat": fiyat.toString(),
    };
    veriYolu.set(kitaplar).whenComplete(() {
      Fluttertoast.showToast(msg: id + "  Id'li ürün eklendi.");
    });
    clearAll();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (r) => Listele()), (route) => false);
  }
}
