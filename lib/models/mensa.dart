class Mensa {

  final int id;
  final String name;

  Mensa(this.id, this.name);


  // JSON-serialization

  Mensa.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'];
    
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}