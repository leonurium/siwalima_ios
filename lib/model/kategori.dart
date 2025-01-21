class Kategori {
  final int? id;
  final String? name;

  const Kategori({
    required this.id,
    required this.name,
  });

  factory Kategori.fromJson(Map<String, dynamic> json) => Kategori(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
