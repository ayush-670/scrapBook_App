import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import '../widgets/products/product_fab.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import '../widgets/ui_elements/title_default.dart';
import '../models/product.dart';
import '../scoped_models/main2.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage(this.product);

  Widget _buildAddressPriceRow(double price, String genre) {
    final intPrice = price.toInt();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '\Genre: ' + genre,
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '|',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Text(
          '\₹' + intPrice.toString(),
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        ),
        
      ],
    );
  
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Back button pressed!');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        //appBar: AppBar(
        //title: Text(product.title),
        //),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 256.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(product.title),
                background: Hero(
                  tag: product.id,
                  child: FadeInImage(
                    image: NetworkImage(product.image),
                    height: 300.0,
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets1/Untitled design.jpg'),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    child: TitleDefault(product.title),
                  ),
                  _buildAddressPriceRow(product.price, product.genre),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      product.description,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            
          ],
        ),
        bottomNavigationBar: 
            CupertinoButton(
          child: Text('WhatsApp share'),
          onPressed: () async {
                  var response = await FlutterShareMe().shareToWhatsApp(
                       msg: 'Checkout this awesome article on Kahani App by ${product.userEmail} '+ ':     ' + product.description);
                  if (response == 'success') {
                    print('navigate success');
                  }
                  else{
                    showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('WhatsApp not found'),
                  content: Text('Please try again!'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Okay'),
                    )
                  ],
                );
              });
                  }
              

           /*FlutterShareMe()
                       .shareToWhatsApp( msg: 'Checkout this awesome article on Kahani App by ${product.userEmail} '+ ':     ' + product.description);*/
          },
        ),
        
       
        floatingActionButton: ProductFab(product),
        
       
      ),
    );
  }
}
