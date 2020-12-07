
import 'package:ichsampleapp/Constant/Constant.dart';

import 'countriesList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class CountryService{


  void showInSnackBar(String value) {
    Fluttertoast.showToast(
        msg: value,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0
    );
  }


  Future<CountriesList> getCountries() async{

    CountriesList countryRecords;

    var countryList;

    var url = API_URL+'Commons/country_list';

      final response = await http.get(url);
      if(response.statusCode == 200){

        var body = json.decode(response.body);
        var statusCode = body['status'];

        if(statusCode== true){

          Map<String, dynamic> map = json.decode(response.body);
          countryList = map['data'];

          countryRecords =
          new CountriesList.fromJson(countryList);
          print(countryRecords.records.length);
        }
      }
      else if (response.statusCode < 200 ||
          response.statusCode >= 400 ||
          json == null) {
        print(response.statusCode);
        showInSnackBar("Error while fetching data");
        throw new Exception(
            "Error while fetching data");
      }
      else
      {
        showInSnackBar("something went wrong, please try again");
      }

    return countryRecords;
  }

}