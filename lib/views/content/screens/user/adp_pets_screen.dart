import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:mascotas_bga/controllers/gets/adp_pets_controller.dart';



import 'package:mascotas_bga/helpers/shared.dart';

class AdpPetsScreen extends ConsumerStatefulWidget {
  const AdpPetsScreen({Key? key}) : super(key: key);

  @override
  AdpPetsScreenState createState() => AdpPetsScreenState();
}

class AdpPetsScreenState extends ConsumerState<AdpPetsScreen> {
  final AdpPetsController _controller = AdpPetsController();
  List<Map<String, dynamic>> mascotasadp = [];

  @override
  void initState() {
    getMascotasAdp();
    super.initState();
  }

  Future<void> getMascotasAdp() async {
    final mascotasAdp = await _controller.getMascotasAdp();
    setState(() {
      mascotasadp = mascotasAdp;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final rolActual = ref.watch(rolProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mascotas en Adopción'),
      ),
      body: mascotasadp.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: mascotasadp.length,
              itemBuilder: (context, index) {
                final pet = mascotasadp[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(pet['imagen_mascota']),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(pet['nombre_mascota_adp']),
                        Text(
                          'Refugio: ${pet['nombre_refugio']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Teléfono: ${pet['telefono_refugio']}',
                        ),
                        Text(
                          'Ciudad: ${pet['ciudad_refugio']}',
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Raza: ${pet['raza_mascota_adp']}'),
                        Text('Tamaño: ${pet['tamano_mascota_adp']}'),
                        Text('Edad: ${pet['edad_mascota_adp']}'),
                        Text('Color: ${pet['color_mascota_adp']}'),
                        Text('Descripción: ${pet['desc_mascota_adp']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
