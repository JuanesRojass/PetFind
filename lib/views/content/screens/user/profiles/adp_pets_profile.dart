import 'package:flutter/material.dart';

class PetsAdoptProfile extends StatefulWidget {
  const PetsAdoptProfile({super.key, required this.petsAdp});

  @override
  State<PetsAdoptProfile> createState() => _PetsAdoptProfileState();
  final Map petsAdp;
}

class _PetsAdoptProfileState extends State<PetsAdoptProfile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.petsAdp["nombre_mascota_adp"] ?? "Mascota"}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text("Refugio: ${widget.petsAdp["id_refugio_fk"] ?? "Refugio no encontrado"}"),        
              const SizedBox(height: 20,),
              Text("Tamaño: ${widget.petsAdp["tipo_mascota_adp"] ?? "Tamaño no definido"}"),        
              const SizedBox(height: 20,),
              Text("Imagen: ${widget.petsAdp["imagen_mascota_adp"] ?? "No Image"}"),
              const SizedBox(height: 20,),
              Text("Sexo: ${widget.petsAdp["sexo_mascota_adp"] ?? "Sexo no definido"}"),        
              const SizedBox(height: 20,),
              Text("Raza: ${widget.petsAdp["raza_mascota_adp"] ?? "Raza no definida"}"),
              const SizedBox(height: 20,),
              Text("Tamaño: ${widget.petsAdp["tamano_mascota_adp"] ?? "Tamaño no definido"}"),        
              const SizedBox(height: 20,),
              Text("Edad: ${widget.petsAdp["edad_mascota_adp"] ?? "Edad no definida"}"),        
              const SizedBox(height: 20,),
              Text("Color: ${widget.petsAdp["color_mascota_adp"] ?? "Color no definido"}"),        
              const SizedBox(height: 20,),
              Text("Descripción: ${widget.petsAdp["desc_mascota_adp"] ?? "No hay descripción"}"),        
              const SizedBox(height: 20,),
              const Center(child: Text("Mascotas", style: TextStyle( fontSize: 20),)),
        
        
          ]),
      ));
  }
}