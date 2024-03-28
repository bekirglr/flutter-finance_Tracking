import 'package:flutter/material.dart';

class BottomSheetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20,
          ),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Tutar',
            ),
            onChanged: (value) {
              // setState(() {
              //   amount = double.tryParse(value) ?? 0.0;
              // });
            },
          ),
          const SizedBox(height: 20.0),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Kategori',
            ),
            onChanged: (value) {
              // setState(() {
              //   description = value;
              // });
            },
          ),
          const SizedBox(
            height: 30,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  ButtonBar(
                    children: [
                      TextButton(
                        onPressed: () => {},
                        child: const Text(
                          "Tutar ekle",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.green.shade800),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      TextButton(
                        onPressed: () => {},
                        child: const Text(
                          "Tutar çıkar",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.green.shade800),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
