class ProductModel {
  int? id;
  String? name, category, createAt, updateAt;
  ProductModel(this.id, this.name, this.category, this.createAt, this.updateAt);

  factory ProductModel.fromJson(Map<String, dynamic>? json) => ProductModel(
        json?['id'],
        json?['name'],
        json?['category'],
        json?['create_at'],
        json?['update_at'],
      );
}
