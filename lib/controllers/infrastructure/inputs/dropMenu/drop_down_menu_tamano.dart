import 'package:flutter/material.dart';

class DropDownMenuTamano extends StatefulWidget {
  final TextEditingController controller;
  const DropDownMenuTamano({super.key, required this.controller});

  @override
  DropDownMenuTamanoState createState() => DropDownMenuTamanoState();
}

class DropDownMenuTamanoState extends State<DropDownMenuTamano> {
  String? _selectedTamano;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: DropdownButton(
        hint: const Text("Tamaño de Mascota",
        style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black45),),
        value: _selectedTamano,
        onChanged: (value) {
          setState(() {
            _selectedTamano = value;
            widget.controller.text = _selectedTamano ?? '';
          });
        },
        items: const [
          DropdownMenuItem(
            value: 'Grande',
            child: Text('Grande', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),),
          ),
          DropdownMenuItem(
            value: 'Mediano',
            child: Text('Mediano', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),),
          ),
          DropdownMenuItem(
            value: 'Pequeño',
            child: Text('Pequeño', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),),
          ),
        ],
      ),
    );
  }
}
