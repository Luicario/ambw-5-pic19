import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pic_19/apiServices.dart';
import 'package:pic_19/customColors.dart';
import 'package:pic_19/customWidgets.dart';
import 'package:pic_19/dataClass.dart';
import 'package:url_launcher/url_launcher.dart';

class vaccination extends StatefulWidget {
  const vaccination({Key? key}) : super(key: key);

  @override
  State<vaccination> createState() => _vaccinationState();
}

class _vaccinationState extends State<vaccination> {
  ApiService apiservice = ApiService();
  late Future<List<cDataKotaProvinsiVaksin>> listProvinsiVaksin;
  late Future<List<cLokasiVaksin>?> listVacc;
  List<String> listKota = ["", ""];
  var valueProvinsi = "Provinsi",
      valueKota = "Kota",
      dropDownIsEnabled = false,
      isLoading = true,
      isFound = true,
      isFirstLoading = true;
  customWidgets customWidget = customWidgets();
  int jumlahLokasiVaksin = 0;
  final ScrollController _scrollController = ScrollController();
  List<String> month = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    listProvinsiVaksin = apiservice.getAllProvinsiVaksin();
    listVacc = apiservice.getAllLokasiVaksin("none");
    listProvinsiVaksin.then(
      (value) => setState(
        () {
          isLoading = false;
          isFirstLoading = false;
        },
      ),
    );
    super.initState();
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
          title: Text("Search Vaccination",
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
                        child: FutureBuilder<List<cDataKotaProvinsiVaksin>>(
                      future: listProvinsiVaksin,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<cDataKotaProvinsiVaksin> dataProvinsiVaksin =
                              snapshot.data!;
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
                                      items: dataProvinsiVaksin.map((item) {
                                        return DropdownMenuItem(
                                          child: Text(item.cNamaProvinsi),
                                          value: item.cNamaProvinsi,
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        final index = dataProvinsiVaksin
                                            .indexWhere((element) =>
                                                element.cNamaProvinsi ==
                                                value.toString());
                                        setState(() {
                                          valueProvinsi =
                                              dataProvinsiVaksin[index]
                                                  .cNamaProvinsi;
                                          valueKota = "Kota";
                                          listKota =
                                              dataProvinsiVaksin[index].cKota;
                                          listVacc =
                                              apiservice.getAllLokasiVaksin(
                                                  dataProvinsiVaksin[index]
                                                      .cNamaProvinsi);
                                          dropDownIsEnabled = true;
                                          isLoading = true;
                                          isFound = true;
                                          // kabSearch = "";
                                        });
                                        listVacc.then(
                                          (value) => setState(
                                            () {
                                              isLoading = false;
                                              jumlahLokasiVaksin =
                                                  value!.length;
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
                          : dropDownButtonKota()),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Vaccination Locations",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              isLoading
                  ? customWidget.shimmerLoading(25)
                  : Text(
                      jumlahLokasiVaksin.toString() +
                          " Vaccination Locations found in " +
                          valueKota +
                          ", " +
                          valueProvinsi,
                      style: TextStyle(fontSize: 15),
                    ),
              FutureBuilder<List<cLokasiVaksin>?>(
                future: listVacc,
                builder: (context, snapshot) {
                  if (!isFound) {
                    return Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/vaccination.png',
                              height: MediaQuery.of(context).size.height / 2,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasData && !isLoading) {
                    var lokasi = snapshot.data!;
                    return Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: lokasi.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              Expanded(child: listViewVacc(lokasi[index])),
                            ],
                          );
                        },
                      ),
                    );
                  }
                  return isFirstLoading
                      ? customWidget.shimmerListView(10, 150)
                      : (isLoading)
                          ? customWidget.shimmerListView(10, 150)
                          : Center(
                              child: Image.asset(
                                'assets/images/vaccination.png',
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
            (isFound && jumlahLokasiVaksin != 0) ? scrollToTop() : null;
          },
          backgroundColor: primaryColor,
          child: Icon(Icons.keyboard_double_arrow_up_rounded),
        ),
      ),
    );
  }

  Widget dropDownButtonKota() {
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
              child: DropdownButton2(
                  isExpanded: true,
                  itemHeight: 35,
                  dropdownMaxHeight: 250,
                  hint: Text(valueKota),
                  iconSize: 35,
                  items: listKota.map((item) {
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    );
                  }).toList(),
                  onChanged: dropDownIsEnabled
                      ? (value) {
                          setState(() {
                            valueKota = value.toString();
                            final index = listKota.indexWhere(
                                (element) => element == value!.toString());

                            valueKota = listKota[index];
                            listVacc = apiservice.getAllLokasiVaksin(
                                valueProvinsi,
                                valueKota.replaceAll(" ", '%20'));

                            isLoading = true;
                            isFound = true;

                            listVacc.then(
                              (value) => setState(
                                () {
                                  isLoading = false;
                                  if (value!.length == 0) {
                                    jumlahLokasiVaksin = 0;
                                    isFound = false;
                                  } else {
                                    isFound = true;
                                    jumlahLokasiVaksin = value.length;
                                  }
                                },
                              ),
                            );
                          });
                        }
                      : null),
            ),
          ),
        ],
      ),
    );
  }

  Widget listViewVacc(cLokasiVaksin data) {
    return Row(
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
                  data.cNama,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: primaryTextColor,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  data.cAlamat,
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${data.cDateStart.split("-")[2]} ${month[int.parse(data.cDateStart.split("-")[1])]} - ${data.cDateEnd.split("-")[2]} ${month[int.parse(data.cDateEnd.split("-")[1])]} ${data.cDateEnd.split("-")[0]}',
                      style: TextStyle(
                        color: primaryTextColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      data.cIsValid ? "Vaksin Siap" : "Vaksin Kosong",
                      style: TextStyle(
                        color: primaryTextColor,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${data.cTimeStart.split(':')[0]}:${data.cTimeStart.split(':')[1]} - ${data.cTimeEnd.split(':')[0]}:${data.cTimeEnd.split(':')[1]}',
                      style: TextStyle(
                        color: primaryTextColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      data.cIsFree ? "Vaksinasi Gratis" : "Vaksinasi Berbayar",
                      style: TextStyle(
                        color: primaryTextColor,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                ConfigurableExpansionTile(
                  headerExpanded: Expanded(
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          "Less Info",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  header: Expanded(
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          "More Info",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.grey.shade500, width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Registration Method : ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(data.cRegisMethod),
                          SizedBox(height: 10),
                          Text("Vaccination Age :",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                              primary: false,
                              itemCount: data.cVaccAge.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Text('- ${data.cVaccAge[index]}');
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Text("Description :",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Text(data.cDesc),
                          SizedBox(height: 10),

                          // Text(data.cLink),
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () async {
                                    final url = Uri.parse(data.cLink);
                                    await launchUrl(url);
                                  },
                                  child: Text(
                                    "Information Link",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            primaryColor),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextButton(
                                  onPressed: () async {
                                    final url =
                                        Uri.parse(data.map.replaceAll(" ", ''));
                                    await launchUrl(url);
                                  },
                                  child: Text(
                                    "Map Location",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            primaryColor),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Text(data.map),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
