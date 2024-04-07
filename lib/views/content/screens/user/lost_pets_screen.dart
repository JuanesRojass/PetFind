import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/controllers/gets/lost_pets_controller.dart';
import 'package:mascotas_bga/controllers/providers/general/rol_provider.dart';
import 'package:mascotas_bga/helpers/shared.dart';

class LostPetsScreen extends ConsumerStatefulWidget {
  const LostPetsScreen({Key? key}) : super(key: key);

  @override
  LostPetsScreenState createState() => LostPetsScreenState();
}

class LostPetsScreenState extends ConsumerState<LostPetsScreen> {
  final LostPetsController _controller = LostPetsController();

  List mascotaslost = [];

  @override
  void initState() {
    getMascotasLost();
    super.initState();
  }

  Future<void> getMascotasLost() async {
    final mascotasLost = await _controller.getMascotasLost();
    setState(() {
      mascotaslost = mascotasLost;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rolActual = ref.watch(rolProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Mi Mascota Perdida'),
        ),
        body: ListView.builder(
          itemCount: mascotaslost.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: GestureDetector(
                      onTap: () {
                        context.push('/petsLostProfile',
                            extra: mascotaslost[index]);
                      },
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(1.0, 1.0, 30, 1.0),
                            child: Icon(
                              Icons.question_mark_outlined,
                              size: 60,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(mascotaslost[index]["nombre_mascota_lost"]),
                              Text(mascotaslost[index]["raza_mascota_lost"]),
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
                            onPressed: () => context.push('/petsLostProfile',
                                extra: mascotaslost[index]),
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
        floatingActionButton: rolActual == "Cliente"
            ? FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.add),
              )
            : null,
        bottomNavigationBar: const BottomNavigationUser());
  }
}
