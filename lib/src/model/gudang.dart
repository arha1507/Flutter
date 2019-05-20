import 'dart:convert';

class Gudang {
  String warehouseItem_id;
  String warehouseItem_code;
  String warehouseItem_name;
  String warehouseItem_stock;
  String warehouseItem_unit;
  String warehouseItemSupplier_id;
  String warehouseItemCategory_id;
  String warehouseItemSubCategory_id;
  String warehouseItemCategory_name;
  String warehouseItemSubCategory_name;
  String warehouseItemSupplier_code;
  String warehouseItemSupplier_name;
  String warehouseItemSupplier_address;

  Gudang ({this.warehouseItem_id, this.warehouseItem_code, this.warehouseItem_name, this.warehouseItem_stock,
    this.warehouseItem_unit, this.warehouseItemSupplier_id, this.warehouseItemCategory_id, this.warehouseItemSubCategory_id,
    this.warehouseItemCategory_name, this.warehouseItemSubCategory_name, this.warehouseItemSupplier_code,
    this.warehouseItemSupplier_name, this.warehouseItemSupplier_address});

  factory Gudang.fromJson (Map<String, dynamic> map) {
    return Gudang (
        warehouseItem_id: map["warehouseItem_id"], warehouseItem_code: map["warehouseItem_code"], warehouseItem_name: map["warehouseItem_name"],
        warehouseItem_stock: map["warehouseItem_stock"], warehouseItem_unit: map["warehouseItem_unit"], warehouseItemSupplier_id: map["warehouseItemSupplier_id"], 
        warehouseItemCategory_id: map["warehouseItemCategory_id"], warehouseItemSubCategory_id: map["warehouseItemSubCategory_id"], 
        warehouseItemCategory_name: map["warehouseItemCategory_name"], warehouseItemSubCategory_name: map["warehouseItemSubCategory_name"], 
        warehouseItemSupplier_code: map["warehouseItemSupplier_code"], warehouseItemSupplier_name: map["warehouseItemSupplier_name"], 
        warehouseItemSupplier_address: map["warehouseItemSupplier_address"]);
  }

  Map<String, dynamic> toJson() {
    return {"warehouseItem_id": warehouseItem_id, "warehouseItem_code": warehouseItem_code, "warehouseItem_name": warehouseItem_name,
    "warehouseItem_stock": warehouseItem_stock, "warehouseItem_unit": warehouseItem_unit, "warehouseItemSupplier_id": warehouseItemSupplier_id,
    "warehouseItemCategory_id": warehouseItemCategory_id, "warehouseItemSubCategory_id": warehouseItemSubCategory_id,
    "warehouseItemCategory_name": warehouseItemCategory_name, "warehouseItemSubCategory_name": warehouseItemSubCategory_name, 
    "warehouseItemSupplier_code": warehouseItemSupplier_code, "warehouseItemSupplier_name": warehouseItemSupplier_name,
    "warehouseItemSupplier_address": warehouseItemSupplier_address};
  }

  @override
  String toString() {
    return '{warehouseItem_id: $warehouseItem_id, warehouseItem_code: $warehouseItem_code, warehouseItem_name: $warehouseItem_name,'
    'warehouseItem_stock: $warehouseItem_stock, warehouseItem_unit: $warehouseItem_unit, warehouseItemSupplier_id: $warehouseItemSupplier_id,'
    'warehouseItemCategory_id: $warehouseItemCategory_id, warehouseItemSubCategory_id: $warehouseItemSubCategory_id,'
    'warehouseItemCategory_name: $warehouseItemCategory_name, warehouseItemSubCategory_name: $warehouseItemSubCategory_name,'
    'warehouseItemSupplier_code: $warehouseItemSupplier_code, warehouseItemSupplier_name: $warehouseItemSupplier_name,'
    'warehouseItemSupplier_address: $warehouseItemSupplier_address}';
  }

}

List<Gudang> gudangFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Gudang>.from(data.map((item) => Gudang.fromJson(item)));
}

String gudangToJson(Gudang data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}