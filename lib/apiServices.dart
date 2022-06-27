import 'dart:convert';
import 'package:pic_19/dataClass.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class ApiService {
  Future<List<cCovidSummaryProvinsi>> getCovidSummaryProvinsi() async {
    final response = await http
        .get(Uri.parse('https://data.covid19.go.id/public/api/prov.json'));
    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      List rawdata = jsonRes['list_data'];
      return rawdata
          .map((data) =>
              cCovidSummaryProvinsi.fromJSON(data, jsonRes['last_date']))
          .toList();
    } else {
      throw Exception("failed to retrevie data");
    }
  }

  Future<cCovidSummaryProvinsi> getCovidSummaryIndonesia() async {
    final response = await http
        .get(Uri.parse('https://data.covid19.go.id/public/api/update.json'));
    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      var rawdata = jsonRes['update'];

      return cCovidSummaryProvinsi(
          cNamaProvinsi: "Indonesia",
          cConfirmed: rawdata['total']['jumlah_positif'],
          cRecovered: rawdata['total']['jumlah_sembuh'],
          cDeaths: rawdata['total']['jumlah_meninggal'],
          cLastUpdate: rawdata['penambahan']['tanggal'],
          cDailyCase: rawdata['penambahan']['jumlah_positif']);
    } else {
      throw Exception("failed to retrevie data");
    }
  }

  Future<List<cItemRssFeed>> getData(String link) async {
    final response =
        await http.get(Uri.parse('https://covid19.go.id/feed/' + link));
    if (response.statusCode == 200) {
      var rawXMLData = xml.parse(response.body);
      var items = rawXMLData.findAllElements("item");
      return items
          .map((item) => cItemRssFeed(
              cTitle: item.findElements('title').first.text,
              clink: item.findElements('link').first.text,
              cPubDate: item.findElements('pubDate').first.text,
              cImage: item
                  .findElements('enclosure')
                  .first
                  .getAttribute('url')
                  .toString()))
          .toList();
    } else {
      throw Exception("failed to retrevie data");
    }
  }

  Future<List<cDataKotaProvinsiVaksin>> getAllProvinsiVaksin() async {
    final response =
        await http.get(Uri.parse('https://api.vaksinasi.id/regions'));
    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      List rawdata = jsonRes['data'];
      return rawdata
          .map((data) => cDataKotaProvinsiVaksin.fromJSON(data))
          .toList();
    } else {
      throw Exception("failed to retrevie data");
    }
  }

  Future<List<cLokasiVaksin>?> getAllLokasiVaksin(provinsi,
      [String? kota]) async {
    if (provinsi == "none") {
      return null;
    }
    final response;
    if (kota == null) {
      response = await http
          .get(Uri.parse('https://api.vaksinasi.id/locations/${provinsi}'));
    } else {
      response = await http.get(Uri.parse(
          'https://api.vaksinasi.id/locations/${provinsi}?city=${kota}'));
    }
    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      List rawdata = jsonRes['data'];
      return rawdata.map((data) => cLokasiVaksin.fromJSON(data)).toList();
    } else {
      throw Exception("failed to retrevie data");
    }
  }
}
