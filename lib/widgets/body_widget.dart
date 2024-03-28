import 'package:flutter/material.dart';
import 'weekly_card_widget.dart';
import 'monthly_card_widget.dart';

class BodyWidget extends StatefulWidget {
  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  bool showSecondCard = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        showSecondCard = false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_view_week,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            'Haftalık',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade700),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        showSecondCard = true;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            'Aylık',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green.shade700),
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (details.delta.dx < -20) {
              setState(() {
                showSecondCard = true;
              });
            } else if (details.delta.dx > 20) {
              setState(() {
                showSecondCard = false;
              });
            }
          },
          child: AnimatedCrossFade(
            duration: Duration(milliseconds: 300),
            firstChild: WeeklyCardWidget(),
            secondChild: MonthlyCardWidget(),
            crossFadeState: showSecondCard
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Text("Son İşlemler"),
              ),
              Text("data"),
              Text("data"),
              Text("data"),
            ],
          ),
        )
      ],
    );
  }
}
