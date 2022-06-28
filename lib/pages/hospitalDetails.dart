import 'package:flutter/material.dart';
import 'package:pic_19/dataClass.dart';

class hospitalDetails extends StatefulWidget {
  final cDataRs selectedRS;
  final id_provinsi;
  const hospitalDetails(
      {Key? key, required this.selectedRS, required this.id_provinsi})
      : super(key: key);

  @override
  State<hospitalDetails> createState() => _hospitalDetailsState();
}

class _hospitalDetailsState extends State<hospitalDetails> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
