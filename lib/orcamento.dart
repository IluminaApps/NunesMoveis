//import 'package:cloud_firestore/cloud_firestore.dart'; //lembrar de adicionar no pubspec.yaml
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'buscafretes.dart';
import 'service_login.dart';

class Home extends StatefulWidget {
  Home({Key key, this.params, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final Map params;
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // ignore: non_constant_identifier_names
  TextEditingController vl_produto_controller = TextEditingController();
// ignore: non_constant_identifier_names
  TextEditingController vl_dinheiro_controller = TextEditingController();
// ignore: non_constant_identifier_names
  TextEditingController vl_cartao_controller = TextEditingController();
// ignore: non_constant_identifier_names
  TextEditingController vl_frete_controller = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isEmailVerified = false;
// ignore: non_constant_identifier_names
  double _vl_total = 0;
// ignore: non_constant_identifier_names
  double vl_dinheiro = 0;
  // ignore: non_constant_identifier_names
  double vl_cartao = 0;
  // ignore: non_constant_identifier_names
  double vl_parcela = 0;
  // ignore: non_constant_identifier_names
  double vl_produto =0;
  // ignore: non_constant_identifier_names
  double vl_frete=0;

  String formaPagamento = "";
  var _formas = ['Selecione', 'Cartão', 'Dinheiro'];
  var _itemSelecionado = 'Selecione';

  String dropdownValue = "1x";

  String dropdown = "1x";

  List<String> spinnerItems = [
    "1x",
    "2x",
    "3x",
    "4x",
    "5x",
    "6x",
    "7x",
    "8x",
    "9x",
    "10x",
    "11x",
    "12x",
  ];

  initState() {
    super.initState();

    _checkEmailVerification().whenComplete(() {
      if (!_isEmailVerified && !widget.params['homePageUnverified']) {
// sign out if email not verified and the parameter is set to not show to unverified user
        _signOut();
      }
    });
  }

  Future<void> _checkEmailVerification() async {
    _isEmailVerified = await widget.auth.isEmailVerified();
    if (!_isEmailVerified) {
      _showVerifyEmailDialog();
    }
  }

  void _resendVerifyEmail() {
    widget.auth.sendEmailVerification();
    _showVerifyEmailSentDialog();
  }

  void _showVerifyEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
// return object of type Dialog
        return AlertDialog(
          title: new Text("Verifique sua conta"),
          content: new Text("Verifique a conta no link enviado para o email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Reenviar email de verificação"),
              onPressed: () {
                Navigator.of(context).pop();
                _resendVerifyEmail();
              },
            ),
            new FlatButton(
              child: new Text("Dispensar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
// return object of type Dialog
        return AlertDialog(
          title: new Text("Verifique sua conta"),
          content:
          new Text("Verifique a conta no link enviado para o email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dispensar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  //
  //
  //
  //
  //
  //
  //
  //
  //

  void _dropDownItemFormaDePagamento(String novoItem) {
    setState(() {
      this._itemSelecionado = novoItem;
    });
  }

  void _botaoreset() {
    vl_cartao_controller.text = "";
    vl_produto_controller.text = "";
    vl_dinheiro_controller.text = "";
    vl_frete_controller.text = "";
    _itemSelecionado = 'Selecione';
    dropdownValue = "1x";
    vl_dinheiro = 0;
     vl_cartao = 0;
     vl_parcela = 0;


    setState(() {
      _formkey = GlobalKey<FormState>();
    });
  }

  //
  //
  //
  //
  //

  // colocar fretes

  @override
  void dispose() {
    dispose();
    super.dispose();
  }

  //
  //
  //
  //

  //
  //
  //        calculo do orçamento Pagamento em dinheiro
  //
  //
  //

  void _formDinheiro() {
     vl_produto = double.parse(vl_produto_controller.text);
     vl_frete = double.parse(vl_frete_controller.text);
   vl_dinheiro = double.parse(vl_dinheiro_controller.text);
   // ignore: non_constant_identifier_names
    double n_parcelas = 0;




    if (dropdownValue == "1x") {
      vl_cartao = (vl_produto + vl_frete - vl_dinheiro) * 1.048218;
      n_parcelas = 1;
    } else if (dropdownValue == "2x") {
      vl_cartao = (vl_produto + vl_frete - vl_dinheiro) * 1.064963;
      n_parcelas = 2;
    } else if (dropdownValue == "3x") {
      vl_cartao = (vl_produto + vl_frete - vl_dinheiro) * 1.082251;
      n_parcelas = 3;
    } else if (dropdownValue == "4x") {
      vl_cartao = (vl_produto + vl_frete - vl_dinheiro) * 1.10011;
      n_parcelas = 4;
    } else if (dropdownValue == "5x") {
      vl_cartao = (vl_produto + vl_frete - vl_dinheiro) * 1.118568;
      n_parcelas = 5;
    } else if (dropdownValue == "6x") {
      vl_cartao = (vl_produto + vl_frete - vl_dinheiro) * 1.137656;
      n_parcelas = 6;
    } else if (dropdownValue == "7x") {
      vl_cartao = (vl_produto + vl_frete - vl_dinheiro) * 1.15741;
      n_parcelas = 7;
    } else if (dropdownValue == "8x") {
      vl_cartao = (vl_produto + vl_frete - vl_dinheiro) * 1.177856;
      n_parcelas = 8;
    } else if (dropdownValue == "9x") {
      vl_cartao = (vl_produto + vl_frete - vl_dinheiro) * 1.19904;
      n_parcelas = 9;
    } else if (dropdownValue == "10x") {
      vl_cartao = (vl_produto + vl_frete - vl_dinheiro) * 1.221;
      n_parcelas = 10;
    } else if (dropdownValue == "11x") {
      vl_cartao = (vl_produto + vl_frete - vl_dinheiro) * 1.24378;
      n_parcelas = 11;
    } else if (dropdownValue == "12x") {
      vl_cartao = (vl_produto + vl_frete - vl_dinheiro) * 1.26743;
      n_parcelas = 12;
    }

     _vl_total = vl_cartao + vl_dinheiro;
    setState(() {
      vl_parcela = vl_cartao / n_parcelas;
    });
  }
  //
  //
  //  orçamento pagamento em cartao
  //
  //
  //
  //

  void _formCartao() {


    setState(() {
      // ignore: non_constant_identifier_names
      double vl_produto = double.parse(vl_produto_controller.text);
      // ignore: non_constant_identifier_names
      double vl_frete = double.parse(vl_frete_controller.text);
      // ignore: non_constant_identifier_names
      double vl_cartao = double.parse(vl_cartao_controller.text);
  // ignore: non_constant_identifier_names
      double n_parcelas = 0;

      if (dropdownValue == "1x") {
        vl_dinheiro = vl_cartao - (vl_cartao * 0.046);
        vl_dinheiro = vl_produto + vl_frete - vl_dinheiro;
        n_parcelas = 1;
      } else if (dropdownValue == "2x") {
        vl_dinheiro = vl_cartao - (vl_cartao * 0.061);
        vl_dinheiro = vl_produto + vl_frete - vl_dinheiro;
        n_parcelas = 2;
      } else if (dropdownValue == "3x") {
        vl_dinheiro = vl_cartao - (vl_cartao * 0.076);
        vl_dinheiro = vl_produto + vl_frete - vl_dinheiro;
        n_parcelas = 3;
      } else if (dropdownValue == "4x") {
        vl_dinheiro = vl_cartao - (vl_cartao * 0.0910);
        vl_dinheiro = vl_produto + vl_frete - vl_dinheiro;
        n_parcelas = 4;
      } else if (dropdownValue == "5x") {
        vl_dinheiro = vl_cartao - (vl_cartao * 0.106);
        vl_dinheiro = vl_produto + vl_frete - vl_dinheiro;
        n_parcelas = 5;
      } else if (dropdownValue == "6x") {
        vl_dinheiro = vl_cartao - (vl_cartao * 0.121);
        vl_dinheiro = vl_produto + vl_frete - vl_dinheiro;
        n_parcelas = 6;
      } else if (dropdownValue == "7x") {
        vl_dinheiro = vl_cartao - (vl_cartao * 0.136);
        vl_dinheiro = vl_produto + vl_frete - vl_dinheiro;
        n_parcelas = 7;
      } else if (dropdownValue == "8x") {
        vl_dinheiro = vl_cartao - (vl_cartao * 0.151);
        vl_dinheiro = vl_produto + vl_frete - vl_dinheiro;
        n_parcelas = 8;
      } else if (dropdownValue == "9x") {
        vl_dinheiro = vl_cartao - (vl_cartao * 0.166);
        vl_dinheiro = vl_produto + vl_frete - vl_dinheiro;
        n_parcelas = 9;
      } else if (dropdownValue == "10x") {
        vl_dinheiro = vl_cartao - (vl_cartao * 0.181);
        vl_dinheiro = vl_produto + vl_frete - vl_dinheiro;
        n_parcelas = 10;
      } else if (dropdownValue == "11x") {
        vl_dinheiro = vl_cartao - (vl_cartao * 0.196);
        vl_dinheiro = vl_produto + vl_frete - vl_dinheiro;
        n_parcelas = 11;
      } else if (dropdownValue == "12x") {
        vl_dinheiro = vl_cartao - (vl_cartao * 0.211);
        vl_dinheiro = vl_produto + vl_frete - vl_dinheiro;
        n_parcelas = 12;
      }

       _vl_total= vl_dinheiro + vl_cartao;

       vl_parcela = vl_cartao / n_parcelas;
    });
  }

  //
  //
  //
  //
  //

  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Orçamento"),
        centerTitle: true,
        backgroundColor: Colors.orange,
        leading: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _botaoreset,
            color: Colors.white,
          ),
        actions: <Widget>[

          FlatButton(
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: _signOut),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //
                //
                //        Valor Produto
                //
                //
                //
                //

                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Valor do Produto:",
                      labelStyle: TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.black),
                      )),

                  onChanged: (double) {
                    if(_itemSelecionado =='Dinheiro'){

                      _formDinheiro();

                      setState(() {

                       
                        vl_cartao_controller.text = '${vl_cartao.toStringAsPrecision(
                               5)}';
                        

                      });
                    }

                    else if(_itemSelecionado =='Cartão'){

                      _formCartao();

                      setState(() {
                        
                      
                        vl_dinheiro_controller.text = '${vl_dinheiro.toStringAsPrecision(5)}';

                        


                      });
                    }


                  },


                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                  controller: vl_produto_controller,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira o valor do Produto!";
                    }
                  },
                ),

                //
                //
                //        Valor frete
                //
                //
                //
                //
                Stack(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                    child: Container(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Valor do Frete:",
                          labelStyle: TextStyle(color: Colors.orange),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),

                        onChanged: (teste) {

                          if(_itemSelecionado =='Dinheiro'){

                            _formDinheiro();

                            setState(() {
                           
                              vl_cartao_controller.text = '${vl_cartao.toStringAsPrecision(
                               5)}';
                              


                            });

                          }

                          else if(_itemSelecionado =='Cartão') {
                            _formCartao();



                            setState(() {
                              
                              
                              vl_dinheiro_controller.text = '${vl_dinheiro.toStringAsPrecision(5)}';
                              

                            });
                          }

                        },

                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                        controller: vl_frete_controller,
                        // ignore: missing_return
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira o valor do Frete!";
                          }
                        },
                      ),
                    ),
                  ),

                  
                  Padding(
                    padding: EdgeInsets.only(
                     
                      top: 28.0,
                    ),
                    child: Container(
                      height: 34.8,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right:10),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => pesquisalocal(),
                              ));
                        },
                        child: Text(
                          "Buscar Local",
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                          textAlign: TextAlign.center,
                        ),
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ]),

                //
                //
                //        forma de pagamento
                //
                //
                //
                //
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 15.0,
                    top: 08.0,
                  ),
                  child: Container(

                    foregroundDecoration: BoxDecoration(
                      border: Border.all(
                        width: 0.6,
                      ),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(7),
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10.0, top: 15.0, bottom: 10.0),
                          child: Container(
                            child: Text(
                              "Forma de Pagamento:",
                              style: TextStyle(
                                  color: Colors.orange, fontSize: 15.0),
                            ),
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          alignment:Alignment.centerRight,
                          padding: EdgeInsets.only(right:10),
                          child: DropdownButton<String>(
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 28,
                            elevation: 16,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                            items: _formas.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (String novoItemSelecionado) {
                              _dropDownItemFormaDePagamento(
                                  novoItemSelecionado);

                              setState(() {
                                this._itemSelecionado = novoItemSelecionado;

                                if(_itemSelecionado =='Dinheiro'){

                                  _formDinheiro();
                                  setState(() {
                                    
                                    vl_cartao_controller.text = '${vl_cartao.toStringAsPrecision(5)}';
                          
                                    

                                  });
                                }

                                 if(_itemSelecionado =='Cartão'){

                                _formCartao();

                                setState(() {
                                
                                
                                vl_dinheiro_controller.text = '${vl_dinheiro.toStringAsPrecision(5)}';
                              


                                });
                                }
                              }
                              );
                            },
                            value: _itemSelecionado,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //
                //
                //        Valor avista
                //
                //
                //
                //

                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Valor a Vista:",
                      labelStyle: TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.black),
                      )),

                  onChanged: (double) {
                    if(_itemSelecionado =='Dinheiro'){

                      _formDinheiro();

                      setState(() {
                        
                        vl_cartao_controller.text = '${vl_cartao.toStringAsPrecision(5)}';
                               
                       
                        


                      });
                    }else if(_itemSelecionado =='Cartão'){

                                  _formCartao();

                                  setState(() {
                                    
                                    
                                    vl_dinheiro_controller.text = '${vl_dinheiro.toStringAsPrecision(5)}';
                                  
                                  });
                                }
                              },

              
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                  controller: vl_dinheiro_controller,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira o Valor a ser pago em Dinheiro!";
                    }

                  },
                ),

                //
                //
                //        nº parcelas
                //
                //
                //
                //
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10.0,
                    top: 15.0,
                  ),
                  child: Container(
                    foregroundDecoration: BoxDecoration(
                      border: Border.all(
                        width: 0.6,
                      ),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(7),
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[

                        Padding(
                          padding: EdgeInsets.only(
                              left: 15.0, right: 15.0,top: 15.0, bottom: 1.0),
                          child: Container(
                            height: 43.0,

                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: "Valor Cartao",
                                  labelStyle: TextStyle(color: Colors.orange),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(color: Colors.black),
                                  ) ),
                              onChanged: (double) {
                                if(_itemSelecionado =='Dinheiro'){

                                  
                                  _formDinheiro();

                                  setState(() {
                                    
                                     vl_cartao_controller.text = '${vl_cartao.toStringAsPrecision(
                               5)}';

                                  });
                                }
                                else if(_itemSelecionado =='Cartão'){

                                  _formCartao();

                                  setState(() {
                                    
                                    
                                    vl_dinheiro_controller.text = '${vl_dinheiro.toStringAsPrecision(5)}';
                                  
                                  });
                                }
                              },
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.black, fontSize: 15.0),
                              controller: vl_cartao_controller,
                              // ignore: missing_return
                              validator: (value) {
                              if (value.isEmpty) {
                              return "Insira o Valor do cartao";
                              }
                              },


                            ),
                        
                          ),
                        ),




                        Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, top: 65.0, bottom: 1.0),
                          child: Container(
                            child: Text(
                              "Parcelas :",
                              style: TextStyle(
                                  color: Colors.orange, fontSize: 15.0),
                            ),
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 70.0,
                            left: 20.0,
                          ),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 28,
                            elevation: 10,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                            underline: Container(
                              height: 2,
                              color: Colors.white,
                            ),
                            onChanged: (String data) {
                              setState(() {
                                dropdownValue = data;


                                  if(_itemSelecionado =='Dinheiro'){
                                    _formDinheiro();

                                    setState(() {
                                      

                                    });

                                }
                                  else if(_itemSelecionado =='Cartão'){

                                    _formCartao();



                                    setState(() {
                                      vl_dinheiro_controller.text = '${vl_dinheiro.toStringAsPrecision(5)}';
                                      


                                    });
                                  }
                              });
                            },
                            items: spinnerItems
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),

                     
                       
                        Padding(
                          padding: EdgeInsets.only(
                            top: 85.0,
                            left: 85.0,
                          ),
                          child: Container(
                            width: 140.0,
                            height: 40.0,
                            child: Text(
                              '${vl_parcela.toStringAsPrecision(4)}',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //
                //
                //  Total
                //
                //
                //
                Stack(
                  children: <Widget>[
                   Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                  child: Container(
                
                     alignment: Alignment.center,
                        child: Text(
                          "Total: "+'${_vl_total.toStringAsPrecision(5)}',
                          style:
                              TextStyle(color: Colors.orange, fontSize: 25.0),
                          textAlign: TextAlign.center,
                        ),
                        color: Colors.white,
                      ),
                    ),
                
                  ],
                ),



                //
                //
                //        botão calcular
                //
                //
                //
                //

                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                  child: Container(
                    height: 40.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {

                     if(_itemSelecionado =='Dinheiro') {

                       Share.share(
                           'Valor a vista: ${vl_dinheiro.toStringAsPrecision(5)}' +'\n' +
                               'Valor do Frete: ${vl_frete.toStringAsPrecision(4)}' + '\n' +
                               'Valor no Cartão: ${vl_cartao.toStringAsPrecision(5)}' + '\n' +
                               'Nº Parcelas: $dropdownValue'+ '\n'+
                               'Valor das Parcelas: ${vl_parcela.toStringAsPrecision(4)}' + '\n'+ '\n'
                               'Total a Pagar : ${_vl_total.toStringAsPrecision(5)}'
                       );

                     }else if(_itemSelecionado =='Cartão') {

                       Share.share('Valor a Vista: ${vl_dinheiro
                           .toStringAsPrecision(5)}' +
                           '\n' +
                           'Valor do Frete: ${vl_frete.toStringAsPrecision(
                               4)}' +
                           '\n' +
                           'Valor no Cartão: ${vl_cartao.toStringAsPrecision(
                               5)}' +
                           '\n' +
                           'Nº Parcelas: $dropdownValue' +
                           '\n' +
                           'Valor das Parcelas: ${vl_parcela
                               .toStringAsPrecision(4)}' +
                           '\n' +
                           '\n'
                               'Total a Pagar : ${_vl_total.toStringAsPrecision(
                               5)}');




                     }
                      },
                      child: Text(
                        "Compartilhar",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      color: Colors.orange,
                    ),
                  ),
                ),

                //
                //
                //
                //
                //
                //
                //
              ],
            ),
          )),
    );
  }
}
