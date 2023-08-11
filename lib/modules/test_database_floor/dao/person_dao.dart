import 'package:floor/floor.dart';
import '../entity/person.dart';

@dao
abstract class PersonDao {
  @Query('SELECT * FROM Person_model')
  Future<List<Person_model>> findAllPeople();

  @Query('SELECT name FROM Person_model')
  Stream<List<String>> findAllPeopleName();

  @Query('SELECT * FROM Person_model WHERE id = :id')
  Stream<Person_model?> findPersonById(int id);

  @Query('DELETE FROM Person_model WHERE id = :id')
  Future<int?> deletePersonById(int id);

  @insert
  Future<void> insertPerson(Person_model person);

  @insert
  Future<void> insertAllPerson(List<Person_model> listPerson);

  @Query('DELETE FROM Person_model')
  Future<int?> delAllPerson();
}
