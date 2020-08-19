//import 'data.dart';
//import 'rating_bar.dart';
import "homepage.dart";
import 'package:flutter/material.dart';
import "RatingBar.dart";
import "../Api_Services/ApiCall.dart";
import "../Api_Services/Uri.dart";
import "../Pages/CurrentUser.dart";

class Detail extends StatefulWidget
{
  final BookClass book;
  Detail(this.book);

  DetailState createState() => DetailState(book);
}

class DetailState extends State<Detail> {
  final BookClass book;

  bool first=true;

  DetailState(this.book);

  @override
  Widget build(BuildContext context) {
    //app bar
    final appBar = AppBar(
      backgroundColor : Color(0xFF262AAA),
      elevation: .5,
      title: Text('Book details'),
      
    );

    ///detail of book image and it's pages
    final topLeft = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Hero(
            tag: book.coverImage,
            child: Material(
              elevation: 15.0,
              shadowColor: Colors.blue.shade900,
              child: Image(
                image: NetworkImage(book.coverImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        text('${book.pages} pages', color: Colors.black38, size: 12)
      ],
    );

    AddtoCart() async
    {
      int curr_id = CurrentUser.id;

              var data = new Map<String,dynamic>();
              data['userId']=curr_id;
              data['bookId']=book.id;

              var response1 = await ApiCall.createRecord(Uri.GET_ALL_CART, data);
                first = false;
                setState((){});
    }

    Widget firstWidget=
    
      Material(
          borderRadius: BorderRadius.circular(20.0),
          shadowColor: Colors.blue.shade200,
          elevation: 5.0,
          child: MaterialButton(
            onPressed: () {
              AddtoCart();
              },
            minWidth: 160.0,
            color: Colors.blue,
            child: text('ADD TO CART', color: Colors.white, size: 13),
          ),
        );
    

    Widget secondWidget=
    
     Material(
          borderRadius: BorderRadius.circular(20.0),
          shadowColor: Colors.blue.shade200,
          elevation: 5.0,
          child: MaterialButton(
            onPressed: () {
              setState((){first = true;});
              
              },
            minWidth: 160.0,
            color: Colors.green,
            child: text('ADDDED TO CART', color: Colors.white, size: 13),
          ),
        );
    

    ///detail top right
    final topRight = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text(book.title,
            size: 20, isBold: true, padding: EdgeInsets.only(top: 16.0)),
        text(
          'by ${book.authorName}',
          color: Colors.black54,
          size: 12,
          padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
        ),
        text(
          '${book.category}',
          color: Colors.black54,
          size: 12,
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
        ),
        Row(
          children: <Widget>[
            text(
              book.price.toString()+" Rs.",
              isBold: true,
              padding: EdgeInsets.only(right: 8.0),
            ),
            RatingBar(rating: book.id%2==0 ? 3.5 :4.5 )
          ],
        ),
        SizedBox(height: 32.0),
        AnimatedCrossFade(
          duration: const Duration(seconds: 3),
          firstChild: firstWidget,
          secondChild: secondWidget,
          crossFadeState: first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        )
      ],
    );

    

    final topContent = Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(flex: 2, child: topLeft),
          Flexible(flex: 3, child: topRight),
        ],
      ),
    );

    ///scrolling text description
    final bottomContent = Container(
      height: 400.0,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in mollis ipsum, elementum lacinia mauris. Integer ut sem purus. Nullam lobortis euismod leo, ullamcorper auctor orci fermentum at. Mauris metus turpis, accumsan quis quam in, tincidunt aliquam nisi. Etiam congue pulvinar sapien. Nulla ullamcorper tempor leo non facilisis. Cras tincidunt, mauris lobortis dignissim fringilla, velit mauris convallis leo, eget placerat velit dolor non neque. Sed sit amet mollis est, id vestibulum est.Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec leo dui, bibendum vitae rhoncus ac, condimentum euismod mauris. Curabitur non rhoncus ipsum, eget consectetur massa. Phasellus in ligula at metus sodales venenatis. Integer ut porttitor magna. Proin tincidunt commodo posuere. Cras nec ornare eros. Pellentesque tristique est a interdum pharetra. Donec pretium neque sed nunc mollis venenatis. Integer tincidunt risus in consequat sodales. Aenean vulputate est eu semper mattis.",
          style: TextStyle(fontSize: 13.0, height: 1.5),
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: ListView(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }

  ///create text widget
  text(String data,
          {Color color = Colors.black87,
          num size = 14,
          EdgeInsetsGeometry padding = EdgeInsets.zero,
          bool isBold = false}) =>
      Padding(
        padding: padding,
        child: Text(
          data,
          style: TextStyle(
              color: color,
              fontSize: size.toDouble(),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      );
}