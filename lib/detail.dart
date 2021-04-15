import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hisnul_muslim/animations/bottomAnimation.dart';
import 'package:hisnul_muslim/model/ItemListModel.dart';

class Detail extends StatefulWidget {
  final String id, ar_title, en_title;

  const Detail({
    Key key,
    @required this.id,
    @required this.ar_title,
    @required this.en_title,
  }) : super(key: key);

  @override
  _DetailState createState() => _DetailState(id, ar_title, en_title);
}

class _DetailState extends State<Detail> {
  final String id, ar_title, en_title;

  _DetailState(this.id, this.ar_title, this.en_title);

  ItemListModel itemListModel;

  getDetailList() async {
    String jsonItem = await DefaultAssetBundle.of(context)
        .loadString("assets/json_files/dua_item.json");

    var jsonResponse = json.decode(jsonItem);

    setState(() {
      itemListModel = new ItemListModel.fromJson(jsonResponse, id);
    });
  }

  @override
  void initState() {
    super.initState();

    getDetailList();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                    onTap: () => {buildPop()},
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Icon(
                        Icons.keyboard_backspace_rounded,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[850],
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
                child: Text(widget.en_title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: height * 0.045)),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount:
                    itemListModel != null ? itemListModel.itemList.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  return WidgetAnimator(
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Card(
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Container(
                                      child: Text(
                                          itemListModel.itemList[index].ar_dua,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontFamily: 'Amiri',
                                              fontWeight: FontWeight.w100)),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Color(0xffee8f8b),
                                  height: 2.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(itemListModel
                                      .itemList[index].en_translation),
                                ),
                                Divider(
                                  color: Color(0xffee8f8b),
                                  height: 2.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(itemListModel
                                      .itemList[index].en_reference),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void buildPop() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }
}
