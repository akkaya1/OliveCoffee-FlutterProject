import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

// create the bannerItems & bannerImage
var bannerItems = ["Coffees", "Desserts"];
var bannerImage = ["images/filtercoffee.jpg", "images/sansebastian.jpg"];

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // data.json file - createList() function
    //
    Future<List<Widget>> createList() async {
      List<Widget> items = [];
      String dataString =
          await DefaultAssetBundle.of(context).loadString("assets/data.json");
      List<dynamic> dataJSON = jsonDecode(dataString);

      for (var element in dataJSON) {
        items.add(Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12, spreadRadius: 2, blurRadius: 1)
                ]),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    element["image"],
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(element["name"]),
                      Text(element["price"])
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
      }
      return items;
    }

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // top - menu icon, logo, person icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu),
                    ),
                    const Text(
                      "Olive Coffee",
                      style: TextStyle(fontSize: 45, fontFamily: "Konimasa"),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.person),
                    ),
                  ],
                ),

                // BannerWidgetArea - upper menu categories
                const BannerWidgetArea(),

                // all menu items - createList() function - data.json file
                FutureBuilder(
                  initialData: const <Widget>[Text("")],
                  future: createList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListView(
                          primary: false,
                          shrinkWrap: true,
                          children: <Widget>[...?snapshot.data],
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
      // coffee button just for design
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {},
        child: Icon(MdiIcons.coffee),
      ),
    );
  }
}

// upper menu categories - coffees & desserts
class BannerWidgetArea extends StatelessWidget {
  const BannerWidgetArea({super.key});
  @override
  Widget build(BuildContext context) {
    // create a controller
    PageController controller =
        PageController(viewportFraction: 0.8, initialPage: 1);

    // create banners var
    List<Widget> banners = [];

    for (int i = 0; i < bannerItems.length; i++) {
      var bannerView = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(4, 4),
                      blurRadius: 4,
                      spreadRadius: 1.5,
                    )
                  ]),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                bannerImage[i],
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                    colors: [Colors.transparent, Colors.black87],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    bannerItems[i],
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  )
                ],
              ),
            )
          ],
        ),
      );
      banners.add(bannerView);
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 9 / 25,
      width: MediaQuery.of(context).size.width,
      child: PageView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: banners,
      ),
    );
  }
}
