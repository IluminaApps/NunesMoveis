import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nunes_moveis_app/searchservice.dart';


// ignore: camel_case_types
class pesquisalocal extends StatefulWidget {
  

  @override
  _pesquisalocalState createState() => new _pesquisalocalState();
}

// ignore: camel_case_types
class _pesquisalocalState extends State<pesquisalocal> {
  var queryResultSet = [];
  // ignore: non_constant_identifier_names
  var vl_pesquisalocal = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        vl_pesquisalocal = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      vl_pesquisalocal = [];
      queryResultSet.forEach((element) {
        if (element['nome'].startsWith(capitalizedValue)) {
          setState(() {
            vl_pesquisalocal.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: (val) {
                initiateSearch(val);
              },
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.arrow_back),
                    iconSize: 20.0,
                    onPressed: () {
                      Navigator.pop(context);
                    },


                  ),
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Pesquise o local',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0))),
            ),
          ),
          SizedBox(width: 1.0, height: 1.0),

          GridView.count(

              padding: EdgeInsets.only(left: 1.0, right: 1.0),
              crossAxisCount: 5,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              primary: false,
              shrinkWrap: true,


              children:vl_pesquisalocal.map((element) {
                return buildResultCard(element);
              }).toList())


        ]

        )

    );
  }


  Widget buildResultCard(data) {

  return Card(shadowColor: Colors.black,
      color: Colors.orangeAccent,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 8.0,
      child: new InkWell(
        onTap: () {

        },

      child: Container(
          child: Center(
              child: Text(data['nome'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,

                ),
              )
          )
      )
      )
  );
}
}