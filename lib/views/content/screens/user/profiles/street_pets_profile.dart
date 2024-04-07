import 'package:flutter/material.dart';

class PetsStreetProfile extends StatefulWidget {
  const PetsStreetProfile({super.key, required this.petsAdp});

  @override
  State<PetsStreetProfile> createState() => _PetsStreetProfileState();
  final Map petsAdp;
}

class _PetsStreetProfileState extends State<PetsStreetProfile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mascota Encontrada"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text("Usuario: ${widget.petsAdp["id_usuario_fk"] ?? "Refugio no encontrado"}"),        
              const SizedBox(height: 20,),
              Text("Tamaño: ${widget.petsAdp["tipo_mascota_calle"] ?? "Tamaño no definido"}"),        
              const SizedBox(height: 20,),
              Text("Imagen: ${widget.petsAdp["imagen_mascota_calle"] ?? "No Image"}"),
              const SizedBox(height: 20,),
              Text("Sexo: ${widget.petsAdp["sexo_mascota_calle"] ?? "Sexo no definido"}"),        
              const SizedBox(height: 20,),
              Text("Raza: ${widget.petsAdp["raza_mascota_calle"] ?? "Raza no definida"}"),
              const SizedBox(height: 20,),
              Text("Tamaño: ${widget.petsAdp["tamano_mascota_calle"] ?? "Tamaño no definido"}"),        
              const SizedBox(height: 20,),
              Text("Edad: ${widget.petsAdp["edad_mascota_calle"] ?? "Edad no definida"}"),        
              const SizedBox(height: 20,),
              Text("Color: ${widget.petsAdp["color_mascota_calle"] ?? "Color no definido"}"),        
              const SizedBox(height: 20,),
              Text("Descripción: ${widget.petsAdp["desc_mascota_calle"] ?? "No hay descripción"}"),        
              const SizedBox(height: 20,),
              const Center(child: Text("Mascotas", style: TextStyle( fontSize: 20),)),
        
        
          ]),
      ));
  }
}