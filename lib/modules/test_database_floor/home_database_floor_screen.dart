import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'add_screen.dart';
import 'dao/person_dao.dart';
import 'database/database.dart';
import 'entity/person.dart';
import 'package:logger/logger.dart';

class HomeDatabaseFloorScreen extends StatefulWidget {
  const HomeDatabaseFloorScreen({super.key});

  @override
  State<HomeDatabaseFloorScreen> createState() =>
      _HomeDatabaseFloorScreenState();
}

class _HomeDatabaseFloorScreenState extends State<HomeDatabaseFloorScreen> {
  var logger = Logger();
  late Color clTxt = Colors.black;
  late int index = 0;

  late List<Person_model> listPer = [];

  Future<PersonDao> createDb() async {
    AppDatabase database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    PersonDao personDao = database.personDao;
    return personDao;
  }

  loadData() async {
    AppDatabase database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    PersonDao personDao = database.personDao;
    listPer = await personDao.findAllPeople();
    database.close;
    setState(() {});
  }

  Future<int?> delData(int? id) async {
    AppDatabase database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    PersonDao personDao = database.personDao;
    int? idResult = await personDao.deletePersonById(id!);
    database.close;
    return idResult;
  }

  Future<int?> delAllData(Person_model model) async {
    AppDatabase database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    PersonDao personDao = database.personDao;
    int? idResult = await personDao.delAllPerson();
    database.close;
    return idResult;
  }

  @override
  void initState() {
    createDb();
    loadData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Container(),
        actions: [
          GestureDetector(
            onTap: () async {
              PersonDao personDao = await createDb();
              var result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddScreen()));

              if (result.runtimeType == Person_model) {
                if (result != null) await personDao.insertPerson(result);
              } else {
                if (result != null) await personDao.insertAllPerson(result);
              }

              listPer = await personDao.findAllPeople();
              setState(() {});
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.add_circle,
                size: 40,
              ),
            ),
          )
        ],
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Floor',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        // primary: true,
        child: Column(
          children: listPer
              .map((e) => Container(
                    // color: Colors.amber,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            alertSnackBar(
                                context: context,
                                txtAlert:
                                    '${e.id.toString()} : ${listPer.length.toString()}');
                          },
                          child: Card(
                            elevation: 40,
                            shadowColor: Colors.pink,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Slidable(
                                    key: const ValueKey(0),
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      // dismissible:
                                      //     DismissiblePane(onDismissed: () {
                                      //   // print('DismissiblePane');
                                      //   // var resultId = delData(listPer[index].id);
                                      //   // print('ลบแล้ว: ${resultId}');
                                      // }),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) async {
                                            int? idRe = await delData(e.id);
                                            loadData();
                                            print(
                                                '${e.id.toString()}:${idRe.toString()}');

                                            alertSnackBar(
                                                context: context,
                                                txtAlert:
                                                    '${e.id.toString()}:${idRe.toString()}');
                                          },
                                          backgroundColor:
                                              const Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                        SlidableAction(
                                          onPressed: (context) async {
                                            int? idRe = await delAllData(
                                                Person_model(
                                                    productName: '',
                                                    productPrice: ''));
                                            loadData();
                                            print(idRe.toString());
                                            alertSnackBar(
                                                context: context,
                                                txtAlert: '${idRe.toString()}');
                                          },
                                          backgroundColor:
                                              Color.fromARGB(255, 141, 0, 0),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete_sweep_outlined,
                                          label: 'DeleteAll',
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${e.productName} : ',
                                          style: const TextStyle(
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 10.0,
                                                  color: Color.fromARGB(
                                                      255, 247, 0, 189),
                                                  offset: Offset(5.0, 5.0),
                                                ),
                                                Shadow(
                                                  color: Color.fromARGB(
                                                      255, 224, 8, 123),
                                                  blurRadius: 10.0,
                                                  offset: Offset(-10.0, 5.0),
                                                ),
                                                Shadow(
                                                  color: Color.fromARGB(
                                                      255, 255, 234, 0),
                                                  blurRadius: 10.0,
                                                  offset: Offset(-10.0, 5.0),
                                                ),
                                              ],
                                              fontSize: 40,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Text(
                                          '${e.productPrice}',
                                          style: const TextStyle(
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 10.0,
                                                  color: Color.fromARGB(
                                                      255, 241, 0, 0),
                                                  offset: Offset(0.0, 0.0),
                                                ),
                                                Shadow(
                                                  color: Color.fromARGB(
                                                      255, 251, 38, 0),
                                                  blurRadius: 10.0,
                                                  offset: Offset(-10.0, 5.0),
                                                ),
                                                Shadow(
                                                  color: Color.fromARGB(
                                                      255, 251, 230, 0),
                                                  blurRadius: 10.0,
                                                  offset: Offset(-10.0, 5.0),
                                                ),
                                              ],
                                              fontSize: 40,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      )),
    );
  }
}

ScaffoldMessengerState alertSnackBar(
    {required BuildContext context, required String txtAlert}) {
  return ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(txtAlert)));
}
