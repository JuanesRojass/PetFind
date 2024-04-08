import 'package:flutter/material.dart';

class RefugioProfile extends StatefulWidget {
  const RefugioProfile({super.key, required this.refugio});

  @override
  State<RefugioProfile> createState() => _RefugioProfileState();
  final Map refugio;
}

class _RefugioProfileState extends State<RefugioProfile> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.refugio["nombre_refugio"] ?? "Refugio"}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text("Email: ${widget.refugio["email_refugio"] ?? ""}"),
              const SizedBox(height: 20,),
              Text("Dirección: ${widget.refugio["direccion_refugio"] ?? ""}"),
              const SizedBox(height: 20,),
              Text("Sobre Nosotros: ${widget.refugio["desc_refugio"] ?? ""}"),        
              const SizedBox(height: 20,),
              const Center(child: Text("Mascotas", style: TextStyle( fontSize: 20),)),
        
        
          ]),
      ));
  }
}
