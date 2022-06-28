import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pic_19/apiServices.dart';
import 'package:pic_19/customColors.dart';
import 'package:pic_19/customWidgets.dart';
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
  bool isLoading = true, isFound = true;
  int jumlahKamar = 0;
  ApiService apiservice = ApiService();
  late Future<List<cDataKamar>?> ListKamar;
  var customWidget = customWidgets();

  @override
  void initState() {
    super.initState();
    ListKamar = apiservice.getAllKamar(
        widget.selectedRS.cId.toString(), widget.id_provinsi);
    ListKamar.then(
      (value) => setState(
        () {
          isLoading = false;
          if (value == null) {
            jumlahKamar = 0;
            isFound = false;
          } else {
            isFound = true;
            jumlahKamar = value.length;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        scaffoldBackgroundColor: primaryColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          // leading: Icon(Icons.arrow_back),f
          leading: IconButton(
              onPressed: () => {Navigator.of(context).pop()},
              icon: Icon(Icons.arrow_back)),
          toolbarHeight: 80,
          title: Text("Hospital Bed Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.selectedRS.cNama,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(height: 3),
                        Text(
                          widget.selectedRS.cAlamat,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        SizedBox(height: 3),
                        Text(
                          widget.selectedRS.cHotline,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                margin: EdgeInsets.only(top: 0),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Hospital Beds",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    isLoading
                        ? customWidget.shimmerLoading(25)
                        : Text(jumlahKamar.toString() +
                            " Beds found in " +
                            widget.selectedRS.cNama),
                    FutureBuilder<List<cDataKamar>?>(
                      future: ListKamar,
                      builder: (context, snapshot) {
                        if (!isFound) {
                          return Center(child: Text("Not Data"));
                        }
                        if (snapshot.hasData && !isLoading) {
                          var dataKamar = snapshot.data!;
                          return Expanded(
                            child: ListView.builder(
                              // controller: _scrollController,
                              itemCount: dataKamar.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    Expanded(
                                        child: listViewKamar(dataKamar[index])),
                                  ],
                                );
                              },
                            ),
                          );
                        }
                        return customWidget.shimmerListView(10, 150);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listViewKamar(cDataKamar kamar) {
    double smollContainerPV = 5, smollContainerPH = 30;
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 18),
            // width: 350,
            padding: EdgeInsets.all(12),
            decoration: new BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.red.shade200, width: 2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Room Name : " + kamar.cNama,
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  "Last Update : " + kamar.cLastUpdate,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("Tempat Tidur",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            )),
                        SizedBox(height: 5),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: smollContainerPH,
                              vertical: smollContainerPV),
                          decoration: new BoxDecoration(
                              color: lightBlueColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: Colors.blueAccent, width: 2)),
                          child: Text(kamar.status.cTempatTidur.toString(),
                              style: TextStyle(
                                  fontSize: 20, color: Colors.blueAccent)),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text("Kosong",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade600,
                            )),
                        SizedBox(height: 5),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: smollContainerPH,
                              vertical: smollContainerPV),
                          decoration: new BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: Colors.green.shade600, width: 2)),
                          child: Text(kamar.status.cKosong.toString(),
                              style: TextStyle(
                                  fontSize: 20, color: Colors.green.shade600)),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text("Antrian",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600,
                            )),
                        SizedBox(height: 5),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: smollContainerPH,
                              vertical: smollContainerPV),
                          decoration: new BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: Colors.grey.shade600, width: 2)),
                          child: Text(kamar.status.cAntrian.toString(),
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey.shade600)),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
