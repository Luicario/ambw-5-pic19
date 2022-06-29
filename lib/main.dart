import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:pic_19/apiServices.dart';
import 'package:pic_19/customColors.dart';
import 'package:pic_19/customWidgets.dart';
import 'package:pic_19/dataClass.dart';
import 'package:pic_19/pages/hospitals.dart';
import 'package:pic_19/pages/rssFeedsDetails.dart';
import 'package:pic_19/pages/settings.dart';
import 'package:pic_19/pages/splashScreen.dart';
import 'package:pic_19/pages/vaccination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  // runApp(const mainApp());
  runApp(const splashScreen());
}

class mainApp extends StatefulWidget {
  const mainApp({Key? key}) : super(key: key);

  @override
  State<mainApp> createState() => _mainState();
}

class _mainState extends State<mainApp> {
  late cCovidSummaryProvinsi covidSummary = cCovidSummaryProvinsi(
      cNamaProvinsi: "INDONESIA",
      cConfirmed: 0,
      cRecovered: 0,
      cDeaths: 0,
      cLastUpdate: "0000-00-00",
      cDailyCase: 0);
  late Future<List<cCovidSummaryProvinsi>> listCovidSummaryProvinsi;
  late cCovidSummaryProvinsi covidSummaryIndonesia = cCovidSummaryProvinsi(
      cNamaProvinsi: "INDONESIA",
      cConfirmed: 0,
      cRecovered: 0,
      cDeaths: 0,
      cLastUpdate: "0000-00-00",
      cDailyCase: 0);

  customWidgets customWidget = customWidgets();
  ApiService apiservice = ApiService();
  List<String> month = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  var isLoading = true,
      isFound = true,
      isFirstLoading = true,
      valueNegara = "INDONESIA";

  @override
  void initState() {
    apiservice.getCovidSummaryIndonesia().then((value) => {
          setState(() {
            covidSummary = value;
            isLoading = false;
            isFirstLoading = false;
            covidSummaryIndonesia = value;
          }),
          checkDailyCaseLimit(value),
        });

    listCovidSummaryProvinsi = apiservice.getCovidSummaryProvinsi();
    listCovidSummaryProvinsi.then((value) => {
          value.sort((a, b) => a.cNamaProvinsi.compareTo(b.cNamaProvinsi)),
          value.insert(0, covidSummaryIndonesia)
        });
    super.initState();
  }

