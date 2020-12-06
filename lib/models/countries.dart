import 'package:flutter/material.dart';

class Countries{

  String id;
  String sortname;
  String name;
  String phonecode;
  String status;
  String url;

  Countries({this.id, this.sortname,this.name, this.phonecode,this.status,this.url});

  Countries.fromJson(Map<String, dynamic> parsedJson){

      id = parsedJson['id'];
      sortname = parsedJson['sortname'];
      name = parsedJson['name'];
      phonecode = parsedJson['phonecode'];
      status = parsedJson['status'];
      url = parsedJson['url'];
  }
}