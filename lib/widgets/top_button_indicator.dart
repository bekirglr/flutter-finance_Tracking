import 'package:flutter/material.dart';

class TopButtonIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Wrap(
              children: <Widget>[
                Container(
                  width: 100,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
