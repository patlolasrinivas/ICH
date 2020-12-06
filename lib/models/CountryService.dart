
import 'package:ichsampleapp/Constant/Constant.dart';

import 'countriesList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryService{

  Future<CountriesList> getCountries() async{

    CountriesList countryRecords;

    var countryList;

    try{

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
      else{
        print("error getting countries");
      }

    }catch(e){
      print("error getting countries");
    }
    return countryRecords;
  }

}