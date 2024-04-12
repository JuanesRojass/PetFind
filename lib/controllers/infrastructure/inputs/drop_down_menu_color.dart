import 'package:flutter/material.dart';

class DropDownMenuColor extends StatefulWidget {
  final TextEditingController controller;
  const DropDownMenuColor({super.key, required this.controller});

  @override
  DropDownMenuColorState createState() => DropDownMenuColorState();
}

class DropDownMenuColorState extends State<DropDownMenuColor> {
  String? _selectedColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: DropdownButton(
        hint: const Text("Color de Mascota",
        style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black45),),
        value: _selectedColor,
        onChanged: (value) {
          setState(() {
            _selectedColor = value;
            widget.controller.text = _selectedColor ?? '';
          });
        },
        items: const [
          DropdownMenuItem(
            value: 'Amarillo',
            child: Text('Amarillo', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),),
          ),
          DropdownMenuItem(
            value: 'Blanco',
            child: Text('Blanco', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),),
          ),
          DropdownMenuItem(
            value: 'Beige',
            child: Text('Beige', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),),
          ),
          DropdownMenuItem(
            value: 'Dorado',
            child: Text('Dorado', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),),
          ),
          DropdownMenuItem(
            value: 'Gris',
            child: Text('Gris', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),),
          ),
          DropdownMenuItem(
            value: 'Marrón',
            child: Text('Marrón', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),),
          ),
          DropdownMenuItem(
            value: 'Negro',
            child: Text('Negro', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),),
          ),
        ],
      ),
    );
  }
}