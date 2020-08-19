import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import "../Api_Services/Uri.dart";
import "../Pages/CurrentUser.dart";
import "../Api_Services/ApiCall.dart";
import '../bloc.navigation_bloc/navigation_bloc.dart';
import "package:flutter_spinkit/flutter_spinkit.dart";

import "homepage.dart";
import "detail.dart";

class MyAccountsPage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner : false,
		home : MyWishlist(),
    );
  }
}


class MyWishlist extends StatefulWidget
{
	MyWishlistState createState() => MyWishlistState();
}

class MyWishlistState extends State<MyWishlist> with SingleTickerProviderStateMixin
{
	List<int> wishlists=[];


	refresh(context)
	{
		return FutureBuilder(
			future : getData(),
			builder : (c,snapshot){
				if(snapshot.data==null){
					return Center(
						child : SpinKitWave(color: Color(0xFF262AAA), type: SpinKitWaveType.start)
					);
				}
				else
				{
					if(snapshot.data.length==0)
					{
						return Center(
							//child : CircularProgressIndicator(),
							child : Text("Wishlist Empty ..!",style : TextStyle(color : Colors.black,
                fontWeight : FontWeight.bold,fontSize : 25.0)),
             /* child : Container(
                width : 200.0,
                height : 200.0,
                child : Image(image : new AssetImage("Assets/Images/empty_wishlist.png")),
              ),*/
						);
					}
					else{
						return Container(
							width : MediaQuery.of(context).size.width,
							height: MediaQuery.of(context).size.height,
							child: ListView.builder(
								shrinkWrap: true,
								itemCount: snapshot.data.length,
								itemBuilder : (c,ind){
									return CartItem(snapshot.data[ind]);
								}
							)
						);
					}
					
				}
			}
		);
	}


	Future<List<BookClass>> getData() async {
    //var json = await ApiCall.getDataFromApi(Uri.GET_ALL_BOOKS+""+filters);
    var json1 = await ApiCall.getDataFromApi(Uri.GET_ALL_WISHLIST+"/3");
    print(json1.length);
    //print(json);
    wishlists.clear();
    int count=0;
    List<BookClass> countries = [];
    if(json1 == "nothing")
    {
      return countries;
    }
    for(int i=0;i<json1.length;i++)
    {
      int bookId = json1[i]['bookId'];
      wishlists.add(bookId);
    }
    for(int i=0;i<wishlists.length;i++)
    {
    	var json = await ApiCall.getDataFromApi(Uri.GET_ALL_BOOKS+"/${wishlists[i]}");
    	//print("length = ${json.length}");
    	
	      int _id = json['bookId'];
	      //print("here");
	      String _coverImage = json['coverImage'];
	      //print((++count).toString());
	      String _title = json['title'];
	      //print((++count).toString());
	      dynamic _price = json['price'];
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



	//List<String> items = List.generate(10, ((i){ return "Item $i"; }));
		@override
	  Widget build(BuildContext context) {
	    return Scaffold(
	      backgroundColor: Colors.grey[200],
	      appBar: AppBar(
	        elevation: 1.1,
	        backgroundColor: Colors.white,
	        title : Text("\t\tWISHLIST",style : TextStyle(color : Color(0xFF262AAA))),
	        actions: <Widget>[
	          Icon(Icons.search, color: Colors.grey)
	        ],
	      ),
	      body: refresh(context),
	      
	    );
	  }
}



class CartItem extends StatefulWidget {
	BookClass obj;
	CartItem(BookClass obj)
	{
		this.obj = obj;
		
	}
  @override
  _CartItemState createState() => _CartItemState(obj);
}

class _CartItemState extends State<CartItem>
    with TickerProviderStateMixin {
BookClass obj;
    _CartItemState(BookClass obj)
    {
    	this.obj = obj;
    	print("obj.id = ${obj.id}" );
    }
  Duration _duration = Duration(seconds : 2);

  double _size = 180;
  Animation<double> _delayedAnimation;
  Animation<double> _opacityAnimation;
  AnimationController _animationController;
  AnimationController _opacityController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2000)
    );

    _opacityController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400)
    );


    _opacityAnimation = Tween<double>(
      begin: 1, //TODO: set this value back to 1
      end: 0
    ).animate(
      CurvedAnimation(
        parent: _opacityController,
        curve: Curves.linear
      )
    )..addStatusListener((status){
      if(status == AnimationStatus.completed){
        _animationController.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  deleteWishlistandAddtoCart(bookId) async
  {
    int curr_id = CurrentUser.id;
    var response1 = await ApiCall.deleteRecord(Uri.GET_ALL_WISHLIST + "/${curr_id}/${bookId}");
    //setState((){});
    var data = new Map<String,dynamic>();
              data['userId']=curr_id;
              data['bookId']=bookId;

              var response2 = await ApiCall.createRecord(Uri.GET_ALL_CART, data);
  }

  @override
  Widget build(BuildContext context) {
    _delayedAnimation = Tween<double>(
        begin: 10,
        end: MediaQuery.of(context).size.width
    )
        .animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(
                0.0, 1.0,
                curve: Curves.bounceInOut
            )
        ))
      ..addStatusListener((status){
      if(status == AnimationStatus.completed){
        _size = 0;
        setState(() {});
      }
    });

    return GestureDetector(
      onTap: (){
        //_animationController.forward();
        //print("obj.id = ${obj.id}");
        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Detail(
                                          obj,
                                        )
                                    )
                                );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 300,
        height: _size,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            AnimatedBuilder(
              animation: _animationController,
              builder: (c, ch){
                return Positioned(
                  left: _delayedAnimation.value,
                  child: Icon(Icons.shopping_cart, size: 90, color: Colors.redAccent,),
                );
              },
            ),

            AnimatedBuilder(
              animation: _opacityController,
              builder: (c, ch){
                return Opacity(
                    opacity: _opacityAnimation.value,
                    child: Container(
                      width: double.maxFinite,
                      height: 200,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[300],
                                blurRadius: 1
                            )
                          ]
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: _buildImagePlaceHolder(),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _buildRowPlaceHolder(obj.title,width: 150),
                              _buildRowPlaceHolder(obj.authorName,width: 160),
                              _buildRowPlaceHolder(obj.price.toString(),width: 180,rowname : " Rs.."),
                              Spacer(),
                              _buildButtonPlaceHolder()
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonPlaceHolder(){
    return Padding(
      padding: const EdgeInsets.only(left: 70),
      child: MaterialButton(
        elevation: 1,
        color: Color(0xFF262AAA),
        onPressed: (){
        	deleteWishlistandAddtoCart(obj.id);
          _opacityController.forward();
        },
        child : Text("ADD TO CART",style : TextStyle(fontWeight : FontWeight.bold,color : Colors.white)),
      ),
    );
  }

  Widget _buildImagePlaceHolder(){
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Container(
        width: 125,
        height: double.maxFinite,
        //color: Colors.grey[200],
        decoration: BoxDecoration(
        image: DecorationImage(
        //fit: BoxFit.cover,
        fit: BoxFit.fitWidth,
        alignment: Alignment.topLeft,
        image: NetworkImage(widget.obj.coverImage)
        )
		),
      ),
    );
  }

  Widget _buildRowPlaceHolder(String data,{double width = 120,double height = 15,String rowname=""}){
    return Container(
      child : Text(data+""+rowname),	
      width: width,
      height: height,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
    );
  }
}