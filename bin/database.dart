import 'package:mongo_dart/mongo_dart.dart';
import 'package:min_id/min_id.dart';
import 'package:intl/intl.dart';

class Database {
  final user = 'dev70200';
  final pass = 'dev70200';

  void dbconection() async {
    var db = await Db.create(
        'mongodb+srv://$user:$pass@cluster0.dmffq.mongodb.net/morfiDB?retryWrites=true&w=majority');
    await db.open();

    db.isConnected
        ? print('base de datos conectada')
        : print('no hay coneccion con base de datos');

    DbCollection coll = db.collection('usuario');

    //************LISTAR USUARIOS */

    /* var usuario =
        await coll.find().toList(); */
    //print(usuarios);

    //await db.close();

    //print(usuarios);

    //************CREAR USUARIOS */

    /* final date = DateTime.now();
    final dateformated =
        DateFormat('dd.MM.yyyy HH:mm').format(DateTime.parse(date.toString()));

    print(dateformated);

    final id = MinId.getId('{{3{d}}{3{w}}{3{d}}{3{w}}{3{d}}{3{w}}{3{d}}{3{w}}}')
        .toString();
    await coll.save({
      '_id': id,
      'name': 'Esteban Caballero',
      'email': 'esteban.caballero@70200.uy',
      'phone': '+598 94387200',
      'address': 'continucion 18 de julio 521',
      'registered': '2019-05-18T08:38:00 +03:00',
      'latitude': -41.034292,
      'longitude': 123.818295,
      'isClient': true,
      'isDelivery': false
    });

    print('usuario registrado con el id $id'); */

    //************ACTUALIZAR USUARIOS */

    /* await coll.update(
        await coll.findOne(where.eq('_id', '703oOW177rzN523vvn823qxv')), {
      r'$set': {'registered': dateformated},
    });

    print('usuario modificado');
 */
    //************BORRAR USUARIOS */

    /*  await coll.remove(where.eq('_id', '703oOW177rzN523vvn823qxv'));
    print('usuario eliminado');
  */
    //await db.close();
  }
}
