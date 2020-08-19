import 'package:flutter/material.dart';

import '../bloc.navigation_bloc/navigation_bloc.dart';

import 'package:flutter/material.dart';
import '../Widget/rounded_bordered_container.dart';
import "../Pages/CurrentUser.dart";
import "homepage.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";

import "../Api_Services/ApiCall.dart";
import "../Api_Services/Uri.dart";

import "confirmorder.dart";

class MyCartPage extends StatelessWidget with NavigationStates
{
	@override
	Widget build(BuildContext context)
	{
    print("efhoehfohef"+CurrentUser.id.toString());
    CurrentUser.id = 3;
    print("efhoehfohef"+CurrentUser.id.toString());
		return MaterialApp(
			debugShowCheckedModeBanner : false,
			home : MycartPage2(),
		);
	}
}


class MycartPage2 extends StatefulWidget with NavigationStates{
	@override
	MycartPageState createState() => MycartPageState();
}

class MycartPageState extends State<MycartPage2> {
  static final String path = "lib/src/pages/ecommerce/cart2.dart";


  List<int> cart=[];
  List<dynamic> prices = [];
  List<int> quantities = [];
  int currentQuantity=1;
  GlobalKey<ScaffoldState> _scaffoldKey;
  dynamic totalPrice=0;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    
  }


  @override  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : Colors.grey[300],
    	key: _scaffoldKey,
        appBar: AppBar(
	        elevation: 1.1,
	        backgroundColor: Colors.white,
	        title : Text("\t\tMY CART",style : TextStyle(color : Color(0xFF262AAA))),
	        actions: <Widget>[

	          Icon(Icons.search, color: Colors.grey)
	        ],
	      ),
        body: FutureBuilder(
        	future : getData(),
        	builder : (b,s){
        		if(s.data==null){
        			return Center(
        				child : SpinKitWave(color: Color(0xFF262AAA), type: SpinKitWaveType.start)
        			);
        		}
        		else{
        			if(s.data.length==0){
        				return Center(child : Text("Cart Empty..!",style : TextStyle(color : Colors.black,
                fontWeight : FontWeight.bold,fontSize : 25.0)));
        				
        			}
        			else{
        				return Column(
					          children: <Widget>[
					            Flexible(
					              child: ListView.builder(
					                itemCount: s.data.length,
					                itemBuilder: (context, int index) {
					                  return cartItems(s.data[index],index);
					                },
					              ),
					            ),
					            _checkoutSection()
					          ],
					        );
        			}
        		}
        	}
        ),




        
        );
  }

  Route _createRoute(total) 
  {
      return PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => ConfirmOrderPage(total),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.easeOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
        position: animation.drive(tween),
        child: child,
        );
      },
      );
  }

  Future<List<BookClass>> getData() async
  {
  	//var json = await ApiCall.getDataFromApi(Uri.GET_ALL_BOOKS+""+filters);
    var json1 = await ApiCall.getDataFromApi(Uri.GET_ALL_CART+"/3");
    print(json1.length);
    //print(json);
    cart.clear();
    prices.clear();
    quantities.clear();
    totalPrice=0;
    int count=0;
    List<BookClass> countries = [];
    if(json1 == "nothing")
    {
      return countries;
    }
    for(int i=0;i<json1.length;i++)
    {
      int bookId = json1[i]['bookId'];
      cart.add(bookId);
    }
    for(int i=0;i<cart.length;i++)
    {
    	var json = await ApiCall.getDataFromApi(Uri.GET_ALL_BOOKS+"/${cart[i]}");
    	//print("length = ${json.length}");
    	
	      int _id = json['bookId'];
	      //print("here");
	      String _coverImage = json['coverImage'];
	      //print((++count).toString());
	      String _title = json['title'];
	      //print((++count).toString());
	      dynamic _price = json['price'];
	      print("type =   ${_price.runtimeType}");
	      prices.add(_price);
	      ;
	      //print((++count).toString());
	      int _pages = json['pages'];
	      //print((++count).toString());
	      String _authorName = json['authorName'];
	      //print((++count).toString());

	      String _category = json['category'];
	      //print((++count).toString());
	      String _description = json['description'];
	      //print((++count).toString());
        int _quantity = json['quantity'];
        int _currentQuantity = json['currentQuantity'];
        totalPrice=totalPrice+(_price*_currentQuantity);
        //quantities.add(1) ;
	      //print("Here");
	      BookClass obj = new BookClass.retrieve(
	        _id,
	        _coverImage,
	        _title,
	        _price,
	        _pages,
	        _authorName,
	        _category,
	        _description,
          _quantity,
          _currentQuantity
	      );
	      //print("here");
	      
	    
	    countries.add(obj);
    }
    

    print("dekh le!");

    return countries;
  }

  decreamentQuantity(obj) async
  {
  	obj.currentQuantity-=1;
  	var response1 = await ApiCall.updateRecord(Uri.GET_ALL_BOOKS,obj.toJson());
  	setState((){});
  }

  increamentQuantity(obj) async
  {
  	obj.currentQuantity+=1;
  	var response1 = await ApiCall.updateRecord(Uri.GET_ALL_BOOKS,obj.toJson());
  	setState((){});
  }

  deleteCart(bookId) async
  {
    int curr_id = CurrentUser.id;
    var response1 = await ApiCall.deleteRecord(Uri.GET_ALL_CART + "/${curr_id}/${bookId}");
    setState((){});
  }

  void showMessage(String message, Color bgcolor,Color txtcolor) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: bgcolor,
        content: new Text(message, style: TextStyle(color: txtcolor,fontSize : 20.0,fontWeight : FontWeight.bold))));
  }

  Widget cartItems(BookClass obj,index) {
    return RoundedContainer(
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.all(10),
      height: 130,
      child: Row(
        children: <Widget>[
          Container(
            width: 130,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(obj.coverImage),
                fit: BoxFit.cover,
              )
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          obj.title,
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ),
                      Container(
                        width: 50,
                        child: IconButton(
                          onPressed: () {
                            //print("delete icon Button Pressed");
                            deleteCart(obj.id);
                          },
                          color: Colors.red,
                          icon: Icon(Icons.delete),
                          iconSize: 20,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Price: "),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${prices[index]*obj.currentQuantity} ₹.',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Ships Free",
                        style: TextStyle(color: Colors.orange),
                      ),
                      Spacer(),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                            	if((obj.currentQuantity-1)>0){
                            		decreamentQuantity(obj);
                            	}
                            	else
                            	{
                            		showMessage("Not possible !!!.",Colors.white,Color(0xFF262AAA));
                            	}
                            	},
                            splashColor: Colors.redAccent.shade200,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.redAccent,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(obj.currentQuantity.toString()),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          InkWell(
                            onTap: () {
                            	if((obj.currentQuantity+1)<=obj.quantity){
                            		increamentQuantity(obj);
                            	}
                            	else
                            	{
                            		showMessage("Cannot add more than 20 books !!!.",Colors.white,Color(0xFF262AAA));
                            	}
                            	},
                            splashColor: Colors.lightBlue,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _checkoutSection() {
    return Material(
      color: Colors.black12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    "Checkout Price:",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  Text(
                    "Rs. $totalPrice",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              color: Color(0xFF262AAA),
              elevation: 1.0,
              child: InkWell(
                //splashColor: Colors.redAccent,
                onTap: () {
                	Navigator.of(context).push(_createRoute(totalPrice));
                	},
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Checkout",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}