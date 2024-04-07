import 'package:flutter/material.dart';

class PetsLostProfile extends StatefulWidget {
  const PetsLostProfile({super.key, required this.petsLost});

  @override
  State<PetsLostProfile> createState() => _PetsLostProfileState();
  final Map petsLost;
}

class _PetsLostProfileState extends State<PetsLostProfile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.petsLost["nombre_mascota_lost"] ?? "Mascota"}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text("Usuario: ${widget.petsLost["id_usuario_fk"] ?? "Refugio no encontrado"}"),        
              const SizedBox(height: 20,),
              Text("Tamaño: ${widget.petsLost["tipo_mascota_lost"] ?? "Tamaño no definido"}"),        
              const SizedBox(height: 20,),
              Text("Imagen: ${widget.petsLost["imagen_mascota_lost"] ?? "No Image"}"),
              const SizedBox(height: 20,),
              Text("Sexo: ${widget.petsLost["sexo_mascota_lost"] ?? "Sexo no definido"}"),        
              const SizedBox(height: 20,),
              Text("Raza: ${widget.petsLost["raza_mascota_lost"] ?? "Raza no definida"}"),
              const SizedBox(height: 20,),
              Text("Tamaño: ${widget.petsLost["tamano_mascota_lost"] ?? "Tamaño no definido"}"),        
              const SizedBox(height: 20,),
              Text("Recompensa: ${widget.petsLost["recom_mascota_lost"] ?? "Edad no definida"}"),        
              const SizedBox(height: 20,),
              Text("Color: ${widget.petsLost["color_mascota_lost"] ?? "Color no definido"}"),        
              const SizedBox(height: 20,),
              Text("Descripción: ${widget.petsLost["desc_mascota_adp"] ?? "No hay descripción"}"),        
              const SizedBox(height: 20,),
              const Center(child: Text("Mascotas", style: TextStyle( fontSize: 20),)),
        
        
          ]),
      ));
  }
}