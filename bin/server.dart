import 'dart:io';
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:min_id/min_id.dart';
import 'package:intl/intl.dart';

void main() async {
  final user = 'dev70200';
  final pass = 'dev70200';
  var port = 8085;

  var db = await Db.create(
      'mongodb+srv://$user:$pass@cluster0.dmffq.mongodb.net/morfiDB?retryWrites=true&w=majority');
  await db.open();

  db.isConnected
      ? print('base de datos conectada')
      : print('no hay coneccion con base de datos');

  DbCollection coll = db.collection('usuario');

  var server = await HttpServer.bind('localhost', port);

  server.listen((HttpRequest request) async {
    print('escuchando el servidor');
    ContentType contentType = request.headers.contentType;
    switch (request.uri.path) {
      case '/':
        request.response.write('estoy en la raiz');
        break;
      case '/users':

        //TODO: handle GET request
        if (request.method == 'GET') {
          request.response.write(await coll.find().toList());
        }
        //TODO: handle POST request
        else if (request.method == 'POST') {
          final content =
              await request.cast<List<int>>().transform(Utf8Decoder()).join();
          final data = json.decode(content);
          await coll.save(data);
        }

        //TODO: handle PUT request
        else if (request.method == 'PUT') {
          var id = await request.uri.queryParameters['id'];
          final content =
              await request.cast<List<int>>().transform(Utf8Decoder()).join();
          final data = json.decode(content);
          var itemToReplace = await coll.findOne(where.eq('_id', id));

          if (itemToReplace == null) {
            await coll.save(data);
          } else {
            await coll.update(itemToReplace, data);
          }
        }
        //TODO: handle DELETE request
        else if (request.method == 'DELETE') {
          var id = await request.uri.queryParameters['id'];
          await coll.remove(where.eq('_id', id));
        }
        //TODO: handle PATCH request
        else if (request.method == 'PATCH') {
          var id = await request.uri.queryParameters['id'];
          final content =
              await request.cast<List<int>>().transform(Utf8Decoder()).join();
          final data = json.decode(content);
          var itemToPatch = await coll.findOne(where.eq('_id', id));
          await coll.update(itemToPatch, {r'$set': data});
        }
        ;
        break;
      default:
        request.response
          ..statusCode = HttpStatus.notFound
          ..write('Not Found');
    }

    await request.response.close();
  });
}
