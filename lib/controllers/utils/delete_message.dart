import 'package:flutter/material.dart';

Future<void> mostrarDialogoConfirmacion({
  required BuildContext context,
  required String idMascota,
  required Future<bool> Function(int id) onDelete,
  required Function(String idMascota) onSuccessfulDelete,
}) async {
  bool confirmado = await showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Confirmar'),
        content: const Text('¿Estás seguro de que deseas borrar esta mascota?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
        ],
      );
    },
  );

  if (confirmado) {
    bool success = await onDelete(int.parse(idMascota));
    if (success) {
      onSuccessfulDelete(idMascota);
    }
  }
}