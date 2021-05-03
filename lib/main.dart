import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 5, vsync: this);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: Colors.green),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 35),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.menu,
                    color: Colors.grey,
                    size: 30,
                  ),
                  Icon(
                    Icons.shopping_cart,
                    size: 30,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text("Top Picks",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              height: 30,
            ),
            TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey.withOpacity(0.6),
                indicatorColor: Colors.green,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.symmetric(horizontal: 20),
                tabs: [
                  Tab(
                    child: Text(
                      "Top",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Outdoor",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Indoor",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "New Arrival",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Top Picks",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ]),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 500,
              width: double.infinity,
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: _plants.length,
                  itemBuilder: (context, i) => Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xff32A060),
                                borderRadius: BorderRadius.circular(20)),
                            child: Stack(
                              children: [
                                Center(
                                  child: Hero(
                                    tag: _plants[i].imageUrl,
                                    child: Image.asset(
                                      _plants[i].imageUrl,
                                      width: 280,
                                      height: 280,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
            )
          ],
        ),
      ),
    );
  }
}

List<Plants> _plants = [
  Plants(
    name: "Janda Bolong",
    description:
        "Tanaman hias monstera janda bolong/tanaman hias rumahan janda bolong",
    imageUrl: "assets/janda_bolong.png",
    price: 99000,
  ),
  Plants(
    name: "Janda Bolong",
    description:
        "Tanaman hias monstera janda bolong/tanaman hias rumahan janda bolong",
    imageUrl: "assets/janda_bolong.png",
    price: 99000,
  ),
  Plants(
      name: "Janda Bolong",
      description:
          "Tanaman hias monstera janda bolong/tanaman hias rumahan janda bolong",
      imageUrl: "assets/janda_bolong.png",
      price: 99000)
];

class Plants {
  String name;
  String description;
  String imageUrl;
  int price;

  Plants({this.description, this.imageUrl, this.name, this.price});
}
