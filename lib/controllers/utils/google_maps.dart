import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';
import 'package:google_places_flutter/google_places_flutter.dart';


class GoogleMapsScreen extends ConsumerStatefulWidget {
  const GoogleMapsScreen({super.key});

  @override
  GoogleMapsScreenState createState() => GoogleMapsScreenState();
}

class GoogleMapsScreenState extends ConsumerState<GoogleMapsScreen> {
  TextEditingController controller = TextEditingController();
  late GoogleMapController mapController;
  late CameraPosition initialCameraPosition;
  LatLng? selectedLocation;


  @override
void initState() {
  super.initState();
  // Inicializar la cámara con las coordenadas predeterminadas
  initialCameraPosition = CameraPosition(
    target: LatLng(7.12539, -73.1198),
    zoom: 15,
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Seleccionar Ubicación'),
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GooglePlaceAutoCompleteTextField(
          textEditingController: controller,
          googleAPIKey: "AIzaSyCup1HEMdW1jZ_UFuPX-NtgYF03BCIpM3c",
          inputDecoration: InputDecoration(
            
           hintText: " Buscar Dirección", hintStyle: TextStyle(fontSize: 20),
            contentPadding: EdgeInsets.symmetric(vertical: 2.0), // Ajusta el padding vertical
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey), // Color del borde
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey), // Color del borde
            ),
            suffixIcon: Icon(Icons.search),
          ),
          debounceTime: 400,
              isLatLngRequired: true,
              getPlaceDetailWithLatLng: (Prediction prediction) {
                setState(() {
                    selectedLocation = LatLng(
                        double.tryParse(prediction.lat ?? "6.991539") ?? 0.0,
                        double.tryParse(prediction.lng ?? "-73.05399799999999") ?? 0.0,
                      );

                      // Nos Aseguramos de que el mapa se centre en la nueva ubicación
                      mapController.moveCamera(CameraUpdate.newLatLng(selectedLocation!));
                    });

                    // Esperar un momento antes de animar la cámara para asegurar que el mapa se haya centrado
                    Future.delayed(Duration(milliseconds: 500), () {
                      // Animar la cámara para que se centre en la nueva ubicación
                      mapController.animateCamera(CameraUpdate.newLatLng(selectedLocation!));
                    });
                print("placeDetails" + prediction.lat.toString() + prediction.lng.toString());
                },
              itemClick: (Prediction prediction) {
                print("Prediction: ${prediction.lat}");
                controller.text = prediction.description ?? "";
                controller.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description?.length ?? 0));
                  setState(() {
                    
                  }
                  );
                  },
          itemBuilder: (context, index, Prediction prediction) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 7),
                  Expanded(child: Text("${prediction.description ?? ""}")),
                ],
              ),
            );
          },
          seperatedBuilder: Divider(),
          isCrossBtnShown: true,
          containerHorizontalPadding: 10,
        ),
        Expanded(
          child: GoogleMap(
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            onTap: _onMapTapped,
            markers: Set.of((selectedLocation != null)
                ? [
                    Marker(
                      markerId: const MarkerId('selected'),
                      position: selectedLocation!,
                    )
                  ]
                : []),
            initialCameraPosition: CameraPosition(
              target: selectedLocation ?? initialCameraPosition.target, // Posición inicial del mapa
              zoom: 15, // Nivel de zoom inicial
            ),
          ),
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        if (selectedLocation != null) {
          String locationAsString = "${selectedLocation!.latitude}, ${selectedLocation!.longitude}";
          ref.read(selectUbicacionProvider.notifier).state = locationAsString;
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Ubicación Guardada.'),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Seleccione una ubicación en el mapa.'),
          ));
        }
      },
      child: const Icon(Icons.check),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
  );
}

    void _onMapCreated(GoogleMapController controller) {
    setState(() {
    mapController = controller;
    });
    }

    void _onMapTapped(LatLng location) {
    setState(() {
    selectedLocation = location;
    });
      }
}
