import 'dart:async';

import 'package:socket_io/socket_io.dart';

void main() {
  final server = Server();

  // el servidor escucha si hay clientes conectados
  server.on('connection', (client) {
    print('Connect to $client ');

    // el servidor escuhando al cliente.
    client.on('stream', (data) {
      print('Data from client: $data');

      // el servidor enviando un mensaje de vuelta una vez recibe un mensaje del cliente
      client.emit('msg', 'me enviaste este mensaje: $data');
    });
  });

  server.listen(3005);
}
