import 'package:flutter/material.dart';
import "package:flutter_spinkit/flutter_spinkit.dart";
import '../bloc.navigation_bloc/navigation_bloc.dart';

import "../Api_Services/ApiCall.dart";
import "../Api_Services/Uri.dart";
import "../Pages/CurrentUser.dart";

import "detail.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HomePage extends StatelessWidget with NavigationStates
{
	@override
	Widget build(BuildContext context)
	{
    print("efhoehfohef"+CurrentUser.id.toString());
    CurrentUser.id = 3;
    print("efhoehfohef"+CurrentUser.id.toString());
		return MaterialApp(
			debugShowCheckedModeBanner : false,
			home : HomePage2(),
		);
	}
}
List<String> data= [];
List<BookClass> countries = [];

class BookClass{
  int id;
  String coverImage;
  String title;
  dynamic price;
  int pages;
  String authorName;
  String category;
  String description;
  int quantity;
  int currentQuantity;

  BookClass.retrieve(
    this.id,
    this.coverImage,
      this.title,
      this.price,
      this.pages,
      this.authorName,
      this.category,
      this.description,
      this.quantity,
      this.currentQuantity
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookId'] = this.id;
    data['coverImage'] = this.coverImage;
    data['title'] = this.title;
    data['price'] = this.price;
    data['pages'] = this.pages;
    data['authorName'] = this.authorName;
    data['category'] = this.category;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['currentQuantity'] = this.currentQuantity;
    return data;
  }
}

class HomePage2 extends StatefulWidget with NavigationStates
{
	HomePageState createState () => HomePageState();
}

class HomePageState extends State<HomePage2> {

  //var filters = ['Tech', 'Fiction', 'Non fiction', 'Science'];
  int _value = -1;
  bool techSelected=false;
  bool fictionSelected = false;
  bool nonFictionSelected = false;
  bool scienceSelected = false;
  String filters="";
  List<int> wishlists=[];



