import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String info = 'Informe seus dados!';

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void reset() {
    weightController.clear();
    heightController.clear();

    setState(() {
      info = 'Informe seus dados!';
      formKey.currentState!.reset();
    });
  }

  void calculate() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      String imcText = imc.toStringAsPrecision(4);

      if (imc < 18.6) {
        info = 'Abaixo do peso: ($imcText)';
      } else if (imc >= 18.8 && imc < 24.9) {
        info = 'Peso ideal ($imcText)';
      } else if (imc >= 24.9 && imc < 29.9) {
        info = 'Levemente acima do peso ($imcText)';
      } else if (imc >= 29.9 && imc < 34.9) {
        info = 'Obesidade Grau I ($imcText)';
      } else if (imc >= 34.9 && imc < 39.9) {
        info = 'Obesidade Grau II ($imcText)';
      } else if (imc >= 39.9) {
        info = 'Obesidade Grau III ($imcText)';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: reset, icon: Icon(Icons.refresh)),
        ],
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Calculadora de IMC'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person_outline, color: Colors.green, size: 120),
              TextFormField(
                controller: weightController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.green),
                  labelText: 'Peso (kg)',
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.green, fontSize: 25),
                textAlign: TextAlign.center,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira seu peso';
                  }
                },
              ),
              TextFormField(
                controller: heightController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.green),
                  labelText: 'Altura (cm)',
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.green, fontSize: 25),
                textAlign: TextAlign.center,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira sua altura';
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: calculate,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text('Calcular',
                          style: TextStyle(color: Colors.white, fontSize: 25))),
                ),
              ),
              Text(info,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25))
            ],
          ),
        ),
      ),
    );
  }
}
