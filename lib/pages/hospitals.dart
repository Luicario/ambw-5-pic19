import 'package:flutter/material.dart';
import 'package:pic_19/apiServices.dart';
import 'package:pic_19/customWidgets.dart';
import 'package:pic_19/dataClass.dart';

class hospitals extends StatefulWidget {
  const hospitals({Key? key}) : super(key: key);

  @override
  State<hospitals> createState() => _hospitalsState();
}

class _hospitalsState extends State<hospitals> {
  ApiService apiservice = ApiService();
  late Future<List<cDataProvinsi>> ListProvinsi;
  late Future<List<cDataRs>?> ListRS;
  late Future<List<cDataKamar>?> ListKamar;
  late List<cDataKabKota> ListKabKota = [cDataKabKota(cId: "-1", cNama: "")];
  final ScrollController _scrollController = ScrollController();
  late cDataRs selectedRS;
  var customWidget = customWidgets();
  var valueProvinsi = "Provinsi", valueKabKota = "Kab. Kota";
  var kabSearch = "";
  var dropDownEnabled = true;
  var idProvinsi;
  var jumlahRS = 0;
  var isLoading = true;
  var isFound = true;
  var isFirstLoading = true;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
