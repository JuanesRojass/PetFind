import 'package:flutter/material.dart';

class DropDownMenuEdad extends StatefulWidget {
  final TextEditingController controller;
  const DropDownMenuEdad({super.key, required this.controller});

  @override
  DropDownMenuEdadState createState() => DropDownMenuEdadState();
}

class DropDownMenuEdadState extends State<DropDownMenuEdad> {
  String? _selectedEdad;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: DropdownButton(
        hint: const Text(
          "Edad de Mascota",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black45),
        ),
        value: _selectedEdad,
        onChanged: (value) {
          setState(() {
            _selectedEdad = value;
            widget.controller.text = _selectedEdad ?? '';
          });
        },
        items: List<DropdownMenuItem<String>>.generate(20, (int index) {
          return DropdownMenuItem(
            value: '${index + 1}',
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            ),
          );
        }),
      ),
    );
  }
}
