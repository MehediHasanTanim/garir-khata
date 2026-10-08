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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $VehiclesTable vehicles = $VehiclesTable(this);
  late final $OdometerEntriesTable odometerEntries = $OdometerEntriesTable(
    this,
  );
  late final $FuelEntriesTable fuelEntries = $FuelEntriesTable(this);
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
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    settings,
    vehicles,
    odometerEntries,
    fuelEntries,
    idxOdometerVehicleRecorded,
    idxOdometerVehicleOdometer,
    idxFuelVehicleDatetime,
    idxFuelVehicleOdometer,
  ];
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
              ({odometerEntriesRefs = false, fuelEntriesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (odometerEntriesRefs) db.odometerEntries,
                    if (fuelEntriesRefs) db.fuelEntries,
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
      PrefetchHooks Function({bool odometerEntriesRefs, bool fuelEntriesRefs})
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
}
