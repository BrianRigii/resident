class Unit {
  final String id;
  final String name;
  final String propertyId;
  final double rentPrice;
  final double? taxRate;
  final String? notes;

  Unit({
    required this.id,
    required this.name,
    required this.rentPrice,
    required this.propertyId,
    this.taxRate,
    this.notes,
  });

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      id: map['id'] as String,
      name: map['name'] as String,
      rentPrice: (map['rent_price'] as num).toDouble(),
      taxRate: (map['tax_rate'] as num).toDouble(),
      notes: map['notes'] as String,
      propertyId: map['property_id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rent_price': rentPrice,
      'tax_rate': taxRate,
      'notes': notes,
    };
  }
}
