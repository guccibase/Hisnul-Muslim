import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hisnul_muslim/Splash.dart';
import 'package:hisnul_muslim/animations/bottomAnimation.dart';
import 'package:hisnul_muslim/customWidgets/flare.dart';
import 'package:hisnul_muslim/detail.dart';
import 'package:hisnul_muslim/model/CategoryListModel.dart';
import 'package:hisnul_muslim/model/CategoryModel.dart';

void main() {
  runApp(MyApp());
}

final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Color(0xff896277),
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    fontFamily: 'Sogeo',
    textTheme: TextTheme(
        headline1: TextStyle(
            fontFamily: 'Sogeo', fontSize: 42, fontWeight: FontWeight.w600),
        headline2: TextStyle(
            fontFamily: 'Sogeo', fontSize: 28, fontWeight: FontWeight.w600),
        bodyText1: TextStyle(
            fontFamily: "Sogeo", fontSize: 18, fontWeight: FontWeight.w600),
        caption: TextStyle(fontFamily: "Sogeo", fontSize: 14)));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      title: 'Hisnul Muslim (Fortress of Muslim)',
      home: Splash(), //
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CategoryModel> _searchResult = [];
  List<CategoryModel> _userDetails = [];
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();

    loadCategories();
  }

  Future loadCategories() async {
    String jsonPhotos = await DefaultAssetBundle.of(context)
        .loadString("assets/json_files/dua_category.json");
    final jsonResponse = json.decode(jsonPhotos);
    setState(() {
      CategoryListModel categoryList = CategoryListModel.fromJson(jsonResponse);

      _userDetails = categoryList.catList;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hisnul Muslim'),
        brightness: Brightness.dark,
      ),
      body: Stack(
        children: [
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -50,
            flareDuration: Duration(seconds: 17),
            left: 100,
            height: 60,
            width: 60,
          ),
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -50,
            flareDuration: Duration(seconds: 12),
            left: 10,
            height: 25,
            width: 25,
          ),
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -40,
            left: -100,
            flareDuration: Duration(seconds: 18),
            height: 50,
            width: 50,
          ),
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -50,
            left: -80,
            flareDuration: Duration(seconds: 15),
            height: 50,
            width: 50,
          ),
          Flare(
            color: Color(0xfff9e9b8),
            offset: Offset(width, -height),
            bottom: -20,
            left: -120,
            flareDuration: Duration(seconds: 12),
            height: 40,
            width: 40,
          ),
          Column(
            children: [
              Container(
                  color: Theme.of(context).primaryColor,
                  child: _buildSearchBox()),
              Expanded(
                child: _searchResult.length != 0 || controller.text.isNotEmpty
                    ? _buildSearchResults()
                    : _buildListView(),
              ),
            ],
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  Widget _buildListView() {
    return Container(
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            color: Color(0xffee8f8b),
            height: 2.0,
          );
        },
        itemCount: _userDetails.length,
        itemBuilder: (context, index) {
          return WidgetAnimator(
            ListTile(
              leading: Text(
                "${_userDetails[index].id}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              title: Text(
                "${_userDetails[index].en_title}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              subtitle: Text(
                "${_userDetails[index].ar_title}",
                textDirection: TextDirection.rtl,
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Detail(
                            id: _userDetails[index].id,
                            en_title: _userDetails[index].en_title,
                            ar_title: _userDetails[index].ar_title,
                          )),
                )
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchResults() {
    return Container(
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            color: Color(0xffee8f8b),
            height: 2.0,
          );
        },
        itemCount: _searchResult.length,
        itemBuilder: (context, index) {
          return WidgetAnimator(
            ListTile(
              leading: Text(
                "${_searchResult[index].id}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              title: Text(
                "${_searchResult[index].en_title}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              subtitle: Text(
                "${_searchResult[index].ar_title}",
                textDirection: TextDirection.rtl,
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Detail(
                            id: _searchResult[index].id,
                            en_title: _searchResult[index].en_title,
                            ar_title: _searchResult[index].ar_title,
                          )),
                )
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Row(
            children: [
              Icon(Icons.search),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: TextField(
                    obscureText: false,
                    controller: controller,
                    decoration: new InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none,
                    ),
                    onChanged: onSearchTextChanged,
                  ),
                ),
              ),
              IconButton(
                icon: new Icon(Icons.cancel),
                onPressed: () {
                  controller.clear();
                  onSearchTextChanged('');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();

    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.en_title.toLowerCase().contains(text.toLowerCase())) {
        _searchResult.add(userDetail);
      }
    });

    setState(() {});
  }
}
