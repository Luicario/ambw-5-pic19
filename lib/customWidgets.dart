import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class customWidgets extends StatefulWidget {
  @override
  Widget shimmerLoading(double h) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade400,
      child: Container(
        decoration: new BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        height: h,
      ),
    );
  }

  @override
  Widget shimmerListView(int _itemCount, double _height,
      [scroll = Axis.vertical]) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: scroll,
          itemCount: _itemCount,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                shimmerLoading(_height),
              ],
            );
          }),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
