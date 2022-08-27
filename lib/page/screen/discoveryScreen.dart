import 'package:flutter/material.dart';

class DiscoveryScreen extends StatefulWidget {
  @override
  _DiscoveryScreenState createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TwoCardPageView(),
    );
  }
}

class TwoCardPageView extends StatefulWidget {
  const TwoCardPageView({Key? key}) : super(key: key);

  @override
  _TwoCardPageViewState createState() => _TwoCardPageViewState();
}

class _TwoCardPageViewState extends State<TwoCardPageView> {
  final List<String> _images = [
    "assets/image/discovery1.png",
    "assets/image/discovery2.png",
    "assets/image/discovery3.png",
    "assets/image/discovery4.png",
    "assets/image/discovery5.png",
    "assets/image/discovery6.png",
  ];

  final List<String> titles = [
    "Basic info",
    "Basic info",
    "Introduction",
    "Character",
    "Character",
    "Q&A"
  ];

  final PageController _pageController =
      PageController(viewportFraction: 0.8, initialPage: 0);
  double _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page != null) {
        _page = _pageController.page!;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int i = 0; i < _images.length; i++)
                Container(
                  margin: EdgeInsets.fromLTRB(5, 20, 5, 20),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 1.5),
                      color: _page - i > 1 || _page - i < -1
                          ? Colors.transparent
                          : _page - i > 0
                              ? Colors.grey.withOpacity(1 - (_page - i))
                              : Colors.grey.withOpacity(1 - (i - _page))),
                )
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 400,
            child: PageView.builder(
                controller: _pageController,
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    child: Column(
                      children: [
                        Expanded(child: Image.asset(_images[index])),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                            child: Text(titles[index],
                                style: TextStyle(
                                    fontFamily: 'Abhaya Libre',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30.0))),
                        Card(
                            elevation: 0.0,
                            child: ListTile(
                              title: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                                  child: Text("강살롱, 24살",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0xff365859),
                                          fontWeight: FontWeight.w800))),
                              subtitle: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Text("배우 | 164cm |  마름",
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyle(color: Color(0xffC4C4C4)))),
                            )),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class ItemBuilder extends StatelessWidget {
  const ItemBuilder({
    Key? key,
    required List<String> images,
    required this.index,
  })  : _images = images,
        super(key: key);

  final List<String> _images;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      height: 200,
      child: Center(child: Text("")),
    );
  }
}

class Item {
  final String title;
  final Color color;

  Item(this.title, this.color);
}
