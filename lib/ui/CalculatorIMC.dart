import 'package:calculator_bmc_flutter/ui/result.dart';
import 'package:flutter/material.dart';

class CalculatorIMC extends StatefulWidget {
  @override
  _CalculatorIMCState createState() => _CalculatorIMCState();
}

class _CalculatorIMCState extends State<CalculatorIMC> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _textInfo = "";
  String _imagem = "";

  void _resetCampos() {
    _formKey.currentState.reset();
    pesoController.clear();
    alturaController.clear();
    setState(() {
      _textInfo = "";
      _imagem = "";
    });
  }

  void _calcular() {
//    setState(() {});
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text) / 100;
    double imc = peso / (altura * altura);

    if (imc < 18.6) {
      _textInfo = "Abaixo do peso iii (${imc.toStringAsPrecision(4)})";
      _imagem = "images/thin-man.png";
    } else if (imc > 18.6 && imc < 24.9) {
      _textInfo = "Peso ideal (${imc.toStringAsPrecision(4)})";
      _imagem = "images/medium-man.png";
    } else if (imc > 24.9 && imc < 29.9) {
      _textInfo = "Levemente acima do peso s (${imc.toStringAsPrecision(4)})";
      _imagem = "images/little-man.png";
    } else if (imc > 29.9 && imc < 34.9) {
      _textInfo = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      _imagem = "images/fat-man.png";
    } else if (imc > 34.9 && imc < 39.9) {
      _textInfo = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      _imagem = "images/fat-man.png";
    } else if (imc > 39.9) {
      _textInfo = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      _imagem = "images/big-fat-man.png";
    }

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Result(_imagem, _textInfo)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadaora IMC'),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetCampos,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person, size: 120, color: Colors.red),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.red)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 25.0),
                  controller: pesoController,
                  validator: (value) {
                    if (value.isEmpty) return "Insira seu peso!";
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.red)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 25.0),
                  controller: alturaController,
                  validator: (value) {
                    if (value.isEmpty) return "Insira sua altura!";
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) _calcular();
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.red,
                      )),
                ),
                Text(
                  _textInfo,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 25.0),
                ),
              ],
            ),
          ),
        ));
  }
}