  void checkDailyCaseLimit(value) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("dailyCaseLimit") &&
        prefs.getInt('dailyCaseLimit') != null) {
      int dailyCaselimit = (prefs.getInt('dailyCaseLimit') ?? 0) * 1000;
      if (value.cDailyCase > dailyCaselimit) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Warning",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            content: Wrap(
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/dailycasewarning.png',
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                    Text(
                      "Daily Case in Indonesia Reach ${value.cDailyCase} Case Perday",
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }
    }
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
          toolbarHeight: 90,
          leadingWidth: 65,
          titleSpacing: 0,
          leading: IconButton(
              onPressed: () async {
                final url =
                    Uri.parse("https://github.com/Luicario/ambw-5-pic19");
                await launchUrl(url);
              },
              icon: Image.asset('assets/images/logo.png')),
          actions: [
            IconButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return settings();
                          },
                        ),
                      )
                    },
                icon: Icon(
                  Icons.settings,
                  size: 30,
                ))
          ],
          title: Text("Home",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          centerTitle: true,
          elevation: 0,
        ),
        body: Scrollbar(
          trackVisibility: true,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
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
                      Container(
                        child: FutureBuilder<List<cCovidSummaryProvinsi>>(
                          future: listCovidSummaryProvinsi,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<cCovidSummaryProvinsi> dataCovidSummary =
                                  snapshot.data!;
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: new BoxDecoration(
                                  border:
                                      Border.all(color: primaryColor, width: 2),
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
                                          hint: Text(valueNegara),
                                          iconSize: 35,
                                          items: dataCovidSummary.map((item) {
                                            return DropdownMenuItem(
                                              child: Text(item.cNamaProvinsi),
                                              value:
                                                  item.cNamaProvinsi.toString(),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            final index = dataCovidSummary
                                                .indexWhere((element) =>
                                                    element.cNamaProvinsi ==
                                                    value.toString());
                                            setState(
                                              () {
                                                isLoading = true;
                                                if (index == 0) {
                                                  covidSummary =
                                                      covidSummaryIndonesia;
                                                } else {
                                                  covidSummary =
                                                      dataCovidSummary[index];
                                                }
                                                valueNegara =
                                                    dataCovidSummary[index]
                                                        .cNamaProvinsi;
                                              },
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
                            return Column(
                              children: [customWidget.shimmerLoading(40)],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Latest Update",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                covidSummary.cLastUpdate
                                        .substring(0, 10)
                                        .split('-')[2]
                                        .toString() +
                                    "-" +
                                    month[int.parse(covidSummary.cLastUpdate
                                            .toString()
                                            .split('-')[1])]
                                        .toString() +
                                    "-" +
                                    covidSummary.cLastUpdate
                                        .toString()
                                        .substring(0, 10)
                                        .split('-')[0]
                                        .toString(),
                                style: TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: containerSummaryCovid(
                                    "Confirmed",
                                    covidSummary.cConfirmed,
                                    Colors.red.shade100,
                                    Colors.red.shade600,
                                    "https://cdn-icons-png.flaticon.com/512/2913/2913604.png"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: containerSummaryCovid(
                                    "Recovered",
                                    covidSummary.cRecovered,
                                    Colors.green.shade100,
                                    Colors.green.shade600,
                                    "https://cdn-icons-png.flaticon.com/512/4015/4015528.png"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: containerSummaryCovid(
                                    "Deaths",
                                    covidSummary.cDeaths,
                                    Colors.grey.shade300,
                                    Colors.grey.shade700,
                                    // "https://cdn-icons-png.flaticon.com/512/2552/2552797.png"
                                    "https://cdn-icons-png.flaticon.com/512/983/983061.png"),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "RSS Feeds",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: cardListViewRSSFeeds(),
                        height: 160,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Information Services",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      cardListViewInformationService(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget shimmerContainerSummaryCovid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: customWidget.shimmerLoading(40),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: customWidget.shimmerLoading(110),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: customWidget.shimmerLoading(110),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: customWidget.shimmerLoading(110),
            ),
          ],
        ),
      ],
    );
  }

  Widget cardListViewRSSFeeds() {
    List<cRssFeedsDataView> rssFeedsDataView = [
      cRssFeedsDataView(
          cName: "News", cImage: "assets/images/news.png", cEndPoint: "berita"),
      cRssFeedsDataView(
          cName: "Public",
          cImage: "assets/images/public.png",
          cEndPoint: "masyarakat-umum"),
      cRssFeedsDataView(
          cName: "Guide",
          cImage: "assets/images/guide.png",
          cEndPoint: "panduan"),
      cRssFeedsDataView(
          cName: "Travelling",
          cImage: "assets/images/travelling.png",
          cEndPoint: "melakukan-perjalanan"),
      cRssFeedsDataView(
          cName: "Regulation",
          cImage: "assets/images/regulation.png",
          cEndPoint: "regulasi"),
      cRssFeedsDataView(
          cName: "Business",
          cImage: "assets/images/business.png",
          cEndPoint: "pengusaha-dan-bisnis")
    ];

    return Scrollbar(
      trackVisibility: true,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // controller: _scrollController,
        itemCount: rssFeedsDataView.length,

        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return rssFeedsDetails(rssFeeds: rssFeedsDataView[index]);
                  },
                ),
              );
            },
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 115,
                      height: 120,
                      decoration: new BoxDecoration(
                        color: lightBlueColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(rssFeedsDataView[index].cImage),
                        ),
                      ),
                    ),
                    Container(
                      width: 115,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: new BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      child: Text(
                        rssFeedsDataView[index].cName,
                        style: GoogleFonts.poppins(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget cardListViewInformationService() {
    List<cInformations> informationsTextView = [
      cInformations(
          cName: "Hospitals",
          cDesc:
              "Check the availability of the COVID-19 patient care room in Indonesia",
          cImage: "assets/images/hospitals.png"),
      cInformations(
          cName: "Vaccination",
          cDesc: "Check vaccination locations for COVID-19 in Indonesia",
          cImage: "assets/images/vaccination.png")
    ];

    return Column(
      children: [
        TouchRippleEffect(
          borderRadius: BorderRadius.circular(5),
          rippleColor: primaryColor,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return hospitals();
                },
              ),
            );
          },
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 145,
                    width: 150,
                    decoration: new BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(informationsTextView[0].cImage),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 145,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: new BoxDecoration(
                        color: lightBlueColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, top: 5, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              informationsTextView[0].cName,
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                color: primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(informationsTextView[0].cDesc)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        TouchRippleEffect(
          borderRadius: BorderRadius.circular(5),
          rippleColor: primaryColor,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return vaccination();
                },
              ),
            );
          },
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 145,
                    width: 150,
                    decoration: new BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(informationsTextView[1].cImage),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 145,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: new BoxDecoration(
                        color: lightBlueColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, top: 5, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              informationsTextView[1].cName,
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                color: primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(informationsTextView[1].cDesc)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        )
      ],
    );
    // return ListView.builder(
    //   // controller: _scrollController,
    //   shrinkWrap: true,
    //   itemCount: informationsTextView.length,
    //   primary: false,
    //   itemBuilder: (BuildContext context, int index) {
    //     return GestureDetector(
    //       onTap: () {
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) {
    //               switch (index) {
    //                 case 1:
    //                   {
    //                     return vaccinationScreen();
    //                   }
    //                   break;
    //                 default:
    //                   {
    //                     return vaccinationScreen();
    //                   }
    //               }
    //             },
    //           ),
    //         );
    //       },
    //       child: Column(
    //         children: [
    //           Row(
    //             children: [
    //               Container(
    //                 height: 145,
    //                 width: 150,
    //                 decoration: new BoxDecoration(
    //                   color: Colors.grey.shade200,
    //                   borderRadius: BorderRadius.only(
    //                     topLeft: Radius.circular(5),
    //                     bottomLeft: Radius.circular(5),
    //                   ),
    //                   image: DecorationImage(
    //                     fit: BoxFit.fill,
    //                     image: AssetImage(informationsTextView[index].cImage),
    //                   ),
    //                 ),
    //               ),
    //               Expanded(
    //                 child: Container(
    //                   height: 145,
    //                   padding: EdgeInsets.symmetric(vertical: 5),
    //                   decoration: new BoxDecoration(
    //                     color: lightBlueColor,
    //                     borderRadius: BorderRadius.only(
    //                       topRight: Radius.circular(10),
    //                       bottomRight: Radius.circular(10),
    //                     ),
    //                   ),
    //                   child: Padding(
    //                     padding:
    //                         const EdgeInsets.only(left: 10, top: 5, right: 15),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           informationsTextView[index].cName,
    //                           style: TextStyle(
    //                             fontSize: 15,
    //                             color: primaryColor,
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         ),
    //                         SizedBox(height: 2),
    //                         Text(informationsTextView[index].cDesc)
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           SizedBox(height: 10),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }

  Widget containerSummaryCovid(bottomtext, int data, bgcolor, textcolor,
      [String imageURL = "https://via.placeholder.com/50"]) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18),
      decoration: new BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: imageURL,
            height: 45,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Text(
              MoneyFormatter(amount: data.toDouble())
                  .output
                  .withoutFractionDigits
                  .toString(),
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: textcolor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            bottomtext,
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: textcolor,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}
