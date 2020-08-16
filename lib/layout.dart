import 'package:flutter/material.Dart';

import 'buscandoeinserindonobanco.dart';

//import 'package:nunesmobile/selection.dart'

class Layout {
  static Widget render(Widget content, [String title = 'Fretes']) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: content,
      floatingActionButton: FloatingActionButton(
        onPressed: () {testebanco();},
        tooltip: 'increment',
        child: Icon(Icons.add),

      ),
    );

  }

  Color primary([double opacity = 1]) =>
      Colors.red[700].withOpacity(opacity = 1.0);

  Color seconday([double opacity = 1]) =>
      Color(0xc203e).withOpacity(opacity = 1.0);
}