import "dart:convert";
import "dart:async";
import "package:http/http.dart" as http;
import "URI.dart";

class ApiCall
{
	static getDataFromApi(baseURI) async
	{
		try
		{
			print(baseURI);	
			var response = await http.get(
		        baseURI,
		        headers : {
		          "Accept" : "application/json"
		        }
		        );
			//print(response.statusCode);
			if(response.statusCode!=200)
			{
				return "nothing";
			}
			else
			{
				var jsonData = jsonDecode(response.body);
				//print(jsonData);
				return jsonData;
			}
			
		}
		catch(e)
		{
			print("Here");
			print(e);
		}
	}
	static createRecord(baseURI,dataa) async
	{
		try
		{
			http.Response response = await http.post(baseURI,body : jsonEncode(dataa),headers : {
              "Accept" : "application/json",
              "Content-Type" : "application/json"
			            });
			      final int statusCode = response.statusCode;
			      print(statusCode);
			      if (statusCode < 200 || statusCode > 400 || json == null) 
		      	{
		      		print("Error while fetching data");
		    	}
		      return (json.decode(response.body));
		}
		catch(e)
		{
			print(e);
		}
	}
	static updateRecord(baseURI,dataa) async
	{
		print(baseURI);
		try
		{
			http.Response response = await http
		    .put(baseURI, body: jsonEncode(dataa),headers : {
              "Accept" : "application/json",
              "Content-Type" : "application/json"
			            });
		    final int statusCode = response.statusCode;
		    print(statusCode);
		    if (statusCode < 200 || statusCode > 400 || json == null) {
		      print("Error while fetching data");
		    }
		    //print("sdfeg = ${response.body}");
		    return (json.decode(response.body));
		}
		catch(e)
		{
			print(e);
		}
	}
	static deleteRecord(baseURI) async
	{
		print(baseURI);
		try
		{
			http.Response response =
		        await http.delete(baseURI);
		    final int statusCode = response.statusCode;
		    print(statusCode);
		    if (statusCode < 200 || statusCode > 400 || json == null) {
		      print("Error while fetching data");
		    }
		    print(response.body);
		    return (json.decode(response.body));
		}
		catch(e)
		{
			print(e);
		}
	}
}
