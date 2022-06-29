import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pic_19/apiServices.dart';
import 'package:pic_19/customColors.dart';
import 'package:pic_19/customWidgets.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dataClass.dart';

class rssFeedsDetails extends StatefulWidget {
  final cRssFeedsDataView rssFeeds;
  const rssFeedsDetails({Key? key, required this.rssFeeds}) : super(key: key);

  @override
  State<rssFeedsDetails> createState() => _rssFeedsDetailsState();
}

class _rssFeedsDetailsState extends State<rssFeedsDetails> {
  ApiService apiservice = ApiService();
  late Future<List<cItemRssFeed>> listFeeds;
  customWidgets customWidget = customWidgets();
  var isFirstLoading = true;

  @override
  void initState() {
    listFeeds = apiservice.getData(widget.rssFeeds.cEndPoint);
    listFeeds.then(
      (value) => {
        setState(() {
          isFirstLoading = false;
        }),
      },
    );
    super.initState();
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
          title: Text("RSS Feeds",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
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
                      widget.rssFeeds.cName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    FutureBuilder<List<cItemRssFeed>>(
                      future: listFeeds,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var isiData = snapshot.data!;
                          return Expanded(
                            child: ListView.builder(
                              itemCount: isiData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    TouchRippleEffect(
                                      borderRadius: BorderRadius.circular(10),
                                      rippleColor: primaryColor,
                                      onTap: () async {
                                        final url =
                                            Uri.parse(isiData[index].clink);
                                        await launchUrl(url);
                                      },
                                      child: Container(
                                        // margin: EdgeInsets.only(bottom: 20),
                                        height: 200,
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      isiData[index].cImage,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Image.asset(
                                                    'assets/images/imageplaceholder.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: Container(
                                                height: 190,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10)),
                                                  gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [
                                                      primaryColor,
                                                      primaryColor
                                                          .withOpacity(0.8),
                                                      Colors.transparent
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    40,
                                                padding: EdgeInsets.all(20),
                                                child: Text(
                                                  isiData[index].cTitle,
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20)
                                  ],
                                );
                              },
                            ),
                          );
                        }
                        return isFirstLoading
                            ? customWidget.shimmerListView(10, 200)
                            : CircularProgressIndicator();
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
}