  refresh (context) {


    return Stack(
      children : <Widget>[

      Row(
        children : [
          /*Expanded(
            child : FilterChip(
              label: Text("text"), 
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(side: BorderSide()),
              onSelected: (bool value) {print("selected");},
          ),
          ),*/
          Expanded(
            child : ChoiceChip(
              label : Text("Tech",style:TextStyle(color : techSelected ? Colors.white : Color(0xFF262AAA))),
              selected : techSelected,
              backgroundColor : Colors.white,
              shape: StadiumBorder(side: BorderSide()),
              selectedColor : Color(0xFF262AAA),
              onSelected : (bool s){
                setState((){
                  if(techSelected!=true)
                  {
                    techSelected = true;
                    fictionSelected=false;
                    nonFictionSelected = false;
                    scienceSelected = false;
                    filters = "/category/tech";
                  }
                  else
                  {
                    techSelected = false;
                    fictionSelected=false;
                    nonFictionSelected = false;
                    scienceSelected = false;
                    filters = "";
                  }
                });
              }
            )
          ),
          Expanded(
            child : ChoiceChip(
              label : Text("Fiction",style:TextStyle(color : fictionSelected ? Colors.white : Color(0xFF262AAA))),
              selected : fictionSelected,
              shape: StadiumBorder(side: BorderSide()),
              selectedColor : Color(0xFF262AAA),
              backgroundColor : Colors.white,
              onSelected : (bool s){
                setState((){
                  if(fictionSelected!=true)
                  {
                    techSelected = false;
                    fictionSelected=true;
                    nonFictionSelected = false;
                    scienceSelected = false;
                    filters = "/category/fiction";
                  }
                  else
                  {
                    techSelected = false;
                    fictionSelected=false;
                    nonFictionSelected = false;
                    scienceSelected = false;
                    filters = "";
                  }
                });
              }
            )
          ),
          Expanded(
            child : ChoiceChip(
              label : Text("Non fiction",style:TextStyle(color : nonFictionSelected ? Colors.white : Color(0xFF262AAA))),

              selected : nonFictionSelected,
              shape: StadiumBorder(side: BorderSide()),
              selectedColor : Color(0xFF262AAA),
              backgroundColor : Colors.white,
              onSelected : (bool s){
                setState((){
                  if(nonFictionSelected!=true)
                  {
                    techSelected = false;
                    fictionSelected=false;
                    nonFictionSelected = true;
                    scienceSelected = false;
                    filters = "/category/nonfiction";
                  }
                  else
                  {
                    techSelected = false;
                    fictionSelected=false;
                    nonFictionSelected = false;
                    scienceSelected = false;
                    filters = "";
                  }
                });
              }
            )
          ),
          Expanded(
            child : ChoiceChip(
              label : Text("Science",style:TextStyle(color : scienceSelected ? Colors.white :Color(0xFF262AAA))),
              selected : scienceSelected,
              backgroundColor : Colors.white,
              shape: StadiumBorder(side: BorderSide()),
              selectedColor : Color(0xFF262AAA),
              onSelected : (bool s){
                setState((){
                  if(scienceSelected!=true)
                  {
                    techSelected = false;
                    fictionSelected=false;
                    nonFictionSelected = false;
                    scienceSelected = true;
                    filters = "/category/science";
                  }
                  else
                  {
                    techSelected = false;
                    fictionSelected=false;
                    nonFictionSelected = false;
                    scienceSelected = false;
                    filters = "";
                  }
                });
              }
            )
          ),

        ],

        ),

        
FutureBuilder(
      future : getUserWishlist(),
      builder : (BuildContext context,AsyncSnapshot snapshot){
        if(snapshot.data==null)
        {
          return Center(
           // child : CircularProgressIndicator(),
           child : Text(""),
          );
        }
        else
        {
          return Padding(
            padding : EdgeInsets.only(top : 45.0),
            child : Divider(),
            ) ;
        }
      }
    ),
  
          
        Padding(
          padding : EdgeInsets.only(top : 55.0),
        child : FutureBuilder(
      future: getData(),  
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print("idar ab kya!");
        if (snapshot.data == null) {
          print("Loading");
          return Container(
            child: Center(
              child : SpinKitWave(color: Color(0xFF262AAA), type: SpinKitWaveType.start)
            ),
          );
        } else {
          print("Trying.........");
          if(snapshot.data.length==0)
          {
            return Center(
              child : Text("No data exists.."),
            );
          }
          else
          {
            
            final orientation = MediaQuery.of(context).orientation;
            var size = MediaQuery.of(context).size;
            final double itemHeight = (size.height - kToolbarHeight - 24) / 1.6;
            final double itemWidth = size.width / 2;

            return GridView.builder(
              
            itemCount: snapshot.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,childAspectRatio: (itemWidth / itemHeight),),
            
            itemBuilder: (BuildContext context, int index) {
              return makeCard(snapshot.data[index]);
          },
        );
        
          }
          
        }
      },
    )),

      ],
    );

  }

  deleteWishlist(bookId) async
  {
    int curr_id = CurrentUser.id;
    var response1 = await ApiCall.deleteRecord(Uri.GET_ALL_WISHLIST + "/${curr_id}/${bookId}");
    setState((){});
  }

  createWishlist(bookId) async
  {
    int curr_id = CurrentUser.id;

    var data = new Map<String,dynamic>();
    data['userId']=curr_id;
    data['bookId']=bookId;

    var response1 = await ApiCall.createRecord(Uri.GET_ALL_WISHLIST, data);

    setState((){});
  } 

  Widget makeCard(var obj)
  {
    //print(obj.id.toString());
    return /*Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: */InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Detail(
                                          obj,
                                        )
                                    )
                                );
                          },
                          child: Hero(
                            tag: obj.coverImage,
                            child: Card(
                              child: Stack(
                                //mainAxisSize: MainAxisSize.min,
                                //mainAxisAlignment:
                                    //MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    //height: MediaQuery.of(context).size.height*.5,
                                    height : 220.0,
                                    width:
                                        MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            //fit: BoxFit.cover,
                                            fit: BoxFit.fitWidth,
                                            alignment: Alignment.topLeft,
                                            image: NetworkImage(obj.coverImage)
                                            )
                                        ),
                                  ),
                                  Padding(
                                  padding : EdgeInsets.only(top : 220.0),
                                  child : ListTile(
                                    isThreeLine : true,
                                    title : Text(obj.title,style:TextStyle(fontWeight : FontWeight.bold,color : Color(0xFF262AAA))),
                                    //subtitle : Text(obj.authorName+"\nRs : "+obj.price.toString()),
                                    subtitle : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                      children : <Widget>[Text(obj.authorName),Text("\nPrice : - Only "+obj.price.toString()+" Rs.",
                                        style : TextStyle(color : Colors.black,fontWeight : FontWeight.bold))]
                                    )
                                    /*trailing : IconButton(
                                      icon : Icon(Icons.map),
                                      onPressed : (){},
                                      )*/
                                  )),
                                  Positioned(
                                    right : 0.0,
                                    top : 0.0,
                                    child : IconButton(
                                      icon : Icon(wishlists.contains(obj.id) ? Icons.favorite : Icons.favorite_border,
                                        color : Colors.pink,size : 30.0),
                                      onPressed : (){
                                        if(wishlists.contains(obj.id))
                                        {
                                          deleteWishlist(obj.id);
                                        }
                                        else
                                        {
                                          createWishlist(obj.id);
                                        }
                                        },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                       /* ),*/
                      );
  }


  Future<List<int>> getUserWishlist() async{
    var json = await ApiCall.getDataFromApi(Uri.GET_ALL_WISHLIST+"/3");
    
    var json2 = await ApiCall.getDataFromApi(Uri.GET_ALL_CART+"/3");
    if(json2=="nothing"){
      CurrentUser.index=true;
    }
    wishlists.clear();
    for(int i=0;i<json.length;i++)
    {
      int bookId = json[i]['bookId'];
      wishlists.add(bookId);
    }
    
    print("Woishlists = $wishlists");
    return wishlists;
  }

  Future<List<BookClass>> getData() async {
    var json = await ApiCall.getDataFromApi(Uri.GET_ALL_BOOKS+""+filters);
    print(json.length);
    //print(json);
    int count=0;
    data.clear();
    
    countries.clear();
    if(json == "nothing")
    {
      return countries;
    }
    for (int i = 0; i < json.length; i++) {
      int _id = json[i]['bookId'];
      String _coverImage = json[i]['coverImage'];
      //print((++count).toString());
      String _title = json[i]['title'];
      data.add(_title);
      //print((++count).toString());
      dynamic _price = json[i]['price'];
      //print((++count).toString());
      int _pages = json[i]['pages'];
      //print((++count).toString());
      String _authorName = json[i]['authorName'];
      data.add(_authorName);
      //print((++count).toString());

      String _category = json[i]['category'];
      //print((++count).toString());
      String _description = json[i]['description'];
      //print((++count).toString());
      int _quantity =json[i]['quantity'];
      int _currentQuantity = json[i]['currentQuantity'];
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

    //print("dekh le!");
    //print("data is  = $data");

    return countries;
  }




  @override
  Widget build(BuildContext context) {
    print(" helo kiidbwidblk ihpiho${CurrentUser.index}");
    return Scaffold(
    	appBar : AppBar(
    		backgroundColor : Colors.white,
    		elevation : 1.0,
    		shape: RoundedRectangleBorder(
			      borderRadius: BorderRadius.vertical(
			        bottom: Radius.circular(15),
			      ),
			    ),
    		title : Row(
          children : <Widget>[
          Container(
            height : 90.0,
            width : 50.0,
            child : Image(
                image : new AssetImage('Assets/Images/bookstore_logo.png'),
                //color : Color(0xFF262AAA),
            )),
            Text("\t\tHOME",style : TextStyle(color : Color(0xFF262AAA))),    
          ]
        ),
        
    		actions : <Widget>[
          
					IconButton(
							icon : Icon(Icons.search,color : Color(0xFF262AAA)),onPressed : (){
								showSearch(context : context , delegate : DataSearch());
							}	
						),
          Stack(
            children : <Widget>[
              IconButton(
            icon : Icon(FontAwesomeIcons.bell,color : Color(0xFF262AAA)),
            onPressed : ()
            {

            }
            ),
             Positioned(
            top : 15.0,
            left : 5.0,
            child : Text("1",style : TextStyle(color : Colors.red ))
            ),
            ],
          ),
					
				],
    	),
    	body : refresh(context),

    );
  }
}



