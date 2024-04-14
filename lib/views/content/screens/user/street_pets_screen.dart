import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/controllers/gets/street_pets_controller.dart';
import 'package:mascotas_bga/controllers/providers/general/rol_provider.dart';
import '../../../../helpers/shared.dart';

class StreetPetsScreen extends ConsumerStatefulWidget {
  const StreetPetsScreen({Key? key}) : super(key: key);

  @override
  StreetPetsScreenState createState() => StreetPetsScreenState();
}

class StreetPetsScreenState extends ConsumerState<StreetPetsScreen> {
  final StreetPetsController _controller = StreetPetsController();
  List mascotascalle = [];

  @override
  void initState() {
    getMascotasStreet();
    super.initState();
  }

  Future<void> getMascotasStreet() async {
    final mascotasCalle = await _controller.getMascotasStreet();
    setState(() {
      mascotascalle = mascotasCalle;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rolActual = ref.watch(rolProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Mascotas En Calle'),
        ),
        body: ListView.builder(
          itemCount: mascotascalle.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: GestureDetector(
                      onTap: () {
                        context.push('/petsStreetProfile',
                            extra: mascotascalle[index]);
                      },
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(1.0, 1.0, 30, 1.0),
                            child: Icon(
                              Icons.book,
                              size: 60,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(mascotascalle[index]
                                  ["direccion_mascota_calle"]),
                              Text(mascotascalle[index]["raza_mascota_calle"]),
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
                            onPressed: () => context.push('/petsStreetProfile',
                                extra: mascotascalle[index]),
                            child: const Text(
                              "Mas Información",
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ))
                ]),
              ),
            );
          },
        ),
        floatingActionButton: rolActual == "Cliente" || rolActual == "Refugio"
            ? FloatingActionButton(
                onPressed: () {
                  context.push("/uploadStreetPets");
                },
                child: const Icon(Icons.add),
              )
            : null,
        bottomNavigationBar: const BottomNavigationUser());
  }
}
