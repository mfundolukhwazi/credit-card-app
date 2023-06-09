// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorFloorDB {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorDBBuilder databaseBuilder(String name) =>
      _$FloorDBBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorDBBuilder inMemoryDatabaseBuilder() => _$FloorDBBuilder(null);
}

class _$FloorDBBuilder {
  _$FloorDBBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$FloorDBBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FloorDBBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FloorDB> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$FloorDB();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FloorDB extends FloorDB {
  _$FloorDB([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CreditCardDao? _creditCardDaoInstance;

  CountryDao? _countryDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `CreditCard` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `number` TEXT NOT NULL, `type` TEXT NOT NULL, `cvv` TEXT NOT NULL, `issuing_country` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Country` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `is_banned` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CreditCardDao get creditCardDao {
    return _creditCardDaoInstance ??= _$CreditCardDao(database, changeListener);
  }

  @override
  CountryDao get countryDao {
    return _countryDaoInstance ??= _$CountryDao(database, changeListener);
  }
}

class _$CreditCardDao extends CreditCardDao {
  _$CreditCardDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _creditCardInsertionAdapter = InsertionAdapter(
            database,
            'CreditCard',
            (CreditCard item) => <String, Object?>{
                  'id': item.id,
                  'number': item.number,
                  'type': item.type,
                  'cvv': item.cvv,
                  'issuing_country': item.issuingCountry
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CreditCard> _creditCardInsertionAdapter;

  @override
  Stream<List<CreditCard>> findAllCreditCards() {
    return _queryAdapter.queryListStream('SELECT * FROM CreditCard',
        mapper: (Map<String, Object?> row) => CreditCard(
            id: row['id'] as int?,
            number: row['number'] as String,
            type: row['type'] as String,
            cvv: row['cvv'] as String,
            issuingCountry: row['issuing_country'] as String),
        queryableName: 'CreditCard',
        isView: false);
  }

  @override
  Future<void> insertCreditCard(CreditCard creditCard) async {
    await _creditCardInsertionAdapter.insert(
        creditCard, OnConflictStrategy.abort);
  }
}

class _$CountryDao extends CountryDao {
  _$CountryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _countryInsertionAdapter = InsertionAdapter(
            database,
            'Country',
            (Country item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'is_banned': item.isBanned ? 1 : 0
                },
            changeListener),
        _countryUpdateAdapter = UpdateAdapter(
            database,
            'Country',
            ['id'],
            (Country item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'is_banned': item.isBanned ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Country> _countryInsertionAdapter;

  final UpdateAdapter<Country> _countryUpdateAdapter;

  @override
  Stream<List<Country>> findAllCountries() {
    return _queryAdapter.queryListStream('SELECT * FROM Country',
        mapper: (Map<String, Object?> row) => Country(
            id: row['id'] as int?,
            name: row['name'] as String,
            isBanned: (row['is_banned'] as int) != 0),
        queryableName: 'Country',
        isView: false);
  }

  @override
  Stream<List<Country>> findAllBannedCountries() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Country where is_banned = true',
        mapper: (Map<String, Object?> row) => Country(
            id: row['id'] as int?,
            name: row['name'] as String,
            isBanned: (row['is_banned'] as int) != 0),
        queryableName: 'Country',
        isView: false);
  }

  @override
  Future<void> insertCountry(Country country) async {
    await _countryInsertionAdapter.insert(country, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertCountries(List<Country> countries) async {
    await _countryInsertionAdapter.insertList(
        countries, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCountry(Country country) async {
    await _countryUpdateAdapter.update(country, OnConflictStrategy.abort);
  }
}
