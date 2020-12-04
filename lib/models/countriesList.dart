import 'package:ichsampleapp/models/countries.dart';

class CountriesList {

  List<Countries> records = new List();

  CountriesList({
    this.records
  });

  factory CountriesList.fromJson(List<dynamic> parsedJson) {

    List<Countries> records = new List<Countries>();

    records = parsedJson.map((i) => Countries.fromJson(i)).toList();

    return new CountriesList(
      records: records,
    );
  }

}