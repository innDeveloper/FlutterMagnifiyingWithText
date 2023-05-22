import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MagnifierDemo extends StatefulWidget {
  const MagnifierDemo({Key? key}) : super(key: key);

  @override
  State<MagnifierDemo> createState() => _MagnifierDemoState();
}

class _MagnifierDemoState extends State<MagnifierDemo> {
  String? data;

  void loadData() async {
    final loadedData = await rootBundle.loadString('assets/sample.txt');
    setState(() {
      data = loadedData;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Offset dragGesturePosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Raw Magnifier"),
          centerTitle: true,
        ),
        body: Center(
          child: Stack(
            children: <Widget>[
              GestureDetector(
                  onPanUpdate: (DragUpdateDetails details) => setState(
                        () {
                          dragGesturePosition = details.localPosition;
                        },
                      ),
                  child: Container(
                    // adding margin
                    margin: const EdgeInsets.all(10.0),
                    // adding padding
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15),
                    // height should be fixed for vertical scrolling
                    height: MediaQuery.of(context).size.height * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // adding borders around the widget
                      border: Border.all(
                        color: Colors.blueAccent,
                        width: 2.0,
                      ),
                    ),
                    child: Text(
                      data ?? 'Text File Loading',
                    ),
                  )),
              Positioned(
                left: dragGesturePosition.dx,
                top: dragGesturePosition.dy,
                child: const RawMagnifier(
                  decoration: MagnifierDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Color.fromARGB(255, 181, 181, 181), width: 3),
                    ),
                  ),
                  size: Size(180, 70),
                  magnificationScale: 1.3,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
