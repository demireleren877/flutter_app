import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:web_scraper/web_scraper.dart';

class Siparisler extends StatefulWidget {
  const Siparisler({Key key}) : super(key: key);
  @override
  _SiparislerState createState() => _SiparislerState();
}

class _SiparislerState extends State<Siparisler> {
  String searchtext = "";
  WebScraper webScraper;
  bool loaded = false;
  List<Map<String, dynamic>> listitles;
  List<Map<String, dynamic>> listprices;
  @override
  void initState() {
    super.initState();
  }

  _getData() async {
    searchtext.isEmpty ?? true
        ? Fluttertoast.showToast(msg: "Eksik Bilgi Girdiniz!")
        : webScraper = WebScraper("https://www.cimri.com/");
    if (await webScraper.loadWebPage("$searchtext".replaceAll(" ", "-"))) {
      List<Map<String, dynamic>> titles =
          webScraper.getElement("h3.product-title", ["title"]);
      List<Map<String, dynamic>> prices =
          webScraper.getElement('div.pbox1-price.c-18', ["title"]);
      setState(() {
        loaded = true;
        listitles = titles;
        listprices = prices;
      });
      print(prices);
    }
  }

  Widget build(BuildContext context) {
    final alltitles = listitles?.map((e) {
          final title = e["title"].toString();
          return ListTile(
            onTap: () {},
            title: Text(title),
          );
        })?.toList() ??
        [];
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _getData();
              })
        ],
        title: Text("En Ucuz Ürünler"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  onChanged: (searchtext) {
                    setState(() {
                      this.searchtext = searchtext;
                    });
                  },
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: "Aramak İstediğiniz Ürünü Giriniz.",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              Container(
                width: 150,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue[800],
                  ),
                  onPressed: () {
                    _getData();
                  },
                  child: Text(
                    "Ara",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ...alltitles,
            ],
          ),
        ),
      ),
    );
  }
}
