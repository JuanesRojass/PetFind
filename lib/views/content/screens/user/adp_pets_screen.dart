import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/controllers/gets/adp_pets_controller.dart';

import 'package:mascotas_bga/controllers/providers/general/rol_provider.dart';

import 'package:mascotas_bga/helpers/shared.dart';


class AdpPetsScreen extends ConsumerStatefulWidget {
  const AdpPetsScreen({Key? key}) : super(key: key);

  @override
  AdpPetsScreenState createState() => AdpPetsScreenState();
}

class AdpPetsScreenState extends ConsumerState<AdpPetsScreen> {
  final AdpPetsController _controller = AdpPetsController();
  List mascotasadp = [];

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
    final rolActual = ref.watch(rolProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mascotas En Adopción'),
      ),
      body: ListView.builder(
        itemCount: mascotasadp.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: GestureDetector(
                      onTap: () {
                        context.push('/petsAdpProfile', extra: mascotasadp[index]);
                      },
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(1.0, 1.0, 30, 1.0),
                            child: Icon(
                              Icons.pets,
                              size: 60,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(mascotasadp[index]["nombre_mascota_adp"]),
                              Text(mascotasadp[index]["raza_mascota_adp"]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () =>
                              context.push('/petsAdpProfile', extra: mascotasadp[index]),
                          child: const Text(
                            "Mas Información",
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: rolActual == "Refugio"
          ? FloatingActionButton(
              onPressed: () {
                // Acción al presionar el botón
              },
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: const BottomNavigationUser(),
    );
  }
}