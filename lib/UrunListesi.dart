import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/Urunler.dart';
import 'package:deneme/UrunlerUpdatePage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Listele extends StatefulWidget {
  const Listele({Key key}) : super(key: key);

  @override
  _ListeleState createState() => _ListeleState();
}

class _ListeleState extends State<Listele> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Listesi"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Deneme")
                      .snapshots(),
                  builder: (context, alinanveri) {
                    if (alinanveri.data == null)
                      return Center(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    else if (alinanveri.hasError) {
                      Fluttertoast.showToast(msg: "Hata");
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        showCheckboxColumn: false,
                        columns: [
                          DataColumn(
                            label: Text("Id"),
                          ),
                          DataColumn(
                            label: Text("Ad"),
                          ),
                          DataColumn(
                            label: Text("Marka"),
                          ),
                          DataColumn(
                            label: Text("Stok"),
                          ),
                          DataColumn(
                            label: Text("Fiyat"),
                          ),
                          DataColumn(
                            label: Text("Ürünü Sil"),
                          ),
                          DataColumn(
                            label: Text("Güncelle"),
                          ),
                        ],
                        rows: _createRows(alinanveri.data, context),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (r) => Urunler()));
          }),
    );
  }

  List<DataRow> _createRows(QuerySnapshot alinanveri, context) {
    List<DataRow> newlist =
        alinanveri.docs.map((DocumentSnapshot documentSnapshot) {
      return new DataRow(
          onSelectChanged: (value) {
            Navigator.push(
                context, MaterialPageRoute(builder: (r) => Urunler()));
          },
          cells: [
            DataCell(
                Text((documentSnapshot.data() as Map)["urunId"].toString())),
            DataCell(
                Text((documentSnapshot.data() as Map)["urunAd"].toString())),
            DataCell(
                Text((documentSnapshot.data() as Map)["urunMarka"].toString())),
            DataCell(
                Text((documentSnapshot.data() as Map)["urunStok"].toString())),
            DataCell(
                Text((documentSnapshot.data() as Map)["urunFiyat"].toString())),
            DataCell(
              IconButton(
                color: Colors.red,
                onPressed: () {
                  String id =
                      (documentSnapshot.data() as Map)["urunId"].toString();
                  DocumentReference verisilyolu =
                      FirebaseFirestore.instance.collection("Deneme").doc(id);
                  showAlertDialog(BuildContext context) {
                    // set up the buttons
                    Widget cancelButton = FlatButton(
                      child: Text("Evet"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        verisilyolu.delete();
                      },
                    );
                    Widget continueButton = FlatButton(
                      child: Text("Hayır"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    );
                    // set up the AlertDialog
                    AlertDialog alert = AlertDialog(
                      title: Text("Uyarı!!!"),
                      content: Text("Ürünü Silmek İstediğinize Emin Misiniz?"),
                      actions: [
                        cancelButton,
                        continueButton,
                      ],
                    );
                    // show the dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  }

                  return showAlertDialog(context);
                },
                icon: Icon(Icons.delete_forever),
              ),
            ),
            DataCell(
              IconButton(
                color: Colors.orange,
                onPressed: () {
                  String id =
                      (documentSnapshot.data() as Map)["urunId"].toString();
                  String ad =
                      (documentSnapshot.data() as Map)["urunAd"].toString();
                  String marka =
                      (documentSnapshot.data() as Map)["urunMarka"].toString();
                  String stok =
                      (documentSnapshot.data() as Map)["urunStok"].toString();
                  String fiyat =
                      (documentSnapshot.data() as Map)["urunFiyat"].toString();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (r) => Urunler1(
                                gelenad: ad,
                                gelenmarka: marka,
                                gelenstok: stok,
                                gelenfiyat: fiyat,
                                gelenid: id,
                              )));
                },
                icon: Icon(Icons.create_outlined),
              ),
            ),
          ]);
    }).toList();
    return newlist;
  }
}
