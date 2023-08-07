class Cart {
  String? image;
  String? name;
  String? flavour;
  double? price;
  int? count;

  Cart({
    this.image,
    this.count,
    this.name,
    this.flavour,
    this.price,
  });

  Map<String, dynamic> toJson() => {
        'image': image,
        'name': name,
        'flavour': flavour,
        'price': price,
        'count': count,
      };
}
