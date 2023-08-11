// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PersonDao? _personDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Person_model` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `product_Name` TEXT NOT NULL, `productPrice` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PersonDao get personDao {
    return _personDaoInstance ??= _$PersonDao(database, changeListener);
  }
}

class _$PersonDao extends PersonDao {
  _$PersonDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _person_modelInsertionAdapter = InsertionAdapter(
            database,
            'Person_model',
            (Person_model item) => <String, Object?>{
                  'id': item.id,
                  'product_Name': item.productName,
                  'productPrice': item.productPrice
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Person_model> _person_modelInsertionAdapter;

  @override
  Future<List<Person_model>> findAllPeople() async {
    return _queryAdapter.queryList('SELECT * FROM Person_model',
        mapper: (Map<String, Object?> row) => Person_model(
            id: row['id'] as int?,
            productName: row['product_Name'] as String,
            productPrice: row['productPrice'] as String));
  }

  @override
  Stream<List<String>> findAllPeopleName() {
    return _queryAdapter.queryListStream('SELECT name FROM Person_model',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        queryableName: 'Person_model',
        isView: false);
  }

  @override
  Stream<Person_model?> findPersonById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Person_model WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Person_model(
            id: row['id'] as int?,
            productName: row['product_Name'] as String,
            productPrice: row['productPrice'] as String),
        arguments: [id],
        queryableName: 'Person_model',
        isView: false);
  }

  @override
  Future<int?> deletePersonById(int id) async {
    return _queryAdapter.query('DELETE FROM Person_model WHERE id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [id]);
  }

  @override
  Future<int?> delAllPerson() async {
    return _queryAdapter.query('DELETE FROM Person_model',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertPerson(Person_model person) async {
    await _person_modelInsertionAdapter.insert(
        person, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertAllPerson(List<Person_model> listPerson) async {
    await _person_modelInsertionAdapter.insertList(
        listPerson, OnConflictStrategy.abort);
  }
}
