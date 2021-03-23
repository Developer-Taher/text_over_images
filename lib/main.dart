import 'dart:ui';
// import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:url_launcher/url_launcher.dart';

import 'imagepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Over Image',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Text Over Image'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  // final phonenumber = "01067093670";
  // final name = "طاهر زيدان";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey imageKey = GlobalKey();

  void launchwhatsapp({@required number, @required message}) async {
    try {
      String url = 'whatsapp://send?phone=$number text=$message';
      await canLaunch(url) ? launch(url) : print('can\'t open whatsapp');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          RepaintBoundary(
            key: imageKey,
            child: Stack(
              children: [
                Image.asset(
                  'assets/win.png',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 180, left: 110),
                  child: Text(
                    'طاهر عبد المنعم رياض ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 225, left: 140),
                  child: Text(
                    '01067093670 ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.camera_alt_outlined,
                ),
                onPressed: () async {
                  RenderRepaintBoundary imageobject =
                      imageKey.currentContext.findRenderObject();
                  final image = await imageobject.toImage(pixelRatio: 2);
                  ByteData bytedata = await image.toByteData(
                    format: ImageByteFormat.png,
                  );
                  final pngbyts = bytedata.buffer.asUint8List();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Imagepage(
                        imageBytes: pngbyts,
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.share,
                ),
                onPressed: () async {
                  RenderRepaintBoundary imageobject =
                      imageKey.currentContext.findRenderObject();
                  final image = await imageobject.toImage(pixelRatio: 2);
                  ByteData bytedata = await image.toByteData(
                    format: ImageByteFormat.png,
                  );
                  final pngbyts = bytedata.buffer.asInt8List();
                  launchwhatsapp(
                      // image: pngbyts,
                      number: '+20 102 244 5719',
                      message: 'wellcome to virgina gold store');
                  // final base64String = base64Encode(pngbyts);
                  await FlutterOpenWhatsapp.sendSingleMessage(
                      "+20 102 244 5719", "wellcome to virgina gold store");
                  // await Share.file(
                  //     'esys image', 'esys.png', pngbyts, 'image/png',
                  //     text:
                  //         'سعداء بخدماتكم فى محل فيرجينيا للمصوغات و المجوهات .');
                  // await Share.file(
                  //     'esys image', 'esys.png', pngbyts, 'image/png',
                  //     text:
                  //         'سعداء بخدماتكم فى محل فيرجينيا للمصوغات و المجوهات .');
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
