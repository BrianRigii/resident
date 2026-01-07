class Property {
  final String id;
  final String name;
  final String address;
  final List<String> landLordId;
  final bool isActive;

  Property({
    required this.id,
    required this.name,
    required this.address,
    required this.landLordId,
    this.isActive = true,
  });
}