class DataSearch extends SearchDelegate<String>
{
  List<String> a=['Suggestions will appear as you write','','',''];
  var suggestionList;
  String str;

   getByBookName(bookname) async
  {
    var json = await ApiCall.getDataFromApi(Uri.GET_ALL_BOOKS+"/find/"+bookname);
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
        print("obj.title = ${obj.title}");
        return obj;

  }

  search(bookname,context) 
  {
    return FutureBuilder(
      future : getByBookName(bookname),
      builder : (c,s){
        if(s.data==null){
          return Center(
              child : SpinKitWave(color: Color(0xFF262AAA), type: SpinKitWaveType.start)
            );
        }
        else
        {
          return Center(
            child : GestureDetector(
              onTap : (){
                print("dfkenf");
              },
              child : Text(s.data.title),
              ),
            );
          print("jsbcb");
           Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => Detail(
                                          s.data,
                                        )
                                    )
                                );
        }
      }
    );
  }

  List<Widget> buildActions(BuildContext context)
  {
    return [
    IconButton(icon : Icon(Icons.clear),onPressed:(){
      query="";
      })
    ];
  }

  Widget buildLeading(BuildContext context)
  {
    return IconButton(
      icon : AnimatedIcon(
          icon : AnimatedIcons.menu_arrow,
          progress : transitionAnimation,
        ),
      onPressed : (){
        close(context,null);
      }
      );
  }

  Widget buildResults(BuildContext context)
  {
    /*return Center(
      child : Container(
        height : 100.0,
        width : 100.0,
        child : Card(
          color : Colors.red,
          child : Center(
            child : Text(query),
          ),
        )
      ),
    );*/
    return FutureBuilder(
      future : getByBookName(str),
      builder : (c,s){
        if(s.data==null){
          return Center(
              child : SpinKitWave(color: Color(0xFF262AAA), type: SpinKitWaveType.start)
            );
        }
        else
        {
          return Center(
            child : GestureDetector(
              onTap : (){
                print("dfkenf");
                Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => Detail(
                                          s.data,
                                        )
                                    )
                                );
              },
              child : Container(
                height : 100.0,
                width : 100.0,
                child : Card(
                  color : Colors.red,
                  child : Center(
                    child : Text(s.data.title,style : TextStyle(color : Colors.white,fontSize : 20.0,fontWeight : FontWeight.bold)),
                  )
                )
              ),
              ),
            );
          print("jsbcb");
           
        }
      }
    );
  
  }

  Widget buildSuggestions(BuildContext context)
  {
     suggestionList = query.isEmpty?a:data.where((p)=>p.startsWith(query)).toList();
    print(suggestionList.runtimeType);
    return ListView.builder(
      itemBuilder : (context,index) =>
      ListTile(
        //leading : Icon(Icons.replay),
        //update
        //rotate_right
        //rotate_left
        //restore
        //replay
        //youtube_searched_for
        onTap : (){
          str=suggestionList[index].substring(0,query.length)+suggestionList[index].substring(query.length);
          showResults(context);
          print(suggestionList[index].substring(0,query.length));
          print(suggestionList[index].substring(query.length));
          
          //search(str,context);
        },
        title : RichText(
          text : TextSpan(
            text : suggestionList[index].substring(0,query.length),
            style : TextStyle(
              color : Colors.black,
              fontWeight : FontWeight.bold,
            ),
            children : [
              TextSpan(
                text : suggestionList[index].substring(query.length),
                style : TextStyle(color : Colors.grey),
              ),
            ],
          )
        ),
      ),
      itemCount : suggestionList.length,
    );
  }
}

