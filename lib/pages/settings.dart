import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pic_19/customColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  late Future<double> dailyCaseLimitFuture;
  late double dailyCaseValue = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dailyCaseLimitFuture = getDailyCaseLimit();
    dailyCaseLimitFuture.then(
      (value) => setState(
        () {
          dailyCaseValue = value;
        },
      ),
    );
  }

  Future<double> getDailyCaseLimit() async {
    final prefs = await SharedPreferences.getInstance();
    double caselimit = prefs.getInt('dailyCaseLimit')?.toDouble() ?? 1.0;
    return caselimit;
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
          leading: IconButton(
              onPressed: () => {Navigator.of(context).pop()},
              icon: Icon(Icons.arrow_back)),
          toolbarHeight: 80,
          title: Text("Settings",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
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
                      "Limit Covid Case Per Day",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 40,
                      child: SliderTheme(
                        data: SliderThemeData(
                            trackHeight: 15,
                            overlayShape: SliderComponentShape.noOverlay),
                        child: Slider(
                          value: dailyCaseValue,
                          onChanged: (newValue) {
                            setState(() {
                              dailyCaseValue = newValue;
                            });
                          },
                          divisions: 5,
                          min: 1,
                          max: 10,
                          activeColor: primaryColor,
                          label: "${dailyCaseValue.toInt() * 1000}",
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Min. 1000"),
                        Text((dailyCaseValue.toInt() * 1000).toString()),
                        Text("Max. 10.000"),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setInt(
                              'dailyCaseLimit', dailyCaseValue.toInt());
                        },
                        child: Text(
                          "Save Limit",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
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
