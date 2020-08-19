import 'package:flutter/material.dart';
import 'creditcardpage.dart';

class ConfirmOrderPage extends StatelessWidget{
  final String address = "Chabahil, Kathmandu";
  final String phone="9818522122";
  final dynamic total ;
  final String delivery = "FREE";

  ConfirmOrderPage(this.total);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1.1,
          backgroundColor: Color(0xFF262AAA),
          title : Text("\t\tConfirm Order",style : TextStyle(color : Colors.white)),
          
        ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Subtotal"),
                  Text("Rs. $total"),
                ],
              ),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Delivery fee"),
                  Text(" $delivery"),
                ],
              ),
              SizedBox(height: 10.0,),  
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total", style: Theme.of(context).textTheme.title,),
                  Text("Rs. ${total}", style: Theme.of(context).textTheme.title),
                ],
              ),
              SizedBox(height: 20.0,),
              Container(
                color: Colors.grey.shade200,
                padding: EdgeInsets.all(8.0),
                width: double.infinity,
                child: Text("Delivery Address".toUpperCase())
              ),
              Column(
                children: <Widget>[
                  RadioListTile(
                    selected: true,
                    value: address,
                    activeColor : Color(0xFF262AAA),
                    groupValue: address,
                    title: Text(address,style : TextStyle(color : Color(0xFF262AAA))),
                    onChanged: (value){},
                  ),
                  RadioListTile(
                    selected: false,
                    value: "New Address",
                    groupValue: address,
                    title: Text("Choose new delivery address"),
                    onChanged: (value){},
                  ),
                  Container(
                    color: Colors.grey.shade200,
                    padding: EdgeInsets.all(8.0),
                    width: double.infinity,
                    child: Text("Contact Number".toUpperCase())
                  ),
                  RadioListTile(
                    selected: true,
                    value: phone,
                    activeColor : Color(0xFF262AAA),
                    groupValue: phone,
                    title: Text(phone,style : TextStyle(color : Color(0xFF262AAA))),
                    onChanged: (value){},
                  ),
                  RadioListTile(
                    selected: false,
                    value: "New Phone",
                    groupValue: phone,
                    title: Text("Choose new contact number"),
                    onChanged: (value){},
                  ),
                ],
              ),
              SizedBox(height: 20.0,),
              Container(
                color: Colors.grey.shade200,
                padding: EdgeInsets.all(8.0),
                width: double.infinity,
                child: Text("Payment Option".toUpperCase())
              ),
              RadioListTile(
                groupValue: true,
                value: true,
                activeColor : Color(0xFF262AAA),
                title: Text("Credit Card",style : TextStyle(color : Color(0xFF262AAA))),
                onChanged: (value){},
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  color: Color(0xFF262AAA),
                  onPressed: () {
                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreditCardPage(
                                          total
                                        )
                                    )
                                );
                    },
                  child: Text("Confirm Order", style: TextStyle(
                    color: Colors.white
                  ),),
                ),
              )
            ],
          ),
        );
  }

  
}
