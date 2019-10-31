import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _alturaController = TextEditingController();
  TextEditingController _pesoController = TextEditingController();

  String _textoDeInformacao = "Informe Seus Dados";

  GlobalKey<FormState> _chaveFormulario = GlobalKey<FormState>();

  void _resetCampos() {
    setState(() {
      _alturaController.text = "";
      _pesoController.text = "";
      _textoDeInformacao = "Informe Seus Dados";
      _chaveFormulario = GlobalKey<FormState>();
    });
  }

  void _calculaIMC() {
    setState(() {
      double peso = double.parse(_pesoController.text);
      double altura = double.parse(_alturaController.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.5) {
        _textoDeInformacao =
            "Seu IMC é ${imc.toStringAsFixed(2)}\n Abaixo do Peso";
      } else if (imc >= 18.5 && imc < 25) {
        _textoDeInformacao =
            "Seu IMC é ${imc.toStringAsFixed(2)}\n Peso Normal";
      } else if (imc >= 25 && imc < 30) {
        _textoDeInformacao = "Seu IMC é ${imc.toStringAsFixed(2)}\n Sobrepeso";
      } else if (imc >= 30 && imc < 35) {
        _textoDeInformacao =
            "Seu IMC é ${imc.toStringAsFixed(2)}\n Obesidade grau 1";
      } else if (imc >= 35 && imc < 40) {
        _textoDeInformacao =
            "Seu IMC é ${imc.toStringAsFixed(2)}\n Obesidade grau 2";
      } else if (imc >= 40) {
        _textoDeInformacao =
            "Seu IMC é ${imc.toStringAsFixed(2)}\n Obesidade grau 3";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculador de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetCampos,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _chaveFormulario,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  color: Colors.green,
                  size: 120,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso(Kg)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: _pesoController,
                  validator: (valor) {
                    if (valor.isEmpty) {
                      return "Insira seu Peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura(cm)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: _alturaController,
                  validator: (valor) {
                    if(valor.isEmpty){
                      return "Insira sua Altura!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    width: 10.0,
                    child: RaisedButton(
                      onPressed: (){
                        if(_chaveFormulario.currentState.validate()){
                          _calculaIMC();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(fontSize: 25.0),
                      ),
                      color: Colors.green,
                      textColor: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 0.0, top: 30.0, bottom: 0.0, right: 0.0),
                  child: Text(
                    _textoDeInformacao,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 30.0),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
