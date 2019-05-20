import 'package:crud_sample/src/model/gudang.dart';
import 'package:http/http.dart' show Client;

class ApiService {
  final String baseUrl = "http://192.168.20.254/smartcard.local/rest_api/index.php";
  Client client = Client();

  Future<List<Gudang>> getGdg() async {
    final response = await client.get("$baseUrl/Stock");
    if (response.statusCode == 200) {
      return gudangFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createGdg(Gudang data) async {
    final response = await client.post(
      "$baseUrl/Stock",
      headers: {"content-type": "application/json"},
      body: gudangToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateGdg(Gudang data) async {
    final response = await client.put(
      "$baseUrl/Stock?warehouseItem_id=${data.warehouseItem_id}",
      headers: {"content-type": "application/json"},
      body: gudangToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteGdg(String warehouseItem_id) async {
    final response = await client.delete(
      "$baseUrl/Stock?warehouseItem_id=$warehouseItem_id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}