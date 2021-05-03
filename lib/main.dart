import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
  int selectedPage = 0;
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
              height: 450,
              width: double.infinity,
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: _plants.length,
                  onPageChanged: (value) {
                    setState(() {
                      selectedPage = value;
                    });
                  },
                  itemBuilder: (context, i) => plantsCard(context, i)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Text(
                "Description",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                _plants[selectedPage].description,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget plantsCard(BuildContext context, int i) {
    return AnimatedBuilder(
      builder: (context, widget) {
        double value = 1;

        if (_pageController.position.haveDimensions) {
          value = _pageController.page - i;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }

        return Center(
          child: SizedBox(
            child: widget,
            height: Curves.easeInOut.transform(value) * 450,
            width: Curves.easeInOut.transform(value) * 350,
          ),
        );
      },
      animation: _pageController,
      child: GestureDetector(
        onTap: () {
          Get.to(() => PlantsPage(_plants[i]));
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: i == 0 ? 0 : 10, bottom: 30, top: 0, right: 0),
              decoration: BoxDecoration(
                  color: Color(0xff32A060),
                  borderRadius: BorderRadius.circular(20)),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      _plants[i].imageUrl,
                      width: 280,
                      height: 280,
                    ),
                  ),
                  Positioned(
                      right: 30,
                      top: 30,
                      child: Column(
                        children: [
                          Text(
                            "PRICE",
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "\$${_plants[i].price.toString()}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )),
                  Positioned(
                    left: 30,
                    bottom: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _plants[i].category,
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          _plants[i].name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 4,
                child: FloatingActionButton(
                  heroTag: null,
                  elevation: 0,
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.black,
                  onPressed: () {},
                ))
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
    price: 99,
    category: "Outdoor",
  ),
  Plants(
      name: "Janda Bolong",
      description:
          "Tanaman hias Anthurium plowmanii atau terkenal dengan nama gelombang cinta pun pernah jadi tanaman favorite orang-orang berduit.",
      imageUrl: "assets/janda_bolong.png",
      price: 99,
      category: "Indoor"),
  Plants(
      name: "Janda Bolong",
      description:
          "Tanaman hias monstera janda bolong/tanaman hias rumahan janda bolong",
      imageUrl: "assets/janda_bolong.png",
      category: "New Arrival",
      price: 99)
];

class Plants {
  String name;
  String description;
  String imageUrl;
  String category;
  int price;

  Plants(
      {this.description, this.imageUrl, this.name, this.price, this.category});
}

class PlantsPage extends StatelessWidget {
  Plants plants;

  PlantsPage(this.plants);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 400,
                  color: Color(0xff32A060),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              Icon(
                                Icons.shopping_cart,
                                size: 30,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            plants.category.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            plants.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "FROM",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "\$" + plants.price.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            "SIZE",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Small",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FloatingActionButton(
                            elevation: 0,
                            child: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.black,
                            onPressed: () {},
                          )
                        ]),
                  ),
                ),
                Positioned(
                    right: 5,
                    bottom: 20,
                    child: Image.asset(
                      plants.imageUrl,
                      height: 250,
                      width: 250,
                    ))
              ],
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -20.0, 0.0),
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, top: 20),
                    child: Text(
                      "All to know",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 10,
                    ),
                    child: Text(
                      plants.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                    ),
                    child: Text(
                      "Details",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 10,
                    ),
                    child: Text(
                      "Plant height: 24-35cm",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                    ),
                    child: Text(
                      "Nursery pot width: 12cm",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
