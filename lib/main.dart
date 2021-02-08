import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Calculadora de IMC",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _textInfo = "";
  String _genero = "Gênero neutro";
  void _resetCampos() {
    _formKey.currentState.reset();
    pesoController.clear();
    alturaController.clear();
    setState(() {
      _textInfo = "";
      _genero = "Gênero neutro";
    });
  }

  void _calcular() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.6)
        _textInfo = "$_genero abaixo do peso (${imc.toStringAsPrecision(4)})";
      else if (imc >= 18.6 && imc < 24.9)
        _textInfo = "$_genero em peso Ideal (${imc.toStringAsPrecision(4)})";
      else if (imc >= 24.9 && imc < 29.9)
        _textInfo =
            "$_genero levemente acima do peso (${imc.toStringAsPrecision(4)})";
      else if (imc >= 29.9 && imc < 34.9)
        _textInfo =
            "$_genero com obesidade Grau I (${imc.toStringAsPrecision(4)})";
      else if (imc >= 34.9 && imc < 39.9)
        _textInfo =
            "$_genero com obesidade Grau II (${imc.toStringAsPrecision(4)})";
      else if (imc >= 40)
        _textInfo =
            "$_genero com obesidade Grau III (${imc.toStringAsPrecision(4)})";
    });
  }

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
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
                  if (value.isEmpty) return "Deve Inserir seu peso!";
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
                  if (value.isEmpty) return "Deve Inserir sua altura!";
                },
              ),
              DropdownButton<String>(
                value: _genero,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.red),
                underline: Container(
                  height: 2,
                  color: Colors.red,
                ),
                onChanged: (String novoGenero) {
                  setState(() {
                    _genero = novoGenero;
                  });
                },
                items: <String>["Gênero neutro", "Homem", "Mulher"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: ButtonTheme(
                    height: 50.0,
                    highlightColor: Colors.amber,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
