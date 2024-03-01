import 'package:flutter/material.dart';

class RefugioPerfil extends StatefulWidget {
  const RefugioPerfil({super.key});

  @override
  State<RefugioPerfil> createState() => _RefugioPerfilState();
}

class _RefugioPerfilState extends State<RefugioPerfil> {

  //TODO Conectarnos a la base de datos mascotas_adopcion


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil Refugio"),
      ),

      
    );
  }
}
