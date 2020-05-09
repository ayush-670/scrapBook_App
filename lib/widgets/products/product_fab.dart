import 'package:first_app/pages/product.dart';
import 'package:flutter/material.dart';
import '../../models/product.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_models/main2.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:share/share.dart';
import 'package:flutter/widgets.dart';

class ProductFab extends StatefulWidget {
  final Product product;

  ProductFab(this.product);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductFabState();
  }
}

class _ProductFabState extends State<ProductFab> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          height: 70.0,
          width: 56.0,
          alignment: FractionalOffset.topCenter,
          child: ScaleTransition(
            scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 1.0, curve: Curves.easeOut)),
            child: FloatingActionButton(
              backgroundColor: Colors.grey[900],
              heroTag: 'contact',
              mini: true,
              onPressed: () async {
                final url = 'mailto:${widget.product.userEmail}';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw ' Could not launch!';
                }
              },
              child: Icon(
                Icons.mail,
                color: Colors.red,
              ),
            ),
          ),
        ),
        Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
              scale: CurvedAnimation(
                  parent: _controller,
                  curve: Interval(0.0, 0.5, curve: Curves.easeOut)),
              child: FloatingActionButton(
                backgroundColor: Colors.grey[900],
                heroTag: 'share',
                mini: true,
                onPressed: () {
                  Share.share('check out my website https://example.com',
                      subject: 'Look what I made!');
                },
                child: Icon(Icons.share, color: Colors.red),
              ),
            )),
        Container(
          height: 70.0,
          width: 56.0,
          child: FloatingActionButton(
              heroTag: 'options',
              onPressed: () {
                if (_controller.isDismissed) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              },
              child: AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget child) {
                    return Transform(
                      alignment: FractionalOffset.center,
                      transform:
                          Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                      child: Icon(_controller.isDismissed
                          ? (Icons.more_vert)
                          : Icons.close),
                    );
                  })),
        ),
      
      ],
     
      );
     
    
    });
  }
}
