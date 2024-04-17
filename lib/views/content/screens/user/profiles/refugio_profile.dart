import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/config/connect/connect_server.dart';
import 'package:mascotas_bga/controllers/gets/adp_pets_refugio.controller.dart';
import 'package:mascotas_bga/views/content/screens/user/profiles/adp_pets_profile.dart';

class RefugioProfile extends StatefulWidget {
  const RefugioProfile({super.key, required this.refugio});

  @override
  _RefugioProfileState createState() => _RefugioProfileState();

  final Map<String, dynamic> refugio;
}

class _RefugioProfileState extends State<RefugioProfile> {
  final AdpPetsRefugioController _controller = AdpPetsRefugioController();
  List<Map<String, dynamic>> mascotasrefugio = [];

  @override
  void initState() {
    super.initState();
    final idRefugio = int.parse(widget.refugio["id_refugio_fk"]);
    cargarMascotas(idRefugio);
  }

  Future<void> cargarMascotas(int idRefugio) async {
    final mascotasRefugio = await _controller.getMascotasAdpRefugio(idRefugio);
    setState(() {
      mascotasrefugio = mascotasRefugio;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${widget.refugio["nombre_refugio"] ?? "Refugio"}'),
              const Icon(Icons.verified_user_rounded, color: Colors.blue, size: 30,)
              ]),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSeccionInfo("Ciudad", widget.refugio["ciudad_refugio"]),
                buildSeccionInfo("Barrio", widget.refugio["barrio_refugio"]),
                buildSeccionInfo(
                    "Dirección", widget.refugio["direccion_refugio"]),
                buildSeccionInfo(
                    "Telefonos", widget.refugio["telefono_refugio"]),
                buildSeccionInfo(
                    "Correo electrónico", widget.refugio["email_refugio"]),
                buildSeccionInfo(
                    "Sobre Nosotros", widget.refugio["desc_refugio"]),
                buildSeccionInfo(
                    "Nuestra Misión", widget.refugio["mision_refugio"]),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "Nuestras Mascotas",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 132, 31, 150),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Aquí se muestra la lista de imágenes
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                        children: List.generate(
                            (mascotasrefugio.length / 2).ceil(), (index) {
                      final startIndex = index * 2;
                      final endIndex = (index + 1) * 2;
                      final mascotas = mascotasrefugio.sublist(
                          startIndex,
                          endIndex < mascotasrefugio.length
                              ? endIndex
                              : mascotasrefugio.length);
                      return Row(
                        children: mascotas.map((mascota) {
                          return Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: GestureDetector(
                                onTap: () {
                                  context.push("/petsAdpProfile", extra: mascota);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "http://$ipConnect/mascotas/${mascota["imagen_mascota"]}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    })))
              ],
            ),
          ),
        ));
  }
}





  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // cargarDatosRefugio();
  // }

  // Future<void> cargarDatosRefugio() async {
  //   final idRefugio = ref.watch(idRefugioInfoProvider.notifier).state;
  //   final url = Uri.parse(
  //       'http://$ipConnect/mascotas/view_refugio_info.php?id_refugio=$idRefugio');
  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     setState(() {
  //       direcciones = data['direcciones'];
  //       telefonos = data['telefonos'];
  //     });
  //   } else {
  //     // Manejar el error
  //     print("Error al obtener los datos del refugio.");
  //   }
  // }