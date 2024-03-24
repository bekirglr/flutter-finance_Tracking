import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Örneği',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Ana Sayfa'),
            onTap: () {
              // Ana sayfaya gitmek için burada işlemler yapabilirsiniz.
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ayarlar'),
            onTap: () {
              // Ayarlar sayfasına gitmek için burada işlemler yapabilirsiniz.
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Hakkında'),
            onTap: () {
              // Hakkında sayfasına gitmek için burada işlemler yapabilirsiniz.
            },
          ),
        ],
      ),
    );
  }
}
