import 'package:flutter/material.dart';

class DropDownMenuSexo extends StatefulWidget {
  final TextEditingController controller;
  const DropDownMenuSexo({super.key, required this.controller});

  @override
  DropDownMenuSexoState createState() => DropDownMenuSexoState();
}

class DropDownMenuSexoState extends State<DropDownMenuSexo> {
  String? _selectedSexo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: DropdownButton(
        hint: const Text("Sexo de Mascota",
        style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black45),),
        value: _selectedSexo,
        onChanged: (value) {
          setState(() {
            _selectedSexo = value;
            widget.controller.text = _selectedSexo ?? '';
          });
        },
        items: const [
          DropdownMenuItem(
            value: 'Hembra',
            child: Text('Hembra', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),),
          ),
          DropdownMenuItem(
            value: 'Macho',
            child: Text('Macho', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),),
          ),
        ],
      ),
    );
  }
}