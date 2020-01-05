class Meal {

  final String date;
  final int mensaId;
  final String dish;
  final bool isVegetarian;
  final bool isVegan;
  final String price;
  final String priceStaff;

  Meal(
    this.date,
    this.mensaId,
    this.dish,
    this.isVegetarian,
    this.isVegan,
    this.price,
    this.priceStaff
  );


  // JSON-serialization

  Meal.fromJson(Map<String, dynamic> json)
    : date = json['date'],
      mensaId = json['canteen'],
      dish = json['dish'],
      isVegetarian = json['vegetarian'],
      isVegan = json['vegan'],
      price = json['price'],
      priceStaff = json['price_staff'];

  Map<String, dynamic> toJson() => {
    'date': date,
    'canteen': mensaId,
    'dish': dish,
    'vegetarian': isVegetarian,
    'vegan': isVegan,
    'price': price,
    'price_staff': priceStaff,
  };
}