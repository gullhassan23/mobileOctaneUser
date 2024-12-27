class CreditCard {
  String? name;
  String? id;
  String? number;
  String? expiry;
  String? cvv;

  CreditCard({
     this.name,
     this.id,

     this.number,
     this.expiry,
     this.cvv,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,

      'number': number,
      'expiry': expiry,
      'cvv': cvv,
    };
  }

  factory CreditCard.fromMap(Map<String, dynamic> map) {
    return CreditCard(
      name: map['name'],
      id: map['id'],

      number: map['number'],
      expiry: map['expiry'],
      cvv: map['cvv'],
    );
  }
}
