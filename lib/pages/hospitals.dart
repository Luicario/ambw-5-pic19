import 'package:badges/badges.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pic_19/apiServices.dart';
import 'package:pic_19/customColors.dart';
import 'package:pic_19/customWidgets.dart';
import 'package:pic_19/dataClass.dart';
import 'package:pic_19/pages/hospitalDetails.dart';

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
  String valueProvinsi = "Provinsi", valueKabKota = "Kab. Kota", kabSearch = "";
  var idProvinsi;
  int jumlahRS = 0;
  bool isLoading = true,
      isFound = true,
      dropDownEnabled = true,
      isFirstLoading = true;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    ListProvinsi = apiservice.getAllProvinsi();
    ListProvinsi.then((value) => setState(
          () {
            isLoading = false;
            isFirstLoading = false;
          },
        ));
    ListRS = apiservice.getAllRumahSakit("none", "none");
    ListKamar = apiservice.getAllKamar("9201012", "92prop");
    super.initState();
  }

  void dropDown2CallBack(String? value) {
    final index =
        ListKabKota.indexWhere((element) => element.cId == value!.toString());
    setState(() {
      valueKabKota = ListKabKota[index].cNama;
      ListRS = apiservice.getAllRumahSakit(idProvinsi, value!);
      isLoading = true;
      isFound = true;
    });
    ListRS.then(
      (value) => setState(
        () {
          isLoading = false;
          if (value == null) {
            jumlahRS = 0;
            isFound = false;
          } else {
            isFound = true;
            jumlahRS = value.length;
          }
          kabSearch = ListKabKota[index].cNama + ", ";
        },
      ),
    );
  }

  void scrollToTop() {
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
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
          title: Text("Search Hospital",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          margin: EdgeInsets.only(top: 0),
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        child: FutureBuilder<List<cDataProvinsi>>(
                      future: ListProvinsi,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<cDataProvinsi> dataProvinsi = snapshot.data!;
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: new BoxDecoration(
                              border: Border.all(color: primaryColor, width: 2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 25,
                                  color: primaryColor,
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      itemHeight: 35,
                                      dropdownMaxHeight: 250,
                                      hint: Text(valueProvinsi),
                                      iconSize: 35,
                                      items: dataProvinsi.map((item) {
                                        return DropdownMenuItem(
                                          child: Text(item.cNama),
                                          value: item.cId.toString(),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        final index = dataProvinsi.indexWhere(
                                            (element) =>
                                                element.cId ==
                                                value.toString());
                                        setState(() {
                                          idProvinsi = dataProvinsi[index].cId;
                                          valueProvinsi =
                                              dataProvinsi[index].cNama;
                                          valueKabKota = "Kab. Kota";
                                          dropDownEnabled = false;
                                          ListKabKota =
                                              dataProvinsi[index].ckabkota;
                                          ListRS = apiservice.getAllRumahSakit(
                                              dataProvinsi[index].cId, "none");
                                          isLoading = true;
                                          isFound = true;
                                          kabSearch = "";
                                        });
                                        ListRS.then(
                                          (value) => setState(
                                            () {
                                              isLoading = false;
                                              jumlahRS = value!.length;
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return customWidget.shimmerLoading(40);
                      },
                    )),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: isFirstLoading
                          ? customWidget.shimmerLoading(40)
                          : dropDownButtonKabKota()),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Hospitals",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              isLoading
                  ? customWidget.shimmerLoading(25)
                  : Text(
                      jumlahRS.toString() +
                          " Hospitals found in " +
                          kabSearch +
                          valueProvinsi,
                      style: TextStyle(fontSize: 15),
                    ),
              SizedBox(height: 10),
              FutureBuilder<List<cDataRs>?>(
                future: ListRS,
                builder: (context, snapshot) {
                  if (!isFound) {
                    return Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/hospitalbed.png',
                              height: MediaQuery.of(context).size.height / 2,
                            ),
                            // Text(
                            //   "Oops No Data!!!",
                            //   style: TextStyle(fontSize: 25),
                            // )
                          ],
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasData && !isLoading) {
                    var RS = snapshot.data!;
                    return Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: RS.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              selectedRS = RS[index];
                              goToHospitalDetails(
                                  context, selectedRS, idProvinsi);
                            },
                            child: Row(
                              children: [
                                Expanded(child: listViewRS(RS[index])),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return isFirstLoading
                      ? customWidget.shimmerListView(10, 70)
                      : (isLoading)
                          ? customWidget.shimmerListView(10, 70)
                          : Center(
                              child: Image.asset(
                                'assets/images/hospitalbed.png',
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                              ),
                            );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            (isFound && jumlahRS != 0) ? scrollToTop() : null;
          },
          backgroundColor: primaryColor,
          child: Icon(Icons.keyboard_double_arrow_up_rounded),
        ),
      ),
    );
  }

  void goToHospitalDetails(context, _selectedRS, _id_provinsi) {
    print(_selectedRS.cId.toString() + " " + idProvinsi);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return hospitalDetails(
              selectedRS: _selectedRS, id_provinsi: _id_provinsi);
        },
      ),
    );
  }

  Text setTextByIGDStatus(int jml) {
    if (jml != 0) {
      return Text(jml.toString() + " IGD BED AVAILABLE",
          style: TextStyle(fontSize: 12, color: Colors.white));
    } else {
      return Text("IGD BED FULL",
          style: TextStyle(fontSize: 12, color: Colors.white));
    }
  }

  Color setColorByIGDStatus(int jml) {
    if (jml != 0) {
      return Colors.green.shade400;
    } else {
      return Colors.red.shade400;
    }
  }

  Widget dropDownButtonKabKota() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: new BoxDecoration(
        border: Border.all(color: primaryColor, width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_city,
            size: 25,
            color: primaryColor,
          ),
          SizedBox(width: 5),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: IgnorePointer(
                ignoring: dropDownEnabled,
                child: DropdownButton2(
                    isExpanded: true,
                    itemHeight: 35,
                    dropdownMaxHeight: 250,
                    hint: Text(valueKabKota),
                    iconSize: 35,
                    items: ListKabKota.map((item) {
                      return DropdownMenuItem(
                        child: Text(item.cNama),
                        value: item.cId.toString(),
                      );
                    }).toList(),
                    onChanged: dropDown2CallBack),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listViewRS(cDataRs RS) {
    return Badge(
      position: BadgePosition.topEnd(top: 10, end: 2),
      badgeContent: setTextByIGDStatus(RS.cBedIgd),
      elevation: 0,
      animationType: BadgeAnimationType.slide,
      badgeColor: setColorByIGDStatus(RS.cBedIgd),
      shape: BadgeShape.square,
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 18),
              // width: 350,
              padding: EdgeInsets.all(20),
              decoration: new BoxDecoration(
                color: lightBlueColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    RS.cNama,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, color: primaryTextColor),
                  ),
                  SizedBox(height: 3),
                  Text(
                    RS.cAlamat + ".",
                    style: TextStyle(
                      color: primaryTextColor,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 12,
                        color: primaryTextColor,
                      ),
                      SizedBox(width: 3),
                      Text(
                        RS.cHotline,
                        style: TextStyle(
                          color: primaryTextColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
