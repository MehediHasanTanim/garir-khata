// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SettingsTable extends Settings
    with TableInfo<$SettingsTable, SettingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SettingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class SettingRow extends DataClass implements Insertable<SettingRow> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const SettingRow({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory SettingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SettingRow copyWith({String? key, String? value, DateTime? updatedAt}) =>
      SettingRow(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  SettingRow copyWithCompanion(SettingsCompanion data) {
    return SettingRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingRow(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingRow &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class SettingsCompanion extends UpdateCompanion<SettingRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    required String value,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       updatedAt = Value(updatedAt);
  static Insertable<SettingRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VehiclesTable extends Vehicles
    with TableInfo<$VehiclesTable, VehicleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nicknameMeta = const VerificationMeta(
    'nickname',
  );
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
    'nickname',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleTypeMeta = const VerificationMeta(
    'vehicleType',
  );
  @override
  late final GeneratedColumn<String> vehicleType = GeneratedColumn<String>(
    'vehicle_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _variantMeta = const VerificationMeta(
    'variant',
  );
  @override
  late final GeneratedColumn<String> variant = GeneratedColumn<String>(
    'variant',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelYearMeta = const VerificationMeta(
    'modelYear',
  );
  @override
  late final GeneratedColumn<int> modelYear = GeneratedColumn<int>(
    'model_year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _registrationNumberMeta =
      const VerificationMeta('registrationNumber');
  @override
  late final GeneratedColumn<String> registrationNumber =
      GeneratedColumn<String>(
        'registration_number',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _fuelTypeMeta = const VerificationMeta(
    'fuelType',
  );
  @override
  late final GeneratedColumn<String> fuelType = GeneratedColumn<String>(
    'fuel_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentOdometerMeta = const VerificationMeta(
    'currentOdometer',
  );
  @override
  late final GeneratedColumn<int> currentOdometer = GeneratedColumn<int>(
    'current_odometer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
    'purchase_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchasePricePaisaMeta =
      const VerificationMeta('purchasePricePaisa');
  @override
  late final GeneratedColumn<int> purchasePricePaisa = GeneratedColumn<int>(
    'purchase_price_paisa',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _engineCapacityMeta = const VerificationMeta(
    'engineCapacity',
  );
  @override
  late final GeneratedColumn<String> engineCapacity = GeneratedColumn<String>(
    'engine_capacity',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _engineNumberMeta = const VerificationMeta(
    'engineNumber',
  );
  @override
  late final GeneratedColumn<String> engineNumber = GeneratedColumn<String>(
    'engine_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chassisNumberMeta = const VerificationMeta(
    'chassisNumber',
  );
  @override
  late final GeneratedColumn<String> chassisNumber = GeneratedColumn<String>(
    'chassis_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ownershipTypeMeta = const VerificationMeta(
    'ownershipType',
  );
  @override
  late final GeneratedColumn<String> ownershipType = GeneratedColumn<String>(
    'ownership_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nickname,
    vehicleType,
    brand,
    model,
    variant,
    modelYear,
    registrationNumber,
    fuelType,
    currentOdometer,
    purchaseDate,
    purchasePricePaisa,
    engineCapacity,
    engineNumber,
    chassisNumber,
    color,
    photoPath,
    ownershipType,
    isArchived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicles';
  @override
  VerificationContext validateIntegrity(
    Insertable<VehicleRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nickname')) {
      context.handle(
        _nicknameMeta,
        nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta),
      );
    } else if (isInserting) {
      context.missing(_nicknameMeta);
    }
    if (data.containsKey('vehicle_type')) {
      context.handle(
        _vehicleTypeMeta,
        vehicleType.isAcceptableOrUnknown(
          data['vehicle_type']!,
          _vehicleTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_vehicleTypeMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    }
    if (data.containsKey('variant')) {
      context.handle(
        _variantMeta,
        variant.isAcceptableOrUnknown(data['variant']!, _variantMeta),
      );
    }
    if (data.containsKey('model_year')) {
      context.handle(
        _modelYearMeta,
        modelYear.isAcceptableOrUnknown(data['model_year']!, _modelYearMeta),
      );
    }
    if (data.containsKey('registration_number')) {
      context.handle(
        _registrationNumberMeta,
        registrationNumber.isAcceptableOrUnknown(
          data['registration_number']!,
          _registrationNumberMeta,
        ),
      );
    }
    if (data.containsKey('fuel_type')) {
      context.handle(
        _fuelTypeMeta,
        fuelType.isAcceptableOrUnknown(data['fuel_type']!, _fuelTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_fuelTypeMeta);
    }
    if (data.containsKey('current_odometer')) {
      context.handle(
        _currentOdometerMeta,
        currentOdometer.isAcceptableOrUnknown(
          data['current_odometer']!,
          _currentOdometerMeta,
        ),
      );
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    }
    if (data.containsKey('purchase_price_paisa')) {
      context.handle(
        _purchasePricePaisaMeta,
        purchasePricePaisa.isAcceptableOrUnknown(
          data['purchase_price_paisa']!,
          _purchasePricePaisaMeta,
        ),
      );
    }
    if (data.containsKey('engine_capacity')) {
      context.handle(
        _engineCapacityMeta,
        engineCapacity.isAcceptableOrUnknown(
          data['engine_capacity']!,
          _engineCapacityMeta,
        ),
      );
    }
    if (data.containsKey('engine_number')) {
      context.handle(
        _engineNumberMeta,
        engineNumber.isAcceptableOrUnknown(
          data['engine_number']!,
          _engineNumberMeta,
        ),
      );
    }
    if (data.containsKey('chassis_number')) {
      context.handle(
        _chassisNumberMeta,
        chassisNumber.isAcceptableOrUnknown(
          data['chassis_number']!,
          _chassisNumberMeta,
        ),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('ownership_type')) {
      context.handle(
        _ownershipTypeMeta,
        ownershipType.isAcceptableOrUnknown(
          data['ownership_type']!,
          _ownershipTypeMeta,
        ),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VehicleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VehicleRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nickname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nickname'],
      )!,
      vehicleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_type'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      ),
      variant: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant'],
      ),
      modelYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}model_year'],
      ),
      registrationNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}registration_number'],
      ),
      fuelType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fuel_type'],
      )!,
      currentOdometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_odometer'],
      )!,
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchase_date'],
      ),
      purchasePricePaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}purchase_price_paisa'],
      ),
      engineCapacity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}engine_capacity'],
      ),
      engineNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}engine_number'],
      ),
      chassisNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chassis_number'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      ownershipType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ownership_type'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $VehiclesTable createAlias(String alias) {
    return $VehiclesTable(attachedDatabase, alias);
  }
}

class VehicleRow extends DataClass implements Insertable<VehicleRow> {
  final String id;
  final String nickname;
  final String vehicleType;
  final String? brand;
  final String? model;
  final String? variant;
  final int? modelYear;
  final String? registrationNumber;
  final String fuelType;
  final int currentOdometer;
  final DateTime? purchaseDate;
  final int? purchasePricePaisa;
  final String? engineCapacity;
  final String? engineNumber;
  final String? chassisNumber;
  final String? color;
  final String? photoPath;
  final String? ownershipType;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const VehicleRow({
    required this.id,
    required this.nickname,
    required this.vehicleType,
    this.brand,
    this.model,
    this.variant,
    this.modelYear,
    this.registrationNumber,
    required this.fuelType,
    required this.currentOdometer,
    this.purchaseDate,
    this.purchasePricePaisa,
    this.engineCapacity,
    this.engineNumber,
    this.chassisNumber,
    this.color,
    this.photoPath,
    this.ownershipType,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nickname'] = Variable<String>(nickname);
    map['vehicle_type'] = Variable<String>(vehicleType);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    if (!nullToAbsent || variant != null) {
      map['variant'] = Variable<String>(variant);
    }
    if (!nullToAbsent || modelYear != null) {
      map['model_year'] = Variable<int>(modelYear);
    }
    if (!nullToAbsent || registrationNumber != null) {
      map['registration_number'] = Variable<String>(registrationNumber);
    }
    map['fuel_type'] = Variable<String>(fuelType);
    map['current_odometer'] = Variable<int>(currentOdometer);
    if (!nullToAbsent || purchaseDate != null) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate);
    }
    if (!nullToAbsent || purchasePricePaisa != null) {
      map['purchase_price_paisa'] = Variable<int>(purchasePricePaisa);
    }
    if (!nullToAbsent || engineCapacity != null) {
      map['engine_capacity'] = Variable<String>(engineCapacity);
    }
    if (!nullToAbsent || engineNumber != null) {
      map['engine_number'] = Variable<String>(engineNumber);
    }
    if (!nullToAbsent || chassisNumber != null) {
      map['chassis_number'] = Variable<String>(chassisNumber);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    if (!nullToAbsent || ownershipType != null) {
      map['ownership_type'] = Variable<String>(ownershipType);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  VehiclesCompanion toCompanion(bool nullToAbsent) {
    return VehiclesCompanion(
      id: Value(id),
      nickname: Value(nickname),
      vehicleType: Value(vehicleType),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      model: model == null && nullToAbsent
          ? const Value.absent()
          : Value(model),
      variant: variant == null && nullToAbsent
          ? const Value.absent()
          : Value(variant),
      modelYear: modelYear == null && nullToAbsent
          ? const Value.absent()
          : Value(modelYear),
      registrationNumber: registrationNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(registrationNumber),
      fuelType: Value(fuelType),
      currentOdometer: Value(currentOdometer),
      purchaseDate: purchaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseDate),
      purchasePricePaisa: purchasePricePaisa == null && nullToAbsent
          ? const Value.absent()
          : Value(purchasePricePaisa),
      engineCapacity: engineCapacity == null && nullToAbsent
          ? const Value.absent()
          : Value(engineCapacity),
      engineNumber: engineNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(engineNumber),
      chassisNumber: chassisNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(chassisNumber),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      ownershipType: ownershipType == null && nullToAbsent
          ? const Value.absent()
          : Value(ownershipType),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory VehicleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehicleRow(
      id: serializer.fromJson<String>(json['id']),
      nickname: serializer.fromJson<String>(json['nickname']),
      vehicleType: serializer.fromJson<String>(json['vehicleType']),
      brand: serializer.fromJson<String?>(json['brand']),
      model: serializer.fromJson<String?>(json['model']),
      variant: serializer.fromJson<String?>(json['variant']),
      modelYear: serializer.fromJson<int?>(json['modelYear']),
      registrationNumber: serializer.fromJson<String?>(
        json['registrationNumber'],
      ),
      fuelType: serializer.fromJson<String>(json['fuelType']),
      currentOdometer: serializer.fromJson<int>(json['currentOdometer']),
      purchaseDate: serializer.fromJson<DateTime?>(json['purchaseDate']),
      purchasePricePaisa: serializer.fromJson<int?>(json['purchasePricePaisa']),
      engineCapacity: serializer.fromJson<String?>(json['engineCapacity']),
      engineNumber: serializer.fromJson<String?>(json['engineNumber']),
      chassisNumber: serializer.fromJson<String?>(json['chassisNumber']),
      color: serializer.fromJson<String?>(json['color']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      ownershipType: serializer.fromJson<String?>(json['ownershipType']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nickname': serializer.toJson<String>(nickname),
      'vehicleType': serializer.toJson<String>(vehicleType),
      'brand': serializer.toJson<String?>(brand),
      'model': serializer.toJson<String?>(model),
      'variant': serializer.toJson<String?>(variant),
      'modelYear': serializer.toJson<int?>(modelYear),
      'registrationNumber': serializer.toJson<String?>(registrationNumber),
      'fuelType': serializer.toJson<String>(fuelType),
      'currentOdometer': serializer.toJson<int>(currentOdometer),
      'purchaseDate': serializer.toJson<DateTime?>(purchaseDate),
      'purchasePricePaisa': serializer.toJson<int?>(purchasePricePaisa),
      'engineCapacity': serializer.toJson<String?>(engineCapacity),
      'engineNumber': serializer.toJson<String?>(engineNumber),
      'chassisNumber': serializer.toJson<String?>(chassisNumber),
      'color': serializer.toJson<String?>(color),
      'photoPath': serializer.toJson<String?>(photoPath),
      'ownershipType': serializer.toJson<String?>(ownershipType),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  VehicleRow copyWith({
    String? id,
    String? nickname,
    String? vehicleType,
    Value<String?> brand = const Value.absent(),
    Value<String?> model = const Value.absent(),
    Value<String?> variant = const Value.absent(),
    Value<int?> modelYear = const Value.absent(),
    Value<String?> registrationNumber = const Value.absent(),
    String? fuelType,
    int? currentOdometer,
    Value<DateTime?> purchaseDate = const Value.absent(),
    Value<int?> purchasePricePaisa = const Value.absent(),
    Value<String?> engineCapacity = const Value.absent(),
    Value<String?> engineNumber = const Value.absent(),
    Value<String?> chassisNumber = const Value.absent(),
    Value<String?> color = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
    Value<String?> ownershipType = const Value.absent(),
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => VehicleRow(
    id: id ?? this.id,
    nickname: nickname ?? this.nickname,
    vehicleType: vehicleType ?? this.vehicleType,
    brand: brand.present ? brand.value : this.brand,
    model: model.present ? model.value : this.model,
    variant: variant.present ? variant.value : this.variant,
    modelYear: modelYear.present ? modelYear.value : this.modelYear,
    registrationNumber: registrationNumber.present
        ? registrationNumber.value
        : this.registrationNumber,
    fuelType: fuelType ?? this.fuelType,
    currentOdometer: currentOdometer ?? this.currentOdometer,
    purchaseDate: purchaseDate.present ? purchaseDate.value : this.purchaseDate,
    purchasePricePaisa: purchasePricePaisa.present
        ? purchasePricePaisa.value
        : this.purchasePricePaisa,
    engineCapacity: engineCapacity.present
        ? engineCapacity.value
        : this.engineCapacity,
    engineNumber: engineNumber.present ? engineNumber.value : this.engineNumber,
    chassisNumber: chassisNumber.present
        ? chassisNumber.value
        : this.chassisNumber,
    color: color.present ? color.value : this.color,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    ownershipType: ownershipType.present
        ? ownershipType.value
        : this.ownershipType,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  VehicleRow copyWithCompanion(VehiclesCompanion data) {
    return VehicleRow(
      id: data.id.present ? data.id.value : this.id,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      vehicleType: data.vehicleType.present
          ? data.vehicleType.value
          : this.vehicleType,
      brand: data.brand.present ? data.brand.value : this.brand,
      model: data.model.present ? data.model.value : this.model,
      variant: data.variant.present ? data.variant.value : this.variant,
      modelYear: data.modelYear.present ? data.modelYear.value : this.modelYear,
      registrationNumber: data.registrationNumber.present
          ? data.registrationNumber.value
          : this.registrationNumber,
      fuelType: data.fuelType.present ? data.fuelType.value : this.fuelType,
      currentOdometer: data.currentOdometer.present
          ? data.currentOdometer.value
          : this.currentOdometer,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      purchasePricePaisa: data.purchasePricePaisa.present
          ? data.purchasePricePaisa.value
          : this.purchasePricePaisa,
      engineCapacity: data.engineCapacity.present
          ? data.engineCapacity.value
          : this.engineCapacity,
      engineNumber: data.engineNumber.present
          ? data.engineNumber.value
          : this.engineNumber,
      chassisNumber: data.chassisNumber.present
          ? data.chassisNumber.value
          : this.chassisNumber,
      color: data.color.present ? data.color.value : this.color,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      ownershipType: data.ownershipType.present
          ? data.ownershipType.value
          : this.ownershipType,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VehicleRow(')
          ..write('id: $id, ')
          ..write('nickname: $nickname, ')
          ..write('vehicleType: $vehicleType, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('variant: $variant, ')
          ..write('modelYear: $modelYear, ')
          ..write('registrationNumber: $registrationNumber, ')
          ..write('fuelType: $fuelType, ')
          ..write('currentOdometer: $currentOdometer, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('purchasePricePaisa: $purchasePricePaisa, ')
          ..write('engineCapacity: $engineCapacity, ')
          ..write('engineNumber: $engineNumber, ')
          ..write('chassisNumber: $chassisNumber, ')
          ..write('color: $color, ')
          ..write('photoPath: $photoPath, ')
          ..write('ownershipType: $ownershipType, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    nickname,
    vehicleType,
    brand,
    model,
    variant,
    modelYear,
    registrationNumber,
    fuelType,
    currentOdometer,
    purchaseDate,
    purchasePricePaisa,
    engineCapacity,
    engineNumber,
    chassisNumber,
    color,
    photoPath,
    ownershipType,
    isArchived,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehicleRow &&
          other.id == this.id &&
          other.nickname == this.nickname &&
          other.vehicleType == this.vehicleType &&
          other.brand == this.brand &&
          other.model == this.model &&
          other.variant == this.variant &&
          other.modelYear == this.modelYear &&
          other.registrationNumber == this.registrationNumber &&
          other.fuelType == this.fuelType &&
          other.currentOdometer == this.currentOdometer &&
          other.purchaseDate == this.purchaseDate &&
          other.purchasePricePaisa == this.purchasePricePaisa &&
          other.engineCapacity == this.engineCapacity &&
          other.engineNumber == this.engineNumber &&
          other.chassisNumber == this.chassisNumber &&
          other.color == this.color &&
          other.photoPath == this.photoPath &&
          other.ownershipType == this.ownershipType &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class VehiclesCompanion extends UpdateCompanion<VehicleRow> {
  final Value<String> id;
  final Value<String> nickname;
  final Value<String> vehicleType;
  final Value<String?> brand;
  final Value<String?> model;
  final Value<String?> variant;
  final Value<int?> modelYear;
  final Value<String?> registrationNumber;
  final Value<String> fuelType;
  final Value<int> currentOdometer;
  final Value<DateTime?> purchaseDate;
  final Value<int?> purchasePricePaisa;
  final Value<String?> engineCapacity;
  final Value<String?> engineNumber;
  final Value<String?> chassisNumber;
  final Value<String?> color;
  final Value<String?> photoPath;
  final Value<String?> ownershipType;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const VehiclesCompanion({
    this.id = const Value.absent(),
    this.nickname = const Value.absent(),
    this.vehicleType = const Value.absent(),
    this.brand = const Value.absent(),
    this.model = const Value.absent(),
    this.variant = const Value.absent(),
    this.modelYear = const Value.absent(),
    this.registrationNumber = const Value.absent(),
    this.fuelType = const Value.absent(),
    this.currentOdometer = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.purchasePricePaisa = const Value.absent(),
    this.engineCapacity = const Value.absent(),
    this.engineNumber = const Value.absent(),
    this.chassisNumber = const Value.absent(),
    this.color = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.ownershipType = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehiclesCompanion.insert({
    required String id,
    required String nickname,
    required String vehicleType,
    this.brand = const Value.absent(),
    this.model = const Value.absent(),
    this.variant = const Value.absent(),
    this.modelYear = const Value.absent(),
    this.registrationNumber = const Value.absent(),
    required String fuelType,
    this.currentOdometer = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.purchasePricePaisa = const Value.absent(),
    this.engineCapacity = const Value.absent(),
    this.engineNumber = const Value.absent(),
    this.chassisNumber = const Value.absent(),
    this.color = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.ownershipType = const Value.absent(),
    this.isArchived = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nickname = Value(nickname),
       vehicleType = Value(vehicleType),
       fuelType = Value(fuelType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<VehicleRow> custom({
    Expression<String>? id,
    Expression<String>? nickname,
    Expression<String>? vehicleType,
    Expression<String>? brand,
    Expression<String>? model,
    Expression<String>? variant,
    Expression<int>? modelYear,
    Expression<String>? registrationNumber,
    Expression<String>? fuelType,
    Expression<int>? currentOdometer,
    Expression<DateTime>? purchaseDate,
    Expression<int>? purchasePricePaisa,
    Expression<String>? engineCapacity,
    Expression<String>? engineNumber,
    Expression<String>? chassisNumber,
    Expression<String>? color,
    Expression<String>? photoPath,
    Expression<String>? ownershipType,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nickname != null) 'nickname': nickname,
      if (vehicleType != null) 'vehicle_type': vehicleType,
      if (brand != null) 'brand': brand,
      if (model != null) 'model': model,
      if (variant != null) 'variant': variant,
      if (modelYear != null) 'model_year': modelYear,
      if (registrationNumber != null) 'registration_number': registrationNumber,
      if (fuelType != null) 'fuel_type': fuelType,
      if (currentOdometer != null) 'current_odometer': currentOdometer,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (purchasePricePaisa != null)
        'purchase_price_paisa': purchasePricePaisa,
      if (engineCapacity != null) 'engine_capacity': engineCapacity,
      if (engineNumber != null) 'engine_number': engineNumber,
      if (chassisNumber != null) 'chassis_number': chassisNumber,
      if (color != null) 'color': color,
      if (photoPath != null) 'photo_path': photoPath,
      if (ownershipType != null) 'ownership_type': ownershipType,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehiclesCompanion copyWith({
    Value<String>? id,
    Value<String>? nickname,
    Value<String>? vehicleType,
    Value<String?>? brand,
    Value<String?>? model,
    Value<String?>? variant,
    Value<int?>? modelYear,
    Value<String?>? registrationNumber,
    Value<String>? fuelType,
    Value<int>? currentOdometer,
    Value<DateTime?>? purchaseDate,
    Value<int?>? purchasePricePaisa,
    Value<String?>? engineCapacity,
    Value<String?>? engineNumber,
    Value<String?>? chassisNumber,
    Value<String?>? color,
    Value<String?>? photoPath,
    Value<String?>? ownershipType,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return VehiclesCompanion(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      vehicleType: vehicleType ?? this.vehicleType,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      variant: variant ?? this.variant,
      modelYear: modelYear ?? this.modelYear,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      fuelType: fuelType ?? this.fuelType,
      currentOdometer: currentOdometer ?? this.currentOdometer,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      purchasePricePaisa: purchasePricePaisa ?? this.purchasePricePaisa,
      engineCapacity: engineCapacity ?? this.engineCapacity,
      engineNumber: engineNumber ?? this.engineNumber,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      color: color ?? this.color,
      photoPath: photoPath ?? this.photoPath,
      ownershipType: ownershipType ?? this.ownershipType,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (vehicleType.present) {
      map['vehicle_type'] = Variable<String>(vehicleType.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (variant.present) {
      map['variant'] = Variable<String>(variant.value);
    }
    if (modelYear.present) {
      map['model_year'] = Variable<int>(modelYear.value);
    }
    if (registrationNumber.present) {
      map['registration_number'] = Variable<String>(registrationNumber.value);
    }
    if (fuelType.present) {
      map['fuel_type'] = Variable<String>(fuelType.value);
    }
    if (currentOdometer.present) {
      map['current_odometer'] = Variable<int>(currentOdometer.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (purchasePricePaisa.present) {
      map['purchase_price_paisa'] = Variable<int>(purchasePricePaisa.value);
    }
    if (engineCapacity.present) {
      map['engine_capacity'] = Variable<String>(engineCapacity.value);
    }
    if (engineNumber.present) {
      map['engine_number'] = Variable<String>(engineNumber.value);
    }
    if (chassisNumber.present) {
      map['chassis_number'] = Variable<String>(chassisNumber.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (ownershipType.present) {
      map['ownership_type'] = Variable<String>(ownershipType.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesCompanion(')
          ..write('id: $id, ')
          ..write('nickname: $nickname, ')
          ..write('vehicleType: $vehicleType, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('variant: $variant, ')
          ..write('modelYear: $modelYear, ')
          ..write('registrationNumber: $registrationNumber, ')
          ..write('fuelType: $fuelType, ')
          ..write('currentOdometer: $currentOdometer, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('purchasePricePaisa: $purchasePricePaisa, ')
          ..write('engineCapacity: $engineCapacity, ')
          ..write('engineNumber: $engineNumber, ')
          ..write('chassisNumber: $chassisNumber, ')
          ..write('color: $color, ')
          ..write('photoPath: $photoPath, ')
          ..write('ownershipType: $ownershipType, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OdometerEntriesTable extends OdometerEntries
    with TableInfo<$OdometerEntriesTable, OdometerEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OdometerEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerMeta = const VerificationMeta(
    'odometer',
  );
  @override
  late final GeneratedColumn<int> odometer = GeneratedColumn<int>(
    'odometer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceRecordIdMeta = const VerificationMeta(
    'sourceRecordId',
  );
  @override
  late final GeneratedColumn<String> sourceRecordId = GeneratedColumn<String>(
    'source_record_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isManualCorrectionMeta =
      const VerificationMeta('isManualCorrection');
  @override
  late final GeneratedColumn<bool> isManualCorrection = GeneratedColumn<bool>(
    'is_manual_correction',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_manual_correction" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDiscontinuityMeta = const VerificationMeta(
    'isDiscontinuity',
  );
  @override
  late final GeneratedColumn<bool> isDiscontinuity = GeneratedColumn<bool>(
    'is_discontinuity',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_discontinuity" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    recordedAt,
    odometer,
    sourceType,
    sourceRecordId,
    note,
    isManualCorrection,
    isDiscontinuity,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'odometer_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<OdometerEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('odometer')) {
      context.handle(
        _odometerMeta,
        odometer.isAcceptableOrUnknown(data['odometer']!, _odometerMeta),
      );
    } else if (isInserting) {
      context.missing(_odometerMeta);
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceTypeMeta);
    }
    if (data.containsKey('source_record_id')) {
      context.handle(
        _sourceRecordIdMeta,
        sourceRecordId.isAcceptableOrUnknown(
          data['source_record_id']!,
          _sourceRecordIdMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('is_manual_correction')) {
      context.handle(
        _isManualCorrectionMeta,
        isManualCorrection.isAcceptableOrUnknown(
          data['is_manual_correction']!,
          _isManualCorrectionMeta,
        ),
      );
    }
    if (data.containsKey('is_discontinuity')) {
      context.handle(
        _isDiscontinuityMeta,
        isDiscontinuity.isAcceptableOrUnknown(
          data['is_discontinuity']!,
          _isDiscontinuityMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OdometerEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OdometerEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
      odometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odometer'],
      )!,
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      )!,
      sourceRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_record_id'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      isManualCorrection: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_manual_correction'],
      )!,
      isDiscontinuity: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_discontinuity'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $OdometerEntriesTable createAlias(String alias) {
    return $OdometerEntriesTable(attachedDatabase, alias);
  }
}

class OdometerEntryRow extends DataClass
    implements Insertable<OdometerEntryRow> {
  final String id;
  final String vehicleId;
  final DateTime recordedAt;
  final int odometer;
  final String sourceType;
  final String? sourceRecordId;
  final String? note;
  final bool isManualCorrection;

  /// Marks odometer reset/replacement discontinuities for reports.
  final bool isDiscontinuity;
  final DateTime createdAt;
  const OdometerEntryRow({
    required this.id,
    required this.vehicleId,
    required this.recordedAt,
    required this.odometer,
    required this.sourceType,
    this.sourceRecordId,
    this.note,
    required this.isManualCorrection,
    required this.isDiscontinuity,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    map['odometer'] = Variable<int>(odometer);
    map['source_type'] = Variable<String>(sourceType);
    if (!nullToAbsent || sourceRecordId != null) {
      map['source_record_id'] = Variable<String>(sourceRecordId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_manual_correction'] = Variable<bool>(isManualCorrection);
    map['is_discontinuity'] = Variable<bool>(isDiscontinuity);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  OdometerEntriesCompanion toCompanion(bool nullToAbsent) {
    return OdometerEntriesCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      recordedAt: Value(recordedAt),
      odometer: Value(odometer),
      sourceType: Value(sourceType),
      sourceRecordId: sourceRecordId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRecordId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isManualCorrection: Value(isManualCorrection),
      isDiscontinuity: Value(isDiscontinuity),
      createdAt: Value(createdAt),
    );
  }

  factory OdometerEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OdometerEntryRow(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      odometer: serializer.fromJson<int>(json['odometer']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      sourceRecordId: serializer.fromJson<String?>(json['sourceRecordId']),
      note: serializer.fromJson<String?>(json['note']),
      isManualCorrection: serializer.fromJson<bool>(json['isManualCorrection']),
      isDiscontinuity: serializer.fromJson<bool>(json['isDiscontinuity']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'odometer': serializer.toJson<int>(odometer),
      'sourceType': serializer.toJson<String>(sourceType),
      'sourceRecordId': serializer.toJson<String?>(sourceRecordId),
      'note': serializer.toJson<String?>(note),
      'isManualCorrection': serializer.toJson<bool>(isManualCorrection),
      'isDiscontinuity': serializer.toJson<bool>(isDiscontinuity),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  OdometerEntryRow copyWith({
    String? id,
    String? vehicleId,
    DateTime? recordedAt,
    int? odometer,
    String? sourceType,
    Value<String?> sourceRecordId = const Value.absent(),
    Value<String?> note = const Value.absent(),
    bool? isManualCorrection,
    bool? isDiscontinuity,
    DateTime? createdAt,
  }) => OdometerEntryRow(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    recordedAt: recordedAt ?? this.recordedAt,
    odometer: odometer ?? this.odometer,
    sourceType: sourceType ?? this.sourceType,
    sourceRecordId: sourceRecordId.present
        ? sourceRecordId.value
        : this.sourceRecordId,
    note: note.present ? note.value : this.note,
    isManualCorrection: isManualCorrection ?? this.isManualCorrection,
    isDiscontinuity: isDiscontinuity ?? this.isDiscontinuity,
    createdAt: createdAt ?? this.createdAt,
  );
  OdometerEntryRow copyWithCompanion(OdometerEntriesCompanion data) {
    return OdometerEntryRow(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
      odometer: data.odometer.present ? data.odometer.value : this.odometer,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      sourceRecordId: data.sourceRecordId.present
          ? data.sourceRecordId.value
          : this.sourceRecordId,
      note: data.note.present ? data.note.value : this.note,
      isManualCorrection: data.isManualCorrection.present
          ? data.isManualCorrection.value
          : this.isManualCorrection,
      isDiscontinuity: data.isDiscontinuity.present
          ? data.isDiscontinuity.value
          : this.isDiscontinuity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OdometerEntryRow(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('odometer: $odometer, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceRecordId: $sourceRecordId, ')
          ..write('note: $note, ')
          ..write('isManualCorrection: $isManualCorrection, ')
          ..write('isDiscontinuity: $isDiscontinuity, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    recordedAt,
    odometer,
    sourceType,
    sourceRecordId,
    note,
    isManualCorrection,
    isDiscontinuity,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OdometerEntryRow &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.recordedAt == this.recordedAt &&
          other.odometer == this.odometer &&
          other.sourceType == this.sourceType &&
          other.sourceRecordId == this.sourceRecordId &&
          other.note == this.note &&
          other.isManualCorrection == this.isManualCorrection &&
          other.isDiscontinuity == this.isDiscontinuity &&
          other.createdAt == this.createdAt);
}

class OdometerEntriesCompanion extends UpdateCompanion<OdometerEntryRow> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<DateTime> recordedAt;
  final Value<int> odometer;
  final Value<String> sourceType;
  final Value<String?> sourceRecordId;
  final Value<String?> note;
  final Value<bool> isManualCorrection;
  final Value<bool> isDiscontinuity;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const OdometerEntriesCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.odometer = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceRecordId = const Value.absent(),
    this.note = const Value.absent(),
    this.isManualCorrection = const Value.absent(),
    this.isDiscontinuity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OdometerEntriesCompanion.insert({
    required String id,
    required String vehicleId,
    required DateTime recordedAt,
    required int odometer,
    required String sourceType,
    this.sourceRecordId = const Value.absent(),
    this.note = const Value.absent(),
    this.isManualCorrection = const Value.absent(),
    this.isDiscontinuity = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       recordedAt = Value(recordedAt),
       odometer = Value(odometer),
       sourceType = Value(sourceType),
       createdAt = Value(createdAt);
  static Insertable<OdometerEntryRow> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<DateTime>? recordedAt,
    Expression<int>? odometer,
    Expression<String>? sourceType,
    Expression<String>? sourceRecordId,
    Expression<String>? note,
    Expression<bool>? isManualCorrection,
    Expression<bool>? isDiscontinuity,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (odometer != null) 'odometer': odometer,
      if (sourceType != null) 'source_type': sourceType,
      if (sourceRecordId != null) 'source_record_id': sourceRecordId,
      if (note != null) 'note': note,
      if (isManualCorrection != null)
        'is_manual_correction': isManualCorrection,
      if (isDiscontinuity != null) 'is_discontinuity': isDiscontinuity,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OdometerEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<DateTime>? recordedAt,
    Value<int>? odometer,
    Value<String>? sourceType,
    Value<String?>? sourceRecordId,
    Value<String?>? note,
    Value<bool>? isManualCorrection,
    Value<bool>? isDiscontinuity,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return OdometerEntriesCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      recordedAt: recordedAt ?? this.recordedAt,
      odometer: odometer ?? this.odometer,
      sourceType: sourceType ?? this.sourceType,
      sourceRecordId: sourceRecordId ?? this.sourceRecordId,
      note: note ?? this.note,
      isManualCorrection: isManualCorrection ?? this.isManualCorrection,
      isDiscontinuity: isDiscontinuity ?? this.isDiscontinuity,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (odometer.present) {
      map['odometer'] = Variable<int>(odometer.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (sourceRecordId.present) {
      map['source_record_id'] = Variable<String>(sourceRecordId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isManualCorrection.present) {
      map['is_manual_correction'] = Variable<bool>(isManualCorrection.value);
    }
    if (isDiscontinuity.present) {
      map['is_discontinuity'] = Variable<bool>(isDiscontinuity.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OdometerEntriesCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('odometer: $odometer, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceRecordId: $sourceRecordId, ')
          ..write('note: $note, ')
          ..write('isManualCorrection: $isManualCorrection, ')
          ..write('isDiscontinuity: $isDiscontinuity, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FuelEntriesTable extends FuelEntries
    with TableInfo<$FuelEntriesTable, FuelEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FuelEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  static const VerificationMeta _entryDateTimeMeta = const VerificationMeta(
    'entryDateTime',
  );
  @override
  late final GeneratedColumn<DateTime> entryDateTime =
      GeneratedColumn<DateTime>(
        'entry_date_time',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _odometerMeta = const VerificationMeta(
    'odometer',
  );
  @override
  late final GeneratedColumn<int> odometer = GeneratedColumn<int>(
    'odometer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fuelTypeMeta = const VerificationMeta(
    'fuelType',
  );
  @override
  late final GeneratedColumn<String> fuelType = GeneratedColumn<String>(
    'fuel_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMlMeta = const VerificationMeta(
    'quantityMl',
  );
  @override
  late final GeneratedColumn<int> quantityMl = GeneratedColumn<int>(
    'quantity_ml',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pricePerUnitPaisaMeta = const VerificationMeta(
    'pricePerUnitPaisa',
  );
  @override
  late final GeneratedColumn<int> pricePerUnitPaisa = GeneratedColumn<int>(
    'price_per_unit_paisa',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalCostPaisaMeta = const VerificationMeta(
    'totalCostPaisa',
  );
  @override
  late final GeneratedColumn<int> totalCostPaisa = GeneratedColumn<int>(
    'total_cost_paisa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFullTankMeta = const VerificationMeta(
    'isFullTank',
  );
  @override
  late final GeneratedColumn<bool> isFullTank = GeneratedColumn<bool>(
    'is_full_tank',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_full_tank" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _vendorIdMeta = const VerificationMeta(
    'vendorId',
  );
  @override
  late final GeneratedColumn<String> vendorId = GeneratedColumn<String>(
    'vendor_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stationNameMeta = const VerificationMeta(
    'stationName',
  );
  @override
  late final GeneratedColumn<String> stationName = GeneratedColumn<String>(
    'station_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationTextMeta = const VerificationMeta(
    'locationText',
  );
  @override
  late final GeneratedColumn<String> locationText = GeneratedColumn<String>(
    'location_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    entryDateTime,
    odometer,
    fuelType,
    quantityMl,
    pricePerUnitPaisa,
    totalCostPaisa,
    isFullTank,
    vendorId,
    stationName,
    locationText,
    paymentMethod,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fuel_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<FuelEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('entry_date_time')) {
      context.handle(
        _entryDateTimeMeta,
        entryDateTime.isAcceptableOrUnknown(
          data['entry_date_time']!,
          _entryDateTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_entryDateTimeMeta);
    }
    if (data.containsKey('odometer')) {
      context.handle(
        _odometerMeta,
        odometer.isAcceptableOrUnknown(data['odometer']!, _odometerMeta),
      );
    } else if (isInserting) {
      context.missing(_odometerMeta);
    }
    if (data.containsKey('fuel_type')) {
      context.handle(
        _fuelTypeMeta,
        fuelType.isAcceptableOrUnknown(data['fuel_type']!, _fuelTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_fuelTypeMeta);
    }
    if (data.containsKey('quantity_ml')) {
      context.handle(
        _quantityMlMeta,
        quantityMl.isAcceptableOrUnknown(data['quantity_ml']!, _quantityMlMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMlMeta);
    }
    if (data.containsKey('price_per_unit_paisa')) {
      context.handle(
        _pricePerUnitPaisaMeta,
        pricePerUnitPaisa.isAcceptableOrUnknown(
          data['price_per_unit_paisa']!,
          _pricePerUnitPaisaMeta,
        ),
      );
    }
    if (data.containsKey('total_cost_paisa')) {
      context.handle(
        _totalCostPaisaMeta,
        totalCostPaisa.isAcceptableOrUnknown(
          data['total_cost_paisa']!,
          _totalCostPaisaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalCostPaisaMeta);
    }
    if (data.containsKey('is_full_tank')) {
      context.handle(
        _isFullTankMeta,
        isFullTank.isAcceptableOrUnknown(
          data['is_full_tank']!,
          _isFullTankMeta,
        ),
      );
    }
    if (data.containsKey('vendor_id')) {
      context.handle(
        _vendorIdMeta,
        vendorId.isAcceptableOrUnknown(data['vendor_id']!, _vendorIdMeta),
      );
    }
    if (data.containsKey('station_name')) {
      context.handle(
        _stationNameMeta,
        stationName.isAcceptableOrUnknown(
          data['station_name']!,
          _stationNameMeta,
        ),
      );
    }
    if (data.containsKey('location_text')) {
      context.handle(
        _locationTextMeta,
        locationText.isAcceptableOrUnknown(
          data['location_text']!,
          _locationTextMeta,
        ),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FuelEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FuelEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      entryDateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}entry_date_time'],
      )!,
      odometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odometer'],
      )!,
      fuelType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fuel_type'],
      )!,
      quantityMl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity_ml'],
      )!,
      pricePerUnitPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_per_unit_paisa'],
      ),
      totalCostPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_cost_paisa'],
      )!,
      isFullTank: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_full_tank'],
      )!,
      vendorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vendor_id'],
      ),
      stationName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}station_name'],
      ),
      locationText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_text'],
      ),
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FuelEntriesTable createAlias(String alias) {
    return $FuelEntriesTable(attachedDatabase, alias);
  }
}

class FuelEntryRow extends DataClass implements Insertable<FuelEntryRow> {
  final String id;
  final String vehicleId;

  /// Named entryDateTime so the getter does not shadow Table.dateTime().
  final DateTime entryDateTime;
  final int odometer;
  final String fuelType;

  /// Quantity stored as milliliters for fixed precision.
  final int quantityMl;

  /// Unit price stored as paisa per liter.
  final int? pricePerUnitPaisa;

  /// Total cost stored as paisa.
  final int totalCostPaisa;
  final bool isFullTank;
  final String? vendorId;
  final String? stationName;
  final String? locationText;
  final String? paymentMethod;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FuelEntryRow({
    required this.id,
    required this.vehicleId,
    required this.entryDateTime,
    required this.odometer,
    required this.fuelType,
    required this.quantityMl,
    this.pricePerUnitPaisa,
    required this.totalCostPaisa,
    required this.isFullTank,
    this.vendorId,
    this.stationName,
    this.locationText,
    this.paymentMethod,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['entry_date_time'] = Variable<DateTime>(entryDateTime);
    map['odometer'] = Variable<int>(odometer);
    map['fuel_type'] = Variable<String>(fuelType);
    map['quantity_ml'] = Variable<int>(quantityMl);
    if (!nullToAbsent || pricePerUnitPaisa != null) {
      map['price_per_unit_paisa'] = Variable<int>(pricePerUnitPaisa);
    }
    map['total_cost_paisa'] = Variable<int>(totalCostPaisa);
    map['is_full_tank'] = Variable<bool>(isFullTank);
    if (!nullToAbsent || vendorId != null) {
      map['vendor_id'] = Variable<String>(vendorId);
    }
    if (!nullToAbsent || stationName != null) {
      map['station_name'] = Variable<String>(stationName);
    }
    if (!nullToAbsent || locationText != null) {
      map['location_text'] = Variable<String>(locationText);
    }
    if (!nullToAbsent || paymentMethod != null) {
      map['payment_method'] = Variable<String>(paymentMethod);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FuelEntriesCompanion toCompanion(bool nullToAbsent) {
    return FuelEntriesCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      entryDateTime: Value(entryDateTime),
      odometer: Value(odometer),
      fuelType: Value(fuelType),
      quantityMl: Value(quantityMl),
      pricePerUnitPaisa: pricePerUnitPaisa == null && nullToAbsent
          ? const Value.absent()
          : Value(pricePerUnitPaisa),
      totalCostPaisa: Value(totalCostPaisa),
      isFullTank: Value(isFullTank),
      vendorId: vendorId == null && nullToAbsent
          ? const Value.absent()
          : Value(vendorId),
      stationName: stationName == null && nullToAbsent
          ? const Value.absent()
          : Value(stationName),
      locationText: locationText == null && nullToAbsent
          ? const Value.absent()
          : Value(locationText),
      paymentMethod: paymentMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMethod),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FuelEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FuelEntryRow(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      entryDateTime: serializer.fromJson<DateTime>(json['entryDateTime']),
      odometer: serializer.fromJson<int>(json['odometer']),
      fuelType: serializer.fromJson<String>(json['fuelType']),
      quantityMl: serializer.fromJson<int>(json['quantityMl']),
      pricePerUnitPaisa: serializer.fromJson<int?>(json['pricePerUnitPaisa']),
      totalCostPaisa: serializer.fromJson<int>(json['totalCostPaisa']),
      isFullTank: serializer.fromJson<bool>(json['isFullTank']),
      vendorId: serializer.fromJson<String?>(json['vendorId']),
      stationName: serializer.fromJson<String?>(json['stationName']),
      locationText: serializer.fromJson<String?>(json['locationText']),
      paymentMethod: serializer.fromJson<String?>(json['paymentMethod']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'entryDateTime': serializer.toJson<DateTime>(entryDateTime),
      'odometer': serializer.toJson<int>(odometer),
      'fuelType': serializer.toJson<String>(fuelType),
      'quantityMl': serializer.toJson<int>(quantityMl),
      'pricePerUnitPaisa': serializer.toJson<int?>(pricePerUnitPaisa),
      'totalCostPaisa': serializer.toJson<int>(totalCostPaisa),
      'isFullTank': serializer.toJson<bool>(isFullTank),
      'vendorId': serializer.toJson<String?>(vendorId),
      'stationName': serializer.toJson<String?>(stationName),
      'locationText': serializer.toJson<String?>(locationText),
      'paymentMethod': serializer.toJson<String?>(paymentMethod),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FuelEntryRow copyWith({
    String? id,
    String? vehicleId,
    DateTime? entryDateTime,
    int? odometer,
    String? fuelType,
    int? quantityMl,
    Value<int?> pricePerUnitPaisa = const Value.absent(),
    int? totalCostPaisa,
    bool? isFullTank,
    Value<String?> vendorId = const Value.absent(),
    Value<String?> stationName = const Value.absent(),
    Value<String?> locationText = const Value.absent(),
    Value<String?> paymentMethod = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FuelEntryRow(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    entryDateTime: entryDateTime ?? this.entryDateTime,
    odometer: odometer ?? this.odometer,
    fuelType: fuelType ?? this.fuelType,
    quantityMl: quantityMl ?? this.quantityMl,
    pricePerUnitPaisa: pricePerUnitPaisa.present
        ? pricePerUnitPaisa.value
        : this.pricePerUnitPaisa,
    totalCostPaisa: totalCostPaisa ?? this.totalCostPaisa,
    isFullTank: isFullTank ?? this.isFullTank,
    vendorId: vendorId.present ? vendorId.value : this.vendorId,
    stationName: stationName.present ? stationName.value : this.stationName,
    locationText: locationText.present ? locationText.value : this.locationText,
    paymentMethod: paymentMethod.present
        ? paymentMethod.value
        : this.paymentMethod,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FuelEntryRow copyWithCompanion(FuelEntriesCompanion data) {
    return FuelEntryRow(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      entryDateTime: data.entryDateTime.present
          ? data.entryDateTime.value
          : this.entryDateTime,
      odometer: data.odometer.present ? data.odometer.value : this.odometer,
      fuelType: data.fuelType.present ? data.fuelType.value : this.fuelType,
      quantityMl: data.quantityMl.present
          ? data.quantityMl.value
          : this.quantityMl,
      pricePerUnitPaisa: data.pricePerUnitPaisa.present
          ? data.pricePerUnitPaisa.value
          : this.pricePerUnitPaisa,
      totalCostPaisa: data.totalCostPaisa.present
          ? data.totalCostPaisa.value
          : this.totalCostPaisa,
      isFullTank: data.isFullTank.present
          ? data.isFullTank.value
          : this.isFullTank,
      vendorId: data.vendorId.present ? data.vendorId.value : this.vendorId,
      stationName: data.stationName.present
          ? data.stationName.value
          : this.stationName,
      locationText: data.locationText.present
          ? data.locationText.value
          : this.locationText,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FuelEntryRow(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('entryDateTime: $entryDateTime, ')
          ..write('odometer: $odometer, ')
          ..write('fuelType: $fuelType, ')
          ..write('quantityMl: $quantityMl, ')
          ..write('pricePerUnitPaisa: $pricePerUnitPaisa, ')
          ..write('totalCostPaisa: $totalCostPaisa, ')
          ..write('isFullTank: $isFullTank, ')
          ..write('vendorId: $vendorId, ')
          ..write('stationName: $stationName, ')
          ..write('locationText: $locationText, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    entryDateTime,
    odometer,
    fuelType,
    quantityMl,
    pricePerUnitPaisa,
    totalCostPaisa,
    isFullTank,
    vendorId,
    stationName,
    locationText,
    paymentMethod,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FuelEntryRow &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.entryDateTime == this.entryDateTime &&
          other.odometer == this.odometer &&
          other.fuelType == this.fuelType &&
          other.quantityMl == this.quantityMl &&
          other.pricePerUnitPaisa == this.pricePerUnitPaisa &&
          other.totalCostPaisa == this.totalCostPaisa &&
          other.isFullTank == this.isFullTank &&
          other.vendorId == this.vendorId &&
          other.stationName == this.stationName &&
          other.locationText == this.locationText &&
          other.paymentMethod == this.paymentMethod &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FuelEntriesCompanion extends UpdateCompanion<FuelEntryRow> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<DateTime> entryDateTime;
  final Value<int> odometer;
  final Value<String> fuelType;
  final Value<int> quantityMl;
  final Value<int?> pricePerUnitPaisa;
  final Value<int> totalCostPaisa;
  final Value<bool> isFullTank;
  final Value<String?> vendorId;
  final Value<String?> stationName;
  final Value<String?> locationText;
  final Value<String?> paymentMethod;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FuelEntriesCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.entryDateTime = const Value.absent(),
    this.odometer = const Value.absent(),
    this.fuelType = const Value.absent(),
    this.quantityMl = const Value.absent(),
    this.pricePerUnitPaisa = const Value.absent(),
    this.totalCostPaisa = const Value.absent(),
    this.isFullTank = const Value.absent(),
    this.vendorId = const Value.absent(),
    this.stationName = const Value.absent(),
    this.locationText = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FuelEntriesCompanion.insert({
    required String id,
    required String vehicleId,
    required DateTime entryDateTime,
    required int odometer,
    required String fuelType,
    required int quantityMl,
    this.pricePerUnitPaisa = const Value.absent(),
    required int totalCostPaisa,
    this.isFullTank = const Value.absent(),
    this.vendorId = const Value.absent(),
    this.stationName = const Value.absent(),
    this.locationText = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       entryDateTime = Value(entryDateTime),
       odometer = Value(odometer),
       fuelType = Value(fuelType),
       quantityMl = Value(quantityMl),
       totalCostPaisa = Value(totalCostPaisa),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FuelEntryRow> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<DateTime>? entryDateTime,
    Expression<int>? odometer,
    Expression<String>? fuelType,
    Expression<int>? quantityMl,
    Expression<int>? pricePerUnitPaisa,
    Expression<int>? totalCostPaisa,
    Expression<bool>? isFullTank,
    Expression<String>? vendorId,
    Expression<String>? stationName,
    Expression<String>? locationText,
    Expression<String>? paymentMethod,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (entryDateTime != null) 'entry_date_time': entryDateTime,
      if (odometer != null) 'odometer': odometer,
      if (fuelType != null) 'fuel_type': fuelType,
      if (quantityMl != null) 'quantity_ml': quantityMl,
      if (pricePerUnitPaisa != null) 'price_per_unit_paisa': pricePerUnitPaisa,
      if (totalCostPaisa != null) 'total_cost_paisa': totalCostPaisa,
      if (isFullTank != null) 'is_full_tank': isFullTank,
      if (vendorId != null) 'vendor_id': vendorId,
      if (stationName != null) 'station_name': stationName,
      if (locationText != null) 'location_text': locationText,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FuelEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<DateTime>? entryDateTime,
    Value<int>? odometer,
    Value<String>? fuelType,
    Value<int>? quantityMl,
    Value<int?>? pricePerUnitPaisa,
    Value<int>? totalCostPaisa,
    Value<bool>? isFullTank,
    Value<String?>? vendorId,
    Value<String?>? stationName,
    Value<String?>? locationText,
    Value<String?>? paymentMethod,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FuelEntriesCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      entryDateTime: entryDateTime ?? this.entryDateTime,
      odometer: odometer ?? this.odometer,
      fuelType: fuelType ?? this.fuelType,
      quantityMl: quantityMl ?? this.quantityMl,
      pricePerUnitPaisa: pricePerUnitPaisa ?? this.pricePerUnitPaisa,
      totalCostPaisa: totalCostPaisa ?? this.totalCostPaisa,
      isFullTank: isFullTank ?? this.isFullTank,
      vendorId: vendorId ?? this.vendorId,
      stationName: stationName ?? this.stationName,
      locationText: locationText ?? this.locationText,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (entryDateTime.present) {
      map['entry_date_time'] = Variable<DateTime>(entryDateTime.value);
    }
    if (odometer.present) {
      map['odometer'] = Variable<int>(odometer.value);
    }
    if (fuelType.present) {
      map['fuel_type'] = Variable<String>(fuelType.value);
    }
    if (quantityMl.present) {
      map['quantity_ml'] = Variable<int>(quantityMl.value);
    }
    if (pricePerUnitPaisa.present) {
      map['price_per_unit_paisa'] = Variable<int>(pricePerUnitPaisa.value);
    }
    if (totalCostPaisa.present) {
      map['total_cost_paisa'] = Variable<int>(totalCostPaisa.value);
    }
    if (isFullTank.present) {
      map['is_full_tank'] = Variable<bool>(isFullTank.value);
    }
    if (vendorId.present) {
      map['vendor_id'] = Variable<String>(vendorId.value);
    }
    if (stationName.present) {
      map['station_name'] = Variable<String>(stationName.value);
    }
    if (locationText.present) {
      map['location_text'] = Variable<String>(locationText.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FuelEntriesCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('entryDateTime: $entryDateTime, ')
          ..write('odometer: $odometer, ')
          ..write('fuelType: $fuelType, ')
          ..write('quantityMl: $quantityMl, ')
          ..write('pricePerUnitPaisa: $pricePerUnitPaisa, ')
          ..write('totalCostPaisa: $totalCostPaisa, ')
          ..write('isFullTank: $isFullTank, ')
          ..write('vendorId: $vendorId, ')
          ..write('stationName: $stationName, ')
          ..write('locationText: $locationText, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpenseCategoriesTable extends ExpenseCategories
    with TableInfo<$ExpenseCategoriesTable, ExpenseCategoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameBnMeta = const VerificationMeta('nameBn');
  @override
  late final GeneratedColumn<String> nameBn = GeneratedColumn<String>(
    'name_bn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dashboardGroupMeta = const VerificationMeta(
    'dashboardGroup',
  );
  @override
  late final GeneratedColumn<String> dashboardGroup = GeneratedColumn<String>(
    'dashboard_group',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconKeyMeta = const VerificationMeta(
    'iconKey',
  );
  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
    'icon_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('other'),
  );
  static const VerificationMeta _isSystemMeta = const VerificationMeta(
    'isSystem',
  );
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
    'is_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    nameEn,
    nameBn,
    dashboardGroup,
    iconKey,
    isSystem,
    sortOrder,
    isArchived,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseCategoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_bn')) {
      context.handle(
        _nameBnMeta,
        nameBn.isAcceptableOrUnknown(data['name_bn']!, _nameBnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameBnMeta);
    }
    if (data.containsKey('dashboard_group')) {
      context.handle(
        _dashboardGroupMeta,
        dashboardGroup.isAcceptableOrUnknown(
          data['dashboard_group']!,
          _dashboardGroupMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dashboardGroupMeta);
    }
    if (data.containsKey('icon_key')) {
      context.handle(
        _iconKeyMeta,
        iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta),
      );
    }
    if (data.containsKey('is_system')) {
      context.handle(
        _isSystemMeta,
        isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseCategoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseCategoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_bn'],
      )!,
      dashboardGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dashboard_group'],
      )!,
      iconKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_key'],
      )!,
      isSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ExpenseCategoriesTable createAlias(String alias) {
    return $ExpenseCategoriesTable(attachedDatabase, alias);
  }
}

class ExpenseCategoryRow extends DataClass
    implements Insertable<ExpenseCategoryRow> {
  final String id;
  final String code;
  final String nameEn;
  final String nameBn;

  /// Dashboard bucket: fuel | maintenance | repair | other
  final String dashboardGroup;
  final String iconKey;
  final bool isSystem;
  final int sortOrder;
  final bool isArchived;
  final DateTime createdAt;
  const ExpenseCategoryRow({
    required this.id,
    required this.code,
    required this.nameEn,
    required this.nameBn,
    required this.dashboardGroup,
    required this.iconKey,
    required this.isSystem,
    required this.sortOrder,
    required this.isArchived,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['name_en'] = Variable<String>(nameEn);
    map['name_bn'] = Variable<String>(nameBn);
    map['dashboard_group'] = Variable<String>(dashboardGroup);
    map['icon_key'] = Variable<String>(iconKey);
    map['is_system'] = Variable<bool>(isSystem);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExpenseCategoriesCompanion toCompanion(bool nullToAbsent) {
    return ExpenseCategoriesCompanion(
      id: Value(id),
      code: Value(code),
      nameEn: Value(nameEn),
      nameBn: Value(nameBn),
      dashboardGroup: Value(dashboardGroup),
      iconKey: Value(iconKey),
      isSystem: Value(isSystem),
      sortOrder: Value(sortOrder),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
    );
  }

  factory ExpenseCategoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseCategoryRow(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameBn: serializer.fromJson<String>(json['nameBn']),
      dashboardGroup: serializer.fromJson<String>(json['dashboardGroup']),
      iconKey: serializer.fromJson<String>(json['iconKey']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameBn': serializer.toJson<String>(nameBn),
      'dashboardGroup': serializer.toJson<String>(dashboardGroup),
      'iconKey': serializer.toJson<String>(iconKey),
      'isSystem': serializer.toJson<bool>(isSystem),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ExpenseCategoryRow copyWith({
    String? id,
    String? code,
    String? nameEn,
    String? nameBn,
    String? dashboardGroup,
    String? iconKey,
    bool? isSystem,
    int? sortOrder,
    bool? isArchived,
    DateTime? createdAt,
  }) => ExpenseCategoryRow(
    id: id ?? this.id,
    code: code ?? this.code,
    nameEn: nameEn ?? this.nameEn,
    nameBn: nameBn ?? this.nameBn,
    dashboardGroup: dashboardGroup ?? this.dashboardGroup,
    iconKey: iconKey ?? this.iconKey,
    isSystem: isSystem ?? this.isSystem,
    sortOrder: sortOrder ?? this.sortOrder,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
  );
  ExpenseCategoryRow copyWithCompanion(ExpenseCategoriesCompanion data) {
    return ExpenseCategoryRow(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameBn: data.nameBn.present ? data.nameBn.value : this.nameBn,
      dashboardGroup: data.dashboardGroup.present
          ? data.dashboardGroup.value
          : this.dashboardGroup,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseCategoryRow(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn, ')
          ..write('dashboardGroup: $dashboardGroup, ')
          ..write('iconKey: $iconKey, ')
          ..write('isSystem: $isSystem, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    nameEn,
    nameBn,
    dashboardGroup,
    iconKey,
    isSystem,
    sortOrder,
    isArchived,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseCategoryRow &&
          other.id == this.id &&
          other.code == this.code &&
          other.nameEn == this.nameEn &&
          other.nameBn == this.nameBn &&
          other.dashboardGroup == this.dashboardGroup &&
          other.iconKey == this.iconKey &&
          other.isSystem == this.isSystem &&
          other.sortOrder == this.sortOrder &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt);
}

class ExpenseCategoriesCompanion extends UpdateCompanion<ExpenseCategoryRow> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> nameEn;
  final Value<String> nameBn;
  final Value<String> dashboardGroup;
  final Value<String> iconKey;
  final Value<bool> isSystem;
  final Value<int> sortOrder;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ExpenseCategoriesCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameBn = const Value.absent(),
    this.dashboardGroup = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpenseCategoriesCompanion.insert({
    required String id,
    required String code,
    required String nameEn,
    required String nameBn,
    required String dashboardGroup,
    this.iconKey = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isArchived = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       nameEn = Value(nameEn),
       nameBn = Value(nameBn),
       dashboardGroup = Value(dashboardGroup),
       createdAt = Value(createdAt);
  static Insertable<ExpenseCategoryRow> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? nameEn,
    Expression<String>? nameBn,
    Expression<String>? dashboardGroup,
    Expression<String>? iconKey,
    Expression<bool>? isSystem,
    Expression<int>? sortOrder,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (nameEn != null) 'name_en': nameEn,
      if (nameBn != null) 'name_bn': nameBn,
      if (dashboardGroup != null) 'dashboard_group': dashboardGroup,
      if (iconKey != null) 'icon_key': iconKey,
      if (isSystem != null) 'is_system': isSystem,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpenseCategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? nameEn,
    Value<String>? nameBn,
    Value<String>? dashboardGroup,
    Value<String>? iconKey,
    Value<bool>? isSystem,
    Value<int>? sortOrder,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ExpenseCategoriesCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      nameEn: nameEn ?? this.nameEn,
      nameBn: nameBn ?? this.nameBn,
      dashboardGroup: dashboardGroup ?? this.dashboardGroup,
      iconKey: iconKey ?? this.iconKey,
      isSystem: isSystem ?? this.isSystem,
      sortOrder: sortOrder ?? this.sortOrder,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameBn.present) {
      map['name_bn'] = Variable<String>(nameBn.value);
    }
    if (dashboardGroup.present) {
      map['dashboard_group'] = Variable<String>(dashboardGroup.value);
    }
    if (iconKey.present) {
      map['icon_key'] = Variable<String>(iconKey.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn, ')
          ..write('dashboardGroup: $dashboardGroup, ')
          ..write('iconKey: $iconKey, ')
          ..write('isSystem: $isSystem, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses
    with TableInfo<$ExpensesTable, ExpenseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  static const VerificationMeta _occurredOnMeta = const VerificationMeta(
    'occurredOn',
  );
  @override
  late final GeneratedColumn<DateTime> occurredOn = GeneratedColumn<DateTime>(
    'occurred_on',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES expense_categories (id)',
    ),
  );
  static const VerificationMeta _amountPaisaMeta = const VerificationMeta(
    'amountPaisa',
  );
  @override
  late final GeneratedColumn<int> amountPaisa = GeneratedColumn<int>(
    'amount_paisa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerMeta = const VerificationMeta(
    'odometer',
  );
  @override
  late final GeneratedColumn<int> odometer = GeneratedColumn<int>(
    'odometer',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vendorIdMeta = const VerificationMeta(
    'vendorId',
  );
  @override
  late final GeneratedColumn<String> vendorId = GeneratedColumn<String>(
    'vendor_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vendorNameMeta = const VerificationMeta(
    'vendorName',
  );
  @override
  late final GeneratedColumn<String> vendorName = GeneratedColumn<String>(
    'vendor_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  static const VerificationMeta _sourceRecordIdMeta = const VerificationMeta(
    'sourceRecordId',
  );
  @override
  late final GeneratedColumn<String> sourceRecordId = GeneratedColumn<String>(
    'source_record_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    occurredOn,
    categoryId,
    amountPaisa,
    odometer,
    vendorId,
    vendorName,
    paymentMethod,
    description,
    note,
    sourceType,
    sourceRecordId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('occurred_on')) {
      context.handle(
        _occurredOnMeta,
        occurredOn.isAcceptableOrUnknown(data['occurred_on']!, _occurredOnMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredOnMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('amount_paisa')) {
      context.handle(
        _amountPaisaMeta,
        amountPaisa.isAcceptableOrUnknown(
          data['amount_paisa']!,
          _amountPaisaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountPaisaMeta);
    }
    if (data.containsKey('odometer')) {
      context.handle(
        _odometerMeta,
        odometer.isAcceptableOrUnknown(data['odometer']!, _odometerMeta),
      );
    }
    if (data.containsKey('vendor_id')) {
      context.handle(
        _vendorIdMeta,
        vendorId.isAcceptableOrUnknown(data['vendor_id']!, _vendorIdMeta),
      );
    }
    if (data.containsKey('vendor_name')) {
      context.handle(
        _vendorNameMeta,
        vendorName.isAcceptableOrUnknown(data['vendor_name']!, _vendorNameMeta),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    }
    if (data.containsKey('source_record_id')) {
      context.handle(
        _sourceRecordIdMeta,
        sourceRecordId.isAcceptableOrUnknown(
          data['source_record_id']!,
          _sourceRecordIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      occurredOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_on'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      amountPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_paisa'],
      )!,
      odometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odometer'],
      ),
      vendorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vendor_id'],
      ),
      vendorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vendor_name'],
      ),
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      )!,
      sourceRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_record_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class ExpenseRow extends DataClass implements Insertable<ExpenseRow> {
  final String id;
  final String vehicleId;

  /// Named occurredOn so the getter does not collide with common names.
  final DateTime occurredOn;
  final String categoryId;

  /// Amount stored as paisa.
  final int amountPaisa;
  final int? odometer;
  final String? vendorId;
  final String? vendorName;
  final String? paymentMethod;
  final String? description;
  final String? note;

  /// manual | fuel | service | repair | import
  final String sourceType;
  final String? sourceRecordId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ExpenseRow({
    required this.id,
    required this.vehicleId,
    required this.occurredOn,
    required this.categoryId,
    required this.amountPaisa,
    this.odometer,
    this.vendorId,
    this.vendorName,
    this.paymentMethod,
    this.description,
    this.note,
    required this.sourceType,
    this.sourceRecordId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['occurred_on'] = Variable<DateTime>(occurredOn);
    map['category_id'] = Variable<String>(categoryId);
    map['amount_paisa'] = Variable<int>(amountPaisa);
    if (!nullToAbsent || odometer != null) {
      map['odometer'] = Variable<int>(odometer);
    }
    if (!nullToAbsent || vendorId != null) {
      map['vendor_id'] = Variable<String>(vendorId);
    }
    if (!nullToAbsent || vendorName != null) {
      map['vendor_name'] = Variable<String>(vendorName);
    }
    if (!nullToAbsent || paymentMethod != null) {
      map['payment_method'] = Variable<String>(paymentMethod);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['source_type'] = Variable<String>(sourceType);
    if (!nullToAbsent || sourceRecordId != null) {
      map['source_record_id'] = Variable<String>(sourceRecordId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      occurredOn: Value(occurredOn),
      categoryId: Value(categoryId),
      amountPaisa: Value(amountPaisa),
      odometer: odometer == null && nullToAbsent
          ? const Value.absent()
          : Value(odometer),
      vendorId: vendorId == null && nullToAbsent
          ? const Value.absent()
          : Value(vendorId),
      vendorName: vendorName == null && nullToAbsent
          ? const Value.absent()
          : Value(vendorName),
      paymentMethod: paymentMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMethod),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      sourceType: Value(sourceType),
      sourceRecordId: sourceRecordId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRecordId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ExpenseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseRow(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      occurredOn: serializer.fromJson<DateTime>(json['occurredOn']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      amountPaisa: serializer.fromJson<int>(json['amountPaisa']),
      odometer: serializer.fromJson<int?>(json['odometer']),
      vendorId: serializer.fromJson<String?>(json['vendorId']),
      vendorName: serializer.fromJson<String?>(json['vendorName']),
      paymentMethod: serializer.fromJson<String?>(json['paymentMethod']),
      description: serializer.fromJson<String?>(json['description']),
      note: serializer.fromJson<String?>(json['note']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      sourceRecordId: serializer.fromJson<String?>(json['sourceRecordId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'occurredOn': serializer.toJson<DateTime>(occurredOn),
      'categoryId': serializer.toJson<String>(categoryId),
      'amountPaisa': serializer.toJson<int>(amountPaisa),
      'odometer': serializer.toJson<int?>(odometer),
      'vendorId': serializer.toJson<String?>(vendorId),
      'vendorName': serializer.toJson<String?>(vendorName),
      'paymentMethod': serializer.toJson<String?>(paymentMethod),
      'description': serializer.toJson<String?>(description),
      'note': serializer.toJson<String?>(note),
      'sourceType': serializer.toJson<String>(sourceType),
      'sourceRecordId': serializer.toJson<String?>(sourceRecordId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ExpenseRow copyWith({
    String? id,
    String? vehicleId,
    DateTime? occurredOn,
    String? categoryId,
    int? amountPaisa,
    Value<int?> odometer = const Value.absent(),
    Value<String?> vendorId = const Value.absent(),
    Value<String?> vendorName = const Value.absent(),
    Value<String?> paymentMethod = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> note = const Value.absent(),
    String? sourceType,
    Value<String?> sourceRecordId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ExpenseRow(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    occurredOn: occurredOn ?? this.occurredOn,
    categoryId: categoryId ?? this.categoryId,
    amountPaisa: amountPaisa ?? this.amountPaisa,
    odometer: odometer.present ? odometer.value : this.odometer,
    vendorId: vendorId.present ? vendorId.value : this.vendorId,
    vendorName: vendorName.present ? vendorName.value : this.vendorName,
    paymentMethod: paymentMethod.present
        ? paymentMethod.value
        : this.paymentMethod,
    description: description.present ? description.value : this.description,
    note: note.present ? note.value : this.note,
    sourceType: sourceType ?? this.sourceType,
    sourceRecordId: sourceRecordId.present
        ? sourceRecordId.value
        : this.sourceRecordId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ExpenseRow copyWithCompanion(ExpensesCompanion data) {
    return ExpenseRow(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      occurredOn: data.occurredOn.present
          ? data.occurredOn.value
          : this.occurredOn,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      amountPaisa: data.amountPaisa.present
          ? data.amountPaisa.value
          : this.amountPaisa,
      odometer: data.odometer.present ? data.odometer.value : this.odometer,
      vendorId: data.vendorId.present ? data.vendorId.value : this.vendorId,
      vendorName: data.vendorName.present
          ? data.vendorName.value
          : this.vendorName,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      description: data.description.present
          ? data.description.value
          : this.description,
      note: data.note.present ? data.note.value : this.note,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      sourceRecordId: data.sourceRecordId.present
          ? data.sourceRecordId.value
          : this.sourceRecordId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseRow(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('occurredOn: $occurredOn, ')
          ..write('categoryId: $categoryId, ')
          ..write('amountPaisa: $amountPaisa, ')
          ..write('odometer: $odometer, ')
          ..write('vendorId: $vendorId, ')
          ..write('vendorName: $vendorName, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('description: $description, ')
          ..write('note: $note, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceRecordId: $sourceRecordId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    occurredOn,
    categoryId,
    amountPaisa,
    odometer,
    vendorId,
    vendorName,
    paymentMethod,
    description,
    note,
    sourceType,
    sourceRecordId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseRow &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.occurredOn == this.occurredOn &&
          other.categoryId == this.categoryId &&
          other.amountPaisa == this.amountPaisa &&
          other.odometer == this.odometer &&
          other.vendorId == this.vendorId &&
          other.vendorName == this.vendorName &&
          other.paymentMethod == this.paymentMethod &&
          other.description == this.description &&
          other.note == this.note &&
          other.sourceType == this.sourceType &&
          other.sourceRecordId == this.sourceRecordId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ExpensesCompanion extends UpdateCompanion<ExpenseRow> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<DateTime> occurredOn;
  final Value<String> categoryId;
  final Value<int> amountPaisa;
  final Value<int?> odometer;
  final Value<String?> vendorId;
  final Value<String?> vendorName;
  final Value<String?> paymentMethod;
  final Value<String?> description;
  final Value<String?> note;
  final Value<String> sourceType;
  final Value<String?> sourceRecordId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.occurredOn = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.amountPaisa = const Value.absent(),
    this.odometer = const Value.absent(),
    this.vendorId = const Value.absent(),
    this.vendorName = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.description = const Value.absent(),
    this.note = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceRecordId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesCompanion.insert({
    required String id,
    required String vehicleId,
    required DateTime occurredOn,
    required String categoryId,
    required int amountPaisa,
    this.odometer = const Value.absent(),
    this.vendorId = const Value.absent(),
    this.vendorName = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.description = const Value.absent(),
    this.note = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceRecordId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       occurredOn = Value(occurredOn),
       categoryId = Value(categoryId),
       amountPaisa = Value(amountPaisa),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ExpenseRow> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<DateTime>? occurredOn,
    Expression<String>? categoryId,
    Expression<int>? amountPaisa,
    Expression<int>? odometer,
    Expression<String>? vendorId,
    Expression<String>? vendorName,
    Expression<String>? paymentMethod,
    Expression<String>? description,
    Expression<String>? note,
    Expression<String>? sourceType,
    Expression<String>? sourceRecordId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (occurredOn != null) 'occurred_on': occurredOn,
      if (categoryId != null) 'category_id': categoryId,
      if (amountPaisa != null) 'amount_paisa': amountPaisa,
      if (odometer != null) 'odometer': odometer,
      if (vendorId != null) 'vendor_id': vendorId,
      if (vendorName != null) 'vendor_name': vendorName,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (description != null) 'description': description,
      if (note != null) 'note': note,
      if (sourceType != null) 'source_type': sourceType,
      if (sourceRecordId != null) 'source_record_id': sourceRecordId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<DateTime>? occurredOn,
    Value<String>? categoryId,
    Value<int>? amountPaisa,
    Value<int?>? odometer,
    Value<String?>? vendorId,
    Value<String?>? vendorName,
    Value<String?>? paymentMethod,
    Value<String?>? description,
    Value<String?>? note,
    Value<String>? sourceType,
    Value<String?>? sourceRecordId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      occurredOn: occurredOn ?? this.occurredOn,
      categoryId: categoryId ?? this.categoryId,
      amountPaisa: amountPaisa ?? this.amountPaisa,
      odometer: odometer ?? this.odometer,
      vendorId: vendorId ?? this.vendorId,
      vendorName: vendorName ?? this.vendorName,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      description: description ?? this.description,
      note: note ?? this.note,
      sourceType: sourceType ?? this.sourceType,
      sourceRecordId: sourceRecordId ?? this.sourceRecordId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (occurredOn.present) {
      map['occurred_on'] = Variable<DateTime>(occurredOn.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (amountPaisa.present) {
      map['amount_paisa'] = Variable<int>(amountPaisa.value);
    }
    if (odometer.present) {
      map['odometer'] = Variable<int>(odometer.value);
    }
    if (vendorId.present) {
      map['vendor_id'] = Variable<String>(vendorId.value);
    }
    if (vendorName.present) {
      map['vendor_name'] = Variable<String>(vendorName.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (sourceRecordId.present) {
      map['source_record_id'] = Variable<String>(sourceRecordId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('occurredOn: $occurredOn, ')
          ..write('categoryId: $categoryId, ')
          ..write('amountPaisa: $amountPaisa, ')
          ..write('odometer: $odometer, ')
          ..write('vendorId: $vendorId, ')
          ..write('vendorName: $vendorName, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('description: $description, ')
          ..write('note: $note, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceRecordId: $sourceRecordId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MaintenanceTemplatesTable extends MaintenanceTemplates
    with TableInfo<$MaintenanceTemplatesTable, MaintenanceTemplateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenanceTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameBnMeta = const VerificationMeta('nameBn');
  @override
  late final GeneratedColumn<String> nameBn = GeneratedColumn<String>(
    'name_bn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleTypeMeta = const VerificationMeta(
    'vehicleType',
  );
  @override
  late final GeneratedColumn<String> vehicleType = GeneratedColumn<String>(
    'vehicle_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('all'),
  );
  static const VerificationMeta _defaultKmIntervalMeta = const VerificationMeta(
    'defaultKmInterval',
  );
  @override
  late final GeneratedColumn<int> defaultKmInterval = GeneratedColumn<int>(
    'default_km_interval',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultDayIntervalMeta =
      const VerificationMeta('defaultDayInterval');
  @override
  late final GeneratedColumn<int> defaultDayInterval = GeneratedColumn<int>(
    'default_day_interval',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconKeyMeta = const VerificationMeta(
    'iconKey',
  );
  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
    'icon_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('service'),
  );
  static const VerificationMeta _isSystemMeta = const VerificationMeta(
    'isSystem',
  );
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
    'is_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    nameEn,
    nameBn,
    vehicleType,
    defaultKmInterval,
    defaultDayInterval,
    iconKey,
    isSystem,
    isActive,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenance_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaintenanceTemplateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_bn')) {
      context.handle(
        _nameBnMeta,
        nameBn.isAcceptableOrUnknown(data['name_bn']!, _nameBnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameBnMeta);
    }
    if (data.containsKey('vehicle_type')) {
      context.handle(
        _vehicleTypeMeta,
        vehicleType.isAcceptableOrUnknown(
          data['vehicle_type']!,
          _vehicleTypeMeta,
        ),
      );
    }
    if (data.containsKey('default_km_interval')) {
      context.handle(
        _defaultKmIntervalMeta,
        defaultKmInterval.isAcceptableOrUnknown(
          data['default_km_interval']!,
          _defaultKmIntervalMeta,
        ),
      );
    }
    if (data.containsKey('default_day_interval')) {
      context.handle(
        _defaultDayIntervalMeta,
        defaultDayInterval.isAcceptableOrUnknown(
          data['default_day_interval']!,
          _defaultDayIntervalMeta,
        ),
      );
    }
    if (data.containsKey('icon_key')) {
      context.handle(
        _iconKeyMeta,
        iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta),
      );
    }
    if (data.containsKey('is_system')) {
      context.handle(
        _isSystemMeta,
        isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {code, vehicleType},
  ];
  @override
  MaintenanceTemplateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaintenanceTemplateRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_bn'],
      )!,
      vehicleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_type'],
      )!,
      defaultKmInterval: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_km_interval'],
      ),
      defaultDayInterval: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_day_interval'],
      ),
      iconKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_key'],
      )!,
      isSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MaintenanceTemplatesTable createAlias(String alias) {
    return $MaintenanceTemplatesTable(attachedDatabase, alias);
  }
}

class MaintenanceTemplateRow extends DataClass
    implements Insertable<MaintenanceTemplateRow> {
  final String id;
  final String code;
  final String nameEn;
  final String nameBn;

  /// motorcycle | car | all
  final String vehicleType;
  final int? defaultKmInterval;
  final int? defaultDayInterval;
  final String iconKey;
  final bool isSystem;
  final bool isActive;
  final int sortOrder;
  final DateTime createdAt;
  const MaintenanceTemplateRow({
    required this.id,
    required this.code,
    required this.nameEn,
    required this.nameBn,
    required this.vehicleType,
    this.defaultKmInterval,
    this.defaultDayInterval,
    required this.iconKey,
    required this.isSystem,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['name_en'] = Variable<String>(nameEn);
    map['name_bn'] = Variable<String>(nameBn);
    map['vehicle_type'] = Variable<String>(vehicleType);
    if (!nullToAbsent || defaultKmInterval != null) {
      map['default_km_interval'] = Variable<int>(defaultKmInterval);
    }
    if (!nullToAbsent || defaultDayInterval != null) {
      map['default_day_interval'] = Variable<int>(defaultDayInterval);
    }
    map['icon_key'] = Variable<String>(iconKey);
    map['is_system'] = Variable<bool>(isSystem);
    map['is_active'] = Variable<bool>(isActive);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MaintenanceTemplatesCompanion toCompanion(bool nullToAbsent) {
    return MaintenanceTemplatesCompanion(
      id: Value(id),
      code: Value(code),
      nameEn: Value(nameEn),
      nameBn: Value(nameBn),
      vehicleType: Value(vehicleType),
      defaultKmInterval: defaultKmInterval == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultKmInterval),
      defaultDayInterval: defaultDayInterval == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultDayInterval),
      iconKey: Value(iconKey),
      isSystem: Value(isSystem),
      isActive: Value(isActive),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory MaintenanceTemplateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaintenanceTemplateRow(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameBn: serializer.fromJson<String>(json['nameBn']),
      vehicleType: serializer.fromJson<String>(json['vehicleType']),
      defaultKmInterval: serializer.fromJson<int?>(json['defaultKmInterval']),
      defaultDayInterval: serializer.fromJson<int?>(json['defaultDayInterval']),
      iconKey: serializer.fromJson<String>(json['iconKey']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameBn': serializer.toJson<String>(nameBn),
      'vehicleType': serializer.toJson<String>(vehicleType),
      'defaultKmInterval': serializer.toJson<int?>(defaultKmInterval),
      'defaultDayInterval': serializer.toJson<int?>(defaultDayInterval),
      'iconKey': serializer.toJson<String>(iconKey),
      'isSystem': serializer.toJson<bool>(isSystem),
      'isActive': serializer.toJson<bool>(isActive),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MaintenanceTemplateRow copyWith({
    String? id,
    String? code,
    String? nameEn,
    String? nameBn,
    String? vehicleType,
    Value<int?> defaultKmInterval = const Value.absent(),
    Value<int?> defaultDayInterval = const Value.absent(),
    String? iconKey,
    bool? isSystem,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
  }) => MaintenanceTemplateRow(
    id: id ?? this.id,
    code: code ?? this.code,
    nameEn: nameEn ?? this.nameEn,
    nameBn: nameBn ?? this.nameBn,
    vehicleType: vehicleType ?? this.vehicleType,
    defaultKmInterval: defaultKmInterval.present
        ? defaultKmInterval.value
        : this.defaultKmInterval,
    defaultDayInterval: defaultDayInterval.present
        ? defaultDayInterval.value
        : this.defaultDayInterval,
    iconKey: iconKey ?? this.iconKey,
    isSystem: isSystem ?? this.isSystem,
    isActive: isActive ?? this.isActive,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  MaintenanceTemplateRow copyWithCompanion(MaintenanceTemplatesCompanion data) {
    return MaintenanceTemplateRow(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameBn: data.nameBn.present ? data.nameBn.value : this.nameBn,
      vehicleType: data.vehicleType.present
          ? data.vehicleType.value
          : this.vehicleType,
      defaultKmInterval: data.defaultKmInterval.present
          ? data.defaultKmInterval.value
          : this.defaultKmInterval,
      defaultDayInterval: data.defaultDayInterval.present
          ? data.defaultDayInterval.value
          : this.defaultDayInterval,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceTemplateRow(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn, ')
          ..write('vehicleType: $vehicleType, ')
          ..write('defaultKmInterval: $defaultKmInterval, ')
          ..write('defaultDayInterval: $defaultDayInterval, ')
          ..write('iconKey: $iconKey, ')
          ..write('isSystem: $isSystem, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    nameEn,
    nameBn,
    vehicleType,
    defaultKmInterval,
    defaultDayInterval,
    iconKey,
    isSystem,
    isActive,
    sortOrder,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaintenanceTemplateRow &&
          other.id == this.id &&
          other.code == this.code &&
          other.nameEn == this.nameEn &&
          other.nameBn == this.nameBn &&
          other.vehicleType == this.vehicleType &&
          other.defaultKmInterval == this.defaultKmInterval &&
          other.defaultDayInterval == this.defaultDayInterval &&
          other.iconKey == this.iconKey &&
          other.isSystem == this.isSystem &&
          other.isActive == this.isActive &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class MaintenanceTemplatesCompanion
    extends UpdateCompanion<MaintenanceTemplateRow> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> nameEn;
  final Value<String> nameBn;
  final Value<String> vehicleType;
  final Value<int?> defaultKmInterval;
  final Value<int?> defaultDayInterval;
  final Value<String> iconKey;
  final Value<bool> isSystem;
  final Value<bool> isActive;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MaintenanceTemplatesCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameBn = const Value.absent(),
    this.vehicleType = const Value.absent(),
    this.defaultKmInterval = const Value.absent(),
    this.defaultDayInterval = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MaintenanceTemplatesCompanion.insert({
    required String id,
    required String code,
    required String nameEn,
    required String nameBn,
    this.vehicleType = const Value.absent(),
    this.defaultKmInterval = const Value.absent(),
    this.defaultDayInterval = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       nameEn = Value(nameEn),
       nameBn = Value(nameBn),
       createdAt = Value(createdAt);
  static Insertable<MaintenanceTemplateRow> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? nameEn,
    Expression<String>? nameBn,
    Expression<String>? vehicleType,
    Expression<int>? defaultKmInterval,
    Expression<int>? defaultDayInterval,
    Expression<String>? iconKey,
    Expression<bool>? isSystem,
    Expression<bool>? isActive,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (nameEn != null) 'name_en': nameEn,
      if (nameBn != null) 'name_bn': nameBn,
      if (vehicleType != null) 'vehicle_type': vehicleType,
      if (defaultKmInterval != null) 'default_km_interval': defaultKmInterval,
      if (defaultDayInterval != null)
        'default_day_interval': defaultDayInterval,
      if (iconKey != null) 'icon_key': iconKey,
      if (isSystem != null) 'is_system': isSystem,
      if (isActive != null) 'is_active': isActive,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MaintenanceTemplatesCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? nameEn,
    Value<String>? nameBn,
    Value<String>? vehicleType,
    Value<int?>? defaultKmInterval,
    Value<int?>? defaultDayInterval,
    Value<String>? iconKey,
    Value<bool>? isSystem,
    Value<bool>? isActive,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return MaintenanceTemplatesCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      nameEn: nameEn ?? this.nameEn,
      nameBn: nameBn ?? this.nameBn,
      vehicleType: vehicleType ?? this.vehicleType,
      defaultKmInterval: defaultKmInterval ?? this.defaultKmInterval,
      defaultDayInterval: defaultDayInterval ?? this.defaultDayInterval,
      iconKey: iconKey ?? this.iconKey,
      isSystem: isSystem ?? this.isSystem,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameBn.present) {
      map['name_bn'] = Variable<String>(nameBn.value);
    }
    if (vehicleType.present) {
      map['vehicle_type'] = Variable<String>(vehicleType.value);
    }
    if (defaultKmInterval.present) {
      map['default_km_interval'] = Variable<int>(defaultKmInterval.value);
    }
    if (defaultDayInterval.present) {
      map['default_day_interval'] = Variable<int>(defaultDayInterval.value);
    }
    if (iconKey.present) {
      map['icon_key'] = Variable<String>(iconKey.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn, ')
          ..write('vehicleType: $vehicleType, ')
          ..write('defaultKmInterval: $defaultKmInterval, ')
          ..write('defaultDayInterval: $defaultDayInterval, ')
          ..write('iconKey: $iconKey, ')
          ..write('isSystem: $isSystem, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServiceRecordsTable extends ServiceRecords
    with TableInfo<$ServiceRecordsTable, ServiceRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiceRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  static const VerificationMeta _serviceDateMeta = const VerificationMeta(
    'serviceDate',
  );
  @override
  late final GeneratedColumn<DateTime> serviceDate = GeneratedColumn<DateTime>(
    'service_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerMeta = const VerificationMeta(
    'odometer',
  );
  @override
  late final GeneratedColumn<int> odometer = GeneratedColumn<int>(
    'odometer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vendorNameMeta = const VerificationMeta(
    'vendorName',
  );
  @override
  late final GeneratedColumn<String> vendorName = GeneratedColumn<String>(
    'vendor_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _laborCostPaisaMeta = const VerificationMeta(
    'laborCostPaisa',
  );
  @override
  late final GeneratedColumn<int> laborCostPaisa = GeneratedColumn<int>(
    'labor_cost_paisa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _partsCostPaisaMeta = const VerificationMeta(
    'partsCostPaisa',
  );
  @override
  late final GeneratedColumn<int> partsCostPaisa = GeneratedColumn<int>(
    'parts_cost_paisa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalCostPaisaMeta = const VerificationMeta(
    'totalCostPaisa',
  );
  @override
  late final GeneratedColumn<int> totalCostPaisa = GeneratedColumn<int>(
    'total_cost_paisa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nextDueDateMeta = const VerificationMeta(
    'nextDueDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextDueDate = GeneratedColumn<DateTime>(
    'next_due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextDueOdometerMeta = const VerificationMeta(
    'nextDueOdometer',
  );
  @override
  late final GeneratedColumn<int> nextDueOdometer = GeneratedColumn<int>(
    'next_due_odometer',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    serviceDate,
    odometer,
    vendorName,
    laborCostPaisa,
    partsCostPaisa,
    totalCostPaisa,
    nextDueDate,
    nextDueOdometer,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServiceRecordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('service_date')) {
      context.handle(
        _serviceDateMeta,
        serviceDate.isAcceptableOrUnknown(
          data['service_date']!,
          _serviceDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serviceDateMeta);
    }
    if (data.containsKey('odometer')) {
      context.handle(
        _odometerMeta,
        odometer.isAcceptableOrUnknown(data['odometer']!, _odometerMeta),
      );
    } else if (isInserting) {
      context.missing(_odometerMeta);
    }
    if (data.containsKey('vendor_name')) {
      context.handle(
        _vendorNameMeta,
        vendorName.isAcceptableOrUnknown(data['vendor_name']!, _vendorNameMeta),
      );
    }
    if (data.containsKey('labor_cost_paisa')) {
      context.handle(
        _laborCostPaisaMeta,
        laborCostPaisa.isAcceptableOrUnknown(
          data['labor_cost_paisa']!,
          _laborCostPaisaMeta,
        ),
      );
    }
    if (data.containsKey('parts_cost_paisa')) {
      context.handle(
        _partsCostPaisaMeta,
        partsCostPaisa.isAcceptableOrUnknown(
          data['parts_cost_paisa']!,
          _partsCostPaisaMeta,
        ),
      );
    }
    if (data.containsKey('total_cost_paisa')) {
      context.handle(
        _totalCostPaisaMeta,
        totalCostPaisa.isAcceptableOrUnknown(
          data['total_cost_paisa']!,
          _totalCostPaisaMeta,
        ),
      );
    }
    if (data.containsKey('next_due_date')) {
      context.handle(
        _nextDueDateMeta,
        nextDueDate.isAcceptableOrUnknown(
          data['next_due_date']!,
          _nextDueDateMeta,
        ),
      );
    }
    if (data.containsKey('next_due_odometer')) {
      context.handle(
        _nextDueOdometerMeta,
        nextDueOdometer.isAcceptableOrUnknown(
          data['next_due_odometer']!,
          _nextDueOdometerMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceRecordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      serviceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}service_date'],
      )!,
      odometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odometer'],
      )!,
      vendorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vendor_name'],
      ),
      laborCostPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}labor_cost_paisa'],
      )!,
      partsCostPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parts_cost_paisa'],
      )!,
      totalCostPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_cost_paisa'],
      )!,
      nextDueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_due_date'],
      ),
      nextDueOdometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_due_odometer'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ServiceRecordsTable createAlias(String alias) {
    return $ServiceRecordsTable(attachedDatabase, alias);
  }
}

class ServiceRecordRow extends DataClass
    implements Insertable<ServiceRecordRow> {
  final String id;
  final String vehicleId;
  final DateTime serviceDate;
  final int odometer;
  final String? vendorName;
  final int laborCostPaisa;
  final int partsCostPaisa;
  final int totalCostPaisa;
  final DateTime? nextDueDate;
  final int? nextDueOdometer;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ServiceRecordRow({
    required this.id,
    required this.vehicleId,
    required this.serviceDate,
    required this.odometer,
    this.vendorName,
    required this.laborCostPaisa,
    required this.partsCostPaisa,
    required this.totalCostPaisa,
    this.nextDueDate,
    this.nextDueOdometer,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['service_date'] = Variable<DateTime>(serviceDate);
    map['odometer'] = Variable<int>(odometer);
    if (!nullToAbsent || vendorName != null) {
      map['vendor_name'] = Variable<String>(vendorName);
    }
    map['labor_cost_paisa'] = Variable<int>(laborCostPaisa);
    map['parts_cost_paisa'] = Variable<int>(partsCostPaisa);
    map['total_cost_paisa'] = Variable<int>(totalCostPaisa);
    if (!nullToAbsent || nextDueDate != null) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate);
    }
    if (!nullToAbsent || nextDueOdometer != null) {
      map['next_due_odometer'] = Variable<int>(nextDueOdometer);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ServiceRecordsCompanion toCompanion(bool nullToAbsent) {
    return ServiceRecordsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      serviceDate: Value(serviceDate),
      odometer: Value(odometer),
      vendorName: vendorName == null && nullToAbsent
          ? const Value.absent()
          : Value(vendorName),
      laborCostPaisa: Value(laborCostPaisa),
      partsCostPaisa: Value(partsCostPaisa),
      totalCostPaisa: Value(totalCostPaisa),
      nextDueDate: nextDueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextDueDate),
      nextDueOdometer: nextDueOdometer == null && nullToAbsent
          ? const Value.absent()
          : Value(nextDueOdometer),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ServiceRecordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServiceRecordRow(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      serviceDate: serializer.fromJson<DateTime>(json['serviceDate']),
      odometer: serializer.fromJson<int>(json['odometer']),
      vendorName: serializer.fromJson<String?>(json['vendorName']),
      laborCostPaisa: serializer.fromJson<int>(json['laborCostPaisa']),
      partsCostPaisa: serializer.fromJson<int>(json['partsCostPaisa']),
      totalCostPaisa: serializer.fromJson<int>(json['totalCostPaisa']),
      nextDueDate: serializer.fromJson<DateTime?>(json['nextDueDate']),
      nextDueOdometer: serializer.fromJson<int?>(json['nextDueOdometer']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'serviceDate': serializer.toJson<DateTime>(serviceDate),
      'odometer': serializer.toJson<int>(odometer),
      'vendorName': serializer.toJson<String?>(vendorName),
      'laborCostPaisa': serializer.toJson<int>(laborCostPaisa),
      'partsCostPaisa': serializer.toJson<int>(partsCostPaisa),
      'totalCostPaisa': serializer.toJson<int>(totalCostPaisa),
      'nextDueDate': serializer.toJson<DateTime?>(nextDueDate),
      'nextDueOdometer': serializer.toJson<int?>(nextDueOdometer),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ServiceRecordRow copyWith({
    String? id,
    String? vehicleId,
    DateTime? serviceDate,
    int? odometer,
    Value<String?> vendorName = const Value.absent(),
    int? laborCostPaisa,
    int? partsCostPaisa,
    int? totalCostPaisa,
    Value<DateTime?> nextDueDate = const Value.absent(),
    Value<int?> nextDueOdometer = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ServiceRecordRow(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    serviceDate: serviceDate ?? this.serviceDate,
    odometer: odometer ?? this.odometer,
    vendorName: vendorName.present ? vendorName.value : this.vendorName,
    laborCostPaisa: laborCostPaisa ?? this.laborCostPaisa,
    partsCostPaisa: partsCostPaisa ?? this.partsCostPaisa,
    totalCostPaisa: totalCostPaisa ?? this.totalCostPaisa,
    nextDueDate: nextDueDate.present ? nextDueDate.value : this.nextDueDate,
    nextDueOdometer: nextDueOdometer.present
        ? nextDueOdometer.value
        : this.nextDueOdometer,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ServiceRecordRow copyWithCompanion(ServiceRecordsCompanion data) {
    return ServiceRecordRow(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      serviceDate: data.serviceDate.present
          ? data.serviceDate.value
          : this.serviceDate,
      odometer: data.odometer.present ? data.odometer.value : this.odometer,
      vendorName: data.vendorName.present
          ? data.vendorName.value
          : this.vendorName,
      laborCostPaisa: data.laborCostPaisa.present
          ? data.laborCostPaisa.value
          : this.laborCostPaisa,
      partsCostPaisa: data.partsCostPaisa.present
          ? data.partsCostPaisa.value
          : this.partsCostPaisa,
      totalCostPaisa: data.totalCostPaisa.present
          ? data.totalCostPaisa.value
          : this.totalCostPaisa,
      nextDueDate: data.nextDueDate.present
          ? data.nextDueDate.value
          : this.nextDueDate,
      nextDueOdometer: data.nextDueOdometer.present
          ? data.nextDueOdometer.value
          : this.nextDueOdometer,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServiceRecordRow(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('serviceDate: $serviceDate, ')
          ..write('odometer: $odometer, ')
          ..write('vendorName: $vendorName, ')
          ..write('laborCostPaisa: $laborCostPaisa, ')
          ..write('partsCostPaisa: $partsCostPaisa, ')
          ..write('totalCostPaisa: $totalCostPaisa, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('nextDueOdometer: $nextDueOdometer, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    serviceDate,
    odometer,
    vendorName,
    laborCostPaisa,
    partsCostPaisa,
    totalCostPaisa,
    nextDueDate,
    nextDueOdometer,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceRecordRow &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.serviceDate == this.serviceDate &&
          other.odometer == this.odometer &&
          other.vendorName == this.vendorName &&
          other.laborCostPaisa == this.laborCostPaisa &&
          other.partsCostPaisa == this.partsCostPaisa &&
          other.totalCostPaisa == this.totalCostPaisa &&
          other.nextDueDate == this.nextDueDate &&
          other.nextDueOdometer == this.nextDueOdometer &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ServiceRecordsCompanion extends UpdateCompanion<ServiceRecordRow> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<DateTime> serviceDate;
  final Value<int> odometer;
  final Value<String?> vendorName;
  final Value<int> laborCostPaisa;
  final Value<int> partsCostPaisa;
  final Value<int> totalCostPaisa;
  final Value<DateTime?> nextDueDate;
  final Value<int?> nextDueOdometer;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ServiceRecordsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.serviceDate = const Value.absent(),
    this.odometer = const Value.absent(),
    this.vendorName = const Value.absent(),
    this.laborCostPaisa = const Value.absent(),
    this.partsCostPaisa = const Value.absent(),
    this.totalCostPaisa = const Value.absent(),
    this.nextDueDate = const Value.absent(),
    this.nextDueOdometer = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServiceRecordsCompanion.insert({
    required String id,
    required String vehicleId,
    required DateTime serviceDate,
    required int odometer,
    this.vendorName = const Value.absent(),
    this.laborCostPaisa = const Value.absent(),
    this.partsCostPaisa = const Value.absent(),
    this.totalCostPaisa = const Value.absent(),
    this.nextDueDate = const Value.absent(),
    this.nextDueOdometer = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       serviceDate = Value(serviceDate),
       odometer = Value(odometer),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ServiceRecordRow> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<DateTime>? serviceDate,
    Expression<int>? odometer,
    Expression<String>? vendorName,
    Expression<int>? laborCostPaisa,
    Expression<int>? partsCostPaisa,
    Expression<int>? totalCostPaisa,
    Expression<DateTime>? nextDueDate,
    Expression<int>? nextDueOdometer,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (serviceDate != null) 'service_date': serviceDate,
      if (odometer != null) 'odometer': odometer,
      if (vendorName != null) 'vendor_name': vendorName,
      if (laborCostPaisa != null) 'labor_cost_paisa': laborCostPaisa,
      if (partsCostPaisa != null) 'parts_cost_paisa': partsCostPaisa,
      if (totalCostPaisa != null) 'total_cost_paisa': totalCostPaisa,
      if (nextDueDate != null) 'next_due_date': nextDueDate,
      if (nextDueOdometer != null) 'next_due_odometer': nextDueOdometer,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServiceRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<DateTime>? serviceDate,
    Value<int>? odometer,
    Value<String?>? vendorName,
    Value<int>? laborCostPaisa,
    Value<int>? partsCostPaisa,
    Value<int>? totalCostPaisa,
    Value<DateTime?>? nextDueDate,
    Value<int?>? nextDueOdometer,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ServiceRecordsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      serviceDate: serviceDate ?? this.serviceDate,
      odometer: odometer ?? this.odometer,
      vendorName: vendorName ?? this.vendorName,
      laborCostPaisa: laborCostPaisa ?? this.laborCostPaisa,
      partsCostPaisa: partsCostPaisa ?? this.partsCostPaisa,
      totalCostPaisa: totalCostPaisa ?? this.totalCostPaisa,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      nextDueOdometer: nextDueOdometer ?? this.nextDueOdometer,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (serviceDate.present) {
      map['service_date'] = Variable<DateTime>(serviceDate.value);
    }
    if (odometer.present) {
      map['odometer'] = Variable<int>(odometer.value);
    }
    if (vendorName.present) {
      map['vendor_name'] = Variable<String>(vendorName.value);
    }
    if (laborCostPaisa.present) {
      map['labor_cost_paisa'] = Variable<int>(laborCostPaisa.value);
    }
    if (partsCostPaisa.present) {
      map['parts_cost_paisa'] = Variable<int>(partsCostPaisa.value);
    }
    if (totalCostPaisa.present) {
      map['total_cost_paisa'] = Variable<int>(totalCostPaisa.value);
    }
    if (nextDueDate.present) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate.value);
    }
    if (nextDueOdometer.present) {
      map['next_due_odometer'] = Variable<int>(nextDueOdometer.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceRecordsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('serviceDate: $serviceDate, ')
          ..write('odometer: $odometer, ')
          ..write('vendorName: $vendorName, ')
          ..write('laborCostPaisa: $laborCostPaisa, ')
          ..write('partsCostPaisa: $partsCostPaisa, ')
          ..write('totalCostPaisa: $totalCostPaisa, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('nextDueOdometer: $nextDueOdometer, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServiceItemsTable extends ServiceItems
    with TableInfo<$ServiceItemsTable, ServiceItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiceItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceRecordIdMeta = const VerificationMeta(
    'serviceRecordId',
  );
  @override
  late final GeneratedColumn<String> serviceRecordId = GeneratedColumn<String>(
    'service_record_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES service_records (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES maintenance_templates (id)',
    ),
  );
  static const VerificationMeta _maintenanceTypeMeta = const VerificationMeta(
    'maintenanceType',
  );
  @override
  late final GeneratedColumn<String> maintenanceType = GeneratedColumn<String>(
    'maintenance_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costPaisaMeta = const VerificationMeta(
    'costPaisa',
  );
  @override
  late final GeneratedColumn<int> costPaisa = GeneratedColumn<int>(
    'cost_paisa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serviceRecordId,
    templateId,
    maintenanceType,
    title,
    costPaisa,
    quantity,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServiceItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('service_record_id')) {
      context.handle(
        _serviceRecordIdMeta,
        serviceRecordId.isAcceptableOrUnknown(
          data['service_record_id']!,
          _serviceRecordIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serviceRecordIdMeta);
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    }
    if (data.containsKey('maintenance_type')) {
      context.handle(
        _maintenanceTypeMeta,
        maintenanceType.isAcceptableOrUnknown(
          data['maintenance_type']!,
          _maintenanceTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maintenanceTypeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('cost_paisa')) {
      context.handle(
        _costPaisaMeta,
        costPaisa.isAcceptableOrUnknown(data['cost_paisa']!, _costPaisaMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      serviceRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_record_id'],
      )!,
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      ),
      maintenanceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}maintenance_type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      costPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_paisa'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $ServiceItemsTable createAlias(String alias) {
    return $ServiceItemsTable(attachedDatabase, alias);
  }
}

class ServiceItemRow extends DataClass implements Insertable<ServiceItemRow> {
  final String id;
  final String serviceRecordId;
  final String? templateId;
  final String maintenanceType;
  final String title;
  final int costPaisa;
  final double quantity;
  final String? note;
  const ServiceItemRow({
    required this.id,
    required this.serviceRecordId,
    this.templateId,
    required this.maintenanceType,
    required this.title,
    required this.costPaisa,
    required this.quantity,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['service_record_id'] = Variable<String>(serviceRecordId);
    if (!nullToAbsent || templateId != null) {
      map['template_id'] = Variable<String>(templateId);
    }
    map['maintenance_type'] = Variable<String>(maintenanceType);
    map['title'] = Variable<String>(title);
    map['cost_paisa'] = Variable<int>(costPaisa);
    map['quantity'] = Variable<double>(quantity);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  ServiceItemsCompanion toCompanion(bool nullToAbsent) {
    return ServiceItemsCompanion(
      id: Value(id),
      serviceRecordId: Value(serviceRecordId),
      templateId: templateId == null && nullToAbsent
          ? const Value.absent()
          : Value(templateId),
      maintenanceType: Value(maintenanceType),
      title: Value(title),
      costPaisa: Value(costPaisa),
      quantity: Value(quantity),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory ServiceItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServiceItemRow(
      id: serializer.fromJson<String>(json['id']),
      serviceRecordId: serializer.fromJson<String>(json['serviceRecordId']),
      templateId: serializer.fromJson<String?>(json['templateId']),
      maintenanceType: serializer.fromJson<String>(json['maintenanceType']),
      title: serializer.fromJson<String>(json['title']),
      costPaisa: serializer.fromJson<int>(json['costPaisa']),
      quantity: serializer.fromJson<double>(json['quantity']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'serviceRecordId': serializer.toJson<String>(serviceRecordId),
      'templateId': serializer.toJson<String?>(templateId),
      'maintenanceType': serializer.toJson<String>(maintenanceType),
      'title': serializer.toJson<String>(title),
      'costPaisa': serializer.toJson<int>(costPaisa),
      'quantity': serializer.toJson<double>(quantity),
      'note': serializer.toJson<String?>(note),
    };
  }

  ServiceItemRow copyWith({
    String? id,
    String? serviceRecordId,
    Value<String?> templateId = const Value.absent(),
    String? maintenanceType,
    String? title,
    int? costPaisa,
    double? quantity,
    Value<String?> note = const Value.absent(),
  }) => ServiceItemRow(
    id: id ?? this.id,
    serviceRecordId: serviceRecordId ?? this.serviceRecordId,
    templateId: templateId.present ? templateId.value : this.templateId,
    maintenanceType: maintenanceType ?? this.maintenanceType,
    title: title ?? this.title,
    costPaisa: costPaisa ?? this.costPaisa,
    quantity: quantity ?? this.quantity,
    note: note.present ? note.value : this.note,
  );
  ServiceItemRow copyWithCompanion(ServiceItemsCompanion data) {
    return ServiceItemRow(
      id: data.id.present ? data.id.value : this.id,
      serviceRecordId: data.serviceRecordId.present
          ? data.serviceRecordId.value
          : this.serviceRecordId,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      maintenanceType: data.maintenanceType.present
          ? data.maintenanceType.value
          : this.maintenanceType,
      title: data.title.present ? data.title.value : this.title,
      costPaisa: data.costPaisa.present ? data.costPaisa.value : this.costPaisa,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServiceItemRow(')
          ..write('id: $id, ')
          ..write('serviceRecordId: $serviceRecordId, ')
          ..write('templateId: $templateId, ')
          ..write('maintenanceType: $maintenanceType, ')
          ..write('title: $title, ')
          ..write('costPaisa: $costPaisa, ')
          ..write('quantity: $quantity, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serviceRecordId,
    templateId,
    maintenanceType,
    title,
    costPaisa,
    quantity,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceItemRow &&
          other.id == this.id &&
          other.serviceRecordId == this.serviceRecordId &&
          other.templateId == this.templateId &&
          other.maintenanceType == this.maintenanceType &&
          other.title == this.title &&
          other.costPaisa == this.costPaisa &&
          other.quantity == this.quantity &&
          other.note == this.note);
}

class ServiceItemsCompanion extends UpdateCompanion<ServiceItemRow> {
  final Value<String> id;
  final Value<String> serviceRecordId;
  final Value<String?> templateId;
  final Value<String> maintenanceType;
  final Value<String> title;
  final Value<int> costPaisa;
  final Value<double> quantity;
  final Value<String?> note;
  final Value<int> rowid;
  const ServiceItemsCompanion({
    this.id = const Value.absent(),
    this.serviceRecordId = const Value.absent(),
    this.templateId = const Value.absent(),
    this.maintenanceType = const Value.absent(),
    this.title = const Value.absent(),
    this.costPaisa = const Value.absent(),
    this.quantity = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServiceItemsCompanion.insert({
    required String id,
    required String serviceRecordId,
    this.templateId = const Value.absent(),
    required String maintenanceType,
    required String title,
    this.costPaisa = const Value.absent(),
    this.quantity = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       serviceRecordId = Value(serviceRecordId),
       maintenanceType = Value(maintenanceType),
       title = Value(title);
  static Insertable<ServiceItemRow> custom({
    Expression<String>? id,
    Expression<String>? serviceRecordId,
    Expression<String>? templateId,
    Expression<String>? maintenanceType,
    Expression<String>? title,
    Expression<int>? costPaisa,
    Expression<double>? quantity,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serviceRecordId != null) 'service_record_id': serviceRecordId,
      if (templateId != null) 'template_id': templateId,
      if (maintenanceType != null) 'maintenance_type': maintenanceType,
      if (title != null) 'title': title,
      if (costPaisa != null) 'cost_paisa': costPaisa,
      if (quantity != null) 'quantity': quantity,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServiceItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? serviceRecordId,
    Value<String?>? templateId,
    Value<String>? maintenanceType,
    Value<String>? title,
    Value<int>? costPaisa,
    Value<double>? quantity,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return ServiceItemsCompanion(
      id: id ?? this.id,
      serviceRecordId: serviceRecordId ?? this.serviceRecordId,
      templateId: templateId ?? this.templateId,
      maintenanceType: maintenanceType ?? this.maintenanceType,
      title: title ?? this.title,
      costPaisa: costPaisa ?? this.costPaisa,
      quantity: quantity ?? this.quantity,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (serviceRecordId.present) {
      map['service_record_id'] = Variable<String>(serviceRecordId.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (maintenanceType.present) {
      map['maintenance_type'] = Variable<String>(maintenanceType.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (costPaisa.present) {
      map['cost_paisa'] = Variable<int>(costPaisa.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceItemsCompanion(')
          ..write('id: $id, ')
          ..write('serviceRecordId: $serviceRecordId, ')
          ..write('templateId: $templateId, ')
          ..write('maintenanceType: $maintenanceType, ')
          ..write('title: $title, ')
          ..write('costPaisa: $costPaisa, ')
          ..write('quantity: $quantity, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OilChangesTable extends OilChanges
    with TableInfo<$OilChangesTable, OilChangeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OilChangesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  static const VerificationMeta _occurredOnMeta = const VerificationMeta(
    'occurredOn',
  );
  @override
  late final GeneratedColumn<DateTime> occurredOn = GeneratedColumn<DateTime>(
    'occurred_on',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerMeta = const VerificationMeta(
    'odometer',
  );
  @override
  late final GeneratedColumn<int> odometer = GeneratedColumn<int>(
    'odometer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _viscosityMeta = const VerificationMeta(
    'viscosity',
  );
  @override
  late final GeneratedColumn<String> viscosity = GeneratedColumn<String>(
    'viscosity',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMlMeta = const VerificationMeta(
    'quantityMl',
  );
  @override
  late final GeneratedColumn<int> quantityMl = GeneratedColumn<int>(
    'quantity_ml',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _costPaisaMeta = const VerificationMeta(
    'costPaisa',
  );
  @override
  late final GeneratedColumn<int> costPaisa = GeneratedColumn<int>(
    'cost_paisa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _filterChangedMeta = const VerificationMeta(
    'filterChanged',
  );
  @override
  late final GeneratedColumn<bool> filterChanged = GeneratedColumn<bool>(
    'filter_changed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("filter_changed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _vendorNameMeta = const VerificationMeta(
    'vendorName',
  );
  @override
  late final GeneratedColumn<String> vendorName = GeneratedColumn<String>(
    'vendor_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextDueDateMeta = const VerificationMeta(
    'nextDueDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextDueDate = GeneratedColumn<DateTime>(
    'next_due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextDueOdometerMeta = const VerificationMeta(
    'nextDueOdometer',
  );
  @override
  late final GeneratedColumn<int> nextDueOdometer = GeneratedColumn<int>(
    'next_due_odometer',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serviceRecordIdMeta = const VerificationMeta(
    'serviceRecordId',
  );
  @override
  late final GeneratedColumn<String> serviceRecordId = GeneratedColumn<String>(
    'service_record_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES service_records (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    occurredOn,
    odometer,
    brand,
    productName,
    viscosity,
    quantityMl,
    costPaisa,
    filterChanged,
    vendorName,
    nextDueDate,
    nextDueOdometer,
    note,
    serviceRecordId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'oil_changes';
  @override
  VerificationContext validateIntegrity(
    Insertable<OilChangeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('occurred_on')) {
      context.handle(
        _occurredOnMeta,
        occurredOn.isAcceptableOrUnknown(data['occurred_on']!, _occurredOnMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredOnMeta);
    }
    if (data.containsKey('odometer')) {
      context.handle(
        _odometerMeta,
        odometer.isAcceptableOrUnknown(data['odometer']!, _odometerMeta),
      );
    } else if (isInserting) {
      context.missing(_odometerMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    }
    if (data.containsKey('viscosity')) {
      context.handle(
        _viscosityMeta,
        viscosity.isAcceptableOrUnknown(data['viscosity']!, _viscosityMeta),
      );
    }
    if (data.containsKey('quantity_ml')) {
      context.handle(
        _quantityMlMeta,
        quantityMl.isAcceptableOrUnknown(data['quantity_ml']!, _quantityMlMeta),
      );
    }
    if (data.containsKey('cost_paisa')) {
      context.handle(
        _costPaisaMeta,
        costPaisa.isAcceptableOrUnknown(data['cost_paisa']!, _costPaisaMeta),
      );
    }
    if (data.containsKey('filter_changed')) {
      context.handle(
        _filterChangedMeta,
        filterChanged.isAcceptableOrUnknown(
          data['filter_changed']!,
          _filterChangedMeta,
        ),
      );
    }
    if (data.containsKey('vendor_name')) {
      context.handle(
        _vendorNameMeta,
        vendorName.isAcceptableOrUnknown(data['vendor_name']!, _vendorNameMeta),
      );
    }
    if (data.containsKey('next_due_date')) {
      context.handle(
        _nextDueDateMeta,
        nextDueDate.isAcceptableOrUnknown(
          data['next_due_date']!,
          _nextDueDateMeta,
        ),
      );
    }
    if (data.containsKey('next_due_odometer')) {
      context.handle(
        _nextDueOdometerMeta,
        nextDueOdometer.isAcceptableOrUnknown(
          data['next_due_odometer']!,
          _nextDueOdometerMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('service_record_id')) {
      context.handle(
        _serviceRecordIdMeta,
        serviceRecordId.isAcceptableOrUnknown(
          data['service_record_id']!,
          _serviceRecordIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OilChangeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OilChangeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      occurredOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_on'],
      )!,
      odometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odometer'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      ),
      viscosity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}viscosity'],
      ),
      quantityMl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity_ml'],
      ),
      costPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_paisa'],
      )!,
      filterChanged: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}filter_changed'],
      )!,
      vendorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vendor_name'],
      ),
      nextDueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_due_date'],
      ),
      nextDueOdometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_due_odometer'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      serviceRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_record_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $OilChangesTable createAlias(String alias) {
    return $OilChangesTable(attachedDatabase, alias);
  }
}

class OilChangeRow extends DataClass implements Insertable<OilChangeRow> {
  final String id;
  final String vehicleId;
  final DateTime occurredOn;
  final int odometer;
  final String? brand;
  final String? productName;
  final String? viscosity;

  /// Quantity in milliliters.
  final int? quantityMl;
  final int costPaisa;
  final bool filterChanged;
  final String? vendorName;
  final DateTime? nextDueDate;
  final int? nextDueOdometer;
  final String? note;
  final String? serviceRecordId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const OilChangeRow({
    required this.id,
    required this.vehicleId,
    required this.occurredOn,
    required this.odometer,
    this.brand,
    this.productName,
    this.viscosity,
    this.quantityMl,
    required this.costPaisa,
    required this.filterChanged,
    this.vendorName,
    this.nextDueDate,
    this.nextDueOdometer,
    this.note,
    this.serviceRecordId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['occurred_on'] = Variable<DateTime>(occurredOn);
    map['odometer'] = Variable<int>(odometer);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || productName != null) {
      map['product_name'] = Variable<String>(productName);
    }
    if (!nullToAbsent || viscosity != null) {
      map['viscosity'] = Variable<String>(viscosity);
    }
    if (!nullToAbsent || quantityMl != null) {
      map['quantity_ml'] = Variable<int>(quantityMl);
    }
    map['cost_paisa'] = Variable<int>(costPaisa);
    map['filter_changed'] = Variable<bool>(filterChanged);
    if (!nullToAbsent || vendorName != null) {
      map['vendor_name'] = Variable<String>(vendorName);
    }
    if (!nullToAbsent || nextDueDate != null) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate);
    }
    if (!nullToAbsent || nextDueOdometer != null) {
      map['next_due_odometer'] = Variable<int>(nextDueOdometer);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || serviceRecordId != null) {
      map['service_record_id'] = Variable<String>(serviceRecordId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  OilChangesCompanion toCompanion(bool nullToAbsent) {
    return OilChangesCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      occurredOn: Value(occurredOn),
      odometer: Value(odometer),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      productName: productName == null && nullToAbsent
          ? const Value.absent()
          : Value(productName),
      viscosity: viscosity == null && nullToAbsent
          ? const Value.absent()
          : Value(viscosity),
      quantityMl: quantityMl == null && nullToAbsent
          ? const Value.absent()
          : Value(quantityMl),
      costPaisa: Value(costPaisa),
      filterChanged: Value(filterChanged),
      vendorName: vendorName == null && nullToAbsent
          ? const Value.absent()
          : Value(vendorName),
      nextDueDate: nextDueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextDueDate),
      nextDueOdometer: nextDueOdometer == null && nullToAbsent
          ? const Value.absent()
          : Value(nextDueOdometer),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      serviceRecordId: serviceRecordId == null && nullToAbsent
          ? const Value.absent()
          : Value(serviceRecordId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory OilChangeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OilChangeRow(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      occurredOn: serializer.fromJson<DateTime>(json['occurredOn']),
      odometer: serializer.fromJson<int>(json['odometer']),
      brand: serializer.fromJson<String?>(json['brand']),
      productName: serializer.fromJson<String?>(json['productName']),
      viscosity: serializer.fromJson<String?>(json['viscosity']),
      quantityMl: serializer.fromJson<int?>(json['quantityMl']),
      costPaisa: serializer.fromJson<int>(json['costPaisa']),
      filterChanged: serializer.fromJson<bool>(json['filterChanged']),
      vendorName: serializer.fromJson<String?>(json['vendorName']),
      nextDueDate: serializer.fromJson<DateTime?>(json['nextDueDate']),
      nextDueOdometer: serializer.fromJson<int?>(json['nextDueOdometer']),
      note: serializer.fromJson<String?>(json['note']),
      serviceRecordId: serializer.fromJson<String?>(json['serviceRecordId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'occurredOn': serializer.toJson<DateTime>(occurredOn),
      'odometer': serializer.toJson<int>(odometer),
      'brand': serializer.toJson<String?>(brand),
      'productName': serializer.toJson<String?>(productName),
      'viscosity': serializer.toJson<String?>(viscosity),
      'quantityMl': serializer.toJson<int?>(quantityMl),
      'costPaisa': serializer.toJson<int>(costPaisa),
      'filterChanged': serializer.toJson<bool>(filterChanged),
      'vendorName': serializer.toJson<String?>(vendorName),
      'nextDueDate': serializer.toJson<DateTime?>(nextDueDate),
      'nextDueOdometer': serializer.toJson<int?>(nextDueOdometer),
      'note': serializer.toJson<String?>(note),
      'serviceRecordId': serializer.toJson<String?>(serviceRecordId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  OilChangeRow copyWith({
    String? id,
    String? vehicleId,
    DateTime? occurredOn,
    int? odometer,
    Value<String?> brand = const Value.absent(),
    Value<String?> productName = const Value.absent(),
    Value<String?> viscosity = const Value.absent(),
    Value<int?> quantityMl = const Value.absent(),
    int? costPaisa,
    bool? filterChanged,
    Value<String?> vendorName = const Value.absent(),
    Value<DateTime?> nextDueDate = const Value.absent(),
    Value<int?> nextDueOdometer = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<String?> serviceRecordId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => OilChangeRow(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    occurredOn: occurredOn ?? this.occurredOn,
    odometer: odometer ?? this.odometer,
    brand: brand.present ? brand.value : this.brand,
    productName: productName.present ? productName.value : this.productName,
    viscosity: viscosity.present ? viscosity.value : this.viscosity,
    quantityMl: quantityMl.present ? quantityMl.value : this.quantityMl,
    costPaisa: costPaisa ?? this.costPaisa,
    filterChanged: filterChanged ?? this.filterChanged,
    vendorName: vendorName.present ? vendorName.value : this.vendorName,
    nextDueDate: nextDueDate.present ? nextDueDate.value : this.nextDueDate,
    nextDueOdometer: nextDueOdometer.present
        ? nextDueOdometer.value
        : this.nextDueOdometer,
    note: note.present ? note.value : this.note,
    serviceRecordId: serviceRecordId.present
        ? serviceRecordId.value
        : this.serviceRecordId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  OilChangeRow copyWithCompanion(OilChangesCompanion data) {
    return OilChangeRow(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      occurredOn: data.occurredOn.present
          ? data.occurredOn.value
          : this.occurredOn,
      odometer: data.odometer.present ? data.odometer.value : this.odometer,
      brand: data.brand.present ? data.brand.value : this.brand,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      viscosity: data.viscosity.present ? data.viscosity.value : this.viscosity,
      quantityMl: data.quantityMl.present
          ? data.quantityMl.value
          : this.quantityMl,
      costPaisa: data.costPaisa.present ? data.costPaisa.value : this.costPaisa,
      filterChanged: data.filterChanged.present
          ? data.filterChanged.value
          : this.filterChanged,
      vendorName: data.vendorName.present
          ? data.vendorName.value
          : this.vendorName,
      nextDueDate: data.nextDueDate.present
          ? data.nextDueDate.value
          : this.nextDueDate,
      nextDueOdometer: data.nextDueOdometer.present
          ? data.nextDueOdometer.value
          : this.nextDueOdometer,
      note: data.note.present ? data.note.value : this.note,
      serviceRecordId: data.serviceRecordId.present
          ? data.serviceRecordId.value
          : this.serviceRecordId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OilChangeRow(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('occurredOn: $occurredOn, ')
          ..write('odometer: $odometer, ')
          ..write('brand: $brand, ')
          ..write('productName: $productName, ')
          ..write('viscosity: $viscosity, ')
          ..write('quantityMl: $quantityMl, ')
          ..write('costPaisa: $costPaisa, ')
          ..write('filterChanged: $filterChanged, ')
          ..write('vendorName: $vendorName, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('nextDueOdometer: $nextDueOdometer, ')
          ..write('note: $note, ')
          ..write('serviceRecordId: $serviceRecordId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    occurredOn,
    odometer,
    brand,
    productName,
    viscosity,
    quantityMl,
    costPaisa,
    filterChanged,
    vendorName,
    nextDueDate,
    nextDueOdometer,
    note,
    serviceRecordId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OilChangeRow &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.occurredOn == this.occurredOn &&
          other.odometer == this.odometer &&
          other.brand == this.brand &&
          other.productName == this.productName &&
          other.viscosity == this.viscosity &&
          other.quantityMl == this.quantityMl &&
          other.costPaisa == this.costPaisa &&
          other.filterChanged == this.filterChanged &&
          other.vendorName == this.vendorName &&
          other.nextDueDate == this.nextDueDate &&
          other.nextDueOdometer == this.nextDueOdometer &&
          other.note == this.note &&
          other.serviceRecordId == this.serviceRecordId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class OilChangesCompanion extends UpdateCompanion<OilChangeRow> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<DateTime> occurredOn;
  final Value<int> odometer;
  final Value<String?> brand;
  final Value<String?> productName;
  final Value<String?> viscosity;
  final Value<int?> quantityMl;
  final Value<int> costPaisa;
  final Value<bool> filterChanged;
  final Value<String?> vendorName;
  final Value<DateTime?> nextDueDate;
  final Value<int?> nextDueOdometer;
  final Value<String?> note;
  final Value<String?> serviceRecordId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const OilChangesCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.occurredOn = const Value.absent(),
    this.odometer = const Value.absent(),
    this.brand = const Value.absent(),
    this.productName = const Value.absent(),
    this.viscosity = const Value.absent(),
    this.quantityMl = const Value.absent(),
    this.costPaisa = const Value.absent(),
    this.filterChanged = const Value.absent(),
    this.vendorName = const Value.absent(),
    this.nextDueDate = const Value.absent(),
    this.nextDueOdometer = const Value.absent(),
    this.note = const Value.absent(),
    this.serviceRecordId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OilChangesCompanion.insert({
    required String id,
    required String vehicleId,
    required DateTime occurredOn,
    required int odometer,
    this.brand = const Value.absent(),
    this.productName = const Value.absent(),
    this.viscosity = const Value.absent(),
    this.quantityMl = const Value.absent(),
    this.costPaisa = const Value.absent(),
    this.filterChanged = const Value.absent(),
    this.vendorName = const Value.absent(),
    this.nextDueDate = const Value.absent(),
    this.nextDueOdometer = const Value.absent(),
    this.note = const Value.absent(),
    this.serviceRecordId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       occurredOn = Value(occurredOn),
       odometer = Value(odometer),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<OilChangeRow> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<DateTime>? occurredOn,
    Expression<int>? odometer,
    Expression<String>? brand,
    Expression<String>? productName,
    Expression<String>? viscosity,
    Expression<int>? quantityMl,
    Expression<int>? costPaisa,
    Expression<bool>? filterChanged,
    Expression<String>? vendorName,
    Expression<DateTime>? nextDueDate,
    Expression<int>? nextDueOdometer,
    Expression<String>? note,
    Expression<String>? serviceRecordId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (occurredOn != null) 'occurred_on': occurredOn,
      if (odometer != null) 'odometer': odometer,
      if (brand != null) 'brand': brand,
      if (productName != null) 'product_name': productName,
      if (viscosity != null) 'viscosity': viscosity,
      if (quantityMl != null) 'quantity_ml': quantityMl,
      if (costPaisa != null) 'cost_paisa': costPaisa,
      if (filterChanged != null) 'filter_changed': filterChanged,
      if (vendorName != null) 'vendor_name': vendorName,
      if (nextDueDate != null) 'next_due_date': nextDueDate,
      if (nextDueOdometer != null) 'next_due_odometer': nextDueOdometer,
      if (note != null) 'note': note,
      if (serviceRecordId != null) 'service_record_id': serviceRecordId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OilChangesCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<DateTime>? occurredOn,
    Value<int>? odometer,
    Value<String?>? brand,
    Value<String?>? productName,
    Value<String?>? viscosity,
    Value<int?>? quantityMl,
    Value<int>? costPaisa,
    Value<bool>? filterChanged,
    Value<String?>? vendorName,
    Value<DateTime?>? nextDueDate,
    Value<int?>? nextDueOdometer,
    Value<String?>? note,
    Value<String?>? serviceRecordId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return OilChangesCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      occurredOn: occurredOn ?? this.occurredOn,
      odometer: odometer ?? this.odometer,
      brand: brand ?? this.brand,
      productName: productName ?? this.productName,
      viscosity: viscosity ?? this.viscosity,
      quantityMl: quantityMl ?? this.quantityMl,
      costPaisa: costPaisa ?? this.costPaisa,
      filterChanged: filterChanged ?? this.filterChanged,
      vendorName: vendorName ?? this.vendorName,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      nextDueOdometer: nextDueOdometer ?? this.nextDueOdometer,
      note: note ?? this.note,
      serviceRecordId: serviceRecordId ?? this.serviceRecordId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (occurredOn.present) {
      map['occurred_on'] = Variable<DateTime>(occurredOn.value);
    }
    if (odometer.present) {
      map['odometer'] = Variable<int>(odometer.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (viscosity.present) {
      map['viscosity'] = Variable<String>(viscosity.value);
    }
    if (quantityMl.present) {
      map['quantity_ml'] = Variable<int>(quantityMl.value);
    }
    if (costPaisa.present) {
      map['cost_paisa'] = Variable<int>(costPaisa.value);
    }
    if (filterChanged.present) {
      map['filter_changed'] = Variable<bool>(filterChanged.value);
    }
    if (vendorName.present) {
      map['vendor_name'] = Variable<String>(vendorName.value);
    }
    if (nextDueDate.present) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate.value);
    }
    if (nextDueOdometer.present) {
      map['next_due_odometer'] = Variable<int>(nextDueOdometer.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (serviceRecordId.present) {
      map['service_record_id'] = Variable<String>(serviceRecordId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OilChangesCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('occurredOn: $occurredOn, ')
          ..write('odometer: $odometer, ')
          ..write('brand: $brand, ')
          ..write('productName: $productName, ')
          ..write('viscosity: $viscosity, ')
          ..write('quantityMl: $quantityMl, ')
          ..write('costPaisa: $costPaisa, ')
          ..write('filterChanged: $filterChanged, ')
          ..write('vendorName: $vendorName, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('nextDueOdometer: $nextDueOdometer, ')
          ..write('note: $note, ')
          ..write('serviceRecordId: $serviceRecordId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RepairsTable extends Repairs with TableInfo<$RepairsTable, RepairRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepairsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  static const VerificationMeta _repairDateMeta = const VerificationMeta(
    'repairDate',
  );
  @override
  late final GeneratedColumn<DateTime> repairDate = GeneratedColumn<DateTime>(
    'repair_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerMeta = const VerificationMeta(
    'odometer',
  );
  @override
  late final GeneratedColumn<int> odometer = GeneratedColumn<int>(
    'odometer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _problemDescriptionMeta =
      const VerificationMeta('problemDescription');
  @override
  late final GeneratedColumn<String> problemDescription =
      GeneratedColumn<String>(
        'problem_description',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _diagnosisMeta = const VerificationMeta(
    'diagnosis',
  );
  @override
  late final GeneratedColumn<String> diagnosis = GeneratedColumn<String>(
    'diagnosis',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workPerformedMeta = const VerificationMeta(
    'workPerformed',
  );
  @override
  late final GeneratedColumn<String> workPerformed = GeneratedColumn<String>(
    'work_performed',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vendorNameMeta = const VerificationMeta(
    'vendorName',
  );
  @override
  late final GeneratedColumn<String> vendorName = GeneratedColumn<String>(
    'vendor_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _laborCostPaisaMeta = const VerificationMeta(
    'laborCostPaisa',
  );
  @override
  late final GeneratedColumn<int> laborCostPaisa = GeneratedColumn<int>(
    'labor_cost_paisa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _partsCostPaisaMeta = const VerificationMeta(
    'partsCostPaisa',
  );
  @override
  late final GeneratedColumn<int> partsCostPaisa = GeneratedColumn<int>(
    'parts_cost_paisa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalCostPaisaMeta = const VerificationMeta(
    'totalCostPaisa',
  );
  @override
  late final GeneratedColumn<int> totalCostPaisa = GeneratedColumn<int>(
    'total_cost_paisa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _warrantyEndDateMeta = const VerificationMeta(
    'warrantyEndDate',
  );
  @override
  late final GeneratedColumn<DateTime> warrantyEndDate =
      GeneratedColumn<DateTime>(
        'warranty_end_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _followUpDateMeta = const VerificationMeta(
    'followUpDate',
  );
  @override
  late final GeneratedColumn<DateTime> followUpDate = GeneratedColumn<DateTime>(
    'follow_up_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    repairDate,
    odometer,
    category,
    problemDescription,
    diagnosis,
    workPerformed,
    vendorName,
    laborCostPaisa,
    partsCostPaisa,
    totalCostPaisa,
    warrantyEndDate,
    followUpDate,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repairs';
  @override
  VerificationContext validateIntegrity(
    Insertable<RepairRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('repair_date')) {
      context.handle(
        _repairDateMeta,
        repairDate.isAcceptableOrUnknown(data['repair_date']!, _repairDateMeta),
      );
    } else if (isInserting) {
      context.missing(_repairDateMeta);
    }
    if (data.containsKey('odometer')) {
      context.handle(
        _odometerMeta,
        odometer.isAcceptableOrUnknown(data['odometer']!, _odometerMeta),
      );
    } else if (isInserting) {
      context.missing(_odometerMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('problem_description')) {
      context.handle(
        _problemDescriptionMeta,
        problemDescription.isAcceptableOrUnknown(
          data['problem_description']!,
          _problemDescriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_problemDescriptionMeta);
    }
    if (data.containsKey('diagnosis')) {
      context.handle(
        _diagnosisMeta,
        diagnosis.isAcceptableOrUnknown(data['diagnosis']!, _diagnosisMeta),
      );
    }
    if (data.containsKey('work_performed')) {
      context.handle(
        _workPerformedMeta,
        workPerformed.isAcceptableOrUnknown(
          data['work_performed']!,
          _workPerformedMeta,
        ),
      );
    }
    if (data.containsKey('vendor_name')) {
      context.handle(
        _vendorNameMeta,
        vendorName.isAcceptableOrUnknown(data['vendor_name']!, _vendorNameMeta),
      );
    }
    if (data.containsKey('labor_cost_paisa')) {
      context.handle(
        _laborCostPaisaMeta,
        laborCostPaisa.isAcceptableOrUnknown(
          data['labor_cost_paisa']!,
          _laborCostPaisaMeta,
        ),
      );
    }
    if (data.containsKey('parts_cost_paisa')) {
      context.handle(
        _partsCostPaisaMeta,
        partsCostPaisa.isAcceptableOrUnknown(
          data['parts_cost_paisa']!,
          _partsCostPaisaMeta,
        ),
      );
    }
    if (data.containsKey('total_cost_paisa')) {
      context.handle(
        _totalCostPaisaMeta,
        totalCostPaisa.isAcceptableOrUnknown(
          data['total_cost_paisa']!,
          _totalCostPaisaMeta,
        ),
      );
    }
    if (data.containsKey('warranty_end_date')) {
      context.handle(
        _warrantyEndDateMeta,
        warrantyEndDate.isAcceptableOrUnknown(
          data['warranty_end_date']!,
          _warrantyEndDateMeta,
        ),
      );
    }
    if (data.containsKey('follow_up_date')) {
      context.handle(
        _followUpDateMeta,
        followUpDate.isAcceptableOrUnknown(
          data['follow_up_date']!,
          _followUpDateMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RepairRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RepairRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      repairDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}repair_date'],
      )!,
      odometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odometer'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      problemDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}problem_description'],
      )!,
      diagnosis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}diagnosis'],
      ),
      workPerformed: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_performed'],
      ),
      vendorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vendor_name'],
      ),
      laborCostPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}labor_cost_paisa'],
      )!,
      partsCostPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parts_cost_paisa'],
      )!,
      totalCostPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_cost_paisa'],
      )!,
      warrantyEndDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}warranty_end_date'],
      ),
      followUpDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}follow_up_date'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RepairsTable createAlias(String alias) {
    return $RepairsTable(attachedDatabase, alias);
  }
}

class RepairRow extends DataClass implements Insertable<RepairRow> {
  final String id;
  final String vehicleId;
  final DateTime repairDate;
  final int odometer;
  final String category;
  final String problemDescription;
  final String? diagnosis;
  final String? workPerformed;
  final String? vendorName;
  final int laborCostPaisa;
  final int partsCostPaisa;
  final int totalCostPaisa;
  final DateTime? warrantyEndDate;
  final DateTime? followUpDate;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RepairRow({
    required this.id,
    required this.vehicleId,
    required this.repairDate,
    required this.odometer,
    required this.category,
    required this.problemDescription,
    this.diagnosis,
    this.workPerformed,
    this.vendorName,
    required this.laborCostPaisa,
    required this.partsCostPaisa,
    required this.totalCostPaisa,
    this.warrantyEndDate,
    this.followUpDate,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['repair_date'] = Variable<DateTime>(repairDate);
    map['odometer'] = Variable<int>(odometer);
    map['category'] = Variable<String>(category);
    map['problem_description'] = Variable<String>(problemDescription);
    if (!nullToAbsent || diagnosis != null) {
      map['diagnosis'] = Variable<String>(diagnosis);
    }
    if (!nullToAbsent || workPerformed != null) {
      map['work_performed'] = Variable<String>(workPerformed);
    }
    if (!nullToAbsent || vendorName != null) {
      map['vendor_name'] = Variable<String>(vendorName);
    }
    map['labor_cost_paisa'] = Variable<int>(laborCostPaisa);
    map['parts_cost_paisa'] = Variable<int>(partsCostPaisa);
    map['total_cost_paisa'] = Variable<int>(totalCostPaisa);
    if (!nullToAbsent || warrantyEndDate != null) {
      map['warranty_end_date'] = Variable<DateTime>(warrantyEndDate);
    }
    if (!nullToAbsent || followUpDate != null) {
      map['follow_up_date'] = Variable<DateTime>(followUpDate);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RepairsCompanion toCompanion(bool nullToAbsent) {
    return RepairsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      repairDate: Value(repairDate),
      odometer: Value(odometer),
      category: Value(category),
      problemDescription: Value(problemDescription),
      diagnosis: diagnosis == null && nullToAbsent
          ? const Value.absent()
          : Value(diagnosis),
      workPerformed: workPerformed == null && nullToAbsent
          ? const Value.absent()
          : Value(workPerformed),
      vendorName: vendorName == null && nullToAbsent
          ? const Value.absent()
          : Value(vendorName),
      laborCostPaisa: Value(laborCostPaisa),
      partsCostPaisa: Value(partsCostPaisa),
      totalCostPaisa: Value(totalCostPaisa),
      warrantyEndDate: warrantyEndDate == null && nullToAbsent
          ? const Value.absent()
          : Value(warrantyEndDate),
      followUpDate: followUpDate == null && nullToAbsent
          ? const Value.absent()
          : Value(followUpDate),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RepairRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RepairRow(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      repairDate: serializer.fromJson<DateTime>(json['repairDate']),
      odometer: serializer.fromJson<int>(json['odometer']),
      category: serializer.fromJson<String>(json['category']),
      problemDescription: serializer.fromJson<String>(
        json['problemDescription'],
      ),
      diagnosis: serializer.fromJson<String?>(json['diagnosis']),
      workPerformed: serializer.fromJson<String?>(json['workPerformed']),
      vendorName: serializer.fromJson<String?>(json['vendorName']),
      laborCostPaisa: serializer.fromJson<int>(json['laborCostPaisa']),
      partsCostPaisa: serializer.fromJson<int>(json['partsCostPaisa']),
      totalCostPaisa: serializer.fromJson<int>(json['totalCostPaisa']),
      warrantyEndDate: serializer.fromJson<DateTime?>(json['warrantyEndDate']),
      followUpDate: serializer.fromJson<DateTime?>(json['followUpDate']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'repairDate': serializer.toJson<DateTime>(repairDate),
      'odometer': serializer.toJson<int>(odometer),
      'category': serializer.toJson<String>(category),
      'problemDescription': serializer.toJson<String>(problemDescription),
      'diagnosis': serializer.toJson<String?>(diagnosis),
      'workPerformed': serializer.toJson<String?>(workPerformed),
      'vendorName': serializer.toJson<String?>(vendorName),
      'laborCostPaisa': serializer.toJson<int>(laborCostPaisa),
      'partsCostPaisa': serializer.toJson<int>(partsCostPaisa),
      'totalCostPaisa': serializer.toJson<int>(totalCostPaisa),
      'warrantyEndDate': serializer.toJson<DateTime?>(warrantyEndDate),
      'followUpDate': serializer.toJson<DateTime?>(followUpDate),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RepairRow copyWith({
    String? id,
    String? vehicleId,
    DateTime? repairDate,
    int? odometer,
    String? category,
    String? problemDescription,
    Value<String?> diagnosis = const Value.absent(),
    Value<String?> workPerformed = const Value.absent(),
    Value<String?> vendorName = const Value.absent(),
    int? laborCostPaisa,
    int? partsCostPaisa,
    int? totalCostPaisa,
    Value<DateTime?> warrantyEndDate = const Value.absent(),
    Value<DateTime?> followUpDate = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => RepairRow(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    repairDate: repairDate ?? this.repairDate,
    odometer: odometer ?? this.odometer,
    category: category ?? this.category,
    problemDescription: problemDescription ?? this.problemDescription,
    diagnosis: diagnosis.present ? diagnosis.value : this.diagnosis,
    workPerformed: workPerformed.present
        ? workPerformed.value
        : this.workPerformed,
    vendorName: vendorName.present ? vendorName.value : this.vendorName,
    laborCostPaisa: laborCostPaisa ?? this.laborCostPaisa,
    partsCostPaisa: partsCostPaisa ?? this.partsCostPaisa,
    totalCostPaisa: totalCostPaisa ?? this.totalCostPaisa,
    warrantyEndDate: warrantyEndDate.present
        ? warrantyEndDate.value
        : this.warrantyEndDate,
    followUpDate: followUpDate.present ? followUpDate.value : this.followUpDate,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RepairRow copyWithCompanion(RepairsCompanion data) {
    return RepairRow(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      repairDate: data.repairDate.present
          ? data.repairDate.value
          : this.repairDate,
      odometer: data.odometer.present ? data.odometer.value : this.odometer,
      category: data.category.present ? data.category.value : this.category,
      problemDescription: data.problemDescription.present
          ? data.problemDescription.value
          : this.problemDescription,
      diagnosis: data.diagnosis.present ? data.diagnosis.value : this.diagnosis,
      workPerformed: data.workPerformed.present
          ? data.workPerformed.value
          : this.workPerformed,
      vendorName: data.vendorName.present
          ? data.vendorName.value
          : this.vendorName,
      laborCostPaisa: data.laborCostPaisa.present
          ? data.laborCostPaisa.value
          : this.laborCostPaisa,
      partsCostPaisa: data.partsCostPaisa.present
          ? data.partsCostPaisa.value
          : this.partsCostPaisa,
      totalCostPaisa: data.totalCostPaisa.present
          ? data.totalCostPaisa.value
          : this.totalCostPaisa,
      warrantyEndDate: data.warrantyEndDate.present
          ? data.warrantyEndDate.value
          : this.warrantyEndDate,
      followUpDate: data.followUpDate.present
          ? data.followUpDate.value
          : this.followUpDate,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RepairRow(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('repairDate: $repairDate, ')
          ..write('odometer: $odometer, ')
          ..write('category: $category, ')
          ..write('problemDescription: $problemDescription, ')
          ..write('diagnosis: $diagnosis, ')
          ..write('workPerformed: $workPerformed, ')
          ..write('vendorName: $vendorName, ')
          ..write('laborCostPaisa: $laborCostPaisa, ')
          ..write('partsCostPaisa: $partsCostPaisa, ')
          ..write('totalCostPaisa: $totalCostPaisa, ')
          ..write('warrantyEndDate: $warrantyEndDate, ')
          ..write('followUpDate: $followUpDate, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    repairDate,
    odometer,
    category,
    problemDescription,
    diagnosis,
    workPerformed,
    vendorName,
    laborCostPaisa,
    partsCostPaisa,
    totalCostPaisa,
    warrantyEndDate,
    followUpDate,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RepairRow &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.repairDate == this.repairDate &&
          other.odometer == this.odometer &&
          other.category == this.category &&
          other.problemDescription == this.problemDescription &&
          other.diagnosis == this.diagnosis &&
          other.workPerformed == this.workPerformed &&
          other.vendorName == this.vendorName &&
          other.laborCostPaisa == this.laborCostPaisa &&
          other.partsCostPaisa == this.partsCostPaisa &&
          other.totalCostPaisa == this.totalCostPaisa &&
          other.warrantyEndDate == this.warrantyEndDate &&
          other.followUpDate == this.followUpDate &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RepairsCompanion extends UpdateCompanion<RepairRow> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<DateTime> repairDate;
  final Value<int> odometer;
  final Value<String> category;
  final Value<String> problemDescription;
  final Value<String?> diagnosis;
  final Value<String?> workPerformed;
  final Value<String?> vendorName;
  final Value<int> laborCostPaisa;
  final Value<int> partsCostPaisa;
  final Value<int> totalCostPaisa;
  final Value<DateTime?> warrantyEndDate;
  final Value<DateTime?> followUpDate;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RepairsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.repairDate = const Value.absent(),
    this.odometer = const Value.absent(),
    this.category = const Value.absent(),
    this.problemDescription = const Value.absent(),
    this.diagnosis = const Value.absent(),
    this.workPerformed = const Value.absent(),
    this.vendorName = const Value.absent(),
    this.laborCostPaisa = const Value.absent(),
    this.partsCostPaisa = const Value.absent(),
    this.totalCostPaisa = const Value.absent(),
    this.warrantyEndDate = const Value.absent(),
    this.followUpDate = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RepairsCompanion.insert({
    required String id,
    required String vehicleId,
    required DateTime repairDate,
    required int odometer,
    required String category,
    required String problemDescription,
    this.diagnosis = const Value.absent(),
    this.workPerformed = const Value.absent(),
    this.vendorName = const Value.absent(),
    this.laborCostPaisa = const Value.absent(),
    this.partsCostPaisa = const Value.absent(),
    this.totalCostPaisa = const Value.absent(),
    this.warrantyEndDate = const Value.absent(),
    this.followUpDate = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       repairDate = Value(repairDate),
       odometer = Value(odometer),
       category = Value(category),
       problemDescription = Value(problemDescription),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<RepairRow> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<DateTime>? repairDate,
    Expression<int>? odometer,
    Expression<String>? category,
    Expression<String>? problemDescription,
    Expression<String>? diagnosis,
    Expression<String>? workPerformed,
    Expression<String>? vendorName,
    Expression<int>? laborCostPaisa,
    Expression<int>? partsCostPaisa,
    Expression<int>? totalCostPaisa,
    Expression<DateTime>? warrantyEndDate,
    Expression<DateTime>? followUpDate,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (repairDate != null) 'repair_date': repairDate,
      if (odometer != null) 'odometer': odometer,
      if (category != null) 'category': category,
      if (problemDescription != null) 'problem_description': problemDescription,
      if (diagnosis != null) 'diagnosis': diagnosis,
      if (workPerformed != null) 'work_performed': workPerformed,
      if (vendorName != null) 'vendor_name': vendorName,
      if (laborCostPaisa != null) 'labor_cost_paisa': laborCostPaisa,
      if (partsCostPaisa != null) 'parts_cost_paisa': partsCostPaisa,
      if (totalCostPaisa != null) 'total_cost_paisa': totalCostPaisa,
      if (warrantyEndDate != null) 'warranty_end_date': warrantyEndDate,
      if (followUpDate != null) 'follow_up_date': followUpDate,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RepairsCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<DateTime>? repairDate,
    Value<int>? odometer,
    Value<String>? category,
    Value<String>? problemDescription,
    Value<String?>? diagnosis,
    Value<String?>? workPerformed,
    Value<String?>? vendorName,
    Value<int>? laborCostPaisa,
    Value<int>? partsCostPaisa,
    Value<int>? totalCostPaisa,
    Value<DateTime?>? warrantyEndDate,
    Value<DateTime?>? followUpDate,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RepairsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      repairDate: repairDate ?? this.repairDate,
      odometer: odometer ?? this.odometer,
      category: category ?? this.category,
      problemDescription: problemDescription ?? this.problemDescription,
      diagnosis: diagnosis ?? this.diagnosis,
      workPerformed: workPerformed ?? this.workPerformed,
      vendorName: vendorName ?? this.vendorName,
      laborCostPaisa: laborCostPaisa ?? this.laborCostPaisa,
      partsCostPaisa: partsCostPaisa ?? this.partsCostPaisa,
      totalCostPaisa: totalCostPaisa ?? this.totalCostPaisa,
      warrantyEndDate: warrantyEndDate ?? this.warrantyEndDate,
      followUpDate: followUpDate ?? this.followUpDate,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (repairDate.present) {
      map['repair_date'] = Variable<DateTime>(repairDate.value);
    }
    if (odometer.present) {
      map['odometer'] = Variable<int>(odometer.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (problemDescription.present) {
      map['problem_description'] = Variable<String>(problemDescription.value);
    }
    if (diagnosis.present) {
      map['diagnosis'] = Variable<String>(diagnosis.value);
    }
    if (workPerformed.present) {
      map['work_performed'] = Variable<String>(workPerformed.value);
    }
    if (vendorName.present) {
      map['vendor_name'] = Variable<String>(vendorName.value);
    }
    if (laborCostPaisa.present) {
      map['labor_cost_paisa'] = Variable<int>(laborCostPaisa.value);
    }
    if (partsCostPaisa.present) {
      map['parts_cost_paisa'] = Variable<int>(partsCostPaisa.value);
    }
    if (totalCostPaisa.present) {
      map['total_cost_paisa'] = Variable<int>(totalCostPaisa.value);
    }
    if (warrantyEndDate.present) {
      map['warranty_end_date'] = Variable<DateTime>(warrantyEndDate.value);
    }
    if (followUpDate.present) {
      map['follow_up_date'] = Variable<DateTime>(followUpDate.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepairsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('repairDate: $repairDate, ')
          ..write('odometer: $odometer, ')
          ..write('category: $category, ')
          ..write('problemDescription: $problemDescription, ')
          ..write('diagnosis: $diagnosis, ')
          ..write('workPerformed: $workPerformed, ')
          ..write('vendorName: $vendorName, ')
          ..write('laborCostPaisa: $laborCostPaisa, ')
          ..write('partsCostPaisa: $partsCostPaisa, ')
          ..write('totalCostPaisa: $totalCostPaisa, ')
          ..write('warrantyEndDate: $warrantyEndDate, ')
          ..write('followUpDate: $followUpDate, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RepairPartsTable extends RepairParts
    with TableInfo<$RepairPartsTable, RepairPartRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepairPartsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repairIdMeta = const VerificationMeta(
    'repairId',
  );
  @override
  late final GeneratedColumn<String> repairId = GeneratedColumn<String>(
    'repair_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES repairs (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _partNameMeta = const VerificationMeta(
    'partName',
  );
  @override
  late final GeneratedColumn<String> partName = GeneratedColumn<String>(
    'part_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _partNumberMeta = const VerificationMeta(
    'partNumber',
  );
  @override
  late final GeneratedColumn<String> partNumber = GeneratedColumn<String>(
    'part_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _unitCostPaisaMeta = const VerificationMeta(
    'unitCostPaisa',
  );
  @override
  late final GeneratedColumn<int> unitCostPaisa = GeneratedColumn<int>(
    'unit_cost_paisa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalCostPaisaMeta = const VerificationMeta(
    'totalCostPaisa',
  );
  @override
  late final GeneratedColumn<int> totalCostPaisa = GeneratedColumn<int>(
    'total_cost_paisa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _warrantyEndDateMeta = const VerificationMeta(
    'warrantyEndDate',
  );
  @override
  late final GeneratedColumn<DateTime> warrantyEndDate =
      GeneratedColumn<DateTime>(
        'warranty_end_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    repairId,
    partName,
    brand,
    partNumber,
    quantity,
    unitCostPaisa,
    totalCostPaisa,
    warrantyEndDate,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repair_parts';
  @override
  VerificationContext validateIntegrity(
    Insertable<RepairPartRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('repair_id')) {
      context.handle(
        _repairIdMeta,
        repairId.isAcceptableOrUnknown(data['repair_id']!, _repairIdMeta),
      );
    } else if (isInserting) {
      context.missing(_repairIdMeta);
    }
    if (data.containsKey('part_name')) {
      context.handle(
        _partNameMeta,
        partName.isAcceptableOrUnknown(data['part_name']!, _partNameMeta),
      );
    } else if (isInserting) {
      context.missing(_partNameMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('part_number')) {
      context.handle(
        _partNumberMeta,
        partNumber.isAcceptableOrUnknown(data['part_number']!, _partNumberMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('unit_cost_paisa')) {
      context.handle(
        _unitCostPaisaMeta,
        unitCostPaisa.isAcceptableOrUnknown(
          data['unit_cost_paisa']!,
          _unitCostPaisaMeta,
        ),
      );
    }
    if (data.containsKey('total_cost_paisa')) {
      context.handle(
        _totalCostPaisaMeta,
        totalCostPaisa.isAcceptableOrUnknown(
          data['total_cost_paisa']!,
          _totalCostPaisaMeta,
        ),
      );
    }
    if (data.containsKey('warranty_end_date')) {
      context.handle(
        _warrantyEndDateMeta,
        warrantyEndDate.isAcceptableOrUnknown(
          data['warranty_end_date']!,
          _warrantyEndDateMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RepairPartRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RepairPartRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      repairId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}repair_id'],
      )!,
      partName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_name'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      partNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_number'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      unitCostPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_cost_paisa'],
      )!,
      totalCostPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_cost_paisa'],
      )!,
      warrantyEndDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}warranty_end_date'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $RepairPartsTable createAlias(String alias) {
    return $RepairPartsTable(attachedDatabase, alias);
  }
}

class RepairPartRow extends DataClass implements Insertable<RepairPartRow> {
  final String id;
  final String repairId;
  final String partName;
  final String? brand;
  final String? partNumber;
  final double quantity;
  final int unitCostPaisa;
  final int totalCostPaisa;
  final DateTime? warrantyEndDate;
  final String? note;
  const RepairPartRow({
    required this.id,
    required this.repairId,
    required this.partName,
    this.brand,
    this.partNumber,
    required this.quantity,
    required this.unitCostPaisa,
    required this.totalCostPaisa,
    this.warrantyEndDate,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['repair_id'] = Variable<String>(repairId);
    map['part_name'] = Variable<String>(partName);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || partNumber != null) {
      map['part_number'] = Variable<String>(partNumber);
    }
    map['quantity'] = Variable<double>(quantity);
    map['unit_cost_paisa'] = Variable<int>(unitCostPaisa);
    map['total_cost_paisa'] = Variable<int>(totalCostPaisa);
    if (!nullToAbsent || warrantyEndDate != null) {
      map['warranty_end_date'] = Variable<DateTime>(warrantyEndDate);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  RepairPartsCompanion toCompanion(bool nullToAbsent) {
    return RepairPartsCompanion(
      id: Value(id),
      repairId: Value(repairId),
      partName: Value(partName),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      partNumber: partNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(partNumber),
      quantity: Value(quantity),
      unitCostPaisa: Value(unitCostPaisa),
      totalCostPaisa: Value(totalCostPaisa),
      warrantyEndDate: warrantyEndDate == null && nullToAbsent
          ? const Value.absent()
          : Value(warrantyEndDate),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory RepairPartRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RepairPartRow(
      id: serializer.fromJson<String>(json['id']),
      repairId: serializer.fromJson<String>(json['repairId']),
      partName: serializer.fromJson<String>(json['partName']),
      brand: serializer.fromJson<String?>(json['brand']),
      partNumber: serializer.fromJson<String?>(json['partNumber']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitCostPaisa: serializer.fromJson<int>(json['unitCostPaisa']),
      totalCostPaisa: serializer.fromJson<int>(json['totalCostPaisa']),
      warrantyEndDate: serializer.fromJson<DateTime?>(json['warrantyEndDate']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'repairId': serializer.toJson<String>(repairId),
      'partName': serializer.toJson<String>(partName),
      'brand': serializer.toJson<String?>(brand),
      'partNumber': serializer.toJson<String?>(partNumber),
      'quantity': serializer.toJson<double>(quantity),
      'unitCostPaisa': serializer.toJson<int>(unitCostPaisa),
      'totalCostPaisa': serializer.toJson<int>(totalCostPaisa),
      'warrantyEndDate': serializer.toJson<DateTime?>(warrantyEndDate),
      'note': serializer.toJson<String?>(note),
    };
  }

  RepairPartRow copyWith({
    String? id,
    String? repairId,
    String? partName,
    Value<String?> brand = const Value.absent(),
    Value<String?> partNumber = const Value.absent(),
    double? quantity,
    int? unitCostPaisa,
    int? totalCostPaisa,
    Value<DateTime?> warrantyEndDate = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => RepairPartRow(
    id: id ?? this.id,
    repairId: repairId ?? this.repairId,
    partName: partName ?? this.partName,
    brand: brand.present ? brand.value : this.brand,
    partNumber: partNumber.present ? partNumber.value : this.partNumber,
    quantity: quantity ?? this.quantity,
    unitCostPaisa: unitCostPaisa ?? this.unitCostPaisa,
    totalCostPaisa: totalCostPaisa ?? this.totalCostPaisa,
    warrantyEndDate: warrantyEndDate.present
        ? warrantyEndDate.value
        : this.warrantyEndDate,
    note: note.present ? note.value : this.note,
  );
  RepairPartRow copyWithCompanion(RepairPartsCompanion data) {
    return RepairPartRow(
      id: data.id.present ? data.id.value : this.id,
      repairId: data.repairId.present ? data.repairId.value : this.repairId,
      partName: data.partName.present ? data.partName.value : this.partName,
      brand: data.brand.present ? data.brand.value : this.brand,
      partNumber: data.partNumber.present
          ? data.partNumber.value
          : this.partNumber,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitCostPaisa: data.unitCostPaisa.present
          ? data.unitCostPaisa.value
          : this.unitCostPaisa,
      totalCostPaisa: data.totalCostPaisa.present
          ? data.totalCostPaisa.value
          : this.totalCostPaisa,
      warrantyEndDate: data.warrantyEndDate.present
          ? data.warrantyEndDate.value
          : this.warrantyEndDate,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RepairPartRow(')
          ..write('id: $id, ')
          ..write('repairId: $repairId, ')
          ..write('partName: $partName, ')
          ..write('brand: $brand, ')
          ..write('partNumber: $partNumber, ')
          ..write('quantity: $quantity, ')
          ..write('unitCostPaisa: $unitCostPaisa, ')
          ..write('totalCostPaisa: $totalCostPaisa, ')
          ..write('warrantyEndDate: $warrantyEndDate, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    repairId,
    partName,
    brand,
    partNumber,
    quantity,
    unitCostPaisa,
    totalCostPaisa,
    warrantyEndDate,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RepairPartRow &&
          other.id == this.id &&
          other.repairId == this.repairId &&
          other.partName == this.partName &&
          other.brand == this.brand &&
          other.partNumber == this.partNumber &&
          other.quantity == this.quantity &&
          other.unitCostPaisa == this.unitCostPaisa &&
          other.totalCostPaisa == this.totalCostPaisa &&
          other.warrantyEndDate == this.warrantyEndDate &&
          other.note == this.note);
}

class RepairPartsCompanion extends UpdateCompanion<RepairPartRow> {
  final Value<String> id;
  final Value<String> repairId;
  final Value<String> partName;
  final Value<String?> brand;
  final Value<String?> partNumber;
  final Value<double> quantity;
  final Value<int> unitCostPaisa;
  final Value<int> totalCostPaisa;
  final Value<DateTime?> warrantyEndDate;
  final Value<String?> note;
  final Value<int> rowid;
  const RepairPartsCompanion({
    this.id = const Value.absent(),
    this.repairId = const Value.absent(),
    this.partName = const Value.absent(),
    this.brand = const Value.absent(),
    this.partNumber = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitCostPaisa = const Value.absent(),
    this.totalCostPaisa = const Value.absent(),
    this.warrantyEndDate = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RepairPartsCompanion.insert({
    required String id,
    required String repairId,
    required String partName,
    this.brand = const Value.absent(),
    this.partNumber = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitCostPaisa = const Value.absent(),
    this.totalCostPaisa = const Value.absent(),
    this.warrantyEndDate = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       repairId = Value(repairId),
       partName = Value(partName);
  static Insertable<RepairPartRow> custom({
    Expression<String>? id,
    Expression<String>? repairId,
    Expression<String>? partName,
    Expression<String>? brand,
    Expression<String>? partNumber,
    Expression<double>? quantity,
    Expression<int>? unitCostPaisa,
    Expression<int>? totalCostPaisa,
    Expression<DateTime>? warrantyEndDate,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (repairId != null) 'repair_id': repairId,
      if (partName != null) 'part_name': partName,
      if (brand != null) 'brand': brand,
      if (partNumber != null) 'part_number': partNumber,
      if (quantity != null) 'quantity': quantity,
      if (unitCostPaisa != null) 'unit_cost_paisa': unitCostPaisa,
      if (totalCostPaisa != null) 'total_cost_paisa': totalCostPaisa,
      if (warrantyEndDate != null) 'warranty_end_date': warrantyEndDate,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RepairPartsCompanion copyWith({
    Value<String>? id,
    Value<String>? repairId,
    Value<String>? partName,
    Value<String?>? brand,
    Value<String?>? partNumber,
    Value<double>? quantity,
    Value<int>? unitCostPaisa,
    Value<int>? totalCostPaisa,
    Value<DateTime?>? warrantyEndDate,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return RepairPartsCompanion(
      id: id ?? this.id,
      repairId: repairId ?? this.repairId,
      partName: partName ?? this.partName,
      brand: brand ?? this.brand,
      partNumber: partNumber ?? this.partNumber,
      quantity: quantity ?? this.quantity,
      unitCostPaisa: unitCostPaisa ?? this.unitCostPaisa,
      totalCostPaisa: totalCostPaisa ?? this.totalCostPaisa,
      warrantyEndDate: warrantyEndDate ?? this.warrantyEndDate,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (repairId.present) {
      map['repair_id'] = Variable<String>(repairId.value);
    }
    if (partName.present) {
      map['part_name'] = Variable<String>(partName.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (partNumber.present) {
      map['part_number'] = Variable<String>(partNumber.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitCostPaisa.present) {
      map['unit_cost_paisa'] = Variable<int>(unitCostPaisa.value);
    }
    if (totalCostPaisa.present) {
      map['total_cost_paisa'] = Variable<int>(totalCostPaisa.value);
    }
    if (warrantyEndDate.present) {
      map['warranty_end_date'] = Variable<DateTime>(warrantyEndDate.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepairPartsCompanion(')
          ..write('id: $id, ')
          ..write('repairId: $repairId, ')
          ..write('partName: $partName, ')
          ..write('brand: $brand, ')
          ..write('partNumber: $partNumber, ')
          ..write('quantity: $quantity, ')
          ..write('unitCostPaisa: $unitCostPaisa, ')
          ..write('totalCostPaisa: $totalCostPaisa, ')
          ..write('warrantyEndDate: $warrantyEndDate, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VehiclePartsTable extends VehicleParts
    with TableInfo<$VehiclePartsTable, VehiclePartRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiclePartsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _partNumberMeta = const VerificationMeta(
    'partNumber',
  );
  @override
  late final GeneratedColumn<String> partNumber = GeneratedColumn<String>(
    'part_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _installedDateMeta = const VerificationMeta(
    'installedDate',
  );
  @override
  late final GeneratedColumn<DateTime> installedDate =
      GeneratedColumn<DateTime>(
        'installed_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _installedOdometerMeta = const VerificationMeta(
    'installedOdometer',
  );
  @override
  late final GeneratedColumn<int> installedOdometer = GeneratedColumn<int>(
    'installed_odometer',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _costPaisaMeta = const VerificationMeta(
    'costPaisa',
  );
  @override
  late final GeneratedColumn<int> costPaisa = GeneratedColumn<int>(
    'cost_paisa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _vendorNameMeta = const VerificationMeta(
    'vendorName',
  );
  @override
  late final GeneratedColumn<String> vendorName = GeneratedColumn<String>(
    'vendor_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _warrantyEndDateMeta = const VerificationMeta(
    'warrantyEndDate',
  );
  @override
  late final GeneratedColumn<DateTime> warrantyEndDate =
      GeneratedColumn<DateTime>(
        'warranty_end_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _replacementIntervalKmMeta =
      const VerificationMeta('replacementIntervalKm');
  @override
  late final GeneratedColumn<int> replacementIntervalKm = GeneratedColumn<int>(
    'replacement_interval_km',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _replacementIntervalDaysMeta =
      const VerificationMeta('replacementIntervalDays');
  @override
  late final GeneratedColumn<int> replacementIntervalDays =
      GeneratedColumn<int>(
        'replacement_interval_days',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    category,
    name,
    brand,
    partNumber,
    installedDate,
    installedOdometer,
    costPaisa,
    vendorName,
    warrantyEndDate,
    replacementIntervalKm,
    replacementIntervalDays,
    note,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicle_parts';
  @override
  VerificationContext validateIntegrity(
    Insertable<VehiclePartRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('part_number')) {
      context.handle(
        _partNumberMeta,
        partNumber.isAcceptableOrUnknown(data['part_number']!, _partNumberMeta),
      );
    }
    if (data.containsKey('installed_date')) {
      context.handle(
        _installedDateMeta,
        installedDate.isAcceptableOrUnknown(
          data['installed_date']!,
          _installedDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installedDateMeta);
    }
    if (data.containsKey('installed_odometer')) {
      context.handle(
        _installedOdometerMeta,
        installedOdometer.isAcceptableOrUnknown(
          data['installed_odometer']!,
          _installedOdometerMeta,
        ),
      );
    }
    if (data.containsKey('cost_paisa')) {
      context.handle(
        _costPaisaMeta,
        costPaisa.isAcceptableOrUnknown(data['cost_paisa']!, _costPaisaMeta),
      );
    }
    if (data.containsKey('vendor_name')) {
      context.handle(
        _vendorNameMeta,
        vendorName.isAcceptableOrUnknown(data['vendor_name']!, _vendorNameMeta),
      );
    }
    if (data.containsKey('warranty_end_date')) {
      context.handle(
        _warrantyEndDateMeta,
        warrantyEndDate.isAcceptableOrUnknown(
          data['warranty_end_date']!,
          _warrantyEndDateMeta,
        ),
      );
    }
    if (data.containsKey('replacement_interval_km')) {
      context.handle(
        _replacementIntervalKmMeta,
        replacementIntervalKm.isAcceptableOrUnknown(
          data['replacement_interval_km']!,
          _replacementIntervalKmMeta,
        ),
      );
    }
    if (data.containsKey('replacement_interval_days')) {
      context.handle(
        _replacementIntervalDaysMeta,
        replacementIntervalDays.isAcceptableOrUnknown(
          data['replacement_interval_days']!,
          _replacementIntervalDaysMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VehiclePartRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VehiclePartRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      partNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_number'],
      ),
      installedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}installed_date'],
      )!,
      installedOdometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}installed_odometer'],
      ),
      costPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_paisa'],
      )!,
      vendorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vendor_name'],
      ),
      warrantyEndDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}warranty_end_date'],
      ),
      replacementIntervalKm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}replacement_interval_km'],
      ),
      replacementIntervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}replacement_interval_days'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $VehiclePartsTable createAlias(String alias) {
    return $VehiclePartsTable(attachedDatabase, alias);
  }
}

class VehiclePartRow extends DataClass implements Insertable<VehiclePartRow> {
  final String id;
  final String vehicleId;
  final String category;
  final String name;
  final String? brand;
  final String? partNumber;
  final DateTime installedDate;
  final int? installedOdometer;
  final int costPaisa;
  final String? vendorName;
  final DateTime? warrantyEndDate;
  final int? replacementIntervalKm;
  final int? replacementIntervalDays;
  final String? note;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const VehiclePartRow({
    required this.id,
    required this.vehicleId,
    required this.category,
    required this.name,
    this.brand,
    this.partNumber,
    required this.installedDate,
    this.installedOdometer,
    required this.costPaisa,
    this.vendorName,
    this.warrantyEndDate,
    this.replacementIntervalKm,
    this.replacementIntervalDays,
    this.note,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['category'] = Variable<String>(category);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || partNumber != null) {
      map['part_number'] = Variable<String>(partNumber);
    }
    map['installed_date'] = Variable<DateTime>(installedDate);
    if (!nullToAbsent || installedOdometer != null) {
      map['installed_odometer'] = Variable<int>(installedOdometer);
    }
    map['cost_paisa'] = Variable<int>(costPaisa);
    if (!nullToAbsent || vendorName != null) {
      map['vendor_name'] = Variable<String>(vendorName);
    }
    if (!nullToAbsent || warrantyEndDate != null) {
      map['warranty_end_date'] = Variable<DateTime>(warrantyEndDate);
    }
    if (!nullToAbsent || replacementIntervalKm != null) {
      map['replacement_interval_km'] = Variable<int>(replacementIntervalKm);
    }
    if (!nullToAbsent || replacementIntervalDays != null) {
      map['replacement_interval_days'] = Variable<int>(replacementIntervalDays);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  VehiclePartsCompanion toCompanion(bool nullToAbsent) {
    return VehiclePartsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      category: Value(category),
      name: Value(name),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      partNumber: partNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(partNumber),
      installedDate: Value(installedDate),
      installedOdometer: installedOdometer == null && nullToAbsent
          ? const Value.absent()
          : Value(installedOdometer),
      costPaisa: Value(costPaisa),
      vendorName: vendorName == null && nullToAbsent
          ? const Value.absent()
          : Value(vendorName),
      warrantyEndDate: warrantyEndDate == null && nullToAbsent
          ? const Value.absent()
          : Value(warrantyEndDate),
      replacementIntervalKm: replacementIntervalKm == null && nullToAbsent
          ? const Value.absent()
          : Value(replacementIntervalKm),
      replacementIntervalDays: replacementIntervalDays == null && nullToAbsent
          ? const Value.absent()
          : Value(replacementIntervalDays),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory VehiclePartRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehiclePartRow(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      category: serializer.fromJson<String>(json['category']),
      name: serializer.fromJson<String>(json['name']),
      brand: serializer.fromJson<String?>(json['brand']),
      partNumber: serializer.fromJson<String?>(json['partNumber']),
      installedDate: serializer.fromJson<DateTime>(json['installedDate']),
      installedOdometer: serializer.fromJson<int?>(json['installedOdometer']),
      costPaisa: serializer.fromJson<int>(json['costPaisa']),
      vendorName: serializer.fromJson<String?>(json['vendorName']),
      warrantyEndDate: serializer.fromJson<DateTime?>(json['warrantyEndDate']),
      replacementIntervalKm: serializer.fromJson<int?>(
        json['replacementIntervalKm'],
      ),
      replacementIntervalDays: serializer.fromJson<int?>(
        json['replacementIntervalDays'],
      ),
      note: serializer.fromJson<String?>(json['note']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'category': serializer.toJson<String>(category),
      'name': serializer.toJson<String>(name),
      'brand': serializer.toJson<String?>(brand),
      'partNumber': serializer.toJson<String?>(partNumber),
      'installedDate': serializer.toJson<DateTime>(installedDate),
      'installedOdometer': serializer.toJson<int?>(installedOdometer),
      'costPaisa': serializer.toJson<int>(costPaisa),
      'vendorName': serializer.toJson<String?>(vendorName),
      'warrantyEndDate': serializer.toJson<DateTime?>(warrantyEndDate),
      'replacementIntervalKm': serializer.toJson<int?>(replacementIntervalKm),
      'replacementIntervalDays': serializer.toJson<int?>(
        replacementIntervalDays,
      ),
      'note': serializer.toJson<String?>(note),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  VehiclePartRow copyWith({
    String? id,
    String? vehicleId,
    String? category,
    String? name,
    Value<String?> brand = const Value.absent(),
    Value<String?> partNumber = const Value.absent(),
    DateTime? installedDate,
    Value<int?> installedOdometer = const Value.absent(),
    int? costPaisa,
    Value<String?> vendorName = const Value.absent(),
    Value<DateTime?> warrantyEndDate = const Value.absent(),
    Value<int?> replacementIntervalKm = const Value.absent(),
    Value<int?> replacementIntervalDays = const Value.absent(),
    Value<String?> note = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => VehiclePartRow(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    category: category ?? this.category,
    name: name ?? this.name,
    brand: brand.present ? brand.value : this.brand,
    partNumber: partNumber.present ? partNumber.value : this.partNumber,
    installedDate: installedDate ?? this.installedDate,
    installedOdometer: installedOdometer.present
        ? installedOdometer.value
        : this.installedOdometer,
    costPaisa: costPaisa ?? this.costPaisa,
    vendorName: vendorName.present ? vendorName.value : this.vendorName,
    warrantyEndDate: warrantyEndDate.present
        ? warrantyEndDate.value
        : this.warrantyEndDate,
    replacementIntervalKm: replacementIntervalKm.present
        ? replacementIntervalKm.value
        : this.replacementIntervalKm,
    replacementIntervalDays: replacementIntervalDays.present
        ? replacementIntervalDays.value
        : this.replacementIntervalDays,
    note: note.present ? note.value : this.note,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  VehiclePartRow copyWithCompanion(VehiclePartsCompanion data) {
    return VehiclePartRow(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      category: data.category.present ? data.category.value : this.category,
      name: data.name.present ? data.name.value : this.name,
      brand: data.brand.present ? data.brand.value : this.brand,
      partNumber: data.partNumber.present
          ? data.partNumber.value
          : this.partNumber,
      installedDate: data.installedDate.present
          ? data.installedDate.value
          : this.installedDate,
      installedOdometer: data.installedOdometer.present
          ? data.installedOdometer.value
          : this.installedOdometer,
      costPaisa: data.costPaisa.present ? data.costPaisa.value : this.costPaisa,
      vendorName: data.vendorName.present
          ? data.vendorName.value
          : this.vendorName,
      warrantyEndDate: data.warrantyEndDate.present
          ? data.warrantyEndDate.value
          : this.warrantyEndDate,
      replacementIntervalKm: data.replacementIntervalKm.present
          ? data.replacementIntervalKm.value
          : this.replacementIntervalKm,
      replacementIntervalDays: data.replacementIntervalDays.present
          ? data.replacementIntervalDays.value
          : this.replacementIntervalDays,
      note: data.note.present ? data.note.value : this.note,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VehiclePartRow(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('category: $category, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('partNumber: $partNumber, ')
          ..write('installedDate: $installedDate, ')
          ..write('installedOdometer: $installedOdometer, ')
          ..write('costPaisa: $costPaisa, ')
          ..write('vendorName: $vendorName, ')
          ..write('warrantyEndDate: $warrantyEndDate, ')
          ..write('replacementIntervalKm: $replacementIntervalKm, ')
          ..write('replacementIntervalDays: $replacementIntervalDays, ')
          ..write('note: $note, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    category,
    name,
    brand,
    partNumber,
    installedDate,
    installedOdometer,
    costPaisa,
    vendorName,
    warrantyEndDate,
    replacementIntervalKm,
    replacementIntervalDays,
    note,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehiclePartRow &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.category == this.category &&
          other.name == this.name &&
          other.brand == this.brand &&
          other.partNumber == this.partNumber &&
          other.installedDate == this.installedDate &&
          other.installedOdometer == this.installedOdometer &&
          other.costPaisa == this.costPaisa &&
          other.vendorName == this.vendorName &&
          other.warrantyEndDate == this.warrantyEndDate &&
          other.replacementIntervalKm == this.replacementIntervalKm &&
          other.replacementIntervalDays == this.replacementIntervalDays &&
          other.note == this.note &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class VehiclePartsCompanion extends UpdateCompanion<VehiclePartRow> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<String> category;
  final Value<String> name;
  final Value<String?> brand;
  final Value<String?> partNumber;
  final Value<DateTime> installedDate;
  final Value<int?> installedOdometer;
  final Value<int> costPaisa;
  final Value<String?> vendorName;
  final Value<DateTime?> warrantyEndDate;
  final Value<int?> replacementIntervalKm;
  final Value<int?> replacementIntervalDays;
  final Value<String?> note;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const VehiclePartsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.category = const Value.absent(),
    this.name = const Value.absent(),
    this.brand = const Value.absent(),
    this.partNumber = const Value.absent(),
    this.installedDate = const Value.absent(),
    this.installedOdometer = const Value.absent(),
    this.costPaisa = const Value.absent(),
    this.vendorName = const Value.absent(),
    this.warrantyEndDate = const Value.absent(),
    this.replacementIntervalKm = const Value.absent(),
    this.replacementIntervalDays = const Value.absent(),
    this.note = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehiclePartsCompanion.insert({
    required String id,
    required String vehicleId,
    required String category,
    required String name,
    this.brand = const Value.absent(),
    this.partNumber = const Value.absent(),
    required DateTime installedDate,
    this.installedOdometer = const Value.absent(),
    this.costPaisa = const Value.absent(),
    this.vendorName = const Value.absent(),
    this.warrantyEndDate = const Value.absent(),
    this.replacementIntervalKm = const Value.absent(),
    this.replacementIntervalDays = const Value.absent(),
    this.note = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       category = Value(category),
       name = Value(name),
       installedDate = Value(installedDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<VehiclePartRow> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<String>? category,
    Expression<String>? name,
    Expression<String>? brand,
    Expression<String>? partNumber,
    Expression<DateTime>? installedDate,
    Expression<int>? installedOdometer,
    Expression<int>? costPaisa,
    Expression<String>? vendorName,
    Expression<DateTime>? warrantyEndDate,
    Expression<int>? replacementIntervalKm,
    Expression<int>? replacementIntervalDays,
    Expression<String>? note,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (category != null) 'category': category,
      if (name != null) 'name': name,
      if (brand != null) 'brand': brand,
      if (partNumber != null) 'part_number': partNumber,
      if (installedDate != null) 'installed_date': installedDate,
      if (installedOdometer != null) 'installed_odometer': installedOdometer,
      if (costPaisa != null) 'cost_paisa': costPaisa,
      if (vendorName != null) 'vendor_name': vendorName,
      if (warrantyEndDate != null) 'warranty_end_date': warrantyEndDate,
      if (replacementIntervalKm != null)
        'replacement_interval_km': replacementIntervalKm,
      if (replacementIntervalDays != null)
        'replacement_interval_days': replacementIntervalDays,
      if (note != null) 'note': note,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehiclePartsCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<String>? category,
    Value<String>? name,
    Value<String?>? brand,
    Value<String?>? partNumber,
    Value<DateTime>? installedDate,
    Value<int?>? installedOdometer,
    Value<int>? costPaisa,
    Value<String?>? vendorName,
    Value<DateTime?>? warrantyEndDate,
    Value<int?>? replacementIntervalKm,
    Value<int?>? replacementIntervalDays,
    Value<String?>? note,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return VehiclePartsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      category: category ?? this.category,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      partNumber: partNumber ?? this.partNumber,
      installedDate: installedDate ?? this.installedDate,
      installedOdometer: installedOdometer ?? this.installedOdometer,
      costPaisa: costPaisa ?? this.costPaisa,
      vendorName: vendorName ?? this.vendorName,
      warrantyEndDate: warrantyEndDate ?? this.warrantyEndDate,
      replacementIntervalKm:
          replacementIntervalKm ?? this.replacementIntervalKm,
      replacementIntervalDays:
          replacementIntervalDays ?? this.replacementIntervalDays,
      note: note ?? this.note,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (partNumber.present) {
      map['part_number'] = Variable<String>(partNumber.value);
    }
    if (installedDate.present) {
      map['installed_date'] = Variable<DateTime>(installedDate.value);
    }
    if (installedOdometer.present) {
      map['installed_odometer'] = Variable<int>(installedOdometer.value);
    }
    if (costPaisa.present) {
      map['cost_paisa'] = Variable<int>(costPaisa.value);
    }
    if (vendorName.present) {
      map['vendor_name'] = Variable<String>(vendorName.value);
    }
    if (warrantyEndDate.present) {
      map['warranty_end_date'] = Variable<DateTime>(warrantyEndDate.value);
    }
    if (replacementIntervalKm.present) {
      map['replacement_interval_km'] = Variable<int>(
        replacementIntervalKm.value,
      );
    }
    if (replacementIntervalDays.present) {
      map['replacement_interval_days'] = Variable<int>(
        replacementIntervalDays.value,
      );
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiclePartsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('category: $category, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('partNumber: $partNumber, ')
          ..write('installedDate: $installedDate, ')
          ..write('installedOdometer: $installedOdometer, ')
          ..write('costPaisa: $costPaisa, ')
          ..write('vendorName: $vendorName, ')
          ..write('warrantyEndDate: $warrantyEndDate, ')
          ..write('replacementIntervalKm: $replacementIntervalKm, ')
          ..write('replacementIntervalDays: $replacementIntervalDays, ')
          ..write('note: $note, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TyresTable extends Tyres with TableInfo<$TyresTable, TyreRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TyresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<String> size = GeneratedColumn<String>(
    'size',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
    'purchase_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _installDateMeta = const VerificationMeta(
    'installDate',
  );
  @override
  late final GeneratedColumn<DateTime> installDate = GeneratedColumn<DateTime>(
    'install_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _installOdometerMeta = const VerificationMeta(
    'installOdometer',
  );
  @override
  late final GeneratedColumn<int> installOdometer = GeneratedColumn<int>(
    'install_odometer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costPaisaMeta = const VerificationMeta(
    'costPaisa',
  );
  @override
  late final GeneratedColumn<int> costPaisa = GeneratedColumn<int>(
    'cost_paisa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _warrantyEndDateMeta = const VerificationMeta(
    'warrantyEndDate',
  );
  @override
  late final GeneratedColumn<DateTime> warrantyEndDate =
      GeneratedColumn<DateTime>(
        'warranty_end_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _vendorNameMeta = const VerificationMeta(
    'vendorName',
  );
  @override
  late final GeneratedColumn<String> vendorName = GeneratedColumn<String>(
    'vendor_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    position,
    brand,
    model,
    size,
    purchaseDate,
    installDate,
    installOdometer,
    costPaisa,
    warrantyEndDate,
    vendorName,
    status,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tyres';
  @override
  VerificationContext validateIntegrity(
    Insertable<TyreRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    }
    if (data.containsKey('install_date')) {
      context.handle(
        _installDateMeta,
        installDate.isAcceptableOrUnknown(
          data['install_date']!,
          _installDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installDateMeta);
    }
    if (data.containsKey('install_odometer')) {
      context.handle(
        _installOdometerMeta,
        installOdometer.isAcceptableOrUnknown(
          data['install_odometer']!,
          _installOdometerMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installOdometerMeta);
    }
    if (data.containsKey('cost_paisa')) {
      context.handle(
        _costPaisaMeta,
        costPaisa.isAcceptableOrUnknown(data['cost_paisa']!, _costPaisaMeta),
      );
    }
    if (data.containsKey('warranty_end_date')) {
      context.handle(
        _warrantyEndDateMeta,
        warrantyEndDate.isAcceptableOrUnknown(
          data['warranty_end_date']!,
          _warrantyEndDateMeta,
        ),
      );
    }
    if (data.containsKey('vendor_name')) {
      context.handle(
        _vendorNameMeta,
        vendorName.isAcceptableOrUnknown(data['vendor_name']!, _vendorNameMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TyreRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TyreRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      ),
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}size'],
      ),
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchase_date'],
      ),
      installDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}install_date'],
      )!,
      installOdometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}install_odometer'],
      )!,
      costPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_paisa'],
      )!,
      warrantyEndDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}warranty_end_date'],
      ),
      vendorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vendor_name'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TyresTable createAlias(String alias) {
    return $TyresTable(attachedDatabase, alias);
  }
}

class TyreRow extends DataClass implements Insertable<TyreRow> {
  final String id;
  final String vehicleId;
  final String position;
  final String? brand;
  final String? model;
  final String? size;
  final DateTime? purchaseDate;
  final DateTime installDate;
  final int installOdometer;
  final int costPaisa;
  final DateTime? warrantyEndDate;
  final String? vendorName;

  /// active | replaced | removed | stored
  final String status;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TyreRow({
    required this.id,
    required this.vehicleId,
    required this.position,
    this.brand,
    this.model,
    this.size,
    this.purchaseDate,
    required this.installDate,
    required this.installOdometer,
    required this.costPaisa,
    this.warrantyEndDate,
    this.vendorName,
    required this.status,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['position'] = Variable<String>(position);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<String>(size);
    }
    if (!nullToAbsent || purchaseDate != null) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate);
    }
    map['install_date'] = Variable<DateTime>(installDate);
    map['install_odometer'] = Variable<int>(installOdometer);
    map['cost_paisa'] = Variable<int>(costPaisa);
    if (!nullToAbsent || warrantyEndDate != null) {
      map['warranty_end_date'] = Variable<DateTime>(warrantyEndDate);
    }
    if (!nullToAbsent || vendorName != null) {
      map['vendor_name'] = Variable<String>(vendorName);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TyresCompanion toCompanion(bool nullToAbsent) {
    return TyresCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      position: Value(position),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      model: model == null && nullToAbsent
          ? const Value.absent()
          : Value(model),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      purchaseDate: purchaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseDate),
      installDate: Value(installDate),
      installOdometer: Value(installOdometer),
      costPaisa: Value(costPaisa),
      warrantyEndDate: warrantyEndDate == null && nullToAbsent
          ? const Value.absent()
          : Value(warrantyEndDate),
      vendorName: vendorName == null && nullToAbsent
          ? const Value.absent()
          : Value(vendorName),
      status: Value(status),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TyreRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TyreRow(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      position: serializer.fromJson<String>(json['position']),
      brand: serializer.fromJson<String?>(json['brand']),
      model: serializer.fromJson<String?>(json['model']),
      size: serializer.fromJson<String?>(json['size']),
      purchaseDate: serializer.fromJson<DateTime?>(json['purchaseDate']),
      installDate: serializer.fromJson<DateTime>(json['installDate']),
      installOdometer: serializer.fromJson<int>(json['installOdometer']),
      costPaisa: serializer.fromJson<int>(json['costPaisa']),
      warrantyEndDate: serializer.fromJson<DateTime?>(json['warrantyEndDate']),
      vendorName: serializer.fromJson<String?>(json['vendorName']),
      status: serializer.fromJson<String>(json['status']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'position': serializer.toJson<String>(position),
      'brand': serializer.toJson<String?>(brand),
      'model': serializer.toJson<String?>(model),
      'size': serializer.toJson<String?>(size),
      'purchaseDate': serializer.toJson<DateTime?>(purchaseDate),
      'installDate': serializer.toJson<DateTime>(installDate),
      'installOdometer': serializer.toJson<int>(installOdometer),
      'costPaisa': serializer.toJson<int>(costPaisa),
      'warrantyEndDate': serializer.toJson<DateTime?>(warrantyEndDate),
      'vendorName': serializer.toJson<String?>(vendorName),
      'status': serializer.toJson<String>(status),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TyreRow copyWith({
    String? id,
    String? vehicleId,
    String? position,
    Value<String?> brand = const Value.absent(),
    Value<String?> model = const Value.absent(),
    Value<String?> size = const Value.absent(),
    Value<DateTime?> purchaseDate = const Value.absent(),
    DateTime? installDate,
    int? installOdometer,
    int? costPaisa,
    Value<DateTime?> warrantyEndDate = const Value.absent(),
    Value<String?> vendorName = const Value.absent(),
    String? status,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TyreRow(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    position: position ?? this.position,
    brand: brand.present ? brand.value : this.brand,
    model: model.present ? model.value : this.model,
    size: size.present ? size.value : this.size,
    purchaseDate: purchaseDate.present ? purchaseDate.value : this.purchaseDate,
    installDate: installDate ?? this.installDate,
    installOdometer: installOdometer ?? this.installOdometer,
    costPaisa: costPaisa ?? this.costPaisa,
    warrantyEndDate: warrantyEndDate.present
        ? warrantyEndDate.value
        : this.warrantyEndDate,
    vendorName: vendorName.present ? vendorName.value : this.vendorName,
    status: status ?? this.status,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TyreRow copyWithCompanion(TyresCompanion data) {
    return TyreRow(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      position: data.position.present ? data.position.value : this.position,
      brand: data.brand.present ? data.brand.value : this.brand,
      model: data.model.present ? data.model.value : this.model,
      size: data.size.present ? data.size.value : this.size,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      installDate: data.installDate.present
          ? data.installDate.value
          : this.installDate,
      installOdometer: data.installOdometer.present
          ? data.installOdometer.value
          : this.installOdometer,
      costPaisa: data.costPaisa.present ? data.costPaisa.value : this.costPaisa,
      warrantyEndDate: data.warrantyEndDate.present
          ? data.warrantyEndDate.value
          : this.warrantyEndDate,
      vendorName: data.vendorName.present
          ? data.vendorName.value
          : this.vendorName,
      status: data.status.present ? data.status.value : this.status,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TyreRow(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('position: $position, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('size: $size, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('installDate: $installDate, ')
          ..write('installOdometer: $installOdometer, ')
          ..write('costPaisa: $costPaisa, ')
          ..write('warrantyEndDate: $warrantyEndDate, ')
          ..write('vendorName: $vendorName, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    position,
    brand,
    model,
    size,
    purchaseDate,
    installDate,
    installOdometer,
    costPaisa,
    warrantyEndDate,
    vendorName,
    status,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TyreRow &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.position == this.position &&
          other.brand == this.brand &&
          other.model == this.model &&
          other.size == this.size &&
          other.purchaseDate == this.purchaseDate &&
          other.installDate == this.installDate &&
          other.installOdometer == this.installOdometer &&
          other.costPaisa == this.costPaisa &&
          other.warrantyEndDate == this.warrantyEndDate &&
          other.vendorName == this.vendorName &&
          other.status == this.status &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TyresCompanion extends UpdateCompanion<TyreRow> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<String> position;
  final Value<String?> brand;
  final Value<String?> model;
  final Value<String?> size;
  final Value<DateTime?> purchaseDate;
  final Value<DateTime> installDate;
  final Value<int> installOdometer;
  final Value<int> costPaisa;
  final Value<DateTime?> warrantyEndDate;
  final Value<String?> vendorName;
  final Value<String> status;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TyresCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.position = const Value.absent(),
    this.brand = const Value.absent(),
    this.model = const Value.absent(),
    this.size = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.installDate = const Value.absent(),
    this.installOdometer = const Value.absent(),
    this.costPaisa = const Value.absent(),
    this.warrantyEndDate = const Value.absent(),
    this.vendorName = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TyresCompanion.insert({
    required String id,
    required String vehicleId,
    required String position,
    this.brand = const Value.absent(),
    this.model = const Value.absent(),
    this.size = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    required DateTime installDate,
    required int installOdometer,
    this.costPaisa = const Value.absent(),
    this.warrantyEndDate = const Value.absent(),
    this.vendorName = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       position = Value(position),
       installDate = Value(installDate),
       installOdometer = Value(installOdometer),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<TyreRow> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<String>? position,
    Expression<String>? brand,
    Expression<String>? model,
    Expression<String>? size,
    Expression<DateTime>? purchaseDate,
    Expression<DateTime>? installDate,
    Expression<int>? installOdometer,
    Expression<int>? costPaisa,
    Expression<DateTime>? warrantyEndDate,
    Expression<String>? vendorName,
    Expression<String>? status,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (position != null) 'position': position,
      if (brand != null) 'brand': brand,
      if (model != null) 'model': model,
      if (size != null) 'size': size,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (installDate != null) 'install_date': installDate,
      if (installOdometer != null) 'install_odometer': installOdometer,
      if (costPaisa != null) 'cost_paisa': costPaisa,
      if (warrantyEndDate != null) 'warranty_end_date': warrantyEndDate,
      if (vendorName != null) 'vendor_name': vendorName,
      if (status != null) 'status': status,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TyresCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<String>? position,
    Value<String?>? brand,
    Value<String?>? model,
    Value<String?>? size,
    Value<DateTime?>? purchaseDate,
    Value<DateTime>? installDate,
    Value<int>? installOdometer,
    Value<int>? costPaisa,
    Value<DateTime?>? warrantyEndDate,
    Value<String?>? vendorName,
    Value<String>? status,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TyresCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      position: position ?? this.position,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      size: size ?? this.size,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      installDate: installDate ?? this.installDate,
      installOdometer: installOdometer ?? this.installOdometer,
      costPaisa: costPaisa ?? this.costPaisa,
      warrantyEndDate: warrantyEndDate ?? this.warrantyEndDate,
      vendorName: vendorName ?? this.vendorName,
      status: status ?? this.status,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (size.present) {
      map['size'] = Variable<String>(size.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (installDate.present) {
      map['install_date'] = Variable<DateTime>(installDate.value);
    }
    if (installOdometer.present) {
      map['install_odometer'] = Variable<int>(installOdometer.value);
    }
    if (costPaisa.present) {
      map['cost_paisa'] = Variable<int>(costPaisa.value);
    }
    if (warrantyEndDate.present) {
      map['warranty_end_date'] = Variable<DateTime>(warrantyEndDate.value);
    }
    if (vendorName.present) {
      map['vendor_name'] = Variable<String>(vendorName.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TyresCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('position: $position, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('size: $size, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('installDate: $installDate, ')
          ..write('installOdometer: $installOdometer, ')
          ..write('costPaisa: $costPaisa, ')
          ..write('warrantyEndDate: $warrantyEndDate, ')
          ..write('vendorName: $vendorName, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TyreEventsTable extends TyreEvents
    with TableInfo<$TyreEventsTable, TyreEventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TyreEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tyreIdMeta = const VerificationMeta('tyreId');
  @override
  late final GeneratedColumn<String> tyreId = GeneratedColumn<String>(
    'tyre_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tyres (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occurredOnMeta = const VerificationMeta(
    'occurredOn',
  );
  @override
  late final GeneratedColumn<DateTime> occurredOn = GeneratedColumn<DateTime>(
    'occurred_on',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerMeta = const VerificationMeta(
    'odometer',
  );
  @override
  late final GeneratedColumn<int> odometer = GeneratedColumn<int>(
    'odometer',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fromPositionMeta = const VerificationMeta(
    'fromPosition',
  );
  @override
  late final GeneratedColumn<String> fromPosition = GeneratedColumn<String>(
    'from_position',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _toPositionMeta = const VerificationMeta(
    'toPosition',
  );
  @override
  late final GeneratedColumn<String> toPosition = GeneratedColumn<String>(
    'to_position',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _inspectionResultMeta = const VerificationMeta(
    'inspectionResult',
  );
  @override
  late final GeneratedColumn<String> inspectionResult = GeneratedColumn<String>(
    'inspection_result',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _costPaisaMeta = const VerificationMeta(
    'costPaisa',
  );
  @override
  late final GeneratedColumn<int> costPaisa = GeneratedColumn<int>(
    'cost_paisa',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tyreId,
    vehicleId,
    eventType,
    occurredOn,
    odometer,
    fromPosition,
    toPosition,
    inspectionResult,
    costPaisa,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tyre_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<TyreEventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tyre_id')) {
      context.handle(
        _tyreIdMeta,
        tyreId.isAcceptableOrUnknown(data['tyre_id']!, _tyreIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tyreIdMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('occurred_on')) {
      context.handle(
        _occurredOnMeta,
        occurredOn.isAcceptableOrUnknown(data['occurred_on']!, _occurredOnMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredOnMeta);
    }
    if (data.containsKey('odometer')) {
      context.handle(
        _odometerMeta,
        odometer.isAcceptableOrUnknown(data['odometer']!, _odometerMeta),
      );
    }
    if (data.containsKey('from_position')) {
      context.handle(
        _fromPositionMeta,
        fromPosition.isAcceptableOrUnknown(
          data['from_position']!,
          _fromPositionMeta,
        ),
      );
    }
    if (data.containsKey('to_position')) {
      context.handle(
        _toPositionMeta,
        toPosition.isAcceptableOrUnknown(data['to_position']!, _toPositionMeta),
      );
    }
    if (data.containsKey('inspection_result')) {
      context.handle(
        _inspectionResultMeta,
        inspectionResult.isAcceptableOrUnknown(
          data['inspection_result']!,
          _inspectionResultMeta,
        ),
      );
    }
    if (data.containsKey('cost_paisa')) {
      context.handle(
        _costPaisaMeta,
        costPaisa.isAcceptableOrUnknown(data['cost_paisa']!, _costPaisaMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TyreEventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TyreEventRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tyreId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tyre_id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      occurredOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_on'],
      )!,
      odometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odometer'],
      ),
      fromPosition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_position'],
      ),
      toPosition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_position'],
      ),
      inspectionResult: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}inspection_result'],
      ),
      costPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_paisa'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TyreEventsTable createAlias(String alias) {
    return $TyreEventsTable(attachedDatabase, alias);
  }
}

class TyreEventRow extends DataClass implements Insertable<TyreEventRow> {
  final String id;
  final String tyreId;
  final String vehicleId;

  /// installed | rotated | inspected | repaired | replaced | removed
  final String eventType;
  final DateTime occurredOn;
  final int? odometer;
  final String? fromPosition;
  final String? toPosition;
  final String? inspectionResult;
  final int? costPaisa;
  final String? note;
  final DateTime createdAt;
  const TyreEventRow({
    required this.id,
    required this.tyreId,
    required this.vehicleId,
    required this.eventType,
    required this.occurredOn,
    this.odometer,
    this.fromPosition,
    this.toPosition,
    this.inspectionResult,
    this.costPaisa,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tyre_id'] = Variable<String>(tyreId);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['event_type'] = Variable<String>(eventType);
    map['occurred_on'] = Variable<DateTime>(occurredOn);
    if (!nullToAbsent || odometer != null) {
      map['odometer'] = Variable<int>(odometer);
    }
    if (!nullToAbsent || fromPosition != null) {
      map['from_position'] = Variable<String>(fromPosition);
    }
    if (!nullToAbsent || toPosition != null) {
      map['to_position'] = Variable<String>(toPosition);
    }
    if (!nullToAbsent || inspectionResult != null) {
      map['inspection_result'] = Variable<String>(inspectionResult);
    }
    if (!nullToAbsent || costPaisa != null) {
      map['cost_paisa'] = Variable<int>(costPaisa);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TyreEventsCompanion toCompanion(bool nullToAbsent) {
    return TyreEventsCompanion(
      id: Value(id),
      tyreId: Value(tyreId),
      vehicleId: Value(vehicleId),
      eventType: Value(eventType),
      occurredOn: Value(occurredOn),
      odometer: odometer == null && nullToAbsent
          ? const Value.absent()
          : Value(odometer),
      fromPosition: fromPosition == null && nullToAbsent
          ? const Value.absent()
          : Value(fromPosition),
      toPosition: toPosition == null && nullToAbsent
          ? const Value.absent()
          : Value(toPosition),
      inspectionResult: inspectionResult == null && nullToAbsent
          ? const Value.absent()
          : Value(inspectionResult),
      costPaisa: costPaisa == null && nullToAbsent
          ? const Value.absent()
          : Value(costPaisa),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory TyreEventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TyreEventRow(
      id: serializer.fromJson<String>(json['id']),
      tyreId: serializer.fromJson<String>(json['tyreId']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      eventType: serializer.fromJson<String>(json['eventType']),
      occurredOn: serializer.fromJson<DateTime>(json['occurredOn']),
      odometer: serializer.fromJson<int?>(json['odometer']),
      fromPosition: serializer.fromJson<String?>(json['fromPosition']),
      toPosition: serializer.fromJson<String?>(json['toPosition']),
      inspectionResult: serializer.fromJson<String?>(json['inspectionResult']),
      costPaisa: serializer.fromJson<int?>(json['costPaisa']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tyreId': serializer.toJson<String>(tyreId),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'eventType': serializer.toJson<String>(eventType),
      'occurredOn': serializer.toJson<DateTime>(occurredOn),
      'odometer': serializer.toJson<int?>(odometer),
      'fromPosition': serializer.toJson<String?>(fromPosition),
      'toPosition': serializer.toJson<String?>(toPosition),
      'inspectionResult': serializer.toJson<String?>(inspectionResult),
      'costPaisa': serializer.toJson<int?>(costPaisa),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TyreEventRow copyWith({
    String? id,
    String? tyreId,
    String? vehicleId,
    String? eventType,
    DateTime? occurredOn,
    Value<int?> odometer = const Value.absent(),
    Value<String?> fromPosition = const Value.absent(),
    Value<String?> toPosition = const Value.absent(),
    Value<String?> inspectionResult = const Value.absent(),
    Value<int?> costPaisa = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => TyreEventRow(
    id: id ?? this.id,
    tyreId: tyreId ?? this.tyreId,
    vehicleId: vehicleId ?? this.vehicleId,
    eventType: eventType ?? this.eventType,
    occurredOn: occurredOn ?? this.occurredOn,
    odometer: odometer.present ? odometer.value : this.odometer,
    fromPosition: fromPosition.present ? fromPosition.value : this.fromPosition,
    toPosition: toPosition.present ? toPosition.value : this.toPosition,
    inspectionResult: inspectionResult.present
        ? inspectionResult.value
        : this.inspectionResult,
    costPaisa: costPaisa.present ? costPaisa.value : this.costPaisa,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  TyreEventRow copyWithCompanion(TyreEventsCompanion data) {
    return TyreEventRow(
      id: data.id.present ? data.id.value : this.id,
      tyreId: data.tyreId.present ? data.tyreId.value : this.tyreId,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      occurredOn: data.occurredOn.present
          ? data.occurredOn.value
          : this.occurredOn,
      odometer: data.odometer.present ? data.odometer.value : this.odometer,
      fromPosition: data.fromPosition.present
          ? data.fromPosition.value
          : this.fromPosition,
      toPosition: data.toPosition.present
          ? data.toPosition.value
          : this.toPosition,
      inspectionResult: data.inspectionResult.present
          ? data.inspectionResult.value
          : this.inspectionResult,
      costPaisa: data.costPaisa.present ? data.costPaisa.value : this.costPaisa,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TyreEventRow(')
          ..write('id: $id, ')
          ..write('tyreId: $tyreId, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('eventType: $eventType, ')
          ..write('occurredOn: $occurredOn, ')
          ..write('odometer: $odometer, ')
          ..write('fromPosition: $fromPosition, ')
          ..write('toPosition: $toPosition, ')
          ..write('inspectionResult: $inspectionResult, ')
          ..write('costPaisa: $costPaisa, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tyreId,
    vehicleId,
    eventType,
    occurredOn,
    odometer,
    fromPosition,
    toPosition,
    inspectionResult,
    costPaisa,
    note,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TyreEventRow &&
          other.id == this.id &&
          other.tyreId == this.tyreId &&
          other.vehicleId == this.vehicleId &&
          other.eventType == this.eventType &&
          other.occurredOn == this.occurredOn &&
          other.odometer == this.odometer &&
          other.fromPosition == this.fromPosition &&
          other.toPosition == this.toPosition &&
          other.inspectionResult == this.inspectionResult &&
          other.costPaisa == this.costPaisa &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class TyreEventsCompanion extends UpdateCompanion<TyreEventRow> {
  final Value<String> id;
  final Value<String> tyreId;
  final Value<String> vehicleId;
  final Value<String> eventType;
  final Value<DateTime> occurredOn;
  final Value<int?> odometer;
  final Value<String?> fromPosition;
  final Value<String?> toPosition;
  final Value<String?> inspectionResult;
  final Value<int?> costPaisa;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TyreEventsCompanion({
    this.id = const Value.absent(),
    this.tyreId = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.eventType = const Value.absent(),
    this.occurredOn = const Value.absent(),
    this.odometer = const Value.absent(),
    this.fromPosition = const Value.absent(),
    this.toPosition = const Value.absent(),
    this.inspectionResult = const Value.absent(),
    this.costPaisa = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TyreEventsCompanion.insert({
    required String id,
    required String tyreId,
    required String vehicleId,
    required String eventType,
    required DateTime occurredOn,
    this.odometer = const Value.absent(),
    this.fromPosition = const Value.absent(),
    this.toPosition = const Value.absent(),
    this.inspectionResult = const Value.absent(),
    this.costPaisa = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tyreId = Value(tyreId),
       vehicleId = Value(vehicleId),
       eventType = Value(eventType),
       occurredOn = Value(occurredOn),
       createdAt = Value(createdAt);
  static Insertable<TyreEventRow> custom({
    Expression<String>? id,
    Expression<String>? tyreId,
    Expression<String>? vehicleId,
    Expression<String>? eventType,
    Expression<DateTime>? occurredOn,
    Expression<int>? odometer,
    Expression<String>? fromPosition,
    Expression<String>? toPosition,
    Expression<String>? inspectionResult,
    Expression<int>? costPaisa,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tyreId != null) 'tyre_id': tyreId,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (eventType != null) 'event_type': eventType,
      if (occurredOn != null) 'occurred_on': occurredOn,
      if (odometer != null) 'odometer': odometer,
      if (fromPosition != null) 'from_position': fromPosition,
      if (toPosition != null) 'to_position': toPosition,
      if (inspectionResult != null) 'inspection_result': inspectionResult,
      if (costPaisa != null) 'cost_paisa': costPaisa,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TyreEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? tyreId,
    Value<String>? vehicleId,
    Value<String>? eventType,
    Value<DateTime>? occurredOn,
    Value<int?>? odometer,
    Value<String?>? fromPosition,
    Value<String?>? toPosition,
    Value<String?>? inspectionResult,
    Value<int?>? costPaisa,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return TyreEventsCompanion(
      id: id ?? this.id,
      tyreId: tyreId ?? this.tyreId,
      vehicleId: vehicleId ?? this.vehicleId,
      eventType: eventType ?? this.eventType,
      occurredOn: occurredOn ?? this.occurredOn,
      odometer: odometer ?? this.odometer,
      fromPosition: fromPosition ?? this.fromPosition,
      toPosition: toPosition ?? this.toPosition,
      inspectionResult: inspectionResult ?? this.inspectionResult,
      costPaisa: costPaisa ?? this.costPaisa,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tyreId.present) {
      map['tyre_id'] = Variable<String>(tyreId.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (occurredOn.present) {
      map['occurred_on'] = Variable<DateTime>(occurredOn.value);
    }
    if (odometer.present) {
      map['odometer'] = Variable<int>(odometer.value);
    }
    if (fromPosition.present) {
      map['from_position'] = Variable<String>(fromPosition.value);
    }
    if (toPosition.present) {
      map['to_position'] = Variable<String>(toPosition.value);
    }
    if (inspectionResult.present) {
      map['inspection_result'] = Variable<String>(inspectionResult.value);
    }
    if (costPaisa.present) {
      map['cost_paisa'] = Variable<int>(costPaisa.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TyreEventsCompanion(')
          ..write('id: $id, ')
          ..write('tyreId: $tyreId, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('eventType: $eventType, ')
          ..write('occurredOn: $occurredOn, ')
          ..write('odometer: $odometer, ')
          ..write('fromPosition: $fromPosition, ')
          ..write('toPosition: $toPosition, ')
          ..write('inspectionResult: $inspectionResult, ')
          ..write('costPaisa: $costPaisa, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BatteriesTable extends Batteries
    with TableInfo<$BatteriesTable, BatteryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BatteriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _specificationMeta = const VerificationMeta(
    'specification',
  );
  @override
  late final GeneratedColumn<String> specification = GeneratedColumn<String>(
    'specification',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
    'purchase_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _installDateMeta = const VerificationMeta(
    'installDate',
  );
  @override
  late final GeneratedColumn<DateTime> installDate = GeneratedColumn<DateTime>(
    'install_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _installOdometerMeta = const VerificationMeta(
    'installOdometer',
  );
  @override
  late final GeneratedColumn<int> installOdometer = GeneratedColumn<int>(
    'install_odometer',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _costPaisaMeta = const VerificationMeta(
    'costPaisa',
  );
  @override
  late final GeneratedColumn<int> costPaisa = GeneratedColumn<int>(
    'cost_paisa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _warrantyEndDateMeta = const VerificationMeta(
    'warrantyEndDate',
  );
  @override
  late final GeneratedColumn<DateTime> warrantyEndDate =
      GeneratedColumn<DateTime>(
        'warranty_end_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _vendorNameMeta = const VerificationMeta(
    'vendorName',
  );
  @override
  late final GeneratedColumn<String> vendorName = GeneratedColumn<String>(
    'vendor_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    brand,
    model,
    specification,
    purchaseDate,
    installDate,
    installOdometer,
    costPaisa,
    warrantyEndDate,
    vendorName,
    status,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'batteries';
  @override
  VerificationContext validateIntegrity(
    Insertable<BatteryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    }
    if (data.containsKey('specification')) {
      context.handle(
        _specificationMeta,
        specification.isAcceptableOrUnknown(
          data['specification']!,
          _specificationMeta,
        ),
      );
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    }
    if (data.containsKey('install_date')) {
      context.handle(
        _installDateMeta,
        installDate.isAcceptableOrUnknown(
          data['install_date']!,
          _installDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installDateMeta);
    }
    if (data.containsKey('install_odometer')) {
      context.handle(
        _installOdometerMeta,
        installOdometer.isAcceptableOrUnknown(
          data['install_odometer']!,
          _installOdometerMeta,
        ),
      );
    }
    if (data.containsKey('cost_paisa')) {
      context.handle(
        _costPaisaMeta,
        costPaisa.isAcceptableOrUnknown(data['cost_paisa']!, _costPaisaMeta),
      );
    }
    if (data.containsKey('warranty_end_date')) {
      context.handle(
        _warrantyEndDateMeta,
        warrantyEndDate.isAcceptableOrUnknown(
          data['warranty_end_date']!,
          _warrantyEndDateMeta,
        ),
      );
    }
    if (data.containsKey('vendor_name')) {
      context.handle(
        _vendorNameMeta,
        vendorName.isAcceptableOrUnknown(data['vendor_name']!, _vendorNameMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BatteryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BatteryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      ),
      specification: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}specification'],
      ),
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchase_date'],
      ),
      installDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}install_date'],
      )!,
      installOdometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}install_odometer'],
      ),
      costPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_paisa'],
      )!,
      warrantyEndDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}warranty_end_date'],
      ),
      vendorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vendor_name'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BatteriesTable createAlias(String alias) {
    return $BatteriesTable(attachedDatabase, alias);
  }
}

class BatteryRow extends DataClass implements Insertable<BatteryRow> {
  final String id;
  final String vehicleId;
  final String? brand;
  final String? model;
  final String? specification;
  final DateTime? purchaseDate;
  final DateTime installDate;
  final int? installOdometer;
  final int costPaisa;
  final DateTime? warrantyEndDate;
  final String? vendorName;

  /// active | replaced | removed
  final String status;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BatteryRow({
    required this.id,
    required this.vehicleId,
    this.brand,
    this.model,
    this.specification,
    this.purchaseDate,
    required this.installDate,
    this.installOdometer,
    required this.costPaisa,
    this.warrantyEndDate,
    this.vendorName,
    required this.status,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    if (!nullToAbsent || specification != null) {
      map['specification'] = Variable<String>(specification);
    }
    if (!nullToAbsent || purchaseDate != null) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate);
    }
    map['install_date'] = Variable<DateTime>(installDate);
    if (!nullToAbsent || installOdometer != null) {
      map['install_odometer'] = Variable<int>(installOdometer);
    }
    map['cost_paisa'] = Variable<int>(costPaisa);
    if (!nullToAbsent || warrantyEndDate != null) {
      map['warranty_end_date'] = Variable<DateTime>(warrantyEndDate);
    }
    if (!nullToAbsent || vendorName != null) {
      map['vendor_name'] = Variable<String>(vendorName);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BatteriesCompanion toCompanion(bool nullToAbsent) {
    return BatteriesCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      model: model == null && nullToAbsent
          ? const Value.absent()
          : Value(model),
      specification: specification == null && nullToAbsent
          ? const Value.absent()
          : Value(specification),
      purchaseDate: purchaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseDate),
      installDate: Value(installDate),
      installOdometer: installOdometer == null && nullToAbsent
          ? const Value.absent()
          : Value(installOdometer),
      costPaisa: Value(costPaisa),
      warrantyEndDate: warrantyEndDate == null && nullToAbsent
          ? const Value.absent()
          : Value(warrantyEndDate),
      vendorName: vendorName == null && nullToAbsent
          ? const Value.absent()
          : Value(vendorName),
      status: Value(status),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BatteryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BatteryRow(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      brand: serializer.fromJson<String?>(json['brand']),
      model: serializer.fromJson<String?>(json['model']),
      specification: serializer.fromJson<String?>(json['specification']),
      purchaseDate: serializer.fromJson<DateTime?>(json['purchaseDate']),
      installDate: serializer.fromJson<DateTime>(json['installDate']),
      installOdometer: serializer.fromJson<int?>(json['installOdometer']),
      costPaisa: serializer.fromJson<int>(json['costPaisa']),
      warrantyEndDate: serializer.fromJson<DateTime?>(json['warrantyEndDate']),
      vendorName: serializer.fromJson<String?>(json['vendorName']),
      status: serializer.fromJson<String>(json['status']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'brand': serializer.toJson<String?>(brand),
      'model': serializer.toJson<String?>(model),
      'specification': serializer.toJson<String?>(specification),
      'purchaseDate': serializer.toJson<DateTime?>(purchaseDate),
      'installDate': serializer.toJson<DateTime>(installDate),
      'installOdometer': serializer.toJson<int?>(installOdometer),
      'costPaisa': serializer.toJson<int>(costPaisa),
      'warrantyEndDate': serializer.toJson<DateTime?>(warrantyEndDate),
      'vendorName': serializer.toJson<String?>(vendorName),
      'status': serializer.toJson<String>(status),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BatteryRow copyWith({
    String? id,
    String? vehicleId,
    Value<String?> brand = const Value.absent(),
    Value<String?> model = const Value.absent(),
    Value<String?> specification = const Value.absent(),
    Value<DateTime?> purchaseDate = const Value.absent(),
    DateTime? installDate,
    Value<int?> installOdometer = const Value.absent(),
    int? costPaisa,
    Value<DateTime?> warrantyEndDate = const Value.absent(),
    Value<String?> vendorName = const Value.absent(),
    String? status,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BatteryRow(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    brand: brand.present ? brand.value : this.brand,
    model: model.present ? model.value : this.model,
    specification: specification.present
        ? specification.value
        : this.specification,
    purchaseDate: purchaseDate.present ? purchaseDate.value : this.purchaseDate,
    installDate: installDate ?? this.installDate,
    installOdometer: installOdometer.present
        ? installOdometer.value
        : this.installOdometer,
    costPaisa: costPaisa ?? this.costPaisa,
    warrantyEndDate: warrantyEndDate.present
        ? warrantyEndDate.value
        : this.warrantyEndDate,
    vendorName: vendorName.present ? vendorName.value : this.vendorName,
    status: status ?? this.status,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BatteryRow copyWithCompanion(BatteriesCompanion data) {
    return BatteryRow(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      brand: data.brand.present ? data.brand.value : this.brand,
      model: data.model.present ? data.model.value : this.model,
      specification: data.specification.present
          ? data.specification.value
          : this.specification,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      installDate: data.installDate.present
          ? data.installDate.value
          : this.installDate,
      installOdometer: data.installOdometer.present
          ? data.installOdometer.value
          : this.installOdometer,
      costPaisa: data.costPaisa.present ? data.costPaisa.value : this.costPaisa,
      warrantyEndDate: data.warrantyEndDate.present
          ? data.warrantyEndDate.value
          : this.warrantyEndDate,
      vendorName: data.vendorName.present
          ? data.vendorName.value
          : this.vendorName,
      status: data.status.present ? data.status.value : this.status,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BatteryRow(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('specification: $specification, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('installDate: $installDate, ')
          ..write('installOdometer: $installOdometer, ')
          ..write('costPaisa: $costPaisa, ')
          ..write('warrantyEndDate: $warrantyEndDate, ')
          ..write('vendorName: $vendorName, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    brand,
    model,
    specification,
    purchaseDate,
    installDate,
    installOdometer,
    costPaisa,
    warrantyEndDate,
    vendorName,
    status,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BatteryRow &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.brand == this.brand &&
          other.model == this.model &&
          other.specification == this.specification &&
          other.purchaseDate == this.purchaseDate &&
          other.installDate == this.installDate &&
          other.installOdometer == this.installOdometer &&
          other.costPaisa == this.costPaisa &&
          other.warrantyEndDate == this.warrantyEndDate &&
          other.vendorName == this.vendorName &&
          other.status == this.status &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BatteriesCompanion extends UpdateCompanion<BatteryRow> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<String?> brand;
  final Value<String?> model;
  final Value<String?> specification;
  final Value<DateTime?> purchaseDate;
  final Value<DateTime> installDate;
  final Value<int?> installOdometer;
  final Value<int> costPaisa;
  final Value<DateTime?> warrantyEndDate;
  final Value<String?> vendorName;
  final Value<String> status;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BatteriesCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.brand = const Value.absent(),
    this.model = const Value.absent(),
    this.specification = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.installDate = const Value.absent(),
    this.installOdometer = const Value.absent(),
    this.costPaisa = const Value.absent(),
    this.warrantyEndDate = const Value.absent(),
    this.vendorName = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BatteriesCompanion.insert({
    required String id,
    required String vehicleId,
    this.brand = const Value.absent(),
    this.model = const Value.absent(),
    this.specification = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    required DateTime installDate,
    this.installOdometer = const Value.absent(),
    this.costPaisa = const Value.absent(),
    this.warrantyEndDate = const Value.absent(),
    this.vendorName = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       installDate = Value(installDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BatteryRow> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<String>? brand,
    Expression<String>? model,
    Expression<String>? specification,
    Expression<DateTime>? purchaseDate,
    Expression<DateTime>? installDate,
    Expression<int>? installOdometer,
    Expression<int>? costPaisa,
    Expression<DateTime>? warrantyEndDate,
    Expression<String>? vendorName,
    Expression<String>? status,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (brand != null) 'brand': brand,
      if (model != null) 'model': model,
      if (specification != null) 'specification': specification,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (installDate != null) 'install_date': installDate,
      if (installOdometer != null) 'install_odometer': installOdometer,
      if (costPaisa != null) 'cost_paisa': costPaisa,
      if (warrantyEndDate != null) 'warranty_end_date': warrantyEndDate,
      if (vendorName != null) 'vendor_name': vendorName,
      if (status != null) 'status': status,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BatteriesCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<String?>? brand,
    Value<String?>? model,
    Value<String?>? specification,
    Value<DateTime?>? purchaseDate,
    Value<DateTime>? installDate,
    Value<int?>? installOdometer,
    Value<int>? costPaisa,
    Value<DateTime?>? warrantyEndDate,
    Value<String?>? vendorName,
    Value<String>? status,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BatteriesCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      specification: specification ?? this.specification,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      installDate: installDate ?? this.installDate,
      installOdometer: installOdometer ?? this.installOdometer,
      costPaisa: costPaisa ?? this.costPaisa,
      warrantyEndDate: warrantyEndDate ?? this.warrantyEndDate,
      vendorName: vendorName ?? this.vendorName,
      status: status ?? this.status,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (specification.present) {
      map['specification'] = Variable<String>(specification.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (installDate.present) {
      map['install_date'] = Variable<DateTime>(installDate.value);
    }
    if (installOdometer.present) {
      map['install_odometer'] = Variable<int>(installOdometer.value);
    }
    if (costPaisa.present) {
      map['cost_paisa'] = Variable<int>(costPaisa.value);
    }
    if (warrantyEndDate.present) {
      map['warranty_end_date'] = Variable<DateTime>(warrantyEndDate.value);
    }
    if (vendorName.present) {
      map['vendor_name'] = Variable<String>(vendorName.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BatteriesCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('specification: $specification, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('installDate: $installDate, ')
          ..write('installOdometer: $installOdometer, ')
          ..write('costPaisa: $costPaisa, ')
          ..write('warrantyEndDate: $warrantyEndDate, ')
          ..write('vendorName: $vendorName, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VehicleDocumentsTable extends VehicleDocuments
    with TableInfo<$VehicleDocumentsTable, VehicleDocumentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehicleDocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  static const VerificationMeta _documentTypeMeta = const VerificationMeta(
    'documentType',
  );
  @override
  late final GeneratedColumn<String> documentType = GeneratedColumn<String>(
    'document_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentNumberMeta = const VerificationMeta(
    'documentNumber',
  );
  @override
  late final GeneratedColumn<String> documentNumber = GeneratedColumn<String>(
    'document_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _issueDateMeta = const VerificationMeta(
    'issueDate',
  );
  @override
  late final GeneratedColumn<DateTime> issueDate = GeneratedColumn<DateTime>(
    'issue_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expiryDateMeta = const VerificationMeta(
    'expiryDate',
  );
  @override
  late final GeneratedColumn<DateTime> expiryDate = GeneratedColumn<DateTime>(
    'expiry_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _feePaisaMeta = const VerificationMeta(
    'feePaisa',
  );
  @override
  late final GeneratedColumn<int> feePaisa = GeneratedColumn<int>(
    'fee_paisa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _issuingAuthorityMeta = const VerificationMeta(
    'issuingAuthority',
  );
  @override
  late final GeneratedColumn<String> issuingAuthority = GeneratedColumn<String>(
    'issuing_authority',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _providerNameMeta = const VerificationMeta(
    'providerName',
  );
  @override
  late final GeneratedColumn<String> providerName = GeneratedColumn<String>(
    'provider_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _policyNumberMeta = const VerificationMeta(
    'policyNumber',
  );
  @override
  late final GeneratedColumn<String> policyNumber = GeneratedColumn<String>(
    'policy_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverageTypeMeta = const VerificationMeta(
    'coverageType',
  );
  @override
  late final GeneratedColumn<String> coverageType = GeneratedColumn<String>(
    'coverage_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ownerNameMeta = const VerificationMeta(
    'ownerName',
  );
  @override
  late final GeneratedColumn<String> ownerName = GeneratedColumn<String>(
    'owner_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    documentType,
    documentNumber,
    issueDate,
    expiryDate,
    feePaisa,
    issuingAuthority,
    providerName,
    policyNumber,
    coverageType,
    ownerName,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicle_documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<VehicleDocumentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('document_type')) {
      context.handle(
        _documentTypeMeta,
        documentType.isAcceptableOrUnknown(
          data['document_type']!,
          _documentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentTypeMeta);
    }
    if (data.containsKey('document_number')) {
      context.handle(
        _documentNumberMeta,
        documentNumber.isAcceptableOrUnknown(
          data['document_number']!,
          _documentNumberMeta,
        ),
      );
    }
    if (data.containsKey('issue_date')) {
      context.handle(
        _issueDateMeta,
        issueDate.isAcceptableOrUnknown(data['issue_date']!, _issueDateMeta),
      );
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
        _expiryDateMeta,
        expiryDate.isAcceptableOrUnknown(data['expiry_date']!, _expiryDateMeta),
      );
    }
    if (data.containsKey('fee_paisa')) {
      context.handle(
        _feePaisaMeta,
        feePaisa.isAcceptableOrUnknown(data['fee_paisa']!, _feePaisaMeta),
      );
    }
    if (data.containsKey('issuing_authority')) {
      context.handle(
        _issuingAuthorityMeta,
        issuingAuthority.isAcceptableOrUnknown(
          data['issuing_authority']!,
          _issuingAuthorityMeta,
        ),
      );
    }
    if (data.containsKey('provider_name')) {
      context.handle(
        _providerNameMeta,
        providerName.isAcceptableOrUnknown(
          data['provider_name']!,
          _providerNameMeta,
        ),
      );
    }
    if (data.containsKey('policy_number')) {
      context.handle(
        _policyNumberMeta,
        policyNumber.isAcceptableOrUnknown(
          data['policy_number']!,
          _policyNumberMeta,
        ),
      );
    }
    if (data.containsKey('coverage_type')) {
      context.handle(
        _coverageTypeMeta,
        coverageType.isAcceptableOrUnknown(
          data['coverage_type']!,
          _coverageTypeMeta,
        ),
      );
    }
    if (data.containsKey('owner_name')) {
      context.handle(
        _ownerNameMeta,
        ownerName.isAcceptableOrUnknown(data['owner_name']!, _ownerNameMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VehicleDocumentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VehicleDocumentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      documentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_type'],
      )!,
      documentNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_number'],
      ),
      issueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}issue_date'],
      ),
      expiryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expiry_date'],
      ),
      feePaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fee_paisa'],
      )!,
      issuingAuthority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}issuing_authority'],
      ),
      providerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider_name'],
      ),
      policyNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}policy_number'],
      ),
      coverageType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coverage_type'],
      ),
      ownerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_name'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $VehicleDocumentsTable createAlias(String alias) {
    return $VehicleDocumentsTable(attachedDatabase, alias);
  }
}

class VehicleDocumentRow extends DataClass
    implements Insertable<VehicleDocumentRow> {
  final String id;
  final String vehicleId;

  /// registration | tax_token | fitness | insurance | route_permit |
  /// driving_license | ownership_transfer | loan | other
  final String documentType;
  final String? documentNumber;
  final DateTime? issueDate;
  final DateTime? expiryDate;
  final int feePaisa;
  final String? issuingAuthority;
  final String? providerName;
  final String? policyNumber;
  final String? coverageType;
  final String? ownerName;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const VehicleDocumentRow({
    required this.id,
    required this.vehicleId,
    required this.documentType,
    this.documentNumber,
    this.issueDate,
    this.expiryDate,
    required this.feePaisa,
    this.issuingAuthority,
    this.providerName,
    this.policyNumber,
    this.coverageType,
    this.ownerName,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['document_type'] = Variable<String>(documentType);
    if (!nullToAbsent || documentNumber != null) {
      map['document_number'] = Variable<String>(documentNumber);
    }
    if (!nullToAbsent || issueDate != null) {
      map['issue_date'] = Variable<DateTime>(issueDate);
    }
    if (!nullToAbsent || expiryDate != null) {
      map['expiry_date'] = Variable<DateTime>(expiryDate);
    }
    map['fee_paisa'] = Variable<int>(feePaisa);
    if (!nullToAbsent || issuingAuthority != null) {
      map['issuing_authority'] = Variable<String>(issuingAuthority);
    }
    if (!nullToAbsent || providerName != null) {
      map['provider_name'] = Variable<String>(providerName);
    }
    if (!nullToAbsent || policyNumber != null) {
      map['policy_number'] = Variable<String>(policyNumber);
    }
    if (!nullToAbsent || coverageType != null) {
      map['coverage_type'] = Variable<String>(coverageType);
    }
    if (!nullToAbsent || ownerName != null) {
      map['owner_name'] = Variable<String>(ownerName);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  VehicleDocumentsCompanion toCompanion(bool nullToAbsent) {
    return VehicleDocumentsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      documentType: Value(documentType),
      documentNumber: documentNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(documentNumber),
      issueDate: issueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(issueDate),
      expiryDate: expiryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expiryDate),
      feePaisa: Value(feePaisa),
      issuingAuthority: issuingAuthority == null && nullToAbsent
          ? const Value.absent()
          : Value(issuingAuthority),
      providerName: providerName == null && nullToAbsent
          ? const Value.absent()
          : Value(providerName),
      policyNumber: policyNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(policyNumber),
      coverageType: coverageType == null && nullToAbsent
          ? const Value.absent()
          : Value(coverageType),
      ownerName: ownerName == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerName),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory VehicleDocumentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehicleDocumentRow(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      documentType: serializer.fromJson<String>(json['documentType']),
      documentNumber: serializer.fromJson<String?>(json['documentNumber']),
      issueDate: serializer.fromJson<DateTime?>(json['issueDate']),
      expiryDate: serializer.fromJson<DateTime?>(json['expiryDate']),
      feePaisa: serializer.fromJson<int>(json['feePaisa']),
      issuingAuthority: serializer.fromJson<String?>(json['issuingAuthority']),
      providerName: serializer.fromJson<String?>(json['providerName']),
      policyNumber: serializer.fromJson<String?>(json['policyNumber']),
      coverageType: serializer.fromJson<String?>(json['coverageType']),
      ownerName: serializer.fromJson<String?>(json['ownerName']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'documentType': serializer.toJson<String>(documentType),
      'documentNumber': serializer.toJson<String?>(documentNumber),
      'issueDate': serializer.toJson<DateTime?>(issueDate),
      'expiryDate': serializer.toJson<DateTime?>(expiryDate),
      'feePaisa': serializer.toJson<int>(feePaisa),
      'issuingAuthority': serializer.toJson<String?>(issuingAuthority),
      'providerName': serializer.toJson<String?>(providerName),
      'policyNumber': serializer.toJson<String?>(policyNumber),
      'coverageType': serializer.toJson<String?>(coverageType),
      'ownerName': serializer.toJson<String?>(ownerName),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  VehicleDocumentRow copyWith({
    String? id,
    String? vehicleId,
    String? documentType,
    Value<String?> documentNumber = const Value.absent(),
    Value<DateTime?> issueDate = const Value.absent(),
    Value<DateTime?> expiryDate = const Value.absent(),
    int? feePaisa,
    Value<String?> issuingAuthority = const Value.absent(),
    Value<String?> providerName = const Value.absent(),
    Value<String?> policyNumber = const Value.absent(),
    Value<String?> coverageType = const Value.absent(),
    Value<String?> ownerName = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => VehicleDocumentRow(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    documentType: documentType ?? this.documentType,
    documentNumber: documentNumber.present
        ? documentNumber.value
        : this.documentNumber,
    issueDate: issueDate.present ? issueDate.value : this.issueDate,
    expiryDate: expiryDate.present ? expiryDate.value : this.expiryDate,
    feePaisa: feePaisa ?? this.feePaisa,
    issuingAuthority: issuingAuthority.present
        ? issuingAuthority.value
        : this.issuingAuthority,
    providerName: providerName.present ? providerName.value : this.providerName,
    policyNumber: policyNumber.present ? policyNumber.value : this.policyNumber,
    coverageType: coverageType.present ? coverageType.value : this.coverageType,
    ownerName: ownerName.present ? ownerName.value : this.ownerName,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  VehicleDocumentRow copyWithCompanion(VehicleDocumentsCompanion data) {
    return VehicleDocumentRow(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      documentType: data.documentType.present
          ? data.documentType.value
          : this.documentType,
      documentNumber: data.documentNumber.present
          ? data.documentNumber.value
          : this.documentNumber,
      issueDate: data.issueDate.present ? data.issueDate.value : this.issueDate,
      expiryDate: data.expiryDate.present
          ? data.expiryDate.value
          : this.expiryDate,
      feePaisa: data.feePaisa.present ? data.feePaisa.value : this.feePaisa,
      issuingAuthority: data.issuingAuthority.present
          ? data.issuingAuthority.value
          : this.issuingAuthority,
      providerName: data.providerName.present
          ? data.providerName.value
          : this.providerName,
      policyNumber: data.policyNumber.present
          ? data.policyNumber.value
          : this.policyNumber,
      coverageType: data.coverageType.present
          ? data.coverageType.value
          : this.coverageType,
      ownerName: data.ownerName.present ? data.ownerName.value : this.ownerName,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VehicleDocumentRow(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('documentType: $documentType, ')
          ..write('documentNumber: $documentNumber, ')
          ..write('issueDate: $issueDate, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('feePaisa: $feePaisa, ')
          ..write('issuingAuthority: $issuingAuthority, ')
          ..write('providerName: $providerName, ')
          ..write('policyNumber: $policyNumber, ')
          ..write('coverageType: $coverageType, ')
          ..write('ownerName: $ownerName, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    documentType,
    documentNumber,
    issueDate,
    expiryDate,
    feePaisa,
    issuingAuthority,
    providerName,
    policyNumber,
    coverageType,
    ownerName,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehicleDocumentRow &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.documentType == this.documentType &&
          other.documentNumber == this.documentNumber &&
          other.issueDate == this.issueDate &&
          other.expiryDate == this.expiryDate &&
          other.feePaisa == this.feePaisa &&
          other.issuingAuthority == this.issuingAuthority &&
          other.providerName == this.providerName &&
          other.policyNumber == this.policyNumber &&
          other.coverageType == this.coverageType &&
          other.ownerName == this.ownerName &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class VehicleDocumentsCompanion extends UpdateCompanion<VehicleDocumentRow> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<String> documentType;
  final Value<String?> documentNumber;
  final Value<DateTime?> issueDate;
  final Value<DateTime?> expiryDate;
  final Value<int> feePaisa;
  final Value<String?> issuingAuthority;
  final Value<String?> providerName;
  final Value<String?> policyNumber;
  final Value<String?> coverageType;
  final Value<String?> ownerName;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const VehicleDocumentsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.documentType = const Value.absent(),
    this.documentNumber = const Value.absent(),
    this.issueDate = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.feePaisa = const Value.absent(),
    this.issuingAuthority = const Value.absent(),
    this.providerName = const Value.absent(),
    this.policyNumber = const Value.absent(),
    this.coverageType = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehicleDocumentsCompanion.insert({
    required String id,
    required String vehicleId,
    required String documentType,
    this.documentNumber = const Value.absent(),
    this.issueDate = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.feePaisa = const Value.absent(),
    this.issuingAuthority = const Value.absent(),
    this.providerName = const Value.absent(),
    this.policyNumber = const Value.absent(),
    this.coverageType = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       documentType = Value(documentType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<VehicleDocumentRow> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<String>? documentType,
    Expression<String>? documentNumber,
    Expression<DateTime>? issueDate,
    Expression<DateTime>? expiryDate,
    Expression<int>? feePaisa,
    Expression<String>? issuingAuthority,
    Expression<String>? providerName,
    Expression<String>? policyNumber,
    Expression<String>? coverageType,
    Expression<String>? ownerName,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (documentType != null) 'document_type': documentType,
      if (documentNumber != null) 'document_number': documentNumber,
      if (issueDate != null) 'issue_date': issueDate,
      if (expiryDate != null) 'expiry_date': expiryDate,
      if (feePaisa != null) 'fee_paisa': feePaisa,
      if (issuingAuthority != null) 'issuing_authority': issuingAuthority,
      if (providerName != null) 'provider_name': providerName,
      if (policyNumber != null) 'policy_number': policyNumber,
      if (coverageType != null) 'coverage_type': coverageType,
      if (ownerName != null) 'owner_name': ownerName,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehicleDocumentsCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<String>? documentType,
    Value<String?>? documentNumber,
    Value<DateTime?>? issueDate,
    Value<DateTime?>? expiryDate,
    Value<int>? feePaisa,
    Value<String?>? issuingAuthority,
    Value<String?>? providerName,
    Value<String?>? policyNumber,
    Value<String?>? coverageType,
    Value<String?>? ownerName,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return VehicleDocumentsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      documentType: documentType ?? this.documentType,
      documentNumber: documentNumber ?? this.documentNumber,
      issueDate: issueDate ?? this.issueDate,
      expiryDate: expiryDate ?? this.expiryDate,
      feePaisa: feePaisa ?? this.feePaisa,
      issuingAuthority: issuingAuthority ?? this.issuingAuthority,
      providerName: providerName ?? this.providerName,
      policyNumber: policyNumber ?? this.policyNumber,
      coverageType: coverageType ?? this.coverageType,
      ownerName: ownerName ?? this.ownerName,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (documentType.present) {
      map['document_type'] = Variable<String>(documentType.value);
    }
    if (documentNumber.present) {
      map['document_number'] = Variable<String>(documentNumber.value);
    }
    if (issueDate.present) {
      map['issue_date'] = Variable<DateTime>(issueDate.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<DateTime>(expiryDate.value);
    }
    if (feePaisa.present) {
      map['fee_paisa'] = Variable<int>(feePaisa.value);
    }
    if (issuingAuthority.present) {
      map['issuing_authority'] = Variable<String>(issuingAuthority.value);
    }
    if (providerName.present) {
      map['provider_name'] = Variable<String>(providerName.value);
    }
    if (policyNumber.present) {
      map['policy_number'] = Variable<String>(policyNumber.value);
    }
    if (coverageType.present) {
      map['coverage_type'] = Variable<String>(coverageType.value);
    }
    if (ownerName.present) {
      map['owner_name'] = Variable<String>(ownerName.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehicleDocumentsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('documentType: $documentType, ')
          ..write('documentNumber: $documentNumber, ')
          ..write('issueDate: $issueDate, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('feePaisa: $feePaisa, ')
          ..write('issuingAuthority: $issuingAuthority, ')
          ..write('providerName: $providerName, ')
          ..write('policyNumber: $policyNumber, ')
          ..write('coverageType: $coverageType, ')
          ..write('ownerName: $ownerName, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, ReminderRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id)',
    ),
  );
  static const VerificationMeta _relatedEntityTypeMeta = const VerificationMeta(
    'relatedEntityType',
  );
  @override
  late final GeneratedColumn<String> relatedEntityType =
      GeneratedColumn<String>(
        'related_entity_type',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _relatedEntityIdMeta = const VerificationMeta(
    'relatedEntityId',
  );
  @override
  late final GeneratedColumn<String> relatedEntityId = GeneratedColumn<String>(
    'related_entity_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderTypeMeta = const VerificationMeta(
    'reminderType',
  );
  @override
  late final GeneratedColumn<String> reminderType = GeneratedColumn<String>(
    'reminder_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueOdometerMeta = const VerificationMeta(
    'dueOdometer',
  );
  @override
  late final GeneratedColumn<int> dueOdometer = GeneratedColumn<int>(
    'due_odometer',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _advanceDaysMeta = const VerificationMeta(
    'advanceDays',
  );
  @override
  late final GeneratedColumn<int> advanceDays = GeneratedColumn<int>(
    'advance_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _advanceKmMeta = const VerificationMeta(
    'advanceKm',
  );
  @override
  late final GeneratedColumn<int> advanceKm = GeneratedColumn<int>(
    'advance_km',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(500),
  );
  static const VerificationMeta _recurrenceTypeMeta = const VerificationMeta(
    'recurrenceType',
  );
  @override
  late final GeneratedColumn<String> recurrenceType = GeneratedColumn<String>(
    'recurrence_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
  );
  static const VerificationMeta _recurrenceDaysMeta = const VerificationMeta(
    'recurrenceDays',
  );
  @override
  late final GeneratedColumn<int> recurrenceDays = GeneratedColumn<int>(
    'recurrence_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recurrenceKmMeta = const VerificationMeta(
    'recurrenceKm',
  );
  @override
  late final GeneratedColumn<int> recurrenceKm = GeneratedColumn<int>(
    'recurrence_km',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('upcoming'),
  );
  static const VerificationMeta _notificationEnabledMeta =
      const VerificationMeta('notificationEnabled');
  @override
  late final GeneratedColumn<bool> notificationEnabled = GeneratedColumn<bool>(
    'notification_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notification_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _snoozedUntilMeta = const VerificationMeta(
    'snoozedUntil',
  );
  @override
  late final GeneratedColumn<DateTime> snoozedUntil = GeneratedColumn<DateTime>(
    'snoozed_until',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastTriggeredAtMeta = const VerificationMeta(
    'lastTriggeredAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastTriggeredAt =
      GeneratedColumn<DateTime>(
        'last_triggered_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    relatedEntityType,
    relatedEntityId,
    reminderType,
    title,
    description,
    dueDate,
    dueOdometer,
    advanceDays,
    advanceKm,
    recurrenceType,
    recurrenceDays,
    recurrenceKm,
    status,
    notificationEnabled,
    snoozedUntil,
    lastTriggeredAt,
    completedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('related_entity_type')) {
      context.handle(
        _relatedEntityTypeMeta,
        relatedEntityType.isAcceptableOrUnknown(
          data['related_entity_type']!,
          _relatedEntityTypeMeta,
        ),
      );
    }
    if (data.containsKey('related_entity_id')) {
      context.handle(
        _relatedEntityIdMeta,
        relatedEntityId.isAcceptableOrUnknown(
          data['related_entity_id']!,
          _relatedEntityIdMeta,
        ),
      );
    }
    if (data.containsKey('reminder_type')) {
      context.handle(
        _reminderTypeMeta,
        reminderType.isAcceptableOrUnknown(
          data['reminder_type']!,
          _reminderTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reminderTypeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('due_odometer')) {
      context.handle(
        _dueOdometerMeta,
        dueOdometer.isAcceptableOrUnknown(
          data['due_odometer']!,
          _dueOdometerMeta,
        ),
      );
    }
    if (data.containsKey('advance_days')) {
      context.handle(
        _advanceDaysMeta,
        advanceDays.isAcceptableOrUnknown(
          data['advance_days']!,
          _advanceDaysMeta,
        ),
      );
    }
    if (data.containsKey('advance_km')) {
      context.handle(
        _advanceKmMeta,
        advanceKm.isAcceptableOrUnknown(data['advance_km']!, _advanceKmMeta),
      );
    }
    if (data.containsKey('recurrence_type')) {
      context.handle(
        _recurrenceTypeMeta,
        recurrenceType.isAcceptableOrUnknown(
          data['recurrence_type']!,
          _recurrenceTypeMeta,
        ),
      );
    }
    if (data.containsKey('recurrence_days')) {
      context.handle(
        _recurrenceDaysMeta,
        recurrenceDays.isAcceptableOrUnknown(
          data['recurrence_days']!,
          _recurrenceDaysMeta,
        ),
      );
    }
    if (data.containsKey('recurrence_km')) {
      context.handle(
        _recurrenceKmMeta,
        recurrenceKm.isAcceptableOrUnknown(
          data['recurrence_km']!,
          _recurrenceKmMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('notification_enabled')) {
      context.handle(
        _notificationEnabledMeta,
        notificationEnabled.isAcceptableOrUnknown(
          data['notification_enabled']!,
          _notificationEnabledMeta,
        ),
      );
    }
    if (data.containsKey('snoozed_until')) {
      context.handle(
        _snoozedUntilMeta,
        snoozedUntil.isAcceptableOrUnknown(
          data['snoozed_until']!,
          _snoozedUntilMeta,
        ),
      );
    }
    if (data.containsKey('last_triggered_at')) {
      context.handle(
        _lastTriggeredAtMeta,
        lastTriggeredAt.isAcceptableOrUnknown(
          data['last_triggered_at']!,
          _lastTriggeredAtMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReminderRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      relatedEntityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}related_entity_type'],
      ),
      relatedEntityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}related_entity_id'],
      ),
      reminderType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      dueOdometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_odometer'],
      ),
      advanceDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}advance_days'],
      )!,
      advanceKm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}advance_km'],
      )!,
      recurrenceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence_type'],
      )!,
      recurrenceDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recurrence_days'],
      ),
      recurrenceKm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recurrence_km'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notificationEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notification_enabled'],
      )!,
      snoozedUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}snoozed_until'],
      ),
      lastTriggeredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_triggered_at'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }
}

class ReminderRow extends DataClass implements Insertable<ReminderRow> {
  final String id;
  final String vehicleId;

  /// document | service | oil | custom | tyre | battery | other
  final String? relatedEntityType;
  final String? relatedEntityId;

  /// date | odometer | combined
  final String reminderType;
  final String title;
  final String? description;
  final DateTime? dueDate;
  final int? dueOdometer;
  final int advanceDays;
  final int advanceKm;

  /// none | daily | weekly | monthly | custom_days | custom_km
  final String recurrenceType;
  final int? recurrenceDays;
  final int? recurrenceKm;

  /// upcoming | due_soon | due | overdue | completed | skipped
  final String status;
  final bool notificationEnabled;
  final DateTime? snoozedUntil;
  final DateTime? lastTriggeredAt;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ReminderRow({
    required this.id,
    required this.vehicleId,
    this.relatedEntityType,
    this.relatedEntityId,
    required this.reminderType,
    required this.title,
    this.description,
    this.dueDate,
    this.dueOdometer,
    required this.advanceDays,
    required this.advanceKm,
    required this.recurrenceType,
    this.recurrenceDays,
    this.recurrenceKm,
    required this.status,
    required this.notificationEnabled,
    this.snoozedUntil,
    this.lastTriggeredAt,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    if (!nullToAbsent || relatedEntityType != null) {
      map['related_entity_type'] = Variable<String>(relatedEntityType);
    }
    if (!nullToAbsent || relatedEntityId != null) {
      map['related_entity_id'] = Variable<String>(relatedEntityId);
    }
    map['reminder_type'] = Variable<String>(reminderType);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    if (!nullToAbsent || dueOdometer != null) {
      map['due_odometer'] = Variable<int>(dueOdometer);
    }
    map['advance_days'] = Variable<int>(advanceDays);
    map['advance_km'] = Variable<int>(advanceKm);
    map['recurrence_type'] = Variable<String>(recurrenceType);
    if (!nullToAbsent || recurrenceDays != null) {
      map['recurrence_days'] = Variable<int>(recurrenceDays);
    }
    if (!nullToAbsent || recurrenceKm != null) {
      map['recurrence_km'] = Variable<int>(recurrenceKm);
    }
    map['status'] = Variable<String>(status);
    map['notification_enabled'] = Variable<bool>(notificationEnabled);
    if (!nullToAbsent || snoozedUntil != null) {
      map['snoozed_until'] = Variable<DateTime>(snoozedUntil);
    }
    if (!nullToAbsent || lastTriggeredAt != null) {
      map['last_triggered_at'] = Variable<DateTime>(lastTriggeredAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      relatedEntityType: relatedEntityType == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedEntityType),
      relatedEntityId: relatedEntityId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedEntityId),
      reminderType: Value(reminderType),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      dueOdometer: dueOdometer == null && nullToAbsent
          ? const Value.absent()
          : Value(dueOdometer),
      advanceDays: Value(advanceDays),
      advanceKm: Value(advanceKm),
      recurrenceType: Value(recurrenceType),
      recurrenceDays: recurrenceDays == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceDays),
      recurrenceKm: recurrenceKm == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceKm),
      status: Value(status),
      notificationEnabled: Value(notificationEnabled),
      snoozedUntil: snoozedUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(snoozedUntil),
      lastTriggeredAt: lastTriggeredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastTriggeredAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ReminderRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderRow(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      relatedEntityType: serializer.fromJson<String?>(
        json['relatedEntityType'],
      ),
      relatedEntityId: serializer.fromJson<String?>(json['relatedEntityId']),
      reminderType: serializer.fromJson<String>(json['reminderType']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      dueOdometer: serializer.fromJson<int?>(json['dueOdometer']),
      advanceDays: serializer.fromJson<int>(json['advanceDays']),
      advanceKm: serializer.fromJson<int>(json['advanceKm']),
      recurrenceType: serializer.fromJson<String>(json['recurrenceType']),
      recurrenceDays: serializer.fromJson<int?>(json['recurrenceDays']),
      recurrenceKm: serializer.fromJson<int?>(json['recurrenceKm']),
      status: serializer.fromJson<String>(json['status']),
      notificationEnabled: serializer.fromJson<bool>(
        json['notificationEnabled'],
      ),
      snoozedUntil: serializer.fromJson<DateTime?>(json['snoozedUntil']),
      lastTriggeredAt: serializer.fromJson<DateTime?>(json['lastTriggeredAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'relatedEntityType': serializer.toJson<String?>(relatedEntityType),
      'relatedEntityId': serializer.toJson<String?>(relatedEntityId),
      'reminderType': serializer.toJson<String>(reminderType),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'dueOdometer': serializer.toJson<int?>(dueOdometer),
      'advanceDays': serializer.toJson<int>(advanceDays),
      'advanceKm': serializer.toJson<int>(advanceKm),
      'recurrenceType': serializer.toJson<String>(recurrenceType),
      'recurrenceDays': serializer.toJson<int?>(recurrenceDays),
      'recurrenceKm': serializer.toJson<int?>(recurrenceKm),
      'status': serializer.toJson<String>(status),
      'notificationEnabled': serializer.toJson<bool>(notificationEnabled),
      'snoozedUntil': serializer.toJson<DateTime?>(snoozedUntil),
      'lastTriggeredAt': serializer.toJson<DateTime?>(lastTriggeredAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ReminderRow copyWith({
    String? id,
    String? vehicleId,
    Value<String?> relatedEntityType = const Value.absent(),
    Value<String?> relatedEntityId = const Value.absent(),
    String? reminderType,
    String? title,
    Value<String?> description = const Value.absent(),
    Value<DateTime?> dueDate = const Value.absent(),
    Value<int?> dueOdometer = const Value.absent(),
    int? advanceDays,
    int? advanceKm,
    String? recurrenceType,
    Value<int?> recurrenceDays = const Value.absent(),
    Value<int?> recurrenceKm = const Value.absent(),
    String? status,
    bool? notificationEnabled,
    Value<DateTime?> snoozedUntil = const Value.absent(),
    Value<DateTime?> lastTriggeredAt = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ReminderRow(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    relatedEntityType: relatedEntityType.present
        ? relatedEntityType.value
        : this.relatedEntityType,
    relatedEntityId: relatedEntityId.present
        ? relatedEntityId.value
        : this.relatedEntityId,
    reminderType: reminderType ?? this.reminderType,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    dueOdometer: dueOdometer.present ? dueOdometer.value : this.dueOdometer,
    advanceDays: advanceDays ?? this.advanceDays,
    advanceKm: advanceKm ?? this.advanceKm,
    recurrenceType: recurrenceType ?? this.recurrenceType,
    recurrenceDays: recurrenceDays.present
        ? recurrenceDays.value
        : this.recurrenceDays,
    recurrenceKm: recurrenceKm.present ? recurrenceKm.value : this.recurrenceKm,
    status: status ?? this.status,
    notificationEnabled: notificationEnabled ?? this.notificationEnabled,
    snoozedUntil: snoozedUntil.present ? snoozedUntil.value : this.snoozedUntil,
    lastTriggeredAt: lastTriggeredAt.present
        ? lastTriggeredAt.value
        : this.lastTriggeredAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ReminderRow copyWithCompanion(RemindersCompanion data) {
    return ReminderRow(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      relatedEntityType: data.relatedEntityType.present
          ? data.relatedEntityType.value
          : this.relatedEntityType,
      relatedEntityId: data.relatedEntityId.present
          ? data.relatedEntityId.value
          : this.relatedEntityId,
      reminderType: data.reminderType.present
          ? data.reminderType.value
          : this.reminderType,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      dueOdometer: data.dueOdometer.present
          ? data.dueOdometer.value
          : this.dueOdometer,
      advanceDays: data.advanceDays.present
          ? data.advanceDays.value
          : this.advanceDays,
      advanceKm: data.advanceKm.present ? data.advanceKm.value : this.advanceKm,
      recurrenceType: data.recurrenceType.present
          ? data.recurrenceType.value
          : this.recurrenceType,
      recurrenceDays: data.recurrenceDays.present
          ? data.recurrenceDays.value
          : this.recurrenceDays,
      recurrenceKm: data.recurrenceKm.present
          ? data.recurrenceKm.value
          : this.recurrenceKm,
      status: data.status.present ? data.status.value : this.status,
      notificationEnabled: data.notificationEnabled.present
          ? data.notificationEnabled.value
          : this.notificationEnabled,
      snoozedUntil: data.snoozedUntil.present
          ? data.snoozedUntil.value
          : this.snoozedUntil,
      lastTriggeredAt: data.lastTriggeredAt.present
          ? data.lastTriggeredAt.value
          : this.lastTriggeredAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderRow(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('relatedEntityType: $relatedEntityType, ')
          ..write('relatedEntityId: $relatedEntityId, ')
          ..write('reminderType: $reminderType, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('dueDate: $dueDate, ')
          ..write('dueOdometer: $dueOdometer, ')
          ..write('advanceDays: $advanceDays, ')
          ..write('advanceKm: $advanceKm, ')
          ..write('recurrenceType: $recurrenceType, ')
          ..write('recurrenceDays: $recurrenceDays, ')
          ..write('recurrenceKm: $recurrenceKm, ')
          ..write('status: $status, ')
          ..write('notificationEnabled: $notificationEnabled, ')
          ..write('snoozedUntil: $snoozedUntil, ')
          ..write('lastTriggeredAt: $lastTriggeredAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    vehicleId,
    relatedEntityType,
    relatedEntityId,
    reminderType,
    title,
    description,
    dueDate,
    dueOdometer,
    advanceDays,
    advanceKm,
    recurrenceType,
    recurrenceDays,
    recurrenceKm,
    status,
    notificationEnabled,
    snoozedUntil,
    lastTriggeredAt,
    completedAt,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderRow &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.relatedEntityType == this.relatedEntityType &&
          other.relatedEntityId == this.relatedEntityId &&
          other.reminderType == this.reminderType &&
          other.title == this.title &&
          other.description == this.description &&
          other.dueDate == this.dueDate &&
          other.dueOdometer == this.dueOdometer &&
          other.advanceDays == this.advanceDays &&
          other.advanceKm == this.advanceKm &&
          other.recurrenceType == this.recurrenceType &&
          other.recurrenceDays == this.recurrenceDays &&
          other.recurrenceKm == this.recurrenceKm &&
          other.status == this.status &&
          other.notificationEnabled == this.notificationEnabled &&
          other.snoozedUntil == this.snoozedUntil &&
          other.lastTriggeredAt == this.lastTriggeredAt &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RemindersCompanion extends UpdateCompanion<ReminderRow> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<String?> relatedEntityType;
  final Value<String?> relatedEntityId;
  final Value<String> reminderType;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime?> dueDate;
  final Value<int?> dueOdometer;
  final Value<int> advanceDays;
  final Value<int> advanceKm;
  final Value<String> recurrenceType;
  final Value<int?> recurrenceDays;
  final Value<int?> recurrenceKm;
  final Value<String> status;
  final Value<bool> notificationEnabled;
  final Value<DateTime?> snoozedUntil;
  final Value<DateTime?> lastTriggeredAt;
  final Value<DateTime?> completedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.relatedEntityType = const Value.absent(),
    this.relatedEntityId = const Value.absent(),
    this.reminderType = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.dueOdometer = const Value.absent(),
    this.advanceDays = const Value.absent(),
    this.advanceKm = const Value.absent(),
    this.recurrenceType = const Value.absent(),
    this.recurrenceDays = const Value.absent(),
    this.recurrenceKm = const Value.absent(),
    this.status = const Value.absent(),
    this.notificationEnabled = const Value.absent(),
    this.snoozedUntil = const Value.absent(),
    this.lastTriggeredAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemindersCompanion.insert({
    required String id,
    required String vehicleId,
    this.relatedEntityType = const Value.absent(),
    this.relatedEntityId = const Value.absent(),
    required String reminderType,
    required String title,
    this.description = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.dueOdometer = const Value.absent(),
    this.advanceDays = const Value.absent(),
    this.advanceKm = const Value.absent(),
    this.recurrenceType = const Value.absent(),
    this.recurrenceDays = const Value.absent(),
    this.recurrenceKm = const Value.absent(),
    this.status = const Value.absent(),
    this.notificationEnabled = const Value.absent(),
    this.snoozedUntil = const Value.absent(),
    this.lastTriggeredAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       reminderType = Value(reminderType),
       title = Value(title),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ReminderRow> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<String>? relatedEntityType,
    Expression<String>? relatedEntityId,
    Expression<String>? reminderType,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? dueDate,
    Expression<int>? dueOdometer,
    Expression<int>? advanceDays,
    Expression<int>? advanceKm,
    Expression<String>? recurrenceType,
    Expression<int>? recurrenceDays,
    Expression<int>? recurrenceKm,
    Expression<String>? status,
    Expression<bool>? notificationEnabled,
    Expression<DateTime>? snoozedUntil,
    Expression<DateTime>? lastTriggeredAt,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (relatedEntityType != null) 'related_entity_type': relatedEntityType,
      if (relatedEntityId != null) 'related_entity_id': relatedEntityId,
      if (reminderType != null) 'reminder_type': reminderType,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (dueDate != null) 'due_date': dueDate,
      if (dueOdometer != null) 'due_odometer': dueOdometer,
      if (advanceDays != null) 'advance_days': advanceDays,
      if (advanceKm != null) 'advance_km': advanceKm,
      if (recurrenceType != null) 'recurrence_type': recurrenceType,
      if (recurrenceDays != null) 'recurrence_days': recurrenceDays,
      if (recurrenceKm != null) 'recurrence_km': recurrenceKm,
      if (status != null) 'status': status,
      if (notificationEnabled != null)
        'notification_enabled': notificationEnabled,
      if (snoozedUntil != null) 'snoozed_until': snoozedUntil,
      if (lastTriggeredAt != null) 'last_triggered_at': lastTriggeredAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<String?>? relatedEntityType,
    Value<String?>? relatedEntityId,
    Value<String>? reminderType,
    Value<String>? title,
    Value<String?>? description,
    Value<DateTime?>? dueDate,
    Value<int?>? dueOdometer,
    Value<int>? advanceDays,
    Value<int>? advanceKm,
    Value<String>? recurrenceType,
    Value<int?>? recurrenceDays,
    Value<int?>? recurrenceKm,
    Value<String>? status,
    Value<bool>? notificationEnabled,
    Value<DateTime?>? snoozedUntil,
    Value<DateTime?>? lastTriggeredAt,
    Value<DateTime?>? completedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RemindersCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      relatedEntityType: relatedEntityType ?? this.relatedEntityType,
      relatedEntityId: relatedEntityId ?? this.relatedEntityId,
      reminderType: reminderType ?? this.reminderType,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      dueOdometer: dueOdometer ?? this.dueOdometer,
      advanceDays: advanceDays ?? this.advanceDays,
      advanceKm: advanceKm ?? this.advanceKm,
      recurrenceType: recurrenceType ?? this.recurrenceType,
      recurrenceDays: recurrenceDays ?? this.recurrenceDays,
      recurrenceKm: recurrenceKm ?? this.recurrenceKm,
      status: status ?? this.status,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
      snoozedUntil: snoozedUntil ?? this.snoozedUntil,
      lastTriggeredAt: lastTriggeredAt ?? this.lastTriggeredAt,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (relatedEntityType.present) {
      map['related_entity_type'] = Variable<String>(relatedEntityType.value);
    }
    if (relatedEntityId.present) {
      map['related_entity_id'] = Variable<String>(relatedEntityId.value);
    }
    if (reminderType.present) {
      map['reminder_type'] = Variable<String>(reminderType.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (dueOdometer.present) {
      map['due_odometer'] = Variable<int>(dueOdometer.value);
    }
    if (advanceDays.present) {
      map['advance_days'] = Variable<int>(advanceDays.value);
    }
    if (advanceKm.present) {
      map['advance_km'] = Variable<int>(advanceKm.value);
    }
    if (recurrenceType.present) {
      map['recurrence_type'] = Variable<String>(recurrenceType.value);
    }
    if (recurrenceDays.present) {
      map['recurrence_days'] = Variable<int>(recurrenceDays.value);
    }
    if (recurrenceKm.present) {
      map['recurrence_km'] = Variable<int>(recurrenceKm.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notificationEnabled.present) {
      map['notification_enabled'] = Variable<bool>(notificationEnabled.value);
    }
    if (snoozedUntil.present) {
      map['snoozed_until'] = Variable<DateTime>(snoozedUntil.value);
    }
    if (lastTriggeredAt.present) {
      map['last_triggered_at'] = Variable<DateTime>(lastTriggeredAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('relatedEntityType: $relatedEntityType, ')
          ..write('relatedEntityId: $relatedEntityId, ')
          ..write('reminderType: $reminderType, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('dueDate: $dueDate, ')
          ..write('dueOdometer: $dueOdometer, ')
          ..write('advanceDays: $advanceDays, ')
          ..write('advanceKm: $advanceKm, ')
          ..write('recurrenceType: $recurrenceType, ')
          ..write('recurrenceDays: $recurrenceDays, ')
          ..write('recurrenceKm: $recurrenceKm, ')
          ..write('status: $status, ')
          ..write('notificationEnabled: $notificationEnabled, ')
          ..write('snoozedUntil: $snoozedUntil, ')
          ..write('lastTriggeredAt: $lastTriggeredAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttachmentsTable extends Attachments
    with TableInfo<$AttachmentsTable, AttachmentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttachmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerTypeMeta = const VerificationMeta(
    'ownerType',
  );
  @override
  late final GeneratedColumn<String> ownerType = GeneratedColumn<String>(
    'owner_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalFileNameMeta = const VerificationMeta(
    'originalFileName',
  );
  @override
  late final GeneratedColumn<String> originalFileName = GeneratedColumn<String>(
    'original_file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _storedFileNameMeta = const VerificationMeta(
    'storedFileName',
  );
  @override
  late final GeneratedColumn<String> storedFileName = GeneratedColumn<String>(
    'stored_file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileSizeBytesMeta = const VerificationMeta(
    'fileSizeBytes',
  );
  @override
  late final GeneratedColumn<int> fileSizeBytes = GeneratedColumn<int>(
    'file_size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relativePathMeta = const VerificationMeta(
    'relativePath',
  );
  @override
  late final GeneratedColumn<String> relativePath = GeneratedColumn<String>(
    'relative_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thumbnailRelativePathMeta =
      const VerificationMeta('thumbnailRelativePath');
  @override
  late final GeneratedColumn<String> thumbnailRelativePath =
      GeneratedColumn<String>(
        'thumbnail_relative_path',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _checksumSha256Meta = const VerificationMeta(
    'checksumSha256',
  );
  @override
  late final GeneratedColumn<String> checksumSha256 = GeneratedColumn<String>(
    'checksum_sha256',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayLabelMeta = const VerificationMeta(
    'displayLabel',
  );
  @override
  late final GeneratedColumn<String> displayLabel = GeneratedColumn<String>(
    'display_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerType,
    ownerId,
    originalFileName,
    storedFileName,
    mimeType,
    fileSizeBytes,
    relativePath,
    thumbnailRelativePath,
    checksumSha256,
    displayLabel,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attachments';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttachmentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_type')) {
      context.handle(
        _ownerTypeMeta,
        ownerType.isAcceptableOrUnknown(data['owner_type']!, _ownerTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerTypeMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('original_file_name')) {
      context.handle(
        _originalFileNameMeta,
        originalFileName.isAcceptableOrUnknown(
          data['original_file_name']!,
          _originalFileNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalFileNameMeta);
    }
    if (data.containsKey('stored_file_name')) {
      context.handle(
        _storedFileNameMeta,
        storedFileName.isAcceptableOrUnknown(
          data['stored_file_name']!,
          _storedFileNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_storedFileNameMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mimeTypeMeta);
    }
    if (data.containsKey('file_size_bytes')) {
      context.handle(
        _fileSizeBytesMeta,
        fileSizeBytes.isAcceptableOrUnknown(
          data['file_size_bytes']!,
          _fileSizeBytesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fileSizeBytesMeta);
    }
    if (data.containsKey('relative_path')) {
      context.handle(
        _relativePathMeta,
        relativePath.isAcceptableOrUnknown(
          data['relative_path']!,
          _relativePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relativePathMeta);
    }
    if (data.containsKey('thumbnail_relative_path')) {
      context.handle(
        _thumbnailRelativePathMeta,
        thumbnailRelativePath.isAcceptableOrUnknown(
          data['thumbnail_relative_path']!,
          _thumbnailRelativePathMeta,
        ),
      );
    }
    if (data.containsKey('checksum_sha256')) {
      context.handle(
        _checksumSha256Meta,
        checksumSha256.isAcceptableOrUnknown(
          data['checksum_sha256']!,
          _checksumSha256Meta,
        ),
      );
    } else if (isInserting) {
      context.missing(_checksumSha256Meta);
    }
    if (data.containsKey('display_label')) {
      context.handle(
        _displayLabelMeta,
        displayLabel.isAcceptableOrUnknown(
          data['display_label']!,
          _displayLabelMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttachmentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttachmentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_type'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      originalFileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_file_name'],
      )!,
      storedFileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stored_file_name'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      )!,
      fileSizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size_bytes'],
      )!,
      relativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_path'],
      )!,
      thumbnailRelativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_relative_path'],
      ),
      checksumSha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}checksum_sha256'],
      )!,
      displayLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_label'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AttachmentsTable createAlias(String alias) {
    return $AttachmentsTable(attachedDatabase, alias);
  }
}

class AttachmentRow extends DataClass implements Insertable<AttachmentRow> {
  final String id;
  final String ownerType;
  final String ownerId;
  final String originalFileName;
  final String storedFileName;
  final String mimeType;
  final int fileSizeBytes;
  final String relativePath;
  final String? thumbnailRelativePath;
  final String checksumSha256;
  final String? displayLabel;
  final DateTime createdAt;
  const AttachmentRow({
    required this.id,
    required this.ownerType,
    required this.ownerId,
    required this.originalFileName,
    required this.storedFileName,
    required this.mimeType,
    required this.fileSizeBytes,
    required this.relativePath,
    this.thumbnailRelativePath,
    required this.checksumSha256,
    this.displayLabel,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_type'] = Variable<String>(ownerType);
    map['owner_id'] = Variable<String>(ownerId);
    map['original_file_name'] = Variable<String>(originalFileName);
    map['stored_file_name'] = Variable<String>(storedFileName);
    map['mime_type'] = Variable<String>(mimeType);
    map['file_size_bytes'] = Variable<int>(fileSizeBytes);
    map['relative_path'] = Variable<String>(relativePath);
    if (!nullToAbsent || thumbnailRelativePath != null) {
      map['thumbnail_relative_path'] = Variable<String>(thumbnailRelativePath);
    }
    map['checksum_sha256'] = Variable<String>(checksumSha256);
    if (!nullToAbsent || displayLabel != null) {
      map['display_label'] = Variable<String>(displayLabel);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AttachmentsCompanion toCompanion(bool nullToAbsent) {
    return AttachmentsCompanion(
      id: Value(id),
      ownerType: Value(ownerType),
      ownerId: Value(ownerId),
      originalFileName: Value(originalFileName),
      storedFileName: Value(storedFileName),
      mimeType: Value(mimeType),
      fileSizeBytes: Value(fileSizeBytes),
      relativePath: Value(relativePath),
      thumbnailRelativePath: thumbnailRelativePath == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailRelativePath),
      checksumSha256: Value(checksumSha256),
      displayLabel: displayLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(displayLabel),
      createdAt: Value(createdAt),
    );
  }

  factory AttachmentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttachmentRow(
      id: serializer.fromJson<String>(json['id']),
      ownerType: serializer.fromJson<String>(json['ownerType']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      originalFileName: serializer.fromJson<String>(json['originalFileName']),
      storedFileName: serializer.fromJson<String>(json['storedFileName']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      fileSizeBytes: serializer.fromJson<int>(json['fileSizeBytes']),
      relativePath: serializer.fromJson<String>(json['relativePath']),
      thumbnailRelativePath: serializer.fromJson<String?>(
        json['thumbnailRelativePath'],
      ),
      checksumSha256: serializer.fromJson<String>(json['checksumSha256']),
      displayLabel: serializer.fromJson<String?>(json['displayLabel']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerType': serializer.toJson<String>(ownerType),
      'ownerId': serializer.toJson<String>(ownerId),
      'originalFileName': serializer.toJson<String>(originalFileName),
      'storedFileName': serializer.toJson<String>(storedFileName),
      'mimeType': serializer.toJson<String>(mimeType),
      'fileSizeBytes': serializer.toJson<int>(fileSizeBytes),
      'relativePath': serializer.toJson<String>(relativePath),
      'thumbnailRelativePath': serializer.toJson<String?>(
        thumbnailRelativePath,
      ),
      'checksumSha256': serializer.toJson<String>(checksumSha256),
      'displayLabel': serializer.toJson<String?>(displayLabel),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AttachmentRow copyWith({
    String? id,
    String? ownerType,
    String? ownerId,
    String? originalFileName,
    String? storedFileName,
    String? mimeType,
    int? fileSizeBytes,
    String? relativePath,
    Value<String?> thumbnailRelativePath = const Value.absent(),
    String? checksumSha256,
    Value<String?> displayLabel = const Value.absent(),
    DateTime? createdAt,
  }) => AttachmentRow(
    id: id ?? this.id,
    ownerType: ownerType ?? this.ownerType,
    ownerId: ownerId ?? this.ownerId,
    originalFileName: originalFileName ?? this.originalFileName,
    storedFileName: storedFileName ?? this.storedFileName,
    mimeType: mimeType ?? this.mimeType,
    fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
    relativePath: relativePath ?? this.relativePath,
    thumbnailRelativePath: thumbnailRelativePath.present
        ? thumbnailRelativePath.value
        : this.thumbnailRelativePath,
    checksumSha256: checksumSha256 ?? this.checksumSha256,
    displayLabel: displayLabel.present ? displayLabel.value : this.displayLabel,
    createdAt: createdAt ?? this.createdAt,
  );
  AttachmentRow copyWithCompanion(AttachmentsCompanion data) {
    return AttachmentRow(
      id: data.id.present ? data.id.value : this.id,
      ownerType: data.ownerType.present ? data.ownerType.value : this.ownerType,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      originalFileName: data.originalFileName.present
          ? data.originalFileName.value
          : this.originalFileName,
      storedFileName: data.storedFileName.present
          ? data.storedFileName.value
          : this.storedFileName,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      fileSizeBytes: data.fileSizeBytes.present
          ? data.fileSizeBytes.value
          : this.fileSizeBytes,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
      thumbnailRelativePath: data.thumbnailRelativePath.present
          ? data.thumbnailRelativePath.value
          : this.thumbnailRelativePath,
      checksumSha256: data.checksumSha256.present
          ? data.checksumSha256.value
          : this.checksumSha256,
      displayLabel: data.displayLabel.present
          ? data.displayLabel.value
          : this.displayLabel,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentRow(')
          ..write('id: $id, ')
          ..write('ownerType: $ownerType, ')
          ..write('ownerId: $ownerId, ')
          ..write('originalFileName: $originalFileName, ')
          ..write('storedFileName: $storedFileName, ')
          ..write('mimeType: $mimeType, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('relativePath: $relativePath, ')
          ..write('thumbnailRelativePath: $thumbnailRelativePath, ')
          ..write('checksumSha256: $checksumSha256, ')
          ..write('displayLabel: $displayLabel, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ownerType,
    ownerId,
    originalFileName,
    storedFileName,
    mimeType,
    fileSizeBytes,
    relativePath,
    thumbnailRelativePath,
    checksumSha256,
    displayLabel,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttachmentRow &&
          other.id == this.id &&
          other.ownerType == this.ownerType &&
          other.ownerId == this.ownerId &&
          other.originalFileName == this.originalFileName &&
          other.storedFileName == this.storedFileName &&
          other.mimeType == this.mimeType &&
          other.fileSizeBytes == this.fileSizeBytes &&
          other.relativePath == this.relativePath &&
          other.thumbnailRelativePath == this.thumbnailRelativePath &&
          other.checksumSha256 == this.checksumSha256 &&
          other.displayLabel == this.displayLabel &&
          other.createdAt == this.createdAt);
}

class AttachmentsCompanion extends UpdateCompanion<AttachmentRow> {
  final Value<String> id;
  final Value<String> ownerType;
  final Value<String> ownerId;
  final Value<String> originalFileName;
  final Value<String> storedFileName;
  final Value<String> mimeType;
  final Value<int> fileSizeBytes;
  final Value<String> relativePath;
  final Value<String?> thumbnailRelativePath;
  final Value<String> checksumSha256;
  final Value<String?> displayLabel;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AttachmentsCompanion({
    this.id = const Value.absent(),
    this.ownerType = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.originalFileName = const Value.absent(),
    this.storedFileName = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.fileSizeBytes = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.thumbnailRelativePath = const Value.absent(),
    this.checksumSha256 = const Value.absent(),
    this.displayLabel = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttachmentsCompanion.insert({
    required String id,
    required String ownerType,
    required String ownerId,
    required String originalFileName,
    required String storedFileName,
    required String mimeType,
    required int fileSizeBytes,
    required String relativePath,
    this.thumbnailRelativePath = const Value.absent(),
    required String checksumSha256,
    this.displayLabel = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerType = Value(ownerType),
       ownerId = Value(ownerId),
       originalFileName = Value(originalFileName),
       storedFileName = Value(storedFileName),
       mimeType = Value(mimeType),
       fileSizeBytes = Value(fileSizeBytes),
       relativePath = Value(relativePath),
       checksumSha256 = Value(checksumSha256),
       createdAt = Value(createdAt);
  static Insertable<AttachmentRow> custom({
    Expression<String>? id,
    Expression<String>? ownerType,
    Expression<String>? ownerId,
    Expression<String>? originalFileName,
    Expression<String>? storedFileName,
    Expression<String>? mimeType,
    Expression<int>? fileSizeBytes,
    Expression<String>? relativePath,
    Expression<String>? thumbnailRelativePath,
    Expression<String>? checksumSha256,
    Expression<String>? displayLabel,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerType != null) 'owner_type': ownerType,
      if (ownerId != null) 'owner_id': ownerId,
      if (originalFileName != null) 'original_file_name': originalFileName,
      if (storedFileName != null) 'stored_file_name': storedFileName,
      if (mimeType != null) 'mime_type': mimeType,
      if (fileSizeBytes != null) 'file_size_bytes': fileSizeBytes,
      if (relativePath != null) 'relative_path': relativePath,
      if (thumbnailRelativePath != null)
        'thumbnail_relative_path': thumbnailRelativePath,
      if (checksumSha256 != null) 'checksum_sha256': checksumSha256,
      if (displayLabel != null) 'display_label': displayLabel,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttachmentsCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerType,
    Value<String>? ownerId,
    Value<String>? originalFileName,
    Value<String>? storedFileName,
    Value<String>? mimeType,
    Value<int>? fileSizeBytes,
    Value<String>? relativePath,
    Value<String?>? thumbnailRelativePath,
    Value<String>? checksumSha256,
    Value<String?>? displayLabel,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return AttachmentsCompanion(
      id: id ?? this.id,
      ownerType: ownerType ?? this.ownerType,
      ownerId: ownerId ?? this.ownerId,
      originalFileName: originalFileName ?? this.originalFileName,
      storedFileName: storedFileName ?? this.storedFileName,
      mimeType: mimeType ?? this.mimeType,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      relativePath: relativePath ?? this.relativePath,
      thumbnailRelativePath:
          thumbnailRelativePath ?? this.thumbnailRelativePath,
      checksumSha256: checksumSha256 ?? this.checksumSha256,
      displayLabel: displayLabel ?? this.displayLabel,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ownerType.present) {
      map['owner_type'] = Variable<String>(ownerType.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (originalFileName.present) {
      map['original_file_name'] = Variable<String>(originalFileName.value);
    }
    if (storedFileName.present) {
      map['stored_file_name'] = Variable<String>(storedFileName.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (fileSizeBytes.present) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes.value);
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (thumbnailRelativePath.present) {
      map['thumbnail_relative_path'] = Variable<String>(
        thumbnailRelativePath.value,
      );
    }
    if (checksumSha256.present) {
      map['checksum_sha256'] = Variable<String>(checksumSha256.value);
    }
    if (displayLabel.present) {
      map['display_label'] = Variable<String>(displayLabel.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentsCompanion(')
          ..write('id: $id, ')
          ..write('ownerType: $ownerType, ')
          ..write('ownerId: $ownerId, ')
          ..write('originalFileName: $originalFileName, ')
          ..write('storedFileName: $storedFileName, ')
          ..write('mimeType: $mimeType, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('relativePath: $relativePath, ')
          ..write('thumbnailRelativePath: $thumbnailRelativePath, ')
          ..write('checksumSha256: $checksumSha256, ')
          ..write('displayLabel: $displayLabel, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BackupHistoryTable extends BackupHistory
    with TableInfo<$BackupHistoryTable, BackupHistoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackupHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pathOrUriMeta = const VerificationMeta(
    'pathOrUri',
  );
  @override
  late final GeneratedColumn<String> pathOrUri = GeneratedColumn<String>(
    'path_or_uri',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeBytesMeta = const VerificationMeta(
    'sizeBytes',
  );
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
    'size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleCountMeta = const VerificationMeta(
    'vehicleCount',
  );
  @override
  late final GeneratedColumn<int> vehicleCount = GeneratedColumn<int>(
    'vehicle_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _schemaVersionMeta = const VerificationMeta(
    'schemaVersion',
  );
  @override
  late final GeneratedColumn<int> schemaVersion = GeneratedColumn<int>(
    'schema_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _includeAttachmentsMeta =
      const VerificationMeta('includeAttachments');
  @override
  late final GeneratedColumn<bool> includeAttachments = GeneratedColumn<bool>(
    'include_attachments',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("include_attachments" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    pathOrUri,
    sizeBytes,
    vehicleCount,
    schemaVersion,
    status,
    includeAttachments,
    errorMessage,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'backup_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<BackupHistoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('path_or_uri')) {
      context.handle(
        _pathOrUriMeta,
        pathOrUri.isAcceptableOrUnknown(data['path_or_uri']!, _pathOrUriMeta),
      );
    } else if (isInserting) {
      context.missing(_pathOrUriMeta);
    }
    if (data.containsKey('size_bytes')) {
      context.handle(
        _sizeBytesMeta,
        sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('vehicle_count')) {
      context.handle(
        _vehicleCountMeta,
        vehicleCount.isAcceptableOrUnknown(
          data['vehicle_count']!,
          _vehicleCountMeta,
        ),
      );
    }
    if (data.containsKey('schema_version')) {
      context.handle(
        _schemaVersionMeta,
        schemaVersion.isAcceptableOrUnknown(
          data['schema_version']!,
          _schemaVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_schemaVersionMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('include_attachments')) {
      context.handle(
        _includeAttachmentsMeta,
        includeAttachments.isAcceptableOrUnknown(
          data['include_attachments']!,
          _includeAttachmentsMeta,
        ),
      );
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BackupHistoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackupHistoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      pathOrUri: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path_or_uri'],
      )!,
      sizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_bytes'],
      )!,
      vehicleCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vehicle_count'],
      )!,
      schemaVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}schema_version'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      includeAttachments: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}include_attachments'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
    );
  }

  @override
  $BackupHistoryTable createAlias(String alias) {
    return $BackupHistoryTable(attachedDatabase, alias);
  }
}

class BackupHistoryRow extends DataClass
    implements Insertable<BackupHistoryRow> {
  final String id;
  final DateTime createdAt;
  final String pathOrUri;
  final int sizeBytes;
  final int vehicleCount;
  final int schemaVersion;

  /// success | failed | interrupted
  final String status;
  final bool includeAttachments;
  final String? errorMessage;
  const BackupHistoryRow({
    required this.id,
    required this.createdAt,
    required this.pathOrUri,
    required this.sizeBytes,
    required this.vehicleCount,
    required this.schemaVersion,
    required this.status,
    required this.includeAttachments,
    this.errorMessage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['path_or_uri'] = Variable<String>(pathOrUri);
    map['size_bytes'] = Variable<int>(sizeBytes);
    map['vehicle_count'] = Variable<int>(vehicleCount);
    map['schema_version'] = Variable<int>(schemaVersion);
    map['status'] = Variable<String>(status);
    map['include_attachments'] = Variable<bool>(includeAttachments);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    return map;
  }

  BackupHistoryCompanion toCompanion(bool nullToAbsent) {
    return BackupHistoryCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      pathOrUri: Value(pathOrUri),
      sizeBytes: Value(sizeBytes),
      vehicleCount: Value(vehicleCount),
      schemaVersion: Value(schemaVersion),
      status: Value(status),
      includeAttachments: Value(includeAttachments),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
    );
  }

  factory BackupHistoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackupHistoryRow(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      pathOrUri: serializer.fromJson<String>(json['pathOrUri']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      vehicleCount: serializer.fromJson<int>(json['vehicleCount']),
      schemaVersion: serializer.fromJson<int>(json['schemaVersion']),
      status: serializer.fromJson<String>(json['status']),
      includeAttachments: serializer.fromJson<bool>(json['includeAttachments']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'pathOrUri': serializer.toJson<String>(pathOrUri),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'vehicleCount': serializer.toJson<int>(vehicleCount),
      'schemaVersion': serializer.toJson<int>(schemaVersion),
      'status': serializer.toJson<String>(status),
      'includeAttachments': serializer.toJson<bool>(includeAttachments),
      'errorMessage': serializer.toJson<String?>(errorMessage),
    };
  }

  BackupHistoryRow copyWith({
    String? id,
    DateTime? createdAt,
    String? pathOrUri,
    int? sizeBytes,
    int? vehicleCount,
    int? schemaVersion,
    String? status,
    bool? includeAttachments,
    Value<String?> errorMessage = const Value.absent(),
  }) => BackupHistoryRow(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    pathOrUri: pathOrUri ?? this.pathOrUri,
    sizeBytes: sizeBytes ?? this.sizeBytes,
    vehicleCount: vehicleCount ?? this.vehicleCount,
    schemaVersion: schemaVersion ?? this.schemaVersion,
    status: status ?? this.status,
    includeAttachments: includeAttachments ?? this.includeAttachments,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
  );
  BackupHistoryRow copyWithCompanion(BackupHistoryCompanion data) {
    return BackupHistoryRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      pathOrUri: data.pathOrUri.present ? data.pathOrUri.value : this.pathOrUri,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      vehicleCount: data.vehicleCount.present
          ? data.vehicleCount.value
          : this.vehicleCount,
      schemaVersion: data.schemaVersion.present
          ? data.schemaVersion.value
          : this.schemaVersion,
      status: data.status.present ? data.status.value : this.status,
      includeAttachments: data.includeAttachments.present
          ? data.includeAttachments.value
          : this.includeAttachments,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackupHistoryRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('pathOrUri: $pathOrUri, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('vehicleCount: $vehicleCount, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('status: $status, ')
          ..write('includeAttachments: $includeAttachments, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    pathOrUri,
    sizeBytes,
    vehicleCount,
    schemaVersion,
    status,
    includeAttachments,
    errorMessage,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackupHistoryRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.pathOrUri == this.pathOrUri &&
          other.sizeBytes == this.sizeBytes &&
          other.vehicleCount == this.vehicleCount &&
          other.schemaVersion == this.schemaVersion &&
          other.status == this.status &&
          other.includeAttachments == this.includeAttachments &&
          other.errorMessage == this.errorMessage);
}

class BackupHistoryCompanion extends UpdateCompanion<BackupHistoryRow> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<String> pathOrUri;
  final Value<int> sizeBytes;
  final Value<int> vehicleCount;
  final Value<int> schemaVersion;
  final Value<String> status;
  final Value<bool> includeAttachments;
  final Value<String?> errorMessage;
  final Value<int> rowid;
  const BackupHistoryCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.pathOrUri = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.vehicleCount = const Value.absent(),
    this.schemaVersion = const Value.absent(),
    this.status = const Value.absent(),
    this.includeAttachments = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BackupHistoryCompanion.insert({
    required String id,
    required DateTime createdAt,
    required String pathOrUri,
    required int sizeBytes,
    this.vehicleCount = const Value.absent(),
    required int schemaVersion,
    required String status,
    this.includeAttachments = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       pathOrUri = Value(pathOrUri),
       sizeBytes = Value(sizeBytes),
       schemaVersion = Value(schemaVersion),
       status = Value(status);
  static Insertable<BackupHistoryRow> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? pathOrUri,
    Expression<int>? sizeBytes,
    Expression<int>? vehicleCount,
    Expression<int>? schemaVersion,
    Expression<String>? status,
    Expression<bool>? includeAttachments,
    Expression<String>? errorMessage,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (pathOrUri != null) 'path_or_uri': pathOrUri,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (vehicleCount != null) 'vehicle_count': vehicleCount,
      if (schemaVersion != null) 'schema_version': schemaVersion,
      if (status != null) 'status': status,
      if (includeAttachments != null) 'include_attachments': includeAttachments,
      if (errorMessage != null) 'error_message': errorMessage,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BackupHistoryCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<String>? pathOrUri,
    Value<int>? sizeBytes,
    Value<int>? vehicleCount,
    Value<int>? schemaVersion,
    Value<String>? status,
    Value<bool>? includeAttachments,
    Value<String?>? errorMessage,
    Value<int>? rowid,
  }) {
    return BackupHistoryCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      pathOrUri: pathOrUri ?? this.pathOrUri,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      vehicleCount: vehicleCount ?? this.vehicleCount,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      status: status ?? this.status,
      includeAttachments: includeAttachments ?? this.includeAttachments,
      errorMessage: errorMessage ?? this.errorMessage,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (pathOrUri.present) {
      map['path_or_uri'] = Variable<String>(pathOrUri.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (vehicleCount.present) {
      map['vehicle_count'] = Variable<int>(vehicleCount.value);
    }
    if (schemaVersion.present) {
      map['schema_version'] = Variable<int>(schemaVersion.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (includeAttachments.present) {
      map['include_attachments'] = Variable<bool>(includeAttachments.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackupHistoryCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('pathOrUri: $pathOrUri, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('vehicleCount: $vehicleCount, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('status: $status, ')
          ..write('includeAttachments: $includeAttachments, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $VehiclesTable vehicles = $VehiclesTable(this);
  late final $OdometerEntriesTable odometerEntries = $OdometerEntriesTable(
    this,
  );
  late final $FuelEntriesTable fuelEntries = $FuelEntriesTable(this);
  late final $ExpenseCategoriesTable expenseCategories =
      $ExpenseCategoriesTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $MaintenanceTemplatesTable maintenanceTemplates =
      $MaintenanceTemplatesTable(this);
  late final $ServiceRecordsTable serviceRecords = $ServiceRecordsTable(this);
  late final $ServiceItemsTable serviceItems = $ServiceItemsTable(this);
  late final $OilChangesTable oilChanges = $OilChangesTable(this);
  late final $RepairsTable repairs = $RepairsTable(this);
  late final $RepairPartsTable repairParts = $RepairPartsTable(this);
  late final $VehiclePartsTable vehicleParts = $VehiclePartsTable(this);
  late final $TyresTable tyres = $TyresTable(this);
  late final $TyreEventsTable tyreEvents = $TyreEventsTable(this);
  late final $BatteriesTable batteries = $BatteriesTable(this);
  late final $VehicleDocumentsTable vehicleDocuments = $VehicleDocumentsTable(
    this,
  );
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $AttachmentsTable attachments = $AttachmentsTable(this);
  late final $BackupHistoryTable backupHistory = $BackupHistoryTable(this);
  late final Index idxOdometerVehicleRecorded = Index(
    'idx_odometer_vehicle_recorded',
    'CREATE INDEX idx_odometer_vehicle_recorded ON odometer_entries (vehicle_id, recorded_at)',
  );
  late final Index idxOdometerVehicleOdometer = Index(
    'idx_odometer_vehicle_odometer',
    'CREATE INDEX idx_odometer_vehicle_odometer ON odometer_entries (vehicle_id, odometer)',
  );
  late final Index idxFuelVehicleDatetime = Index(
    'idx_fuel_vehicle_datetime',
    'CREATE INDEX idx_fuel_vehicle_datetime ON fuel_entries (entry_date_time, vehicle_id)',
  );
  late final Index idxFuelVehicleOdometer = Index(
    'idx_fuel_vehicle_odometer',
    'CREATE INDEX idx_fuel_vehicle_odometer ON fuel_entries (vehicle_id, odometer)',
  );
  late final Index idxExpenseVehicleDate = Index(
    'idx_expense_vehicle_date',
    'CREATE INDEX idx_expense_vehicle_date ON expenses (vehicle_id, occurred_on)',
  );
  late final Index idxExpenseSource = Index(
    'idx_expense_source',
    'CREATE INDEX idx_expense_source ON expenses (source_type, source_record_id)',
  );
  late final Index idxServiceVehicleDate = Index(
    'idx_service_vehicle_date',
    'CREATE INDEX idx_service_vehicle_date ON service_records (vehicle_id, service_date)',
  );
  late final Index idxServiceItemsRecord = Index(
    'idx_service_items_record',
    'CREATE INDEX idx_service_items_record ON service_items (service_record_id)',
  );
  late final Index idxOilVehicleDate = Index(
    'idx_oil_vehicle_date',
    'CREATE INDEX idx_oil_vehicle_date ON oil_changes (vehicle_id, occurred_on)',
  );
  late final Index idxRepairVehicleDate = Index(
    'idx_repair_vehicle_date',
    'CREATE INDEX idx_repair_vehicle_date ON repairs (vehicle_id, repair_date)',
  );
  late final Index idxRepairPartsRepair = Index(
    'idx_repair_parts_repair',
    'CREATE INDEX idx_repair_parts_repair ON repair_parts (repair_id)',
  );
  late final Index idxVehiclePartsVehicle = Index(
    'idx_vehicle_parts_vehicle',
    'CREATE INDEX idx_vehicle_parts_vehicle ON vehicle_parts (vehicle_id, installed_date)',
  );
  late final Index idxTyresVehicleStatus = Index(
    'idx_tyres_vehicle_status',
    'CREATE INDEX idx_tyres_vehicle_status ON tyres (vehicle_id, status)',
  );
  late final Index idxTyreEventsTyre = Index(
    'idx_tyre_events_tyre',
    'CREATE INDEX idx_tyre_events_tyre ON tyre_events (tyre_id, occurred_on)',
  );
  late final Index idxBatteriesVehicleStatus = Index(
    'idx_batteries_vehicle_status',
    'CREATE INDEX idx_batteries_vehicle_status ON batteries (vehicle_id, status)',
  );
  late final Index idxVehicleDocumentsVehicleType = Index(
    'idx_vehicle_documents_vehicle_type',
    'CREATE INDEX idx_vehicle_documents_vehicle_type ON vehicle_documents (vehicle_id, document_type)',
  );
  late final Index idxVehicleDocumentsExpiry = Index(
    'idx_vehicle_documents_expiry',
    'CREATE INDEX idx_vehicle_documents_expiry ON vehicle_documents (vehicle_id, expiry_date)',
  );
  late final Index idxRemindersVehicleStatus = Index(
    'idx_reminders_vehicle_status',
    'CREATE INDEX idx_reminders_vehicle_status ON reminders (vehicle_id, status)',
  );
  late final Index idxRemindersDueDate = Index(
    'idx_reminders_due_date',
    'CREATE INDEX idx_reminders_due_date ON reminders (vehicle_id, due_date)',
  );
  late final Index idxAttachmentsOwner = Index(
    'idx_attachments_owner',
    'CREATE INDEX idx_attachments_owner ON attachments (owner_type, owner_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    settings,
    vehicles,
    odometerEntries,
    fuelEntries,
    expenseCategories,
    expenses,
    maintenanceTemplates,
    serviceRecords,
    serviceItems,
    oilChanges,
    repairs,
    repairParts,
    vehicleParts,
    tyres,
    tyreEvents,
    batteries,
    vehicleDocuments,
    reminders,
    attachments,
    backupHistory,
    idxOdometerVehicleRecorded,
    idxOdometerVehicleOdometer,
    idxFuelVehicleDatetime,
    idxFuelVehicleOdometer,
    idxExpenseVehicleDate,
    idxExpenseSource,
    idxServiceVehicleDate,
    idxServiceItemsRecord,
    idxOilVehicleDate,
    idxRepairVehicleDate,
    idxRepairPartsRepair,
    idxVehiclePartsVehicle,
    idxTyresVehicleStatus,
    idxTyreEventsTyre,
    idxBatteriesVehicleStatus,
    idxVehicleDocumentsVehicleType,
    idxVehicleDocumentsExpiry,
    idxRemindersVehicleStatus,
    idxRemindersDueDate,
    idxAttachmentsOwner,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'service_records',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('service_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'repairs',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('repair_parts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tyres',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tyre_events', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  required String key,
  required String value,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          SettingRow,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (
            SettingRow,
            BaseReferences<_$AppDatabase, $SettingsTable, SettingRow>,
          ),
          SettingRow,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SettingsTable, SettingRow>(table),
                  BaseReferences<_$AppDatabase, $SettingsTable, SettingRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      SettingRow,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (SettingRow, BaseReferences<_$AppDatabase, $SettingsTable, SettingRow>),
      SettingRow,
      PrefetchHooks Function()
    >;
typedef $$VehiclesTableCreateCompanionBuilder = VehiclesCompanion Function({
  required String id,
  required String nickname,
  required String vehicleType,
  Value<String?> brand,
  Value<String?> model,
  Value<String?> variant,
  Value<int?> modelYear,
  Value<String?> registrationNumber,
  required String fuelType,
  Value<int> currentOdometer,
  Value<DateTime?> purchaseDate,
  Value<int?> purchasePricePaisa,
  Value<String?> engineCapacity,
  Value<String?> engineNumber,
  Value<String?> chassisNumber,
  Value<String?> color,
  Value<String?> photoPath,
  Value<String?> ownershipType,
  Value<bool> isArchived,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$VehiclesTableUpdateCompanionBuilder = VehiclesCompanion Function({
  Value<String> id,
  Value<String> nickname,
  Value<String> vehicleType,
  Value<String?> brand,
  Value<String?> model,
  Value<String?> variant,
  Value<int?> modelYear,
  Value<String?> registrationNumber,
  Value<String> fuelType,
  Value<int> currentOdometer,
  Value<DateTime?> purchaseDate,
  Value<int?> purchasePricePaisa,
  Value<String?> engineCapacity,
  Value<String?> engineNumber,
  Value<String?> chassisNumber,
  Value<String?> color,
  Value<String?> photoPath,
  Value<String?> ownershipType,
  Value<bool> isArchived,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$VehiclesTableReferences
    extends BaseReferences<_$AppDatabase, $VehiclesTable, VehicleRow> {
  $$VehiclesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$OdometerEntriesTable, List<OdometerEntryRow>>
  _odometerEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.odometerEntries,
    aliasName: 'vehicles__id__odometer_entries__vehicle_id',
  );

  $$OdometerEntriesTableProcessedTableManager get odometerEntriesRefs {
    final manager = $$OdometerEntriesTableTableManager(
      $_db,
      $_db.odometerEntries,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _odometerEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FuelEntriesTable, List<FuelEntryRow>>
  _fuelEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fuelEntries,
    aliasName: 'vehicles__id__fuel_entries__vehicle_id',
  );

  $$FuelEntriesTableProcessedTableManager get fuelEntriesRefs {
    final manager = $$FuelEntriesTableTableManager(
      $_db,
      $_db.fuelEntries,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_fuelEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExpensesTable, List<ExpenseRow>>
  _expensesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.expenses,
    aliasName: 'vehicles__id__expenses__vehicle_id',
  );

  $$ExpensesTableProcessedTableManager get expensesRefs {
    final manager = $$ExpensesTableTableManager(
      $_db,
      $_db.expenses,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ServiceRecordsTable, List<ServiceRecordRow>>
  _serviceRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.serviceRecords,
    aliasName: 'vehicles__id__service_records__vehicle_id',
  );

  $$ServiceRecordsTableProcessedTableManager get serviceRecordsRefs {
    final manager = $$ServiceRecordsTableTableManager(
      $_db,
      $_db.serviceRecords,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_serviceRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$OilChangesTable, List<OilChangeRow>>
  _oilChangesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.oilChanges,
    aliasName: 'vehicles__id__oil_changes__vehicle_id',
  );

  $$OilChangesTableProcessedTableManager get oilChangesRefs {
    final manager = $$OilChangesTableTableManager(
      $_db,
      $_db.oilChanges,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_oilChangesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RepairsTable, List<RepairRow>> _repairsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.repairs,
    aliasName: 'vehicles__id__repairs__vehicle_id',
  );

  $$RepairsTableProcessedTableManager get repairsRefs {
    final manager = $$RepairsTableTableManager(
      $_db,
      $_db.repairs,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_repairsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VehiclePartsTable, List<VehiclePartRow>>
  _vehiclePartsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.vehicleParts,
    aliasName: 'vehicles__id__vehicle_parts__vehicle_id',
  );

  $$VehiclePartsTableProcessedTableManager get vehiclePartsRefs {
    final manager = $$VehiclePartsTableTableManager(
      $_db,
      $_db.vehicleParts,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_vehiclePartsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TyresTable, List<TyreRow>> _tyresRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tyres,
    aliasName: 'vehicles__id__tyres__vehicle_id',
  );

  $$TyresTableProcessedTableManager get tyresRefs {
    final manager = $$TyresTableTableManager(
      $_db,
      $_db.tyres,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tyresRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TyreEventsTable, List<TyreEventRow>>
  _tyreEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.tyreEvents,
    aliasName: 'vehicles__id__tyre_events__vehicle_id',
  );

  $$TyreEventsTableProcessedTableManager get tyreEventsRefs {
    final manager = $$TyreEventsTableTableManager(
      $_db,
      $_db.tyreEvents,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tyreEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BatteriesTable, List<BatteryRow>>
  _batteriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.batteries,
    aliasName: 'vehicles__id__batteries__vehicle_id',
  );

  $$BatteriesTableProcessedTableManager get batteriesRefs {
    final manager = $$BatteriesTableTableManager(
      $_db,
      $_db.batteries,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_batteriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VehicleDocumentsTable, List<VehicleDocumentRow>>
  _vehicleDocumentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.vehicleDocuments,
    aliasName: 'vehicles__id__vehicle_documents__vehicle_id',
  );

  $$VehicleDocumentsTableProcessedTableManager get vehicleDocumentsRefs {
    final manager = $$VehicleDocumentsTableTableManager(
      $_db,
      $_db.vehicleDocuments,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _vehicleDocumentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RemindersTable, List<ReminderRow>>
  _remindersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reminders,
    aliasName: 'vehicles__id__reminders__vehicle_id',
  );

  $$RemindersTableProcessedTableManager get remindersRefs {
    final manager = $$RemindersTableTableManager(
      $_db,
      $_db.reminders,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_remindersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VehiclesTableFilterComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vehicleType => $composableBuilder(
    column: $table.vehicleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variant => $composableBuilder(
    column: $table.variant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get modelYear => $composableBuilder(
    column: $table.modelYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get registrationNumber => $composableBuilder(
    column: $table.registrationNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentOdometer => $composableBuilder(
    column: $table.currentOdometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get purchasePricePaisa => $composableBuilder(
    column: $table.purchasePricePaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get engineCapacity => $composableBuilder(
    column: $table.engineCapacity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get engineNumber => $composableBuilder(
    column: $table.engineNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chassisNumber => $composableBuilder(
    column: $table.chassisNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownershipType => $composableBuilder(
    column: $table.ownershipType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> odometerEntriesRefs(
    Expression<bool> Function($$OdometerEntriesTableFilterComposer f) f,
  ) {
    final $$OdometerEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.odometerEntries,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OdometerEntriesTableFilterComposer(
            $db: $db,
            $table: $db.odometerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fuelEntriesRefs(
    Expression<bool> Function($$FuelEntriesTableFilterComposer f) f,
  ) {
    final $$FuelEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelEntries,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelEntriesTableFilterComposer(
            $db: $db,
            $table: $db.fuelEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> expensesRefs(
    Expression<bool> Function($$ExpensesTableFilterComposer f) f,
  ) {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableFilterComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> serviceRecordsRefs(
    Expression<bool> Function($$ServiceRecordsTableFilterComposer f) f,
  ) {
    final $$ServiceRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceRecords,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceRecordsTableFilterComposer(
            $db: $db,
            $table: $db.serviceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> oilChangesRefs(
    Expression<bool> Function($$OilChangesTableFilterComposer f) f,
  ) {
    final $$OilChangesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.oilChanges,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OilChangesTableFilterComposer(
            $db: $db,
            $table: $db.oilChanges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> repairsRefs(
    Expression<bool> Function($$RepairsTableFilterComposer f) f,
  ) {
    final $$RepairsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairs,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairsTableFilterComposer(
            $db: $db,
            $table: $db.repairs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> vehiclePartsRefs(
    Expression<bool> Function($$VehiclePartsTableFilterComposer f) f,
  ) {
    final $$VehiclePartsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vehicleParts,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclePartsTableFilterComposer(
            $db: $db,
            $table: $db.vehicleParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tyresRefs(
    Expression<bool> Function($$TyresTableFilterComposer f) f,
  ) {
    final $$TyresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tyres,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TyresTableFilterComposer(
            $db: $db,
            $table: $db.tyres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tyreEventsRefs(
    Expression<bool> Function($$TyreEventsTableFilterComposer f) f,
  ) {
    final $$TyreEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tyreEvents,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TyreEventsTableFilterComposer(
            $db: $db,
            $table: $db.tyreEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> batteriesRefs(
    Expression<bool> Function($$BatteriesTableFilterComposer f) f,
  ) {
    final $$BatteriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.batteries,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatteriesTableFilterComposer(
            $db: $db,
            $table: $db.batteries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> vehicleDocumentsRefs(
    Expression<bool> Function($$VehicleDocumentsTableFilterComposer f) f,
  ) {
    final $$VehicleDocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vehicleDocuments,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehicleDocumentsTableFilterComposer(
            $db: $db,
            $table: $db.vehicleDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> remindersRefs(
    Expression<bool> Function($$RemindersTableFilterComposer f) f,
  ) {
    final $$RemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableFilterComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiclesTableOrderingComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vehicleType => $composableBuilder(
    column: $table.vehicleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variant => $composableBuilder(
    column: $table.variant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get modelYear => $composableBuilder(
    column: $table.modelYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get registrationNumber => $composableBuilder(
    column: $table.registrationNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentOdometer => $composableBuilder(
    column: $table.currentOdometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get purchasePricePaisa => $composableBuilder(
    column: $table.purchasePricePaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get engineCapacity => $composableBuilder(
    column: $table.engineCapacity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get engineNumber => $composableBuilder(
    column: $table.engineNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chassisNumber => $composableBuilder(
    column: $table.chassisNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownershipType => $composableBuilder(
    column: $table.ownershipType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VehiclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<String> get vehicleType => $composableBuilder(
    column: $table.vehicleType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get variant =>
      $composableBuilder(column: $table.variant, builder: (column) => column);

  GeneratedColumn<int> get modelYear =>
      $composableBuilder(column: $table.modelYear, builder: (column) => column);

  GeneratedColumn<String> get registrationNumber => $composableBuilder(
    column: $table.registrationNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fuelType =>
      $composableBuilder(column: $table.fuelType, builder: (column) => column);

  GeneratedColumn<int> get currentOdometer => $composableBuilder(
    column: $table.currentOdometer,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get purchasePricePaisa => $composableBuilder(
    column: $table.purchasePricePaisa,
    builder: (column) => column,
  );

  GeneratedColumn<String> get engineCapacity => $composableBuilder(
    column: $table.engineCapacity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get engineNumber => $composableBuilder(
    column: $table.engineNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get chassisNumber => $composableBuilder(
    column: $table.chassisNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<String> get ownershipType => $composableBuilder(
    column: $table.ownershipType,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> odometerEntriesRefs<T extends Object>(
    Expression<T> Function($$OdometerEntriesTableAnnotationComposer a) f,
  ) {
    final $$OdometerEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.odometerEntries,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OdometerEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.odometerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> fuelEntriesRefs<T extends Object>(
    Expression<T> Function($$FuelEntriesTableAnnotationComposer a) f,
  ) {
    final $$FuelEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelEntries,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.fuelEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> expensesRefs<T extends Object>(
    Expression<T> Function($$ExpensesTableAnnotationComposer a) f,
  ) {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableAnnotationComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> serviceRecordsRefs<T extends Object>(
    Expression<T> Function($$ServiceRecordsTableAnnotationComposer a) f,
  ) {
    final $$ServiceRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceRecords,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.serviceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> oilChangesRefs<T extends Object>(
    Expression<T> Function($$OilChangesTableAnnotationComposer a) f,
  ) {
    final $$OilChangesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.oilChanges,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OilChangesTableAnnotationComposer(
            $db: $db,
            $table: $db.oilChanges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> repairsRefs<T extends Object>(
    Expression<T> Function($$RepairsTableAnnotationComposer a) f,
  ) {
    final $$RepairsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairs,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairsTableAnnotationComposer(
            $db: $db,
            $table: $db.repairs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> vehiclePartsRefs<T extends Object>(
    Expression<T> Function($$VehiclePartsTableAnnotationComposer a) f,
  ) {
    final $$VehiclePartsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vehicleParts,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclePartsTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicleParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> tyresRefs<T extends Object>(
    Expression<T> Function($$TyresTableAnnotationComposer a) f,
  ) {
    final $$TyresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tyres,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TyresTableAnnotationComposer(
            $db: $db,
            $table: $db.tyres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> tyreEventsRefs<T extends Object>(
    Expression<T> Function($$TyreEventsTableAnnotationComposer a) f,
  ) {
    final $$TyreEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tyreEvents,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TyreEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.tyreEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> batteriesRefs<T extends Object>(
    Expression<T> Function($$BatteriesTableAnnotationComposer a) f,
  ) {
    final $$BatteriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.batteries,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatteriesTableAnnotationComposer(
            $db: $db,
            $table: $db.batteries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> vehicleDocumentsRefs<T extends Object>(
    Expression<T> Function($$VehicleDocumentsTableAnnotationComposer a) f,
  ) {
    final $$VehicleDocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vehicleDocuments,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehicleDocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicleDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> remindersRefs<T extends Object>(
    Expression<T> Function($$RemindersTableAnnotationComposer a) f,
  ) {
    final $$RemindersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableAnnotationComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiclesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehiclesTable,
          VehicleRow,
          $$VehiclesTableFilterComposer,
          $$VehiclesTableOrderingComposer,
          $$VehiclesTableAnnotationComposer,
          $$VehiclesTableCreateCompanionBuilder,
          $$VehiclesTableUpdateCompanionBuilder,
          (VehicleRow, $$VehiclesTableReferences),
          VehicleRow,
          PrefetchHooks Function({
            bool odometerEntriesRefs,
            bool fuelEntriesRefs,
            bool expensesRefs,
            bool serviceRecordsRefs,
            bool oilChangesRefs,
            bool repairsRefs,
            bool vehiclePartsRefs,
            bool tyresRefs,
            bool tyreEventsRefs,
            bool batteriesRefs,
            bool vehicleDocumentsRefs,
            bool remindersRefs,
          })
        > {
  $$VehiclesTableTableManager(_$AppDatabase db, $VehiclesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nickname = const Value.absent(),
                Value<String> vehicleType = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> variant = const Value.absent(),
                Value<int?> modelYear = const Value.absent(),
                Value<String?> registrationNumber = const Value.absent(),
                Value<String> fuelType = const Value.absent(),
                Value<int> currentOdometer = const Value.absent(),
                Value<DateTime?> purchaseDate = const Value.absent(),
                Value<int?> purchasePricePaisa = const Value.absent(),
                Value<String?> engineCapacity = const Value.absent(),
                Value<String?> engineNumber = const Value.absent(),
                Value<String?> chassisNumber = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<String?> ownershipType = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehiclesCompanion(
                id: id,
                nickname: nickname,
                vehicleType: vehicleType,
                brand: brand,
                model: model,
                variant: variant,
                modelYear: modelYear,
                registrationNumber: registrationNumber,
                fuelType: fuelType,
                currentOdometer: currentOdometer,
                purchaseDate: purchaseDate,
                purchasePricePaisa: purchasePricePaisa,
                engineCapacity: engineCapacity,
                engineNumber: engineNumber,
                chassisNumber: chassisNumber,
                color: color,
                photoPath: photoPath,
                ownershipType: ownershipType,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nickname,
                required String vehicleType,
                Value<String?> brand = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> variant = const Value.absent(),
                Value<int?> modelYear = const Value.absent(),
                Value<String?> registrationNumber = const Value.absent(),
                required String fuelType,
                Value<int> currentOdometer = const Value.absent(),
                Value<DateTime?> purchaseDate = const Value.absent(),
                Value<int?> purchasePricePaisa = const Value.absent(),
                Value<String?> engineCapacity = const Value.absent(),
                Value<String?> engineNumber = const Value.absent(),
                Value<String?> chassisNumber = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<String?> ownershipType = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => VehiclesCompanion.insert(
                id: id,
                nickname: nickname,
                vehicleType: vehicleType,
                brand: brand,
                model: model,
                variant: variant,
                modelYear: modelYear,
                registrationNumber: registrationNumber,
                fuelType: fuelType,
                currentOdometer: currentOdometer,
                purchaseDate: purchaseDate,
                purchasePricePaisa: purchasePricePaisa,
                engineCapacity: engineCapacity,
                engineNumber: engineNumber,
                chassisNumber: chassisNumber,
                color: color,
                photoPath: photoPath,
                ownershipType: ownershipType,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VehiclesTable, VehicleRow>(table),
                  $$VehiclesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                odometerEntriesRefs = false,
                fuelEntriesRefs = false,
                expensesRefs = false,
                serviceRecordsRefs = false,
                oilChangesRefs = false,
                repairsRefs = false,
                vehiclePartsRefs = false,
                tyresRefs = false,
                tyreEventsRefs = false,
                batteriesRefs = false,
                vehicleDocumentsRefs = false,
                remindersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (odometerEntriesRefs) db.odometerEntries,
                    if (fuelEntriesRefs) db.fuelEntries,
                    if (expensesRefs) db.expenses,
                    if (serviceRecordsRefs) db.serviceRecords,
                    if (oilChangesRefs) db.oilChanges,
                    if (repairsRefs) db.repairs,
                    if (vehiclePartsRefs) db.vehicleParts,
                    if (tyresRefs) db.tyres,
                    if (tyreEventsRefs) db.tyreEvents,
                    if (batteriesRefs) db.batteries,
                    if (vehicleDocumentsRefs) db.vehicleDocuments,
                    if (remindersRefs) db.reminders,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (odometerEntriesRefs)
                        await $_getPrefetchedData<
                          VehicleRow,
                          $VehiclesTable,
                          OdometerEntryRow
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._odometerEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).odometerEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fuelEntriesRefs)
                        await $_getPrefetchedData<
                          VehicleRow,
                          $VehiclesTable,
                          FuelEntryRow
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._fuelEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).fuelEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (expensesRefs)
                        await $_getPrefetchedData<
                          VehicleRow,
                          $VehiclesTable,
                          ExpenseRow
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._expensesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).expensesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (serviceRecordsRefs)
                        await $_getPrefetchedData<
                          VehicleRow,
                          $VehiclesTable,
                          ServiceRecordRow
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._serviceRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).serviceRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (oilChangesRefs)
                        await $_getPrefetchedData<
                          VehicleRow,
                          $VehiclesTable,
                          OilChangeRow
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._oilChangesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).oilChangesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (repairsRefs)
                        await $_getPrefetchedData<
                          VehicleRow,
                          $VehiclesTable,
                          RepairRow
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._repairsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).repairsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (vehiclePartsRefs)
                        await $_getPrefetchedData<
                          VehicleRow,
                          $VehiclesTable,
                          VehiclePartRow
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._vehiclePartsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).vehiclePartsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (tyresRefs)
                        await $_getPrefetchedData<
                          VehicleRow,
                          $VehiclesTable,
                          TyreRow
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._tyresRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).tyresRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (tyreEventsRefs)
                        await $_getPrefetchedData<
                          VehicleRow,
                          $VehiclesTable,
                          TyreEventRow
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._tyreEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).tyreEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (batteriesRefs)
                        await $_getPrefetchedData<
                          VehicleRow,
                          $VehiclesTable,
                          BatteryRow
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._batteriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).batteriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (vehicleDocumentsRefs)
                        await $_getPrefetchedData<
                          VehicleRow,
                          $VehiclesTable,
                          VehicleDocumentRow
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._vehicleDocumentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).vehicleDocumentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (remindersRefs)
                        await $_getPrefetchedData<
                          VehicleRow,
                          $VehiclesTable,
                          ReminderRow
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._remindersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).remindersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VehiclesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehiclesTable,
      VehicleRow,
      $$VehiclesTableFilterComposer,
      $$VehiclesTableOrderingComposer,
      $$VehiclesTableAnnotationComposer,
      $$VehiclesTableCreateCompanionBuilder,
      $$VehiclesTableUpdateCompanionBuilder,
      (VehicleRow, $$VehiclesTableReferences),
      VehicleRow,
      PrefetchHooks Function({
        bool odometerEntriesRefs,
        bool fuelEntriesRefs,
        bool expensesRefs,
        bool serviceRecordsRefs,
        bool oilChangesRefs,
        bool repairsRefs,
        bool vehiclePartsRefs,
        bool tyresRefs,
        bool tyreEventsRefs,
        bool batteriesRefs,
        bool vehicleDocumentsRefs,
        bool remindersRefs,
      })
    >;
typedef $$OdometerEntriesTableCreateCompanionBuilder =
    OdometerEntriesCompanion Function({
      required String id,
      required String vehicleId,
      required DateTime recordedAt,
      required int odometer,
      required String sourceType,
      Value<String?> sourceRecordId,
      Value<String?> note,
      Value<bool> isManualCorrection,
      Value<bool> isDiscontinuity,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$OdometerEntriesTableUpdateCompanionBuilder =
    OdometerEntriesCompanion Function({
      Value<String> id,
      Value<String> vehicleId,
      Value<DateTime> recordedAt,
      Value<int> odometer,
      Value<String> sourceType,
      Value<String?> sourceRecordId,
      Value<String?> note,
      Value<bool> isManualCorrection,
      Value<bool> isDiscontinuity,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$OdometerEntriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $OdometerEntriesTable, OdometerEntryRow> {
  $$OdometerEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('odometer_entries__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$OdometerEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $OdometerEntriesTable> {
  $$OdometerEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRecordId => $composableBuilder(
    column: $table.sourceRecordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isManualCorrection => $composableBuilder(
    column: $table.isManualCorrection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDiscontinuity => $composableBuilder(
    column: $table.isDiscontinuity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OdometerEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $OdometerEntriesTable> {
  $$OdometerEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRecordId => $composableBuilder(
    column: $table.sourceRecordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isManualCorrection => $composableBuilder(
    column: $table.isManualCorrection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDiscontinuity => $composableBuilder(
    column: $table.isDiscontinuity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OdometerEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $OdometerEntriesTable> {
  $$OdometerEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get odometer =>
      $composableBuilder(column: $table.odometer, builder: (column) => column);

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceRecordId => $composableBuilder(
    column: $table.sourceRecordId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isManualCorrection => $composableBuilder(
    column: $table.isManualCorrection,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDiscontinuity => $composableBuilder(
    column: $table.isDiscontinuity,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OdometerEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OdometerEntriesTable,
          OdometerEntryRow,
          $$OdometerEntriesTableFilterComposer,
          $$OdometerEntriesTableOrderingComposer,
          $$OdometerEntriesTableAnnotationComposer,
          $$OdometerEntriesTableCreateCompanionBuilder,
          $$OdometerEntriesTableUpdateCompanionBuilder,
          (OdometerEntryRow, $$OdometerEntriesTableReferences),
          OdometerEntryRow,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$OdometerEntriesTableTableManager(
    _$AppDatabase db,
    $OdometerEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OdometerEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OdometerEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OdometerEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<int> odometer = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String?> sourceRecordId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isManualCorrection = const Value.absent(),
                Value<bool> isDiscontinuity = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OdometerEntriesCompanion(
                id: id,
                vehicleId: vehicleId,
                recordedAt: recordedAt,
                odometer: odometer,
                sourceType: sourceType,
                sourceRecordId: sourceRecordId,
                note: note,
                isManualCorrection: isManualCorrection,
                isDiscontinuity: isDiscontinuity,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                required DateTime recordedAt,
                required int odometer,
                required String sourceType,
                Value<String?> sourceRecordId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isManualCorrection = const Value.absent(),
                Value<bool> isDiscontinuity = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => OdometerEntriesCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                recordedAt: recordedAt,
                odometer: odometer,
                sourceType: sourceType,
                sourceRecordId: sourceRecordId,
                note: note,
                isManualCorrection: isManualCorrection,
                isDiscontinuity: isDiscontinuity,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$OdometerEntriesTable, OdometerEntryRow>(table),
                  $$OdometerEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.vehicleId,
                        referencedTable: $$OdometerEntriesTableReferences
                            ._vehicleIdTable(db),
                        referencedColumn: $$OdometerEntriesTableReferences
                            ._vehicleIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$OdometerEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OdometerEntriesTable,
      OdometerEntryRow,
      $$OdometerEntriesTableFilterComposer,
      $$OdometerEntriesTableOrderingComposer,
      $$OdometerEntriesTableAnnotationComposer,
      $$OdometerEntriesTableCreateCompanionBuilder,
      $$OdometerEntriesTableUpdateCompanionBuilder,
      (OdometerEntryRow, $$OdometerEntriesTableReferences),
      OdometerEntryRow,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$FuelEntriesTableCreateCompanionBuilder =
    FuelEntriesCompanion Function({
      required String id,
      required String vehicleId,
      required DateTime entryDateTime,
      required int odometer,
      required String fuelType,
      required int quantityMl,
      Value<int?> pricePerUnitPaisa,
      required int totalCostPaisa,
      Value<bool> isFullTank,
      Value<String?> vendorId,
      Value<String?> stationName,
      Value<String?> locationText,
      Value<String?> paymentMethod,
      Value<String?> note,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FuelEntriesTableUpdateCompanionBuilder =
    FuelEntriesCompanion Function({
      Value<String> id,
      Value<String> vehicleId,
      Value<DateTime> entryDateTime,
      Value<int> odometer,
      Value<String> fuelType,
      Value<int> quantityMl,
      Value<int?> pricePerUnitPaisa,
      Value<int> totalCostPaisa,
      Value<bool> isFullTank,
      Value<String?> vendorId,
      Value<String?> stationName,
      Value<String?> locationText,
      Value<String?> paymentMethod,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$FuelEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $FuelEntriesTable, FuelEntryRow> {
  $$FuelEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('fuel_entries__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FuelEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $FuelEntriesTable> {
  $$FuelEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get entryDateTime => $composableBuilder(
    column: $table.entryDateTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantityMl => $composableBuilder(
    column: $table.quantityMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pricePerUnitPaisa => $composableBuilder(
    column: $table.pricePerUnitPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCostPaisa => $composableBuilder(
    column: $table.totalCostPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFullTank => $composableBuilder(
    column: $table.isFullTank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vendorId => $composableBuilder(
    column: $table.vendorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stationName => $composableBuilder(
    column: $table.stationName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationText => $composableBuilder(
    column: $table.locationText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $FuelEntriesTable> {
  $$FuelEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get entryDateTime => $composableBuilder(
    column: $table.entryDateTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantityMl => $composableBuilder(
    column: $table.quantityMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pricePerUnitPaisa => $composableBuilder(
    column: $table.pricePerUnitPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCostPaisa => $composableBuilder(
    column: $table.totalCostPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFullTank => $composableBuilder(
    column: $table.isFullTank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vendorId => $composableBuilder(
    column: $table.vendorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stationName => $composableBuilder(
    column: $table.stationName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationText => $composableBuilder(
    column: $table.locationText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FuelEntriesTable> {
  $$FuelEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get entryDateTime => $composableBuilder(
    column: $table.entryDateTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get odometer =>
      $composableBuilder(column: $table.odometer, builder: (column) => column);

  GeneratedColumn<String> get fuelType =>
      $composableBuilder(column: $table.fuelType, builder: (column) => column);

  GeneratedColumn<int> get quantityMl => $composableBuilder(
    column: $table.quantityMl,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pricePerUnitPaisa => $composableBuilder(
    column: $table.pricePerUnitPaisa,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCostPaisa => $composableBuilder(
    column: $table.totalCostPaisa,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFullTank => $composableBuilder(
    column: $table.isFullTank,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vendorId =>
      $composableBuilder(column: $table.vendorId, builder: (column) => column);

  GeneratedColumn<String> get stationName => $composableBuilder(
    column: $table.stationName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationText => $composableBuilder(
    column: $table.locationText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FuelEntriesTable,
          FuelEntryRow,
          $$FuelEntriesTableFilterComposer,
          $$FuelEntriesTableOrderingComposer,
          $$FuelEntriesTableAnnotationComposer,
          $$FuelEntriesTableCreateCompanionBuilder,
          $$FuelEntriesTableUpdateCompanionBuilder,
          (FuelEntryRow, $$FuelEntriesTableReferences),
          FuelEntryRow,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$FuelEntriesTableTableManager(_$AppDatabase db, $FuelEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FuelEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FuelEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FuelEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<DateTime> entryDateTime = const Value.absent(),
                Value<int> odometer = const Value.absent(),
                Value<String> fuelType = const Value.absent(),
                Value<int> quantityMl = const Value.absent(),
                Value<int?> pricePerUnitPaisa = const Value.absent(),
                Value<int> totalCostPaisa = const Value.absent(),
                Value<bool> isFullTank = const Value.absent(),
                Value<String?> vendorId = const Value.absent(),
                Value<String?> stationName = const Value.absent(),
                Value<String?> locationText = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FuelEntriesCompanion(
                id: id,
                vehicleId: vehicleId,
                entryDateTime: entryDateTime,
                odometer: odometer,
                fuelType: fuelType,
                quantityMl: quantityMl,
                pricePerUnitPaisa: pricePerUnitPaisa,
                totalCostPaisa: totalCostPaisa,
                isFullTank: isFullTank,
                vendorId: vendorId,
                stationName: stationName,
                locationText: locationText,
                paymentMethod: paymentMethod,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                required DateTime entryDateTime,
                required int odometer,
                required String fuelType,
                required int quantityMl,
                Value<int?> pricePerUnitPaisa = const Value.absent(),
                required int totalCostPaisa,
                Value<bool> isFullTank = const Value.absent(),
                Value<String?> vendorId = const Value.absent(),
                Value<String?> stationName = const Value.absent(),
                Value<String?> locationText = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FuelEntriesCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                entryDateTime: entryDateTime,
                odometer: odometer,
                fuelType: fuelType,
                quantityMl: quantityMl,
                pricePerUnitPaisa: pricePerUnitPaisa,
                totalCostPaisa: totalCostPaisa,
                isFullTank: isFullTank,
                vendorId: vendorId,
                stationName: stationName,
                locationText: locationText,
                paymentMethod: paymentMethod,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FuelEntriesTable, FuelEntryRow>(table),
                  $$FuelEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.vehicleId,
                        referencedTable: $$FuelEntriesTableReferences
                            ._vehicleIdTable(db),
                        referencedColumn: $$FuelEntriesTableReferences
                            ._vehicleIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FuelEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FuelEntriesTable,
      FuelEntryRow,
      $$FuelEntriesTableFilterComposer,
      $$FuelEntriesTableOrderingComposer,
      $$FuelEntriesTableAnnotationComposer,
      $$FuelEntriesTableCreateCompanionBuilder,
      $$FuelEntriesTableUpdateCompanionBuilder,
      (FuelEntryRow, $$FuelEntriesTableReferences),
      FuelEntryRow,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$ExpenseCategoriesTableCreateCompanionBuilder =
    ExpenseCategoriesCompanion Function({
      required String id,
      required String code,
      required String nameEn,
      required String nameBn,
      required String dashboardGroup,
      Value<String> iconKey,
      Value<bool> isSystem,
      Value<int> sortOrder,
      Value<bool> isArchived,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$ExpenseCategoriesTableUpdateCompanionBuilder =
    ExpenseCategoriesCompanion Function({
      Value<String> id,
      Value<String> code,
      Value<String> nameEn,
      Value<String> nameBn,
      Value<String> dashboardGroup,
      Value<String> iconKey,
      Value<bool> isSystem,
      Value<int> sortOrder,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$ExpenseCategoriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExpenseCategoriesTable,
          ExpenseCategoryRow
        > {
  $$ExpenseCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ExpensesTable, List<ExpenseRow>>
  _expensesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.expenses,
    aliasName: 'expense_categories__id__expenses__category_id',
  );

  $$ExpensesTableProcessedTableManager get expensesRefs {
    final manager = $$ExpensesTableTableManager(
      $_db,
      $_db.expenses,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExpenseCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpenseCategoriesTable> {
  $$ExpenseCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dashboardGroup => $composableBuilder(
    column: $table.dashboardGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> expensesRefs(
    Expression<bool> Function($$ExpensesTableFilterComposer f) f,
  ) {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableFilterComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExpenseCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpenseCategoriesTable> {
  $$ExpenseCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dashboardGroup => $composableBuilder(
    column: $table.dashboardGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpenseCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpenseCategoriesTable> {
  $$ExpenseCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameBn =>
      $composableBuilder(column: $table.nameBn, builder: (column) => column);

  GeneratedColumn<String> get dashboardGroup => $composableBuilder(
    column: $table.dashboardGroup,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconKey =>
      $composableBuilder(column: $table.iconKey, builder: (column) => column);

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> expensesRefs<T extends Object>(
    Expression<T> Function($$ExpensesTableAnnotationComposer a) f,
  ) {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableAnnotationComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExpenseCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpenseCategoriesTable,
          ExpenseCategoryRow,
          $$ExpenseCategoriesTableFilterComposer,
          $$ExpenseCategoriesTableOrderingComposer,
          $$ExpenseCategoriesTableAnnotationComposer,
          $$ExpenseCategoriesTableCreateCompanionBuilder,
          $$ExpenseCategoriesTableUpdateCompanionBuilder,
          (ExpenseCategoryRow, $$ExpenseCategoriesTableReferences),
          ExpenseCategoryRow,
          PrefetchHooks Function({bool expensesRefs})
        > {
  $$ExpenseCategoriesTableTableManager(
    _$AppDatabase db,
    $ExpenseCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpenseCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpenseCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpenseCategoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameBn = const Value.absent(),
                Value<String> dashboardGroup = const Value.absent(),
                Value<String> iconKey = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpenseCategoriesCompanion(
                id: id,
                code: code,
                nameEn: nameEn,
                nameBn: nameBn,
                dashboardGroup: dashboardGroup,
                iconKey: iconKey,
                isSystem: isSystem,
                sortOrder: sortOrder,
                isArchived: isArchived,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                required String nameEn,
                required String nameBn,
                required String dashboardGroup,
                Value<String> iconKey = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ExpenseCategoriesCompanion.insert(
                id: id,
                code: code,
                nameEn: nameEn,
                nameBn: nameBn,
                dashboardGroup: dashboardGroup,
                iconKey: iconKey,
                isSystem: isSystem,
                sortOrder: sortOrder,
                isArchived: isArchived,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExpenseCategoriesTable, ExpenseCategoryRow>(
                    table,
                  ),
                  $$ExpenseCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({expensesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (expensesRefs) db.expenses],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (expensesRefs)
                    await $_getPrefetchedData<
                      ExpenseCategoryRow,
                      $ExpenseCategoriesTable,
                      ExpenseRow
                    >(
                      currentTable: table,
                      referencedTable: $$ExpenseCategoriesTableReferences
                          ._expensesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ExpenseCategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).expensesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ExpenseCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpenseCategoriesTable,
      ExpenseCategoryRow,
      $$ExpenseCategoriesTableFilterComposer,
      $$ExpenseCategoriesTableOrderingComposer,
      $$ExpenseCategoriesTableAnnotationComposer,
      $$ExpenseCategoriesTableCreateCompanionBuilder,
      $$ExpenseCategoriesTableUpdateCompanionBuilder,
      (ExpenseCategoryRow, $$ExpenseCategoriesTableReferences),
      ExpenseCategoryRow,
      PrefetchHooks Function({bool expensesRefs})
    >;
typedef $$ExpensesTableCreateCompanionBuilder = ExpensesCompanion Function({
  required String id,
  required String vehicleId,
  required DateTime occurredOn,
  required String categoryId,
  required int amountPaisa,
  Value<int?> odometer,
  Value<String?> vendorId,
  Value<String?> vendorName,
  Value<String?> paymentMethod,
  Value<String?> description,
  Value<String?> note,
  Value<String> sourceType,
  Value<String?> sourceRecordId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$ExpensesTableUpdateCompanionBuilder = ExpensesCompanion Function({
  Value<String> id,
  Value<String> vehicleId,
  Value<DateTime> occurredOn,
  Value<String> categoryId,
  Value<int> amountPaisa,
  Value<int?> odometer,
  Value<String?> vendorId,
  Value<String?> vendorName,
  Value<String?> paymentMethod,
  Value<String?> description,
  Value<String?> note,
  Value<String> sourceType,
  Value<String?> sourceRecordId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$ExpensesTableReferences
    extends BaseReferences<_$AppDatabase, $ExpensesTable, ExpenseRow> {
  $$ExpensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('expenses__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ExpenseCategoriesTable _categoryIdTable(_$AppDatabase db) => db
      .expenseCategories
      .createAlias('expenses__category_id__expense_categories__id');

  $$ExpenseCategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$ExpenseCategoriesTableTableManager(
      $_db,
      $_db.expenseCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredOn => $composableBuilder(
    column: $table.occurredOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountPaisa => $composableBuilder(
    column: $table.amountPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vendorId => $composableBuilder(
    column: $table.vendorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRecordId => $composableBuilder(
    column: $table.sourceRecordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExpenseCategoriesTableFilterComposer get categoryId {
    final $$ExpenseCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.expenseCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpenseCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.expenseCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredOn => $composableBuilder(
    column: $table.occurredOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountPaisa => $composableBuilder(
    column: $table.amountPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vendorId => $composableBuilder(
    column: $table.vendorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRecordId => $composableBuilder(
    column: $table.sourceRecordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExpenseCategoriesTableOrderingComposer get categoryId {
    final $$ExpenseCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.expenseCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpenseCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.expenseCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredOn => $composableBuilder(
    column: $table.occurredOn,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountPaisa => $composableBuilder(
    column: $table.amountPaisa,
    builder: (column) => column,
  );

  GeneratedColumn<int> get odometer =>
      $composableBuilder(column: $table.odometer, builder: (column) => column);

  GeneratedColumn<String> get vendorId =>
      $composableBuilder(column: $table.vendorId, builder: (column) => column);

  GeneratedColumn<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceRecordId => $composableBuilder(
    column: $table.sourceRecordId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExpenseCategoriesTableAnnotationComposer get categoryId {
    final $$ExpenseCategoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.expenseCategories,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExpenseCategoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.expenseCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          ExpenseRow,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (ExpenseRow, $$ExpensesTableReferences),
          ExpenseRow,
          PrefetchHooks Function({bool vehicleId, bool categoryId})
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<DateTime> occurredOn = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<int> amountPaisa = const Value.absent(),
                Value<int?> odometer = const Value.absent(),
                Value<String?> vendorId = const Value.absent(),
                Value<String?> vendorName = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String?> sourceRecordId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                vehicleId: vehicleId,
                occurredOn: occurredOn,
                categoryId: categoryId,
                amountPaisa: amountPaisa,
                odometer: odometer,
                vendorId: vendorId,
                vendorName: vendorName,
                paymentMethod: paymentMethod,
                description: description,
                note: note,
                sourceType: sourceType,
                sourceRecordId: sourceRecordId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                required DateTime occurredOn,
                required String categoryId,
                required int amountPaisa,
                Value<int?> odometer = const Value.absent(),
                Value<String?> vendorId = const Value.absent(),
                Value<String?> vendorName = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String?> sourceRecordId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                occurredOn: occurredOn,
                categoryId: categoryId,
                amountPaisa: amountPaisa,
                odometer: odometer,
                vendorId: vendorId,
                vendorName: vendorName,
                paymentMethod: paymentMethod,
                description: description,
                note: note,
                sourceType: sourceType,
                sourceRecordId: sourceRecordId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExpensesTable, ExpenseRow>(table),
                  $$ExpensesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false, categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.vehicleId,
                        referencedTable: $$ExpensesTableReferences
                            ._vehicleIdTable(db),
                        referencedColumn: $$ExpensesTableReferences
                            ._vehicleIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (categoryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.categoryId,
                        referencedTable: $$ExpensesTableReferences
                            ._categoryIdTable(db),
                        referencedColumn: $$ExpensesTableReferences
                            ._categoryIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      ExpenseRow,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (ExpenseRow, $$ExpensesTableReferences),
      ExpenseRow,
      PrefetchHooks Function({bool vehicleId, bool categoryId})
    >;
typedef $$MaintenanceTemplatesTableCreateCompanionBuilder =
    MaintenanceTemplatesCompanion Function({
      required String id,
      required String code,
      required String nameEn,
      required String nameBn,
      Value<String> vehicleType,
      Value<int?> defaultKmInterval,
      Value<int?> defaultDayInterval,
      Value<String> iconKey,
      Value<bool> isSystem,
      Value<bool> isActive,
      Value<int> sortOrder,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$MaintenanceTemplatesTableUpdateCompanionBuilder =
    MaintenanceTemplatesCompanion Function({
      Value<String> id,
      Value<String> code,
      Value<String> nameEn,
      Value<String> nameBn,
      Value<String> vehicleType,
      Value<int?> defaultKmInterval,
      Value<int?> defaultDayInterval,
      Value<String> iconKey,
      Value<bool> isSystem,
      Value<bool> isActive,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$MaintenanceTemplatesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MaintenanceTemplatesTable,
          MaintenanceTemplateRow
        > {
  $$MaintenanceTemplatesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ServiceItemsTable, List<ServiceItemRow>>
  _serviceItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.serviceItems,
    aliasName: 'maintenance_templates__id__service_items__template_id',
  );

  $$ServiceItemsTableProcessedTableManager get serviceItemsRefs {
    final manager = $$ServiceItemsTableTableManager(
      $_db,
      $_db.serviceItems,
    ).filter((f) => f.templateId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_serviceItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MaintenanceTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenanceTemplatesTable> {
  $$MaintenanceTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vehicleType => $composableBuilder(
    column: $table.vehicleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultKmInterval => $composableBuilder(
    column: $table.defaultKmInterval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultDayInterval => $composableBuilder(
    column: $table.defaultDayInterval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> serviceItemsRefs(
    Expression<bool> Function($$ServiceItemsTableFilterComposer f) f,
  ) {
    final $$ServiceItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceItems,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceItemsTableFilterComposer(
            $db: $db,
            $table: $db.serviceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MaintenanceTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenanceTemplatesTable> {
  $$MaintenanceTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vehicleType => $composableBuilder(
    column: $table.vehicleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultKmInterval => $composableBuilder(
    column: $table.defaultKmInterval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultDayInterval => $composableBuilder(
    column: $table.defaultDayInterval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MaintenanceTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenanceTemplatesTable> {
  $$MaintenanceTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameBn =>
      $composableBuilder(column: $table.nameBn, builder: (column) => column);

  GeneratedColumn<String> get vehicleType => $composableBuilder(
    column: $table.vehicleType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultKmInterval => $composableBuilder(
    column: $table.defaultKmInterval,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultDayInterval => $composableBuilder(
    column: $table.defaultDayInterval,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconKey =>
      $composableBuilder(column: $table.iconKey, builder: (column) => column);

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> serviceItemsRefs<T extends Object>(
    Expression<T> Function($$ServiceItemsTableAnnotationComposer a) f,
  ) {
    final $$ServiceItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceItems,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.serviceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MaintenanceTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaintenanceTemplatesTable,
          MaintenanceTemplateRow,
          $$MaintenanceTemplatesTableFilterComposer,
          $$MaintenanceTemplatesTableOrderingComposer,
          $$MaintenanceTemplatesTableAnnotationComposer,
          $$MaintenanceTemplatesTableCreateCompanionBuilder,
          $$MaintenanceTemplatesTableUpdateCompanionBuilder,
          (MaintenanceTemplateRow, $$MaintenanceTemplatesTableReferences),
          MaintenanceTemplateRow,
          PrefetchHooks Function({bool serviceItemsRefs})
        > {
  $$MaintenanceTemplatesTableTableManager(
    _$AppDatabase db,
    $MaintenanceTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenanceTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaintenanceTemplatesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MaintenanceTemplatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameBn = const Value.absent(),
                Value<String> vehicleType = const Value.absent(),
                Value<int?> defaultKmInterval = const Value.absent(),
                Value<int?> defaultDayInterval = const Value.absent(),
                Value<String> iconKey = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MaintenanceTemplatesCompanion(
                id: id,
                code: code,
                nameEn: nameEn,
                nameBn: nameBn,
                vehicleType: vehicleType,
                defaultKmInterval: defaultKmInterval,
                defaultDayInterval: defaultDayInterval,
                iconKey: iconKey,
                isSystem: isSystem,
                isActive: isActive,
                sortOrder: sortOrder,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                required String nameEn,
                required String nameBn,
                Value<String> vehicleType = const Value.absent(),
                Value<int?> defaultKmInterval = const Value.absent(),
                Value<int?> defaultDayInterval = const Value.absent(),
                Value<String> iconKey = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => MaintenanceTemplatesCompanion.insert(
                id: id,
                code: code,
                nameEn: nameEn,
                nameBn: nameBn,
                vehicleType: vehicleType,
                defaultKmInterval: defaultKmInterval,
                defaultDayInterval: defaultDayInterval,
                iconKey: iconKey,
                isSystem: isSystem,
                isActive: isActive,
                sortOrder: sortOrder,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $MaintenanceTemplatesTable,
                    MaintenanceTemplateRow
                  >(table),
                  $$MaintenanceTemplatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({serviceItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (serviceItemsRefs) db.serviceItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (serviceItemsRefs)
                    await $_getPrefetchedData<
                      MaintenanceTemplateRow,
                      $MaintenanceTemplatesTable,
                      ServiceItemRow
                    >(
                      currentTable: table,
                      referencedTable: $$MaintenanceTemplatesTableReferences
                          ._serviceItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MaintenanceTemplatesTableReferences(
                            db,
                            table,
                            p0,
                          ).serviceItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.templateId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MaintenanceTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaintenanceTemplatesTable,
      MaintenanceTemplateRow,
      $$MaintenanceTemplatesTableFilterComposer,
      $$MaintenanceTemplatesTableOrderingComposer,
      $$MaintenanceTemplatesTableAnnotationComposer,
      $$MaintenanceTemplatesTableCreateCompanionBuilder,
      $$MaintenanceTemplatesTableUpdateCompanionBuilder,
      (MaintenanceTemplateRow, $$MaintenanceTemplatesTableReferences),
      MaintenanceTemplateRow,
      PrefetchHooks Function({bool serviceItemsRefs})
    >;
typedef $$ServiceRecordsTableCreateCompanionBuilder =
    ServiceRecordsCompanion Function({
      required String id,
      required String vehicleId,
      required DateTime serviceDate,
      required int odometer,
      Value<String?> vendorName,
      Value<int> laborCostPaisa,
      Value<int> partsCostPaisa,
      Value<int> totalCostPaisa,
      Value<DateTime?> nextDueDate,
      Value<int?> nextDueOdometer,
      Value<String?> note,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ServiceRecordsTableUpdateCompanionBuilder =
    ServiceRecordsCompanion Function({
      Value<String> id,
      Value<String> vehicleId,
      Value<DateTime> serviceDate,
      Value<int> odometer,
      Value<String?> vendorName,
      Value<int> laborCostPaisa,
      Value<int> partsCostPaisa,
      Value<int> totalCostPaisa,
      Value<DateTime?> nextDueDate,
      Value<int?> nextDueOdometer,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ServiceRecordsTableReferences
    extends
        BaseReferences<_$AppDatabase, $ServiceRecordsTable, ServiceRecordRow> {
  $$ServiceRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('service_records__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ServiceItemsTable, List<ServiceItemRow>>
  _serviceItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.serviceItems,
    aliasName: 'service_records__id__service_items__service_record_id',
  );

  $$ServiceItemsTableProcessedTableManager get serviceItemsRefs {
    final manager = $$ServiceItemsTableTableManager($_db, $_db.serviceItems)
        .filter(
          (f) => f.serviceRecordId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_serviceItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$OilChangesTable, List<OilChangeRow>>
  _oilChangesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.oilChanges,
    aliasName: 'service_records__id__oil_changes__service_record_id',
  );

  $$OilChangesTableProcessedTableManager get oilChangesRefs {
    final manager = $$OilChangesTableTableManager($_db, $_db.oilChanges).filter(
      (f) => f.serviceRecordId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_oilChangesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ServiceRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ServiceRecordsTable> {
  $$ServiceRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get serviceDate => $composableBuilder(
    column: $table.serviceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get laborCostPaisa => $composableBuilder(
    column: $table.laborCostPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get partsCostPaisa => $composableBuilder(
    column: $table.partsCostPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCostPaisa => $composableBuilder(
    column: $table.totalCostPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextDueOdometer => $composableBuilder(
    column: $table.nextDueOdometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> serviceItemsRefs(
    Expression<bool> Function($$ServiceItemsTableFilterComposer f) f,
  ) {
    final $$ServiceItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceItems,
      getReferencedColumn: (t) => t.serviceRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceItemsTableFilterComposer(
            $db: $db,
            $table: $db.serviceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> oilChangesRefs(
    Expression<bool> Function($$OilChangesTableFilterComposer f) f,
  ) {
    final $$OilChangesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.oilChanges,
      getReferencedColumn: (t) => t.serviceRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OilChangesTableFilterComposer(
            $db: $db,
            $table: $db.oilChanges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ServiceRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ServiceRecordsTable> {
  $$ServiceRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get serviceDate => $composableBuilder(
    column: $table.serviceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get laborCostPaisa => $composableBuilder(
    column: $table.laborCostPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get partsCostPaisa => $composableBuilder(
    column: $table.partsCostPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCostPaisa => $composableBuilder(
    column: $table.totalCostPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextDueOdometer => $composableBuilder(
    column: $table.nextDueOdometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServiceRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServiceRecordsTable> {
  $$ServiceRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get serviceDate => $composableBuilder(
    column: $table.serviceDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get odometer =>
      $composableBuilder(column: $table.odometer, builder: (column) => column);

  GeneratedColumn<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get laborCostPaisa => $composableBuilder(
    column: $table.laborCostPaisa,
    builder: (column) => column,
  );

  GeneratedColumn<int> get partsCostPaisa => $composableBuilder(
    column: $table.partsCostPaisa,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCostPaisa => $composableBuilder(
    column: $table.totalCostPaisa,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextDueOdometer => $composableBuilder(
    column: $table.nextDueOdometer,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> serviceItemsRefs<T extends Object>(
    Expression<T> Function($$ServiceItemsTableAnnotationComposer a) f,
  ) {
    final $$ServiceItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.serviceItems,
      getReferencedColumn: (t) => t.serviceRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.serviceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> oilChangesRefs<T extends Object>(
    Expression<T> Function($$OilChangesTableAnnotationComposer a) f,
  ) {
    final $$OilChangesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.oilChanges,
      getReferencedColumn: (t) => t.serviceRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OilChangesTableAnnotationComposer(
            $db: $db,
            $table: $db.oilChanges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ServiceRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServiceRecordsTable,
          ServiceRecordRow,
          $$ServiceRecordsTableFilterComposer,
          $$ServiceRecordsTableOrderingComposer,
          $$ServiceRecordsTableAnnotationComposer,
          $$ServiceRecordsTableCreateCompanionBuilder,
          $$ServiceRecordsTableUpdateCompanionBuilder,
          (ServiceRecordRow, $$ServiceRecordsTableReferences),
          ServiceRecordRow,
          PrefetchHooks Function({
            bool vehicleId,
            bool serviceItemsRefs,
            bool oilChangesRefs,
          })
        > {
  $$ServiceRecordsTableTableManager(
    _$AppDatabase db,
    $ServiceRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServiceRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServiceRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServiceRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<DateTime> serviceDate = const Value.absent(),
                Value<int> odometer = const Value.absent(),
                Value<String?> vendorName = const Value.absent(),
                Value<int> laborCostPaisa = const Value.absent(),
                Value<int> partsCostPaisa = const Value.absent(),
                Value<int> totalCostPaisa = const Value.absent(),
                Value<DateTime?> nextDueDate = const Value.absent(),
                Value<int?> nextDueOdometer = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServiceRecordsCompanion(
                id: id,
                vehicleId: vehicleId,
                serviceDate: serviceDate,
                odometer: odometer,
                vendorName: vendorName,
                laborCostPaisa: laborCostPaisa,
                partsCostPaisa: partsCostPaisa,
                totalCostPaisa: totalCostPaisa,
                nextDueDate: nextDueDate,
                nextDueOdometer: nextDueOdometer,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                required DateTime serviceDate,
                required int odometer,
                Value<String?> vendorName = const Value.absent(),
                Value<int> laborCostPaisa = const Value.absent(),
                Value<int> partsCostPaisa = const Value.absent(),
                Value<int> totalCostPaisa = const Value.absent(),
                Value<DateTime?> nextDueDate = const Value.absent(),
                Value<int?> nextDueOdometer = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ServiceRecordsCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                serviceDate: serviceDate,
                odometer: odometer,
                vendorName: vendorName,
                laborCostPaisa: laborCostPaisa,
                partsCostPaisa: partsCostPaisa,
                totalCostPaisa: totalCostPaisa,
                nextDueDate: nextDueDate,
                nextDueOdometer: nextDueOdometer,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ServiceRecordsTable, ServiceRecordRow>(table),
                  $$ServiceRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                vehicleId = false,
                serviceItemsRefs = false,
                oilChangesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (serviceItemsRefs) db.serviceItems,
                    if (oilChangesRefs) db.oilChanges,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (vehicleId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.vehicleId,
                            referencedTable: $$ServiceRecordsTableReferences
                                ._vehicleIdTable(db),
                            referencedColumn: $$ServiceRecordsTableReferences
                                ._vehicleIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (serviceItemsRefs)
                        await $_getPrefetchedData<
                          ServiceRecordRow,
                          $ServiceRecordsTable,
                          ServiceItemRow
                        >(
                          currentTable: table,
                          referencedTable: $$ServiceRecordsTableReferences
                              ._serviceItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ServiceRecordsTableReferences(
                                db,
                                table,
                                p0,
                              ).serviceItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.serviceRecordId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (oilChangesRefs)
                        await $_getPrefetchedData<
                          ServiceRecordRow,
                          $ServiceRecordsTable,
                          OilChangeRow
                        >(
                          currentTable: table,
                          referencedTable: $$ServiceRecordsTableReferences
                              ._oilChangesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ServiceRecordsTableReferences(
                                db,
                                table,
                                p0,
                              ).oilChangesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.serviceRecordId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ServiceRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServiceRecordsTable,
      ServiceRecordRow,
      $$ServiceRecordsTableFilterComposer,
      $$ServiceRecordsTableOrderingComposer,
      $$ServiceRecordsTableAnnotationComposer,
      $$ServiceRecordsTableCreateCompanionBuilder,
      $$ServiceRecordsTableUpdateCompanionBuilder,
      (ServiceRecordRow, $$ServiceRecordsTableReferences),
      ServiceRecordRow,
      PrefetchHooks Function({
        bool vehicleId,
        bool serviceItemsRefs,
        bool oilChangesRefs,
      })
    >;
typedef $$ServiceItemsTableCreateCompanionBuilder =
    ServiceItemsCompanion Function({
      required String id,
      required String serviceRecordId,
      Value<String?> templateId,
      required String maintenanceType,
      required String title,
      Value<int> costPaisa,
      Value<double> quantity,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$ServiceItemsTableUpdateCompanionBuilder =
    ServiceItemsCompanion Function({
      Value<String> id,
      Value<String> serviceRecordId,
      Value<String?> templateId,
      Value<String> maintenanceType,
      Value<String> title,
      Value<int> costPaisa,
      Value<double> quantity,
      Value<String?> note,
      Value<int> rowid,
    });

final class $$ServiceItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ServiceItemsTable, ServiceItemRow> {
  $$ServiceItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ServiceRecordsTable _serviceRecordIdTable(_$AppDatabase db) => db
      .serviceRecords
      .createAlias('service_items__service_record_id__service_records__id');

  $$ServiceRecordsTableProcessedTableManager get serviceRecordId {
    final $_column = $_itemColumn<String>('service_record_id')!;

    final manager = $$ServiceRecordsTableTableManager(
      $_db,
      $_db.serviceRecords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_serviceRecordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MaintenanceTemplatesTable _templateIdTable(_$AppDatabase db) => db
      .maintenanceTemplates
      .createAlias('service_items__template_id__maintenance_templates__id');

  $$MaintenanceTemplatesTableProcessedTableManager? get templateId {
    final $_column = $_itemColumn<String>('template_id');
    if ($_column == null) return null;
    final manager = $$MaintenanceTemplatesTableTableManager(
      $_db,
      $_db.maintenanceTemplates,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ServiceItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ServiceItemsTable> {
  $$ServiceItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get maintenanceType => $composableBuilder(
    column: $table.maintenanceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costPaisa => $composableBuilder(
    column: $table.costPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$ServiceRecordsTableFilterComposer get serviceRecordId {
    final $$ServiceRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serviceRecordId,
      referencedTable: $db.serviceRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceRecordsTableFilterComposer(
            $db: $db,
            $table: $db.serviceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MaintenanceTemplatesTableFilterComposer get templateId {
    final $$MaintenanceTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.maintenanceTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.maintenanceTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServiceItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ServiceItemsTable> {
  $$ServiceItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get maintenanceType => $composableBuilder(
    column: $table.maintenanceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costPaisa => $composableBuilder(
    column: $table.costPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$ServiceRecordsTableOrderingComposer get serviceRecordId {
    final $$ServiceRecordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serviceRecordId,
      referencedTable: $db.serviceRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceRecordsTableOrderingComposer(
            $db: $db,
            $table: $db.serviceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MaintenanceTemplatesTableOrderingComposer get templateId {
    final $$MaintenanceTemplatesTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.templateId,
          referencedTable: $db.maintenanceTemplates,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MaintenanceTemplatesTableOrderingComposer(
                $db: $db,
                $table: $db.maintenanceTemplates,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ServiceItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServiceItemsTable> {
  $$ServiceItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get maintenanceType => $composableBuilder(
    column: $table.maintenanceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get costPaisa =>
      $composableBuilder(column: $table.costPaisa, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$ServiceRecordsTableAnnotationComposer get serviceRecordId {
    final $$ServiceRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serviceRecordId,
      referencedTable: $db.serviceRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.serviceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MaintenanceTemplatesTableAnnotationComposer get templateId {
    final $$MaintenanceTemplatesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.templateId,
          referencedTable: $db.maintenanceTemplates,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MaintenanceTemplatesTableAnnotationComposer(
                $db: $db,
                $table: $db.maintenanceTemplates,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ServiceItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServiceItemsTable,
          ServiceItemRow,
          $$ServiceItemsTableFilterComposer,
          $$ServiceItemsTableOrderingComposer,
          $$ServiceItemsTableAnnotationComposer,
          $$ServiceItemsTableCreateCompanionBuilder,
          $$ServiceItemsTableUpdateCompanionBuilder,
          (ServiceItemRow, $$ServiceItemsTableReferences),
          ServiceItemRow,
          PrefetchHooks Function({bool serviceRecordId, bool templateId})
        > {
  $$ServiceItemsTableTableManager(_$AppDatabase db, $ServiceItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServiceItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServiceItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServiceItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> serviceRecordId = const Value.absent(),
                Value<String?> templateId = const Value.absent(),
                Value<String> maintenanceType = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> costPaisa = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServiceItemsCompanion(
                id: id,
                serviceRecordId: serviceRecordId,
                templateId: templateId,
                maintenanceType: maintenanceType,
                title: title,
                costPaisa: costPaisa,
                quantity: quantity,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String serviceRecordId,
                Value<String?> templateId = const Value.absent(),
                required String maintenanceType,
                required String title,
                Value<int> costPaisa = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServiceItemsCompanion.insert(
                id: id,
                serviceRecordId: serviceRecordId,
                templateId: templateId,
                maintenanceType: maintenanceType,
                title: title,
                costPaisa: costPaisa,
                quantity: quantity,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ServiceItemsTable, ServiceItemRow>(table),
                  $$ServiceItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({serviceRecordId = false, templateId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (serviceRecordId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.serviceRecordId,
                            referencedTable: $$ServiceItemsTableReferences
                                ._serviceRecordIdTable(db),
                            referencedColumn: $$ServiceItemsTableReferences
                                ._serviceRecordIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (templateId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.templateId,
                            referencedTable: $$ServiceItemsTableReferences
                                ._templateIdTable(db),
                            referencedColumn: $$ServiceItemsTableReferences
                                ._templateIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$ServiceItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServiceItemsTable,
      ServiceItemRow,
      $$ServiceItemsTableFilterComposer,
      $$ServiceItemsTableOrderingComposer,
      $$ServiceItemsTableAnnotationComposer,
      $$ServiceItemsTableCreateCompanionBuilder,
      $$ServiceItemsTableUpdateCompanionBuilder,
      (ServiceItemRow, $$ServiceItemsTableReferences),
      ServiceItemRow,
      PrefetchHooks Function({bool serviceRecordId, bool templateId})
    >;
typedef $$OilChangesTableCreateCompanionBuilder = OilChangesCompanion Function({
  required String id,
  required String vehicleId,
  required DateTime occurredOn,
  required int odometer,
  Value<String?> brand,
  Value<String?> productName,
  Value<String?> viscosity,
  Value<int?> quantityMl,
  Value<int> costPaisa,
  Value<bool> filterChanged,
  Value<String?> vendorName,
  Value<DateTime?> nextDueDate,
  Value<int?> nextDueOdometer,
  Value<String?> note,
  Value<String?> serviceRecordId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$OilChangesTableUpdateCompanionBuilder = OilChangesCompanion Function({
  Value<String> id,
  Value<String> vehicleId,
  Value<DateTime> occurredOn,
  Value<int> odometer,
  Value<String?> brand,
  Value<String?> productName,
  Value<String?> viscosity,
  Value<int?> quantityMl,
  Value<int> costPaisa,
  Value<bool> filterChanged,
  Value<String?> vendorName,
  Value<DateTime?> nextDueDate,
  Value<int?> nextDueOdometer,
  Value<String?> note,
  Value<String?> serviceRecordId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$OilChangesTableReferences
    extends BaseReferences<_$AppDatabase, $OilChangesTable, OilChangeRow> {
  $$OilChangesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('oil_changes__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ServiceRecordsTable _serviceRecordIdTable(_$AppDatabase db) => db
      .serviceRecords
      .createAlias('oil_changes__service_record_id__service_records__id');

  $$ServiceRecordsTableProcessedTableManager? get serviceRecordId {
    final $_column = $_itemColumn<String>('service_record_id');
    if ($_column == null) return null;
    final manager = $$ServiceRecordsTableTableManager(
      $_db,
      $_db.serviceRecords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_serviceRecordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$OilChangesTableFilterComposer
    extends Composer<_$AppDatabase, $OilChangesTable> {
  $$OilChangesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredOn => $composableBuilder(
    column: $table.occurredOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get viscosity => $composableBuilder(
    column: $table.viscosity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantityMl => $composableBuilder(
    column: $table.quantityMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costPaisa => $composableBuilder(
    column: $table.costPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get filterChanged => $composableBuilder(
    column: $table.filterChanged,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextDueOdometer => $composableBuilder(
    column: $table.nextDueOdometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ServiceRecordsTableFilterComposer get serviceRecordId {
    final $$ServiceRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serviceRecordId,
      referencedTable: $db.serviceRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceRecordsTableFilterComposer(
            $db: $db,
            $table: $db.serviceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OilChangesTableOrderingComposer
    extends Composer<_$AppDatabase, $OilChangesTable> {
  $$OilChangesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredOn => $composableBuilder(
    column: $table.occurredOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get viscosity => $composableBuilder(
    column: $table.viscosity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantityMl => $composableBuilder(
    column: $table.quantityMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costPaisa => $composableBuilder(
    column: $table.costPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get filterChanged => $composableBuilder(
    column: $table.filterChanged,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextDueOdometer => $composableBuilder(
    column: $table.nextDueOdometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ServiceRecordsTableOrderingComposer get serviceRecordId {
    final $$ServiceRecordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serviceRecordId,
      referencedTable: $db.serviceRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceRecordsTableOrderingComposer(
            $db: $db,
            $table: $db.serviceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OilChangesTableAnnotationComposer
    extends Composer<_$AppDatabase, $OilChangesTable> {
  $$OilChangesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredOn => $composableBuilder(
    column: $table.occurredOn,
    builder: (column) => column,
  );

  GeneratedColumn<int> get odometer =>
      $composableBuilder(column: $table.odometer, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get viscosity =>
      $composableBuilder(column: $table.viscosity, builder: (column) => column);

  GeneratedColumn<int> get quantityMl => $composableBuilder(
    column: $table.quantityMl,
    builder: (column) => column,
  );

  GeneratedColumn<int> get costPaisa =>
      $composableBuilder(column: $table.costPaisa, builder: (column) => column);

  GeneratedColumn<bool> get filterChanged => $composableBuilder(
    column: $table.filterChanged,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextDueOdometer => $composableBuilder(
    column: $table.nextDueOdometer,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ServiceRecordsTableAnnotationComposer get serviceRecordId {
    final $$ServiceRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serviceRecordId,
      referencedTable: $db.serviceRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServiceRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.serviceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OilChangesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OilChangesTable,
          OilChangeRow,
          $$OilChangesTableFilterComposer,
          $$OilChangesTableOrderingComposer,
          $$OilChangesTableAnnotationComposer,
          $$OilChangesTableCreateCompanionBuilder,
          $$OilChangesTableUpdateCompanionBuilder,
          (OilChangeRow, $$OilChangesTableReferences),
          OilChangeRow,
          PrefetchHooks Function({bool vehicleId, bool serviceRecordId})
        > {
  $$OilChangesTableTableManager(_$AppDatabase db, $OilChangesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OilChangesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OilChangesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OilChangesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<DateTime> occurredOn = const Value.absent(),
                Value<int> odometer = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> productName = const Value.absent(),
                Value<String?> viscosity = const Value.absent(),
                Value<int?> quantityMl = const Value.absent(),
                Value<int> costPaisa = const Value.absent(),
                Value<bool> filterChanged = const Value.absent(),
                Value<String?> vendorName = const Value.absent(),
                Value<DateTime?> nextDueDate = const Value.absent(),
                Value<int?> nextDueOdometer = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> serviceRecordId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OilChangesCompanion(
                id: id,
                vehicleId: vehicleId,
                occurredOn: occurredOn,
                odometer: odometer,
                brand: brand,
                productName: productName,
                viscosity: viscosity,
                quantityMl: quantityMl,
                costPaisa: costPaisa,
                filterChanged: filterChanged,
                vendorName: vendorName,
                nextDueDate: nextDueDate,
                nextDueOdometer: nextDueOdometer,
                note: note,
                serviceRecordId: serviceRecordId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                required DateTime occurredOn,
                required int odometer,
                Value<String?> brand = const Value.absent(),
                Value<String?> productName = const Value.absent(),
                Value<String?> viscosity = const Value.absent(),
                Value<int?> quantityMl = const Value.absent(),
                Value<int> costPaisa = const Value.absent(),
                Value<bool> filterChanged = const Value.absent(),
                Value<String?> vendorName = const Value.absent(),
                Value<DateTime?> nextDueDate = const Value.absent(),
                Value<int?> nextDueOdometer = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> serviceRecordId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => OilChangesCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                occurredOn: occurredOn,
                odometer: odometer,
                brand: brand,
                productName: productName,
                viscosity: viscosity,
                quantityMl: quantityMl,
                costPaisa: costPaisa,
                filterChanged: filterChanged,
                vendorName: vendorName,
                nextDueDate: nextDueDate,
                nextDueOdometer: nextDueOdometer,
                note: note,
                serviceRecordId: serviceRecordId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$OilChangesTable, OilChangeRow>(table),
                  $$OilChangesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({vehicleId = false, serviceRecordId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (vehicleId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.vehicleId,
                            referencedTable: $$OilChangesTableReferences
                                ._vehicleIdTable(db),
                            referencedColumn: $$OilChangesTableReferences
                                ._vehicleIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (serviceRecordId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.serviceRecordId,
                            referencedTable: $$OilChangesTableReferences
                                ._serviceRecordIdTable(db),
                            referencedColumn: $$OilChangesTableReferences
                                ._serviceRecordIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$OilChangesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OilChangesTable,
      OilChangeRow,
      $$OilChangesTableFilterComposer,
      $$OilChangesTableOrderingComposer,
      $$OilChangesTableAnnotationComposer,
      $$OilChangesTableCreateCompanionBuilder,
      $$OilChangesTableUpdateCompanionBuilder,
      (OilChangeRow, $$OilChangesTableReferences),
      OilChangeRow,
      PrefetchHooks Function({bool vehicleId, bool serviceRecordId})
    >;
typedef $$RepairsTableCreateCompanionBuilder = RepairsCompanion Function({
  required String id,
  required String vehicleId,
  required DateTime repairDate,
  required int odometer,
  required String category,
  required String problemDescription,
  Value<String?> diagnosis,
  Value<String?> workPerformed,
  Value<String?> vendorName,
  Value<int> laborCostPaisa,
  Value<int> partsCostPaisa,
  Value<int> totalCostPaisa,
  Value<DateTime?> warrantyEndDate,
  Value<DateTime?> followUpDate,
  Value<String?> note,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$RepairsTableUpdateCompanionBuilder = RepairsCompanion Function({
  Value<String> id,
  Value<String> vehicleId,
  Value<DateTime> repairDate,
  Value<int> odometer,
  Value<String> category,
  Value<String> problemDescription,
  Value<String?> diagnosis,
  Value<String?> workPerformed,
  Value<String?> vendorName,
  Value<int> laborCostPaisa,
  Value<int> partsCostPaisa,
  Value<int> totalCostPaisa,
  Value<DateTime?> warrantyEndDate,
  Value<DateTime?> followUpDate,
  Value<String?> note,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$RepairsTableReferences
    extends BaseReferences<_$AppDatabase, $RepairsTable, RepairRow> {
  $$RepairsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('repairs__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RepairPartsTable, List<RepairPartRow>>
  _repairPartsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.repairParts,
    aliasName: 'repairs__id__repair_parts__repair_id',
  );

  $$RepairPartsTableProcessedTableManager get repairPartsRefs {
    final manager = $$RepairPartsTableTableManager(
      $_db,
      $_db.repairParts,
    ).filter((f) => f.repairId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_repairPartsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RepairsTableFilterComposer
    extends Composer<_$AppDatabase, $RepairsTable> {
  $$RepairsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get repairDate => $composableBuilder(
    column: $table.repairDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get problemDescription => $composableBuilder(
    column: $table.problemDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get diagnosis => $composableBuilder(
    column: $table.diagnosis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workPerformed => $composableBuilder(
    column: $table.workPerformed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get laborCostPaisa => $composableBuilder(
    column: $table.laborCostPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get partsCostPaisa => $composableBuilder(
    column: $table.partsCostPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCostPaisa => $composableBuilder(
    column: $table.totalCostPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get warrantyEndDate => $composableBuilder(
    column: $table.warrantyEndDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get followUpDate => $composableBuilder(
    column: $table.followUpDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> repairPartsRefs(
    Expression<bool> Function($$RepairPartsTableFilterComposer f) f,
  ) {
    final $$RepairPartsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairParts,
      getReferencedColumn: (t) => t.repairId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairPartsTableFilterComposer(
            $db: $db,
            $table: $db.repairParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RepairsTableOrderingComposer
    extends Composer<_$AppDatabase, $RepairsTable> {
  $$RepairsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get repairDate => $composableBuilder(
    column: $table.repairDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get problemDescription => $composableBuilder(
    column: $table.problemDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get diagnosis => $composableBuilder(
    column: $table.diagnosis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workPerformed => $composableBuilder(
    column: $table.workPerformed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get laborCostPaisa => $composableBuilder(
    column: $table.laborCostPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get partsCostPaisa => $composableBuilder(
    column: $table.partsCostPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCostPaisa => $composableBuilder(
    column: $table.totalCostPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get warrantyEndDate => $composableBuilder(
    column: $table.warrantyEndDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get followUpDate => $composableBuilder(
    column: $table.followUpDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepairsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepairsTable> {
  $$RepairsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get repairDate => $composableBuilder(
    column: $table.repairDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get odometer =>
      $composableBuilder(column: $table.odometer, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get problemDescription => $composableBuilder(
    column: $table.problemDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get diagnosis =>
      $composableBuilder(column: $table.diagnosis, builder: (column) => column);

  GeneratedColumn<String> get workPerformed => $composableBuilder(
    column: $table.workPerformed,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get laborCostPaisa => $composableBuilder(
    column: $table.laborCostPaisa,
    builder: (column) => column,
  );

  GeneratedColumn<int> get partsCostPaisa => $composableBuilder(
    column: $table.partsCostPaisa,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCostPaisa => $composableBuilder(
    column: $table.totalCostPaisa,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get warrantyEndDate => $composableBuilder(
    column: $table.warrantyEndDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get followUpDate => $composableBuilder(
    column: $table.followUpDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> repairPartsRefs<T extends Object>(
    Expression<T> Function($$RepairPartsTableAnnotationComposer a) f,
  ) {
    final $$RepairPartsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairParts,
      getReferencedColumn: (t) => t.repairId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairPartsTableAnnotationComposer(
            $db: $db,
            $table: $db.repairParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RepairsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RepairsTable,
          RepairRow,
          $$RepairsTableFilterComposer,
          $$RepairsTableOrderingComposer,
          $$RepairsTableAnnotationComposer,
          $$RepairsTableCreateCompanionBuilder,
          $$RepairsTableUpdateCompanionBuilder,
          (RepairRow, $$RepairsTableReferences),
          RepairRow,
          PrefetchHooks Function({bool vehicleId, bool repairPartsRefs})
        > {
  $$RepairsTableTableManager(_$AppDatabase db, $RepairsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepairsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepairsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepairsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<DateTime> repairDate = const Value.absent(),
                Value<int> odometer = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> problemDescription = const Value.absent(),
                Value<String?> diagnosis = const Value.absent(),
                Value<String?> workPerformed = const Value.absent(),
                Value<String?> vendorName = const Value.absent(),
                Value<int> laborCostPaisa = const Value.absent(),
                Value<int> partsCostPaisa = const Value.absent(),
                Value<int> totalCostPaisa = const Value.absent(),
                Value<DateTime?> warrantyEndDate = const Value.absent(),
                Value<DateTime?> followUpDate = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RepairsCompanion(
                id: id,
                vehicleId: vehicleId,
                repairDate: repairDate,
                odometer: odometer,
                category: category,
                problemDescription: problemDescription,
                diagnosis: diagnosis,
                workPerformed: workPerformed,
                vendorName: vendorName,
                laborCostPaisa: laborCostPaisa,
                partsCostPaisa: partsCostPaisa,
                totalCostPaisa: totalCostPaisa,
                warrantyEndDate: warrantyEndDate,
                followUpDate: followUpDate,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                required DateTime repairDate,
                required int odometer,
                required String category,
                required String problemDescription,
                Value<String?> diagnosis = const Value.absent(),
                Value<String?> workPerformed = const Value.absent(),
                Value<String?> vendorName = const Value.absent(),
                Value<int> laborCostPaisa = const Value.absent(),
                Value<int> partsCostPaisa = const Value.absent(),
                Value<int> totalCostPaisa = const Value.absent(),
                Value<DateTime?> warrantyEndDate = const Value.absent(),
                Value<DateTime?> followUpDate = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => RepairsCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                repairDate: repairDate,
                odometer: odometer,
                category: category,
                problemDescription: problemDescription,
                diagnosis: diagnosis,
                workPerformed: workPerformed,
                vendorName: vendorName,
                laborCostPaisa: laborCostPaisa,
                partsCostPaisa: partsCostPaisa,
                totalCostPaisa: totalCostPaisa,
                warrantyEndDate: warrantyEndDate,
                followUpDate: followUpDate,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RepairsTable, RepairRow>(table),
                  $$RepairsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({vehicleId = false, repairPartsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (repairPartsRefs) db.repairParts,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (vehicleId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.vehicleId,
                            referencedTable: $$RepairsTableReferences
                                ._vehicleIdTable(db),
                            referencedColumn: $$RepairsTableReferences
                                ._vehicleIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (repairPartsRefs)
                        await $_getPrefetchedData<
                          RepairRow,
                          $RepairsTable,
                          RepairPartRow
                        >(
                          currentTable: table,
                          referencedTable: $$RepairsTableReferences
                              ._repairPartsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RepairsTableReferences(
                                db,
                                table,
                                p0,
                              ).repairPartsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.repairId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RepairsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RepairsTable,
      RepairRow,
      $$RepairsTableFilterComposer,
      $$RepairsTableOrderingComposer,
      $$RepairsTableAnnotationComposer,
      $$RepairsTableCreateCompanionBuilder,
      $$RepairsTableUpdateCompanionBuilder,
      (RepairRow, $$RepairsTableReferences),
      RepairRow,
      PrefetchHooks Function({bool vehicleId, bool repairPartsRefs})
    >;
typedef $$RepairPartsTableCreateCompanionBuilder =
    RepairPartsCompanion Function({
      required String id,
      required String repairId,
      required String partName,
      Value<String?> brand,
      Value<String?> partNumber,
      Value<double> quantity,
      Value<int> unitCostPaisa,
      Value<int> totalCostPaisa,
      Value<DateTime?> warrantyEndDate,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$RepairPartsTableUpdateCompanionBuilder =
    RepairPartsCompanion Function({
      Value<String> id,
      Value<String> repairId,
      Value<String> partName,
      Value<String?> brand,
      Value<String?> partNumber,
      Value<double> quantity,
      Value<int> unitCostPaisa,
      Value<int> totalCostPaisa,
      Value<DateTime?> warrantyEndDate,
      Value<String?> note,
      Value<int> rowid,
    });

final class $$RepairPartsTableReferences
    extends BaseReferences<_$AppDatabase, $RepairPartsTable, RepairPartRow> {
  $$RepairPartsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RepairsTable _repairIdTable(_$AppDatabase db) =>
      db.repairs.createAlias('repair_parts__repair_id__repairs__id');

  $$RepairsTableProcessedTableManager get repairId {
    final $_column = $_itemColumn<String>('repair_id')!;

    final manager = $$RepairsTableTableManager(
      $_db,
      $_db.repairs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_repairIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RepairPartsTableFilterComposer
    extends Composer<_$AppDatabase, $RepairPartsTable> {
  $$RepairPartsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partName => $composableBuilder(
    column: $table.partName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partNumber => $composableBuilder(
    column: $table.partNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitCostPaisa => $composableBuilder(
    column: $table.unitCostPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCostPaisa => $composableBuilder(
    column: $table.totalCostPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get warrantyEndDate => $composableBuilder(
    column: $table.warrantyEndDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$RepairsTableFilterComposer get repairId {
    final $$RepairsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairId,
      referencedTable: $db.repairs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairsTableFilterComposer(
            $db: $db,
            $table: $db.repairs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepairPartsTableOrderingComposer
    extends Composer<_$AppDatabase, $RepairPartsTable> {
  $$RepairPartsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partName => $composableBuilder(
    column: $table.partName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partNumber => $composableBuilder(
    column: $table.partNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitCostPaisa => $composableBuilder(
    column: $table.unitCostPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCostPaisa => $composableBuilder(
    column: $table.totalCostPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get warrantyEndDate => $composableBuilder(
    column: $table.warrantyEndDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$RepairsTableOrderingComposer get repairId {
    final $$RepairsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairId,
      referencedTable: $db.repairs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairsTableOrderingComposer(
            $db: $db,
            $table: $db.repairs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepairPartsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepairPartsTable> {
  $$RepairPartsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get partName =>
      $composableBuilder(column: $table.partName, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get partNumber => $composableBuilder(
    column: $table.partNumber,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get unitCostPaisa => $composableBuilder(
    column: $table.unitCostPaisa,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCostPaisa => $composableBuilder(
    column: $table.totalCostPaisa,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get warrantyEndDate => $composableBuilder(
    column: $table.warrantyEndDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$RepairsTableAnnotationComposer get repairId {
    final $$RepairsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairId,
      referencedTable: $db.repairs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairsTableAnnotationComposer(
            $db: $db,
            $table: $db.repairs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepairPartsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RepairPartsTable,
          RepairPartRow,
          $$RepairPartsTableFilterComposer,
          $$RepairPartsTableOrderingComposer,
          $$RepairPartsTableAnnotationComposer,
          $$RepairPartsTableCreateCompanionBuilder,
          $$RepairPartsTableUpdateCompanionBuilder,
          (RepairPartRow, $$RepairPartsTableReferences),
          RepairPartRow,
          PrefetchHooks Function({bool repairId})
        > {
  $$RepairPartsTableTableManager(_$AppDatabase db, $RepairPartsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepairPartsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepairPartsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepairPartsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> repairId = const Value.absent(),
                Value<String> partName = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> partNumber = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<int> unitCostPaisa = const Value.absent(),
                Value<int> totalCostPaisa = const Value.absent(),
                Value<DateTime?> warrantyEndDate = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RepairPartsCompanion(
                id: id,
                repairId: repairId,
                partName: partName,
                brand: brand,
                partNumber: partNumber,
                quantity: quantity,
                unitCostPaisa: unitCostPaisa,
                totalCostPaisa: totalCostPaisa,
                warrantyEndDate: warrantyEndDate,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String repairId,
                required String partName,
                Value<String?> brand = const Value.absent(),
                Value<String?> partNumber = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<int> unitCostPaisa = const Value.absent(),
                Value<int> totalCostPaisa = const Value.absent(),
                Value<DateTime?> warrantyEndDate = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RepairPartsCompanion.insert(
                id: id,
                repairId: repairId,
                partName: partName,
                brand: brand,
                partNumber: partNumber,
                quantity: quantity,
                unitCostPaisa: unitCostPaisa,
                totalCostPaisa: totalCostPaisa,
                warrantyEndDate: warrantyEndDate,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RepairPartsTable, RepairPartRow>(table),
                  $$RepairPartsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({repairId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (repairId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.repairId,
                        referencedTable: $$RepairPartsTableReferences
                            ._repairIdTable(db),
                        referencedColumn: $$RepairPartsTableReferences
                            ._repairIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RepairPartsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RepairPartsTable,
      RepairPartRow,
      $$RepairPartsTableFilterComposer,
      $$RepairPartsTableOrderingComposer,
      $$RepairPartsTableAnnotationComposer,
      $$RepairPartsTableCreateCompanionBuilder,
      $$RepairPartsTableUpdateCompanionBuilder,
      (RepairPartRow, $$RepairPartsTableReferences),
      RepairPartRow,
      PrefetchHooks Function({bool repairId})
    >;
typedef $$VehiclePartsTableCreateCompanionBuilder =
    VehiclePartsCompanion Function({
      required String id,
      required String vehicleId,
      required String category,
      required String name,
      Value<String?> brand,
      Value<String?> partNumber,
      required DateTime installedDate,
      Value<int?> installedOdometer,
      Value<int> costPaisa,
      Value<String?> vendorName,
      Value<DateTime?> warrantyEndDate,
      Value<int?> replacementIntervalKm,
      Value<int?> replacementIntervalDays,
      Value<String?> note,
      Value<bool> isActive,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$VehiclePartsTableUpdateCompanionBuilder =
    VehiclePartsCompanion Function({
      Value<String> id,
      Value<String> vehicleId,
      Value<String> category,
      Value<String> name,
      Value<String?> brand,
      Value<String?> partNumber,
      Value<DateTime> installedDate,
      Value<int?> installedOdometer,
      Value<int> costPaisa,
      Value<String?> vendorName,
      Value<DateTime?> warrantyEndDate,
      Value<int?> replacementIntervalKm,
      Value<int?> replacementIntervalDays,
      Value<String?> note,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$VehiclePartsTableReferences
    extends BaseReferences<_$AppDatabase, $VehiclePartsTable, VehiclePartRow> {
  $$VehiclePartsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('vehicle_parts__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VehiclePartsTableFilterComposer
    extends Composer<_$AppDatabase, $VehiclePartsTable> {
  $$VehiclePartsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partNumber => $composableBuilder(
    column: $table.partNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get installedDate => $composableBuilder(
    column: $table.installedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get installedOdometer => $composableBuilder(
    column: $table.installedOdometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costPaisa => $composableBuilder(
    column: $table.costPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get warrantyEndDate => $composableBuilder(
    column: $table.warrantyEndDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get replacementIntervalKm => $composableBuilder(
    column: $table.replacementIntervalKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get replacementIntervalDays => $composableBuilder(
    column: $table.replacementIntervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehiclePartsTableOrderingComposer
    extends Composer<_$AppDatabase, $VehiclePartsTable> {
  $$VehiclePartsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partNumber => $composableBuilder(
    column: $table.partNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get installedDate => $composableBuilder(
    column: $table.installedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get installedOdometer => $composableBuilder(
    column: $table.installedOdometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costPaisa => $composableBuilder(
    column: $table.costPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get warrantyEndDate => $composableBuilder(
    column: $table.warrantyEndDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get replacementIntervalKm => $composableBuilder(
    column: $table.replacementIntervalKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get replacementIntervalDays => $composableBuilder(
    column: $table.replacementIntervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehiclePartsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehiclePartsTable> {
  $$VehiclePartsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get partNumber => $composableBuilder(
    column: $table.partNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get installedDate => $composableBuilder(
    column: $table.installedDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get installedOdometer => $composableBuilder(
    column: $table.installedOdometer,
    builder: (column) => column,
  );

  GeneratedColumn<int> get costPaisa =>
      $composableBuilder(column: $table.costPaisa, builder: (column) => column);

  GeneratedColumn<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get warrantyEndDate => $composableBuilder(
    column: $table.warrantyEndDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get replacementIntervalKm => $composableBuilder(
    column: $table.replacementIntervalKm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get replacementIntervalDays => $composableBuilder(
    column: $table.replacementIntervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehiclePartsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehiclePartsTable,
          VehiclePartRow,
          $$VehiclePartsTableFilterComposer,
          $$VehiclePartsTableOrderingComposer,
          $$VehiclePartsTableAnnotationComposer,
          $$VehiclePartsTableCreateCompanionBuilder,
          $$VehiclePartsTableUpdateCompanionBuilder,
          (VehiclePartRow, $$VehiclePartsTableReferences),
          VehiclePartRow,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$VehiclePartsTableTableManager(_$AppDatabase db, $VehiclePartsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiclePartsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiclePartsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiclePartsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> partNumber = const Value.absent(),
                Value<DateTime> installedDate = const Value.absent(),
                Value<int?> installedOdometer = const Value.absent(),
                Value<int> costPaisa = const Value.absent(),
                Value<String?> vendorName = const Value.absent(),
                Value<DateTime?> warrantyEndDate = const Value.absent(),
                Value<int?> replacementIntervalKm = const Value.absent(),
                Value<int?> replacementIntervalDays = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehiclePartsCompanion(
                id: id,
                vehicleId: vehicleId,
                category: category,
                name: name,
                brand: brand,
                partNumber: partNumber,
                installedDate: installedDate,
                installedOdometer: installedOdometer,
                costPaisa: costPaisa,
                vendorName: vendorName,
                warrantyEndDate: warrantyEndDate,
                replacementIntervalKm: replacementIntervalKm,
                replacementIntervalDays: replacementIntervalDays,
                note: note,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                required String category,
                required String name,
                Value<String?> brand = const Value.absent(),
                Value<String?> partNumber = const Value.absent(),
                required DateTime installedDate,
                Value<int?> installedOdometer = const Value.absent(),
                Value<int> costPaisa = const Value.absent(),
                Value<String?> vendorName = const Value.absent(),
                Value<DateTime?> warrantyEndDate = const Value.absent(),
                Value<int?> replacementIntervalKm = const Value.absent(),
                Value<int?> replacementIntervalDays = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => VehiclePartsCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                category: category,
                name: name,
                brand: brand,
                partNumber: partNumber,
                installedDate: installedDate,
                installedOdometer: installedOdometer,
                costPaisa: costPaisa,
                vendorName: vendorName,
                warrantyEndDate: warrantyEndDate,
                replacementIntervalKm: replacementIntervalKm,
                replacementIntervalDays: replacementIntervalDays,
                note: note,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VehiclePartsTable, VehiclePartRow>(table),
                  $$VehiclePartsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.vehicleId,
                        referencedTable: $$VehiclePartsTableReferences
                            ._vehicleIdTable(db),
                        referencedColumn: $$VehiclePartsTableReferences
                            ._vehicleIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VehiclePartsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehiclePartsTable,
      VehiclePartRow,
      $$VehiclePartsTableFilterComposer,
      $$VehiclePartsTableOrderingComposer,
      $$VehiclePartsTableAnnotationComposer,
      $$VehiclePartsTableCreateCompanionBuilder,
      $$VehiclePartsTableUpdateCompanionBuilder,
      (VehiclePartRow, $$VehiclePartsTableReferences),
      VehiclePartRow,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$TyresTableCreateCompanionBuilder = TyresCompanion Function({
  required String id,
  required String vehicleId,
  required String position,
  Value<String?> brand,
  Value<String?> model,
  Value<String?> size,
  Value<DateTime?> purchaseDate,
  required DateTime installDate,
  required int installOdometer,
  Value<int> costPaisa,
  Value<DateTime?> warrantyEndDate,
  Value<String?> vendorName,
  Value<String> status,
  Value<String?> note,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$TyresTableUpdateCompanionBuilder = TyresCompanion Function({
  Value<String> id,
  Value<String> vehicleId,
  Value<String> position,
  Value<String?> brand,
  Value<String?> model,
  Value<String?> size,
  Value<DateTime?> purchaseDate,
  Value<DateTime> installDate,
  Value<int> installOdometer,
  Value<int> costPaisa,
  Value<DateTime?> warrantyEndDate,
  Value<String?> vendorName,
  Value<String> status,
  Value<String?> note,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$TyresTableReferences
    extends BaseReferences<_$AppDatabase, $TyresTable, TyreRow> {
  $$TyresTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('tyres__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TyreEventsTable, List<TyreEventRow>>
  _tyreEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.tyreEvents,
    aliasName: 'tyres__id__tyre_events__tyre_id',
  );

  $$TyreEventsTableProcessedTableManager get tyreEventsRefs {
    final manager = $$TyreEventsTableTableManager(
      $_db,
      $_db.tyreEvents,
    ).filter((f) => f.tyreId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tyreEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TyresTableFilterComposer extends Composer<_$AppDatabase, $TyresTable> {
  $$TyresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get installDate => $composableBuilder(
    column: $table.installDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get installOdometer => $composableBuilder(
    column: $table.installOdometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costPaisa => $composableBuilder(
    column: $table.costPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get warrantyEndDate => $composableBuilder(
    column: $table.warrantyEndDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> tyreEventsRefs(
    Expression<bool> Function($$TyreEventsTableFilterComposer f) f,
  ) {
    final $$TyreEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tyreEvents,
      getReferencedColumn: (t) => t.tyreId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TyreEventsTableFilterComposer(
            $db: $db,
            $table: $db.tyreEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TyresTableOrderingComposer
    extends Composer<_$AppDatabase, $TyresTable> {
  $$TyresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get installDate => $composableBuilder(
    column: $table.installDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get installOdometer => $composableBuilder(
    column: $table.installOdometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costPaisa => $composableBuilder(
    column: $table.costPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get warrantyEndDate => $composableBuilder(
    column: $table.warrantyEndDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TyresTableAnnotationComposer
    extends Composer<_$AppDatabase, $TyresTable> {
  $$TyresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get installDate => $composableBuilder(
    column: $table.installDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get installOdometer => $composableBuilder(
    column: $table.installOdometer,
    builder: (column) => column,
  );

  GeneratedColumn<int> get costPaisa =>
      $composableBuilder(column: $table.costPaisa, builder: (column) => column);

  GeneratedColumn<DateTime> get warrantyEndDate => $composableBuilder(
    column: $table.warrantyEndDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> tyreEventsRefs<T extends Object>(
    Expression<T> Function($$TyreEventsTableAnnotationComposer a) f,
  ) {
    final $$TyreEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tyreEvents,
      getReferencedColumn: (t) => t.tyreId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TyreEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.tyreEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TyresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TyresTable,
          TyreRow,
          $$TyresTableFilterComposer,
          $$TyresTableOrderingComposer,
          $$TyresTableAnnotationComposer,
          $$TyresTableCreateCompanionBuilder,
          $$TyresTableUpdateCompanionBuilder,
          (TyreRow, $$TyresTableReferences),
          TyreRow,
          PrefetchHooks Function({bool vehicleId, bool tyreEventsRefs})
        > {
  $$TyresTableTableManager(_$AppDatabase db, $TyresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TyresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TyresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TyresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<String> position = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> size = const Value.absent(),
                Value<DateTime?> purchaseDate = const Value.absent(),
                Value<DateTime> installDate = const Value.absent(),
                Value<int> installOdometer = const Value.absent(),
                Value<int> costPaisa = const Value.absent(),
                Value<DateTime?> warrantyEndDate = const Value.absent(),
                Value<String?> vendorName = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TyresCompanion(
                id: id,
                vehicleId: vehicleId,
                position: position,
                brand: brand,
                model: model,
                size: size,
                purchaseDate: purchaseDate,
                installDate: installDate,
                installOdometer: installOdometer,
                costPaisa: costPaisa,
                warrantyEndDate: warrantyEndDate,
                vendorName: vendorName,
                status: status,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                required String position,
                Value<String?> brand = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> size = const Value.absent(),
                Value<DateTime?> purchaseDate = const Value.absent(),
                required DateTime installDate,
                required int installOdometer,
                Value<int> costPaisa = const Value.absent(),
                Value<DateTime?> warrantyEndDate = const Value.absent(),
                Value<String?> vendorName = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => TyresCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                position: position,
                brand: brand,
                model: model,
                size: size,
                purchaseDate: purchaseDate,
                installDate: installDate,
                installOdometer: installOdometer,
                costPaisa: costPaisa,
                warrantyEndDate: warrantyEndDate,
                vendorName: vendorName,
                status: status,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TyresTable, TyreRow>(table),
                  $$TyresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false, tyreEventsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (tyreEventsRefs) db.tyreEvents],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.vehicleId,
                        referencedTable: $$TyresTableReferences._vehicleIdTable(
                          db,
                        ),
                        referencedColumn: $$TyresTableReferences
                            ._vehicleIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tyreEventsRefs)
                    await $_getPrefetchedData<
                      TyreRow,
                      $TyresTable,
                      TyreEventRow
                    >(
                      currentTable: table,
                      referencedTable: $$TyresTableReferences
                          ._tyreEventsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TyresTableReferences(db, table, p0).tyreEventsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.tyreId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TyresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TyresTable,
      TyreRow,
      $$TyresTableFilterComposer,
      $$TyresTableOrderingComposer,
      $$TyresTableAnnotationComposer,
      $$TyresTableCreateCompanionBuilder,
      $$TyresTableUpdateCompanionBuilder,
      (TyreRow, $$TyresTableReferences),
      TyreRow,
      PrefetchHooks Function({bool vehicleId, bool tyreEventsRefs})
    >;
typedef $$TyreEventsTableCreateCompanionBuilder = TyreEventsCompanion Function({
  required String id,
  required String tyreId,
  required String vehicleId,
  required String eventType,
  required DateTime occurredOn,
  Value<int?> odometer,
  Value<String?> fromPosition,
  Value<String?> toPosition,
  Value<String?> inspectionResult,
  Value<int?> costPaisa,
  Value<String?> note,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$TyreEventsTableUpdateCompanionBuilder = TyreEventsCompanion Function({
  Value<String> id,
  Value<String> tyreId,
  Value<String> vehicleId,
  Value<String> eventType,
  Value<DateTime> occurredOn,
  Value<int?> odometer,
  Value<String?> fromPosition,
  Value<String?> toPosition,
  Value<String?> inspectionResult,
  Value<int?> costPaisa,
  Value<String?> note,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$TyreEventsTableReferences
    extends BaseReferences<_$AppDatabase, $TyreEventsTable, TyreEventRow> {
  $$TyreEventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TyresTable _tyreIdTable(_$AppDatabase db) =>
      db.tyres.createAlias('tyre_events__tyre_id__tyres__id');

  $$TyresTableProcessedTableManager get tyreId {
    final $_column = $_itemColumn<String>('tyre_id')!;

    final manager = $$TyresTableTableManager(
      $_db,
      $_db.tyres,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tyreIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('tyre_events__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TyreEventsTableFilterComposer
    extends Composer<_$AppDatabase, $TyreEventsTable> {
  $$TyreEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredOn => $composableBuilder(
    column: $table.occurredOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fromPosition => $composableBuilder(
    column: $table.fromPosition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toPosition => $composableBuilder(
    column: $table.toPosition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inspectionResult => $composableBuilder(
    column: $table.inspectionResult,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costPaisa => $composableBuilder(
    column: $table.costPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TyresTableFilterComposer get tyreId {
    final $$TyresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tyreId,
      referencedTable: $db.tyres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TyresTableFilterComposer(
            $db: $db,
            $table: $db.tyres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TyreEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $TyreEventsTable> {
  $$TyreEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredOn => $composableBuilder(
    column: $table.occurredOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fromPosition => $composableBuilder(
    column: $table.fromPosition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toPosition => $composableBuilder(
    column: $table.toPosition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inspectionResult => $composableBuilder(
    column: $table.inspectionResult,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costPaisa => $composableBuilder(
    column: $table.costPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TyresTableOrderingComposer get tyreId {
    final $$TyresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tyreId,
      referencedTable: $db.tyres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TyresTableOrderingComposer(
            $db: $db,
            $table: $db.tyres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TyreEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TyreEventsTable> {
  $$TyreEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredOn => $composableBuilder(
    column: $table.occurredOn,
    builder: (column) => column,
  );

  GeneratedColumn<int> get odometer =>
      $composableBuilder(column: $table.odometer, builder: (column) => column);

  GeneratedColumn<String> get fromPosition => $composableBuilder(
    column: $table.fromPosition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get toPosition => $composableBuilder(
    column: $table.toPosition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get inspectionResult => $composableBuilder(
    column: $table.inspectionResult,
    builder: (column) => column,
  );

  GeneratedColumn<int> get costPaisa =>
      $composableBuilder(column: $table.costPaisa, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$TyresTableAnnotationComposer get tyreId {
    final $$TyresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tyreId,
      referencedTable: $db.tyres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TyresTableAnnotationComposer(
            $db: $db,
            $table: $db.tyres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TyreEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TyreEventsTable,
          TyreEventRow,
          $$TyreEventsTableFilterComposer,
          $$TyreEventsTableOrderingComposer,
          $$TyreEventsTableAnnotationComposer,
          $$TyreEventsTableCreateCompanionBuilder,
          $$TyreEventsTableUpdateCompanionBuilder,
          (TyreEventRow, $$TyreEventsTableReferences),
          TyreEventRow,
          PrefetchHooks Function({bool tyreId, bool vehicleId})
        > {
  $$TyreEventsTableTableManager(_$AppDatabase db, $TyreEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TyreEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TyreEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TyreEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tyreId = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<DateTime> occurredOn = const Value.absent(),
                Value<int?> odometer = const Value.absent(),
                Value<String?> fromPosition = const Value.absent(),
                Value<String?> toPosition = const Value.absent(),
                Value<String?> inspectionResult = const Value.absent(),
                Value<int?> costPaisa = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TyreEventsCompanion(
                id: id,
                tyreId: tyreId,
                vehicleId: vehicleId,
                eventType: eventType,
                occurredOn: occurredOn,
                odometer: odometer,
                fromPosition: fromPosition,
                toPosition: toPosition,
                inspectionResult: inspectionResult,
                costPaisa: costPaisa,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tyreId,
                required String vehicleId,
                required String eventType,
                required DateTime occurredOn,
                Value<int?> odometer = const Value.absent(),
                Value<String?> fromPosition = const Value.absent(),
                Value<String?> toPosition = const Value.absent(),
                Value<String?> inspectionResult = const Value.absent(),
                Value<int?> costPaisa = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => TyreEventsCompanion.insert(
                id: id,
                tyreId: tyreId,
                vehicleId: vehicleId,
                eventType: eventType,
                occurredOn: occurredOn,
                odometer: odometer,
                fromPosition: fromPosition,
                toPosition: toPosition,
                inspectionResult: inspectionResult,
                costPaisa: costPaisa,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TyreEventsTable, TyreEventRow>(table),
                  $$TyreEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tyreId = false, vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tyreId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.tyreId,
                        referencedTable: $$TyreEventsTableReferences
                            ._tyreIdTable(db),
                        referencedColumn: $$TyreEventsTableReferences
                            ._tyreIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (vehicleId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.vehicleId,
                        referencedTable: $$TyreEventsTableReferences
                            ._vehicleIdTable(db),
                        referencedColumn: $$TyreEventsTableReferences
                            ._vehicleIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TyreEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TyreEventsTable,
      TyreEventRow,
      $$TyreEventsTableFilterComposer,
      $$TyreEventsTableOrderingComposer,
      $$TyreEventsTableAnnotationComposer,
      $$TyreEventsTableCreateCompanionBuilder,
      $$TyreEventsTableUpdateCompanionBuilder,
      (TyreEventRow, $$TyreEventsTableReferences),
      TyreEventRow,
      PrefetchHooks Function({bool tyreId, bool vehicleId})
    >;
typedef $$BatteriesTableCreateCompanionBuilder = BatteriesCompanion Function({
  required String id,
  required String vehicleId,
  Value<String?> brand,
  Value<String?> model,
  Value<String?> specification,
  Value<DateTime?> purchaseDate,
  required DateTime installDate,
  Value<int?> installOdometer,
  Value<int> costPaisa,
  Value<DateTime?> warrantyEndDate,
  Value<String?> vendorName,
  Value<String> status,
  Value<String?> note,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$BatteriesTableUpdateCompanionBuilder = BatteriesCompanion Function({
  Value<String> id,
  Value<String> vehicleId,
  Value<String?> brand,
  Value<String?> model,
  Value<String?> specification,
  Value<DateTime?> purchaseDate,
  Value<DateTime> installDate,
  Value<int?> installOdometer,
  Value<int> costPaisa,
  Value<DateTime?> warrantyEndDate,
  Value<String?> vendorName,
  Value<String> status,
  Value<String?> note,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$BatteriesTableReferences
    extends BaseReferences<_$AppDatabase, $BatteriesTable, BatteryRow> {
  $$BatteriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('batteries__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BatteriesTableFilterComposer
    extends Composer<_$AppDatabase, $BatteriesTable> {
  $$BatteriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get specification => $composableBuilder(
    column: $table.specification,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get installDate => $composableBuilder(
    column: $table.installDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get installOdometer => $composableBuilder(
    column: $table.installOdometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costPaisa => $composableBuilder(
    column: $table.costPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get warrantyEndDate => $composableBuilder(
    column: $table.warrantyEndDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BatteriesTableOrderingComposer
    extends Composer<_$AppDatabase, $BatteriesTable> {
  $$BatteriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get specification => $composableBuilder(
    column: $table.specification,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get installDate => $composableBuilder(
    column: $table.installDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get installOdometer => $composableBuilder(
    column: $table.installOdometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costPaisa => $composableBuilder(
    column: $table.costPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get warrantyEndDate => $composableBuilder(
    column: $table.warrantyEndDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BatteriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BatteriesTable> {
  $$BatteriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get specification => $composableBuilder(
    column: $table.specification,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get installDate => $composableBuilder(
    column: $table.installDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get installOdometer => $composableBuilder(
    column: $table.installOdometer,
    builder: (column) => column,
  );

  GeneratedColumn<int> get costPaisa =>
      $composableBuilder(column: $table.costPaisa, builder: (column) => column);

  GeneratedColumn<DateTime> get warrantyEndDate => $composableBuilder(
    column: $table.warrantyEndDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vendorName => $composableBuilder(
    column: $table.vendorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BatteriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BatteriesTable,
          BatteryRow,
          $$BatteriesTableFilterComposer,
          $$BatteriesTableOrderingComposer,
          $$BatteriesTableAnnotationComposer,
          $$BatteriesTableCreateCompanionBuilder,
          $$BatteriesTableUpdateCompanionBuilder,
          (BatteryRow, $$BatteriesTableReferences),
          BatteryRow,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$BatteriesTableTableManager(_$AppDatabase db, $BatteriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BatteriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BatteriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BatteriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> specification = const Value.absent(),
                Value<DateTime?> purchaseDate = const Value.absent(),
                Value<DateTime> installDate = const Value.absent(),
                Value<int?> installOdometer = const Value.absent(),
                Value<int> costPaisa = const Value.absent(),
                Value<DateTime?> warrantyEndDate = const Value.absent(),
                Value<String?> vendorName = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BatteriesCompanion(
                id: id,
                vehicleId: vehicleId,
                brand: brand,
                model: model,
                specification: specification,
                purchaseDate: purchaseDate,
                installDate: installDate,
                installOdometer: installOdometer,
                costPaisa: costPaisa,
                warrantyEndDate: warrantyEndDate,
                vendorName: vendorName,
                status: status,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                Value<String?> brand = const Value.absent(),
                Value<String?> model = const Value.absent(),
                Value<String?> specification = const Value.absent(),
                Value<DateTime?> purchaseDate = const Value.absent(),
                required DateTime installDate,
                Value<int?> installOdometer = const Value.absent(),
                Value<int> costPaisa = const Value.absent(),
                Value<DateTime?> warrantyEndDate = const Value.absent(),
                Value<String?> vendorName = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => BatteriesCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                brand: brand,
                model: model,
                specification: specification,
                purchaseDate: purchaseDate,
                installDate: installDate,
                installOdometer: installOdometer,
                costPaisa: costPaisa,
                warrantyEndDate: warrantyEndDate,
                vendorName: vendorName,
                status: status,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BatteriesTable, BatteryRow>(table),
                  $$BatteriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.vehicleId,
                        referencedTable: $$BatteriesTableReferences
                            ._vehicleIdTable(db),
                        referencedColumn: $$BatteriesTableReferences
                            ._vehicleIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BatteriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BatteriesTable,
      BatteryRow,
      $$BatteriesTableFilterComposer,
      $$BatteriesTableOrderingComposer,
      $$BatteriesTableAnnotationComposer,
      $$BatteriesTableCreateCompanionBuilder,
      $$BatteriesTableUpdateCompanionBuilder,
      (BatteryRow, $$BatteriesTableReferences),
      BatteryRow,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$VehicleDocumentsTableCreateCompanionBuilder =
    VehicleDocumentsCompanion Function({
      required String id,
      required String vehicleId,
      required String documentType,
      Value<String?> documentNumber,
      Value<DateTime?> issueDate,
      Value<DateTime?> expiryDate,
      Value<int> feePaisa,
      Value<String?> issuingAuthority,
      Value<String?> providerName,
      Value<String?> policyNumber,
      Value<String?> coverageType,
      Value<String?> ownerName,
      Value<String?> note,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$VehicleDocumentsTableUpdateCompanionBuilder =
    VehicleDocumentsCompanion Function({
      Value<String> id,
      Value<String> vehicleId,
      Value<String> documentType,
      Value<String?> documentNumber,
      Value<DateTime?> issueDate,
      Value<DateTime?> expiryDate,
      Value<int> feePaisa,
      Value<String?> issuingAuthority,
      Value<String?> providerName,
      Value<String?> policyNumber,
      Value<String?> coverageType,
      Value<String?> ownerName,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$VehicleDocumentsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $VehicleDocumentsTable,
          VehicleDocumentRow
        > {
  $$VehicleDocumentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('vehicle_documents__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VehicleDocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $VehicleDocumentsTable> {
  $$VehicleDocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get feePaisa => $composableBuilder(
    column: $table.feePaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get issuingAuthority => $composableBuilder(
    column: $table.issuingAuthority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get providerName => $composableBuilder(
    column: $table.providerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get policyNumber => $composableBuilder(
    column: $table.policyNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverageType => $composableBuilder(
    column: $table.coverageType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerName => $composableBuilder(
    column: $table.ownerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehicleDocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $VehicleDocumentsTable> {
  $$VehicleDocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get feePaisa => $composableBuilder(
    column: $table.feePaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get issuingAuthority => $composableBuilder(
    column: $table.issuingAuthority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get providerName => $composableBuilder(
    column: $table.providerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get policyNumber => $composableBuilder(
    column: $table.policyNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverageType => $composableBuilder(
    column: $table.coverageType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerName => $composableBuilder(
    column: $table.ownerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehicleDocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehicleDocumentsTable> {
  $$VehicleDocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get issueDate =>
      $composableBuilder(column: $table.issueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get feePaisa =>
      $composableBuilder(column: $table.feePaisa, builder: (column) => column);

  GeneratedColumn<String> get issuingAuthority => $composableBuilder(
    column: $table.issuingAuthority,
    builder: (column) => column,
  );

  GeneratedColumn<String> get providerName => $composableBuilder(
    column: $table.providerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get policyNumber => $composableBuilder(
    column: $table.policyNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coverageType => $composableBuilder(
    column: $table.coverageType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ownerName =>
      $composableBuilder(column: $table.ownerName, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VehicleDocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehicleDocumentsTable,
          VehicleDocumentRow,
          $$VehicleDocumentsTableFilterComposer,
          $$VehicleDocumentsTableOrderingComposer,
          $$VehicleDocumentsTableAnnotationComposer,
          $$VehicleDocumentsTableCreateCompanionBuilder,
          $$VehicleDocumentsTableUpdateCompanionBuilder,
          (VehicleDocumentRow, $$VehicleDocumentsTableReferences),
          VehicleDocumentRow,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$VehicleDocumentsTableTableManager(
    _$AppDatabase db,
    $VehicleDocumentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehicleDocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehicleDocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehicleDocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<String> documentType = const Value.absent(),
                Value<String?> documentNumber = const Value.absent(),
                Value<DateTime?> issueDate = const Value.absent(),
                Value<DateTime?> expiryDate = const Value.absent(),
                Value<int> feePaisa = const Value.absent(),
                Value<String?> issuingAuthority = const Value.absent(),
                Value<String?> providerName = const Value.absent(),
                Value<String?> policyNumber = const Value.absent(),
                Value<String?> coverageType = const Value.absent(),
                Value<String?> ownerName = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehicleDocumentsCompanion(
                id: id,
                vehicleId: vehicleId,
                documentType: documentType,
                documentNumber: documentNumber,
                issueDate: issueDate,
                expiryDate: expiryDate,
                feePaisa: feePaisa,
                issuingAuthority: issuingAuthority,
                providerName: providerName,
                policyNumber: policyNumber,
                coverageType: coverageType,
                ownerName: ownerName,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                required String documentType,
                Value<String?> documentNumber = const Value.absent(),
                Value<DateTime?> issueDate = const Value.absent(),
                Value<DateTime?> expiryDate = const Value.absent(),
                Value<int> feePaisa = const Value.absent(),
                Value<String?> issuingAuthority = const Value.absent(),
                Value<String?> providerName = const Value.absent(),
                Value<String?> policyNumber = const Value.absent(),
                Value<String?> coverageType = const Value.absent(),
                Value<String?> ownerName = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => VehicleDocumentsCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                documentType: documentType,
                documentNumber: documentNumber,
                issueDate: issueDate,
                expiryDate: expiryDate,
                feePaisa: feePaisa,
                issuingAuthority: issuingAuthority,
                providerName: providerName,
                policyNumber: policyNumber,
                coverageType: coverageType,
                ownerName: ownerName,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VehicleDocumentsTable, VehicleDocumentRow>(
                    table,
                  ),
                  $$VehicleDocumentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.vehicleId,
                        referencedTable: $$VehicleDocumentsTableReferences
                            ._vehicleIdTable(db),
                        referencedColumn: $$VehicleDocumentsTableReferences
                            ._vehicleIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VehicleDocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehicleDocumentsTable,
      VehicleDocumentRow,
      $$VehicleDocumentsTableFilterComposer,
      $$VehicleDocumentsTableOrderingComposer,
      $$VehicleDocumentsTableAnnotationComposer,
      $$VehicleDocumentsTableCreateCompanionBuilder,
      $$VehicleDocumentsTableUpdateCompanionBuilder,
      (VehicleDocumentRow, $$VehicleDocumentsTableReferences),
      VehicleDocumentRow,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$RemindersTableCreateCompanionBuilder = RemindersCompanion Function({
  required String id,
  required String vehicleId,
  Value<String?> relatedEntityType,
  Value<String?> relatedEntityId,
  required String reminderType,
  required String title,
  Value<String?> description,
  Value<DateTime?> dueDate,
  Value<int?> dueOdometer,
  Value<int> advanceDays,
  Value<int> advanceKm,
  Value<String> recurrenceType,
  Value<int?> recurrenceDays,
  Value<int?> recurrenceKm,
  Value<String> status,
  Value<bool> notificationEnabled,
  Value<DateTime?> snoozedUntil,
  Value<DateTime?> lastTriggeredAt,
  Value<DateTime?> completedAt,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$RemindersTableUpdateCompanionBuilder = RemindersCompanion Function({
  Value<String> id,
  Value<String> vehicleId,
  Value<String?> relatedEntityType,
  Value<String?> relatedEntityId,
  Value<String> reminderType,
  Value<String> title,
  Value<String?> description,
  Value<DateTime?> dueDate,
  Value<int?> dueOdometer,
  Value<int> advanceDays,
  Value<int> advanceKm,
  Value<String> recurrenceType,
  Value<int?> recurrenceDays,
  Value<int?> recurrenceKm,
  Value<String> status,
  Value<bool> notificationEnabled,
  Value<DateTime?> snoozedUntil,
  Value<DateTime?> lastTriggeredAt,
  Value<DateTime?> completedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$RemindersTableReferences
    extends BaseReferences<_$AppDatabase, $RemindersTable, ReminderRow> {
  $$RemindersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('reminders__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relatedEntityType => $composableBuilder(
    column: $table.relatedEntityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relatedEntityId => $composableBuilder(
    column: $table.relatedEntityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reminderType => $composableBuilder(
    column: $table.reminderType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueOdometer => $composableBuilder(
    column: $table.dueOdometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get advanceDays => $composableBuilder(
    column: $table.advanceDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get advanceKm => $composableBuilder(
    column: $table.advanceKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurrenceType => $composableBuilder(
    column: $table.recurrenceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recurrenceDays => $composableBuilder(
    column: $table.recurrenceDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recurrenceKm => $composableBuilder(
    column: $table.recurrenceKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notificationEnabled => $composableBuilder(
    column: $table.notificationEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get snoozedUntil => $composableBuilder(
    column: $table.snoozedUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastTriggeredAt => $composableBuilder(
    column: $table.lastTriggeredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relatedEntityType => $composableBuilder(
    column: $table.relatedEntityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relatedEntityId => $composableBuilder(
    column: $table.relatedEntityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderType => $composableBuilder(
    column: $table.reminderType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueOdometer => $composableBuilder(
    column: $table.dueOdometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get advanceDays => $composableBuilder(
    column: $table.advanceDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get advanceKm => $composableBuilder(
    column: $table.advanceKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrenceType => $composableBuilder(
    column: $table.recurrenceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recurrenceDays => $composableBuilder(
    column: $table.recurrenceDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recurrenceKm => $composableBuilder(
    column: $table.recurrenceKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notificationEnabled => $composableBuilder(
    column: $table.notificationEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get snoozedUntil => $composableBuilder(
    column: $table.snoozedUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastTriggeredAt => $composableBuilder(
    column: $table.lastTriggeredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get relatedEntityType => $composableBuilder(
    column: $table.relatedEntityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get relatedEntityId => $composableBuilder(
    column: $table.relatedEntityId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reminderType => $composableBuilder(
    column: $table.reminderType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<int> get dueOdometer => $composableBuilder(
    column: $table.dueOdometer,
    builder: (column) => column,
  );

  GeneratedColumn<int> get advanceDays => $composableBuilder(
    column: $table.advanceDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get advanceKm =>
      $composableBuilder(column: $table.advanceKm, builder: (column) => column);

  GeneratedColumn<String> get recurrenceType => $composableBuilder(
    column: $table.recurrenceType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get recurrenceDays => $composableBuilder(
    column: $table.recurrenceDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get recurrenceKm => $composableBuilder(
    column: $table.recurrenceKm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get notificationEnabled => $composableBuilder(
    column: $table.notificationEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get snoozedUntil => $composableBuilder(
    column: $table.snoozedUntil,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastTriggeredAt => $composableBuilder(
    column: $table.lastTriggeredAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTable,
          ReminderRow,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (ReminderRow, $$RemindersTableReferences),
          ReminderRow,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<String?> relatedEntityType = const Value.absent(),
                Value<String?> relatedEntityId = const Value.absent(),
                Value<String> reminderType = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<int?> dueOdometer = const Value.absent(),
                Value<int> advanceDays = const Value.absent(),
                Value<int> advanceKm = const Value.absent(),
                Value<String> recurrenceType = const Value.absent(),
                Value<int?> recurrenceDays = const Value.absent(),
                Value<int?> recurrenceKm = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> notificationEnabled = const Value.absent(),
                Value<DateTime?> snoozedUntil = const Value.absent(),
                Value<DateTime?> lastTriggeredAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion(
                id: id,
                vehicleId: vehicleId,
                relatedEntityType: relatedEntityType,
                relatedEntityId: relatedEntityId,
                reminderType: reminderType,
                title: title,
                description: description,
                dueDate: dueDate,
                dueOdometer: dueOdometer,
                advanceDays: advanceDays,
                advanceKm: advanceKm,
                recurrenceType: recurrenceType,
                recurrenceDays: recurrenceDays,
                recurrenceKm: recurrenceKm,
                status: status,
                notificationEnabled: notificationEnabled,
                snoozedUntil: snoozedUntil,
                lastTriggeredAt: lastTriggeredAt,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                Value<String?> relatedEntityType = const Value.absent(),
                Value<String?> relatedEntityId = const Value.absent(),
                required String reminderType,
                required String title,
                Value<String?> description = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<int?> dueOdometer = const Value.absent(),
                Value<int> advanceDays = const Value.absent(),
                Value<int> advanceKm = const Value.absent(),
                Value<String> recurrenceType = const Value.absent(),
                Value<int?> recurrenceDays = const Value.absent(),
                Value<int?> recurrenceKm = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> notificationEnabled = const Value.absent(),
                Value<DateTime?> snoozedUntil = const Value.absent(),
                Value<DateTime?> lastTriggeredAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                relatedEntityType: relatedEntityType,
                relatedEntityId: relatedEntityId,
                reminderType: reminderType,
                title: title,
                description: description,
                dueDate: dueDate,
                dueOdometer: dueOdometer,
                advanceDays: advanceDays,
                advanceKm: advanceKm,
                recurrenceType: recurrenceType,
                recurrenceDays: recurrenceDays,
                recurrenceKm: recurrenceKm,
                status: status,
                notificationEnabled: notificationEnabled,
                snoozedUntil: snoozedUntil,
                lastTriggeredAt: lastTriggeredAt,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RemindersTable, ReminderRow>(table),
                  $$RemindersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.vehicleId,
                        referencedTable: $$RemindersTableReferences
                            ._vehicleIdTable(db),
                        referencedColumn: $$RemindersTableReferences
                            ._vehicleIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTable,
      ReminderRow,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (ReminderRow, $$RemindersTableReferences),
      ReminderRow,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$AttachmentsTableCreateCompanionBuilder =
    AttachmentsCompanion Function({
      required String id,
      required String ownerType,
      required String ownerId,
      required String originalFileName,
      required String storedFileName,
      required String mimeType,
      required int fileSizeBytes,
      required String relativePath,
      Value<String?> thumbnailRelativePath,
      required String checksumSha256,
      Value<String?> displayLabel,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$AttachmentsTableUpdateCompanionBuilder =
    AttachmentsCompanion Function({
      Value<String> id,
      Value<String> ownerType,
      Value<String> ownerId,
      Value<String> originalFileName,
      Value<String> storedFileName,
      Value<String> mimeType,
      Value<int> fileSizeBytes,
      Value<String> relativePath,
      Value<String?> thumbnailRelativePath,
      Value<String> checksumSha256,
      Value<String?> displayLabel,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$AttachmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerType => $composableBuilder(
    column: $table.ownerType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalFileName => $composableBuilder(
    column: $table.originalFileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get storedFileName => $composableBuilder(
    column: $table.storedFileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnailRelativePath => $composableBuilder(
    column: $table.thumbnailRelativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checksumSha256 => $composableBuilder(
    column: $table.checksumSha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayLabel => $composableBuilder(
    column: $table.displayLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AttachmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerType => $composableBuilder(
    column: $table.ownerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalFileName => $composableBuilder(
    column: $table.originalFileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storedFileName => $composableBuilder(
    column: $table.storedFileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnailRelativePath => $composableBuilder(
    column: $table.thumbnailRelativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checksumSha256 => $composableBuilder(
    column: $table.checksumSha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayLabel => $composableBuilder(
    column: $table.displayLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttachmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ownerType =>
      $composableBuilder(column: $table.ownerType, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get originalFileName => $composableBuilder(
    column: $table.originalFileName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get storedFileName => $composableBuilder(
    column: $table.storedFileName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get thumbnailRelativePath => $composableBuilder(
    column: $table.thumbnailRelativePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get checksumSha256 => $composableBuilder(
    column: $table.checksumSha256,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayLabel => $composableBuilder(
    column: $table.displayLabel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AttachmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttachmentsTable,
          AttachmentRow,
          $$AttachmentsTableFilterComposer,
          $$AttachmentsTableOrderingComposer,
          $$AttachmentsTableAnnotationComposer,
          $$AttachmentsTableCreateCompanionBuilder,
          $$AttachmentsTableUpdateCompanionBuilder,
          (
            AttachmentRow,
            BaseReferences<_$AppDatabase, $AttachmentsTable, AttachmentRow>,
          ),
          AttachmentRow,
          PrefetchHooks Function()
        > {
  $$AttachmentsTableTableManager(_$AppDatabase db, $AttachmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttachmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttachmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttachmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerType = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> originalFileName = const Value.absent(),
                Value<String> storedFileName = const Value.absent(),
                Value<String> mimeType = const Value.absent(),
                Value<int> fileSizeBytes = const Value.absent(),
                Value<String> relativePath = const Value.absent(),
                Value<String?> thumbnailRelativePath = const Value.absent(),
                Value<String> checksumSha256 = const Value.absent(),
                Value<String?> displayLabel = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttachmentsCompanion(
                id: id,
                ownerType: ownerType,
                ownerId: ownerId,
                originalFileName: originalFileName,
                storedFileName: storedFileName,
                mimeType: mimeType,
                fileSizeBytes: fileSizeBytes,
                relativePath: relativePath,
                thumbnailRelativePath: thumbnailRelativePath,
                checksumSha256: checksumSha256,
                displayLabel: displayLabel,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ownerType,
                required String ownerId,
                required String originalFileName,
                required String storedFileName,
                required String mimeType,
                required int fileSizeBytes,
                required String relativePath,
                Value<String?> thumbnailRelativePath = const Value.absent(),
                required String checksumSha256,
                Value<String?> displayLabel = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => AttachmentsCompanion.insert(
                id: id,
                ownerType: ownerType,
                ownerId: ownerId,
                originalFileName: originalFileName,
                storedFileName: storedFileName,
                mimeType: mimeType,
                fileSizeBytes: fileSizeBytes,
                relativePath: relativePath,
                thumbnailRelativePath: thumbnailRelativePath,
                checksumSha256: checksumSha256,
                displayLabel: displayLabel,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AttachmentsTable, AttachmentRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AttachmentsTable,
                    AttachmentRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AttachmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttachmentsTable,
      AttachmentRow,
      $$AttachmentsTableFilterComposer,
      $$AttachmentsTableOrderingComposer,
      $$AttachmentsTableAnnotationComposer,
      $$AttachmentsTableCreateCompanionBuilder,
      $$AttachmentsTableUpdateCompanionBuilder,
      (
        AttachmentRow,
        BaseReferences<_$AppDatabase, $AttachmentsTable, AttachmentRow>,
      ),
      AttachmentRow,
      PrefetchHooks Function()
    >;
typedef $$BackupHistoryTableCreateCompanionBuilder =
    BackupHistoryCompanion Function({
      required String id,
      required DateTime createdAt,
      required String pathOrUri,
      required int sizeBytes,
      Value<int> vehicleCount,
      required int schemaVersion,
      required String status,
      Value<bool> includeAttachments,
      Value<String?> errorMessage,
      Value<int> rowid,
    });
typedef $$BackupHistoryTableUpdateCompanionBuilder =
    BackupHistoryCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<String> pathOrUri,
      Value<int> sizeBytes,
      Value<int> vehicleCount,
      Value<int> schemaVersion,
      Value<String> status,
      Value<bool> includeAttachments,
      Value<String?> errorMessage,
      Value<int> rowid,
    });

class $$BackupHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $BackupHistoryTable> {
  $$BackupHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pathOrUri => $composableBuilder(
    column: $table.pathOrUri,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vehicleCount => $composableBuilder(
    column: $table.vehicleCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get includeAttachments => $composableBuilder(
    column: $table.includeAttachments,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BackupHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $BackupHistoryTable> {
  $$BackupHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pathOrUri => $composableBuilder(
    column: $table.pathOrUri,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vehicleCount => $composableBuilder(
    column: $table.vehicleCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get includeAttachments => $composableBuilder(
    column: $table.includeAttachments,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BackupHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $BackupHistoryTable> {
  $$BackupHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get pathOrUri =>
      $composableBuilder(column: $table.pathOrUri, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<int> get vehicleCount => $composableBuilder(
    column: $table.vehicleCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get includeAttachments => $composableBuilder(
    column: $table.includeAttachments,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );
}

class $$BackupHistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BackupHistoryTable,
          BackupHistoryRow,
          $$BackupHistoryTableFilterComposer,
          $$BackupHistoryTableOrderingComposer,
          $$BackupHistoryTableAnnotationComposer,
          $$BackupHistoryTableCreateCompanionBuilder,
          $$BackupHistoryTableUpdateCompanionBuilder,
          (
            BackupHistoryRow,
            BaseReferences<
              _$AppDatabase,
              $BackupHistoryTable,
              BackupHistoryRow
            >,
          ),
          BackupHistoryRow,
          PrefetchHooks Function()
        > {
  $$BackupHistoryTableTableManager(_$AppDatabase db, $BackupHistoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BackupHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BackupHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BackupHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> pathOrUri = const Value.absent(),
                Value<int> sizeBytes = const Value.absent(),
                Value<int> vehicleCount = const Value.absent(),
                Value<int> schemaVersion = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> includeAttachments = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BackupHistoryCompanion(
                id: id,
                createdAt: createdAt,
                pathOrUri: pathOrUri,
                sizeBytes: sizeBytes,
                vehicleCount: vehicleCount,
                schemaVersion: schemaVersion,
                status: status,
                includeAttachments: includeAttachments,
                errorMessage: errorMessage,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required String pathOrUri,
                required int sizeBytes,
                Value<int> vehicleCount = const Value.absent(),
                required int schemaVersion,
                required String status,
                Value<bool> includeAttachments = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BackupHistoryCompanion.insert(
                id: id,
                createdAt: createdAt,
                pathOrUri: pathOrUri,
                sizeBytes: sizeBytes,
                vehicleCount: vehicleCount,
                schemaVersion: schemaVersion,
                status: status,
                includeAttachments: includeAttachments,
                errorMessage: errorMessage,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BackupHistoryTable, BackupHistoryRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $BackupHistoryTable,
                    BackupHistoryRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BackupHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BackupHistoryTable,
      BackupHistoryRow,
      $$BackupHistoryTableFilterComposer,
      $$BackupHistoryTableOrderingComposer,
      $$BackupHistoryTableAnnotationComposer,
      $$BackupHistoryTableCreateCompanionBuilder,
      $$BackupHistoryTableUpdateCompanionBuilder,
      (
        BackupHistoryRow,
        BaseReferences<_$AppDatabase, $BackupHistoryTable, BackupHistoryRow>,
      ),
      BackupHistoryRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db, _db.vehicles);
  $$OdometerEntriesTableTableManager get odometerEntries =>
      $$OdometerEntriesTableTableManager(_db, _db.odometerEntries);
  $$FuelEntriesTableTableManager get fuelEntries =>
      $$FuelEntriesTableTableManager(_db, _db.fuelEntries);
  $$ExpenseCategoriesTableTableManager get expenseCategories =>
      $$ExpenseCategoriesTableTableManager(_db, _db.expenseCategories);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$MaintenanceTemplatesTableTableManager get maintenanceTemplates =>
      $$MaintenanceTemplatesTableTableManager(_db, _db.maintenanceTemplates);
  $$ServiceRecordsTableTableManager get serviceRecords =>
      $$ServiceRecordsTableTableManager(_db, _db.serviceRecords);
  $$ServiceItemsTableTableManager get serviceItems =>
      $$ServiceItemsTableTableManager(_db, _db.serviceItems);
  $$OilChangesTableTableManager get oilChanges =>
      $$OilChangesTableTableManager(_db, _db.oilChanges);
  $$RepairsTableTableManager get repairs =>
      $$RepairsTableTableManager(_db, _db.repairs);
  $$RepairPartsTableTableManager get repairParts =>
      $$RepairPartsTableTableManager(_db, _db.repairParts);
  $$VehiclePartsTableTableManager get vehicleParts =>
      $$VehiclePartsTableTableManager(_db, _db.vehicleParts);
  $$TyresTableTableManager get tyres =>
      $$TyresTableTableManager(_db, _db.tyres);
  $$TyreEventsTableTableManager get tyreEvents =>
      $$TyreEventsTableTableManager(_db, _db.tyreEvents);
  $$BatteriesTableTableManager get batteries =>
      $$BatteriesTableTableManager(_db, _db.batteries);
  $$VehicleDocumentsTableTableManager get vehicleDocuments =>
      $$VehicleDocumentsTableTableManager(_db, _db.vehicleDocuments);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$AttachmentsTableTableManager get attachments =>
      $$AttachmentsTableTableManager(_db, _db.attachments);
  $$BackupHistoryTableTableManager get backupHistory =>
      $$BackupHistoryTableTableManager(_db, _db.backupHistory);
}
