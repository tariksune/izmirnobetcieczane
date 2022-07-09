import 'package:izmirnobetcieczane/models/pharmacy.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Pharmacy>?> getPharmacies() async {
    var client = http.Client();

    var uri =
        Uri.parse('https://openapi.izmir.bel.tr/api/ibb/nobetcieczaneler');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return pharmacyFromJson(json);
    }
  }
}
