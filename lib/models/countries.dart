class Countries{

  int id;
  String name;
  String url;
  int phonecode;

  Countries({this.id, this.name, this.url,this.phonecode});

  factory Countries.fromJson(Map<String, dynamic> parsedJson){

    return Countries(

      id: parsedJson['id'] as int,
      name: parsedJson['name'] as String,
      url: parsedJson['url'] as String,
      phonecode: parsedJson['phonecode'] as int,

    );
  }
}