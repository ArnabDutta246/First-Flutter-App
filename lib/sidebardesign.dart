import 'package:flutter/material.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class SidebarDesign extends StatefulWidget {
  @override
  _SidebarDesignState createState() => _SidebarDesignState();
}

class _SidebarDesignState extends State<SidebarDesign>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenwidth, screenhight;
  final Duration duration = const Duration(milliseconds: 300);
  final controller = PageController(
    initialPage: 1,
  );
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  //for animation
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<Offset> _slideAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.9).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenwidth = size.width;
    screenhight = size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: <Widget>[menu(context), dashboard(context)],
        ),
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Dashboard",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Meetings",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenwidth,
      right: isCollapsed ? 0 : -0.2 * screenwidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      InkWell(
                        child: Icon(Icons.menu, color: Colors.white),
                        onTap: () {
                          setState(() {
                            if (isCollapsed)
                              _controller.forward();
                            else
                              _controller.reverse();
                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      Text(
                        "My First Design",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      Icon(Icons.settings, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: 200,
                    child: PageView(
                      controller: PageController(viewportFraction: 0.8),
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.redAccent,
                          width: 100,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.blueAccent,
                          width: 100,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.greenAccent,
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Text("List items"),
                  SizedBox(height: 10),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: entries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        color: Colors.amber[colorCodes[index]],
                        child: Center(
                          child: Text('Entry ${entries[index]}'),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
