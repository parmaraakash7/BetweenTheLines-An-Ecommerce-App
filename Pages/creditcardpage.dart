import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import '../Widget/profile_tile.dart';
import '../Widget/credit_card_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import "../Screens/User.dart";
import "CurrentUser.dart";
import "../Api_Services/ApiCall.dart";
import "../Api_Services/Uri.dart";


class CreditCardPage extends StatelessWidget {
  dynamic total;
  CreditCardPage(this.total);
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext _context;
  CreditCardBloc cardBloc;
  MaskedTextController ccMask =
      MaskedTextController(mask: "0000 0000 0000 0000");
  MaskedTextController expMask = MaskedTextController(mask: "00/00");
  Widget bodyData() => ListView(
        
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[creditCardWidget(), fillEntries()],
        
      );
  void showMessage(String message, Color bgcolor,Color txtcolor) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: bgcolor,
        content: new Text(message, style: TextStyle(color: txtcolor,fontSize : 20.0,fontWeight : FontWeight.bold))));
  }
  List<Color> kitGradients = [
    // new Color.fromRGBO(103, 218, 255, 1.0),
    // new Color.fromRGBO(3, 169, 244, 1.0),
    // new Color.fromRGBO(0, 122, 193, 1.0),
    Colors.blueGrey.shade800,
    Colors.black87,
  ];
  Widget creditCardWidget() {
    var deviceSize = MediaQuery.of(_context).size;
    return Container(
      height: deviceSize.height * 0.3,
      color: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 3.0,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: kitGradients)),
              ),
              /*Opacity(
                opacity: 0.1,
                child: Image.asset(
                  "D:\\Flutter\\try4\\Assets\\Images\\CRM.jpg",
                  fit: BoxFit.cover,
                ),
              ),*/
              MediaQuery.of(_context).orientation == Orientation.portrait
                  ? cardEntries()
                  : FittedBox(
                      child: cardEntries(),
                    ),
              Positioned(
                right: 10.0,
                top: 10.0,
                child: Icon(
                  FontAwesomeIcons.ccVisa,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
              Positioned(
                right: 10.0,
                bottom: 10.0,
                child: StreamBuilder<String>(
                  stream: cardBloc.nameOutputStream,
                  initialData: "Your Name",
                  builder: (context, snapshot) => Text(
                        snapshot.data.length > 0 ? snapshot.data : "Your Name",
                        style: TextStyle(
                            color: Colors.white,
                            ////fontFamily: UIData.ralewayFont,
                            fontSize: 20.0),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardEntries() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder<String>(
                stream: cardBloc.ccOutputStream,
                initialData: "**** **** **** ****",
                builder: (context, snapshot) {
                  snapshot.data.length > 0
                      ? ccMask.updateText(snapshot.data)
                      : null;
                  return Text(
                    snapshot.data.length > 0
                        ? snapshot.data
                        : "**** **** **** ****",
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StreamBuilder<String>(
                    stream: cardBloc.expOutputStream,
                    initialData: "MM/YY",
                    builder: (context, snapshot) {
                      snapshot.data.length > 0
                          ? expMask.updateText(snapshot.data)
                          : null;
                      return ProfileTile(
                        textColor: Colors.white,
                        title: "Expiry",
                        subtitle:
                            snapshot.data.length > 0 ? snapshot.data : "MM/YY",
                      );
                    }),
                SizedBox(
                  width: 30.0,
                ),
                StreamBuilder<String>(
                    stream: cardBloc.cvvOutputStream,
                    initialData: "***",
                    builder: (context, snapshot) => ProfileTile(
                          textColor: Colors.white,
                          title: "CVV",
                          subtitle:
                              snapshot.data.length > 0 ? snapshot.data : "***",
                        )),
              ],
            ),
          ],
        ),
      );

  Widget fillEntries() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: ccMask,
              keyboardType: TextInputType.number,
              maxLength: 19,
              style: TextStyle(
                  //fontFamily: UIData.ralewayFont, 
                  color: Colors.black),
              onChanged: (out) => cardBloc.ccInputSink.add(ccMask.text),
              decoration: InputDecoration(
                  labelText: "Credit Card Number",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder()),
            ),
            TextField(
              controller: expMask,
              keyboardType: TextInputType.number,
              maxLength: 5,
              style: TextStyle(
                  //fontFamily: UIData.ralewayFont, 
                  color: Colors.black),
              onChanged: (out) => cardBloc.expInputSink.add(expMask.text),
              decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  labelText: "MM/YY",
                  border: OutlineInputBorder()),
            ),
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 3,
              style: TextStyle(
                  //fontFamily: UIData.ralewayFont,
                   color: Colors.black),
              onChanged: (out) => cardBloc.cvvInputSink.add(out),
              decoration: InputDecoration(
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  labelText: "CVV",
                  border: OutlineInputBorder()),
            ),
            TextField(
              keyboardType: TextInputType.text,
              maxLength: 20,
              style: TextStyle(
                  //fontFamily: UIData.ralewayFont,
                   color: Colors.black),
              onChanged: (out) => cardBloc.nameInputSink.add(out),
              decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  labelText: "Name on card",
                  border: OutlineInputBorder()),
            ),
          ],
        ),
      );
  void showSuccessDialog(context) {
   // setState(() {
      //isDataAvailable = false;
      Future.delayed(Duration(seconds: 3)).then((_) => goToDialog(context));
   
  }
  emptyCart()async{
    var json1 = await ApiCall.getDataFromApi(Uri.GET_ALL_CART+"/3");
    for(int i=0;i<json1.length;i++)
    {
      int bookId = json1[i]['bookId'];
      //cart.add(bookId);
      int curr_id = CurrentUser.id;
      var r=await ApiCall.deleteRecord(Uri.GET_ALL_CART+"/$curr_id/$bookId");
    }
  }

  goToDialog(context) {
    
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    successTicket(),
                    SizedBox(
                      height: 10.0,
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        
                        emptyCart();
                        User user = new User(3,"aakash parmar","parmaraakash783@gmail.com",
                          "https://lh3.googleusercontent.com/--gtKxXlcrok/AAAAAAAAAAI/AAAAAAAAAAA/AKF05nBvFzX_BTpaWsARt6jkHtEFQskGWQ/s96-c/photo.jpg");
                        CurrentUser.index=true;
                        print(" helo kiidbwidblk ihpiho   ${CurrentUser.index}");
                        //setState((){});

                        Navigator.pushReplacementNamed(context,'/homepage',arguments:user);
                        //Navigator.pop(context);
                        //Navigator.pop(context);

                        //BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickedEvent);
                      },
                    )
                  ],
                ),
              ),
            ));
  }

  successTicket() => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Material(
          clipBehavior: Clip.antiAlias,
          elevation: 2.0,
          borderRadius: BorderRadius.circular(4.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ProfileTile(
                  title: "Thank You!",
                  textColor: Colors.purple,
                  subtitle: "Your transaction was successful",
                ),
                ListTile(
                  title: Text("Date"),
                  subtitle: Text("11 April 2020"),
                  trailing: Text("11:00 AM"),
                ),
                ListTile(
                  title: Text("Between The Lines"),
                  subtitle: Text("support@btl.com"),
                  trailing: CircleAvatar(
                    radius: 20.0,
                    child : ClipOval(
                      child : Image.asset('Assets/Images/bookstore_logo.png'),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Amount"),
                  subtitle: Text("${total} ₹."),
                  trailing: Text("Completed"),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 0.0,
                  color: Colors.grey.shade300,
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.ccAmex,
                      color: Colors.blue,
                    ),
                    title: Text("Credit Card"),
                    subtitle: Text("Visa Card ending ***9"),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget floatingBar(context) => Ink(
        decoration: ShapeDecoration(
            shape: StadiumBorder(),
            gradient: LinearGradient(colors: kitGradients)),
        child: FloatingActionButton.extended(
          onPressed: () {showSuccessDialog(context);showMessage("Books purchased !!!.",Colors.white,Color(0xFF262AAA));},
          backgroundColor: Colors.transparent,
          icon: Icon(
            FontAwesomeIcons.amazonPay,
            color: Colors.white,
          ),
          label: Text(
            "Continue",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    _context = context;
    cardBloc = CreditCardBloc();
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          elevation: 1.1,
          backgroundColor: Color(0xFF262AAA),
          title : Text("\t\tCredit Card",style : TextStyle(color :Colors.white )),
          
        ),
      body: bodyData(),
      floatingActionButton: floatingBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
