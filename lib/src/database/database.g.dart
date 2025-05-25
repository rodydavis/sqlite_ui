// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Assets extends Table with TableInfo<Assets, Asset> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Assets(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE');
  static const VerificationMeta _mimeTypeMeta =
      const VerificationMeta('mimeType');
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
      'mime_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  late final GeneratedColumn<Uint8List> content = GeneratedColumn<Uint8List>(
      'content', aliasedName, false,
      type: DriftSqlType.blob,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, mimeType, content, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assets';
  @override
  VerificationContext validateIntegrity(Insertable<Asset> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(_mimeTypeMeta,
          mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta));
    } else if (isInserting) {
      context.missing(_mimeTypeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Asset map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Asset(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      mimeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mime_type'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}content'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  Assets createAlias(String alias) {
    return Assets(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Asset extends DataClass implements Insertable<Asset> {
  final int id;
  final String name;

  /// A unique name or path for the asset
  final String mimeType;

  /// e.g., 'text/plain', 'text/html', 'image/png', 'application/json'
  final Uint8List content;

  /// The binary content of the asset
  final String? description;
  const Asset(
      {required this.id,
      required this.name,
      required this.mimeType,
      required this.content,
      this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['mime_type'] = Variable<String>(mimeType);
    map['content'] = Variable<Uint8List>(content);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  AssetsCompanion toCompanion(bool nullToAbsent) {
    return AssetsCompanion(
      id: Value(id),
      name: Value(name),
      mimeType: Value(mimeType),
      content: Value(content),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Asset.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Asset(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      mimeType: serializer.fromJson<String>(json['mime_type']),
      content: serializer.fromJson<Uint8List>(json['content']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'mime_type': serializer.toJson<String>(mimeType),
      'content': serializer.toJson<Uint8List>(content),
      'description': serializer.toJson<String?>(description),
    };
  }

  Asset copyWith(
          {int? id,
          String? name,
          String? mimeType,
          Uint8List? content,
          Value<String?> description = const Value.absent()}) =>
      Asset(
        id: id ?? this.id,
        name: name ?? this.name,
        mimeType: mimeType ?? this.mimeType,
        content: content ?? this.content,
        description: description.present ? description.value : this.description,
      );
  Asset copyWithCompanion(AssetsCompanion data) {
    return Asset(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      content: data.content.present ? data.content.value : this.content,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Asset(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('mimeType: $mimeType, ')
          ..write('content: $content, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, mimeType, $driftBlobEquality.hash(content), description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Asset &&
          other.id == this.id &&
          other.name == this.name &&
          other.mimeType == this.mimeType &&
          $driftBlobEquality.equals(other.content, this.content) &&
          other.description == this.description);
}

class AssetsCompanion extends UpdateCompanion<Asset> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> mimeType;
  final Value<Uint8List> content;
  final Value<String?> description;
  const AssetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.content = const Value.absent(),
    this.description = const Value.absent(),
  });
  AssetsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String mimeType,
    required Uint8List content,
    this.description = const Value.absent(),
  })  : name = Value(name),
        mimeType = Value(mimeType),
        content = Value(content);
  static Insertable<Asset> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? mimeType,
    Expression<Uint8List>? content,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (mimeType != null) 'mime_type': mimeType,
      if (content != null) 'content': content,
      if (description != null) 'description': description,
    });
  }

  AssetsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? mimeType,
      Value<Uint8List>? content,
      Value<String?>? description}) {
    return AssetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      mimeType: mimeType ?? this.mimeType,
      content: content ?? this.content,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (content.present) {
      map['content'] = Variable<Uint8List>(content.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('mimeType: $mimeType, ')
          ..write('content: $content, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class Templates extends Table with TableInfo<Templates, Template> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Templates(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE');
  static const VerificationMeta _assetIdMeta =
      const VerificationMeta('assetId');
  late final GeneratedColumn<int> assetId = GeneratedColumn<int>(
      'asset_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, name, assetId, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'templates';
  @override
  VerificationContext validateIntegrity(Insertable<Template> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('asset_id')) {
      context.handle(_assetIdMeta,
          assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta));
    } else if (isInserting) {
      context.missing(_assetIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Template map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Template(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      assetId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}asset_id'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  Templates createAlias(String alias) {
    return Templates(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(asset_id)REFERENCES assets(id)ON DELETE CASCADE'];
  @override
  bool get dontWriteConstraints => true;
}

class Template extends DataClass implements Insertable<Template> {
  final int id;
  final String name;
  final int assetId;

  /// Asset containing the template content
  final String? description;
  const Template(
      {required this.id,
      required this.name,
      required this.assetId,
      this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['asset_id'] = Variable<int>(assetId);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  TemplatesCompanion toCompanion(bool nullToAbsent) {
    return TemplatesCompanion(
      id: Value(id),
      name: Value(name),
      assetId: Value(assetId),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Template.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Template(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      assetId: serializer.fromJson<int>(json['asset_id']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'asset_id': serializer.toJson<int>(assetId),
      'description': serializer.toJson<String?>(description),
    };
  }

  Template copyWith(
          {int? id,
          String? name,
          int? assetId,
          Value<String?> description = const Value.absent()}) =>
      Template(
        id: id ?? this.id,
        name: name ?? this.name,
        assetId: assetId ?? this.assetId,
        description: description.present ? description.value : this.description,
      );
  Template copyWithCompanion(TemplatesCompanion data) {
    return Template(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Template(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('assetId: $assetId, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, assetId, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Template &&
          other.id == this.id &&
          other.name == this.name &&
          other.assetId == this.assetId &&
          other.description == this.description);
}

class TemplatesCompanion extends UpdateCompanion<Template> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> assetId;
  final Value<String?> description;
  const TemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.assetId = const Value.absent(),
    this.description = const Value.absent(),
  });
  TemplatesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int assetId,
    this.description = const Value.absent(),
  })  : name = Value(name),
        assetId = Value(assetId);
  static Insertable<Template> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? assetId,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (assetId != null) 'asset_id': assetId,
      if (description != null) 'description': description,
    });
  }

  TemplatesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? assetId,
      Value<String?>? description}) {
    return TemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      assetId: assetId ?? this.assetId,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (assetId.present) {
      map['asset_id'] = Variable<int>(assetId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('assetId: $assetId, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class Routes extends Table with TableInfo<Routes, Route> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Routes(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE');
  static const VerificationMeta _templateIdMeta =
      const VerificationMeta('templateId');
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
      'template_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _assetIdMeta =
      const VerificationMeta('assetId');
  late final GeneratedColumn<int> assetId = GeneratedColumn<int>(
      'asset_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _redirectToMeta =
      const VerificationMeta('redirectTo');
  late final GeneratedColumn<String> redirectTo = GeneratedColumn<String>(
      'redirect_to', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns =>
      [id, path, templateId, assetId, description, redirectTo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routes';
  @override
  VerificationContext validateIntegrity(Insertable<Route> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('template_id')) {
      context.handle(
          _templateIdMeta,
          templateId.isAcceptableOrUnknown(
              data['template_id']!, _templateIdMeta));
    }
    if (data.containsKey('asset_id')) {
      context.handle(_assetIdMeta,
          assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('redirect_to')) {
      context.handle(
          _redirectToMeta,
          redirectTo.isAcceptableOrUnknown(
              data['redirect_to']!, _redirectToMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Route map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Route(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      templateId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}template_id']),
      assetId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}asset_id']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      redirectTo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}redirect_to']),
    );
  }

  @override
  Routes createAlias(String alias) {
    return Routes(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(template_id)REFERENCES templates(id)ON DELETE CASCADE',
        'FOREIGN KEY(asset_id)REFERENCES assets(id)ON DELETE CASCADE',
        'CHECK(NOT(template_id IS NOT NULL AND asset_id IS NOT NULL))',
        'CHECK(template_id IS NOT NULL OR asset_id IS NOT NULL OR redirect_to IS NOT NULL)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class Route extends DataClass implements Insertable<Route> {
  final int id;
  final String path;

  /// e.g., '/users/:id' or '/posts'
  final int? templateId;

  /// Nullable, if serving a template
  final int? assetId;

  /// Nullable, if directly serving an asset
  final String? description;
  final String? redirectTo;
  const Route(
      {required this.id,
      required this.path,
      this.templateId,
      this.assetId,
      this.description,
      this.redirectTo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['path'] = Variable<String>(path);
    if (!nullToAbsent || templateId != null) {
      map['template_id'] = Variable<int>(templateId);
    }
    if (!nullToAbsent || assetId != null) {
      map['asset_id'] = Variable<int>(assetId);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || redirectTo != null) {
      map['redirect_to'] = Variable<String>(redirectTo);
    }
    return map;
  }

  RoutesCompanion toCompanion(bool nullToAbsent) {
    return RoutesCompanion(
      id: Value(id),
      path: Value(path),
      templateId: templateId == null && nullToAbsent
          ? const Value.absent()
          : Value(templateId),
      assetId: assetId == null && nullToAbsent
          ? const Value.absent()
          : Value(assetId),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      redirectTo: redirectTo == null && nullToAbsent
          ? const Value.absent()
          : Value(redirectTo),
    );
  }

  factory Route.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Route(
      id: serializer.fromJson<int>(json['id']),
      path: serializer.fromJson<String>(json['path']),
      templateId: serializer.fromJson<int?>(json['template_id']),
      assetId: serializer.fromJson<int?>(json['asset_id']),
      description: serializer.fromJson<String?>(json['description']),
      redirectTo: serializer.fromJson<String?>(json['redirect_to']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'path': serializer.toJson<String>(path),
      'template_id': serializer.toJson<int?>(templateId),
      'asset_id': serializer.toJson<int?>(assetId),
      'description': serializer.toJson<String?>(description),
      'redirect_to': serializer.toJson<String?>(redirectTo),
    };
  }

  Route copyWith(
          {int? id,
          String? path,
          Value<int?> templateId = const Value.absent(),
          Value<int?> assetId = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> redirectTo = const Value.absent()}) =>
      Route(
        id: id ?? this.id,
        path: path ?? this.path,
        templateId: templateId.present ? templateId.value : this.templateId,
        assetId: assetId.present ? assetId.value : this.assetId,
        description: description.present ? description.value : this.description,
        redirectTo: redirectTo.present ? redirectTo.value : this.redirectTo,
      );
  Route copyWithCompanion(RoutesCompanion data) {
    return Route(
      id: data.id.present ? data.id.value : this.id,
      path: data.path.present ? data.path.value : this.path,
      templateId:
          data.templateId.present ? data.templateId.value : this.templateId,
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      description:
          data.description.present ? data.description.value : this.description,
      redirectTo:
          data.redirectTo.present ? data.redirectTo.value : this.redirectTo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Route(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('templateId: $templateId, ')
          ..write('assetId: $assetId, ')
          ..write('description: $description, ')
          ..write('redirectTo: $redirectTo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, path, templateId, assetId, description, redirectTo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Route &&
          other.id == this.id &&
          other.path == this.path &&
          other.templateId == this.templateId &&
          other.assetId == this.assetId &&
          other.description == this.description &&
          other.redirectTo == this.redirectTo);
}

class RoutesCompanion extends UpdateCompanion<Route> {
  final Value<int> id;
  final Value<String> path;
  final Value<int?> templateId;
  final Value<int?> assetId;
  final Value<String?> description;
  final Value<String?> redirectTo;
  const RoutesCompanion({
    this.id = const Value.absent(),
    this.path = const Value.absent(),
    this.templateId = const Value.absent(),
    this.assetId = const Value.absent(),
    this.description = const Value.absent(),
    this.redirectTo = const Value.absent(),
  });
  RoutesCompanion.insert({
    this.id = const Value.absent(),
    required String path,
    this.templateId = const Value.absent(),
    this.assetId = const Value.absent(),
    this.description = const Value.absent(),
    this.redirectTo = const Value.absent(),
  }) : path = Value(path);
  static Insertable<Route> custom({
    Expression<int>? id,
    Expression<String>? path,
    Expression<int>? templateId,
    Expression<int>? assetId,
    Expression<String>? description,
    Expression<String>? redirectTo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (path != null) 'path': path,
      if (templateId != null) 'template_id': templateId,
      if (assetId != null) 'asset_id': assetId,
      if (description != null) 'description': description,
      if (redirectTo != null) 'redirect_to': redirectTo,
    });
  }

  RoutesCompanion copyWith(
      {Value<int>? id,
      Value<String>? path,
      Value<int?>? templateId,
      Value<int?>? assetId,
      Value<String?>? description,
      Value<String?>? redirectTo}) {
    return RoutesCompanion(
      id: id ?? this.id,
      path: path ?? this.path,
      templateId: templateId ?? this.templateId,
      assetId: assetId ?? this.assetId,
      description: description ?? this.description,
      redirectTo: redirectTo ?? this.redirectTo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<int>(templateId.value);
    }
    if (assetId.present) {
      map['asset_id'] = Variable<int>(assetId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (redirectTo.present) {
      map['redirect_to'] = Variable<String>(redirectTo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutesCompanion(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('templateId: $templateId, ')
          ..write('assetId: $assetId, ')
          ..write('description: $description, ')
          ..write('redirectTo: $redirectTo')
          ..write(')'))
        .toString();
  }
}

class DataSources extends Table with TableInfo<DataSources, DataSource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  DataSources(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE');
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL CHECK (type IN (\'sql\', \'json\', \'http\'))');
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, name, type, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'data_sources';
  @override
  VerificationContext validateIntegrity(Insertable<DataSource> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DataSource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DataSource(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  DataSources createAlias(String alias) {
    return DataSources(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class DataSource extends DataClass implements Insertable<DataSource> {
  final int id;
  final String name;
  final String type;
  final String? description;
  const DataSource(
      {required this.id,
      required this.name,
      required this.type,
      this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  DataSourcesCompanion toCompanion(bool nullToAbsent) {
    return DataSourcesCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory DataSource.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DataSource(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'description': serializer.toJson<String?>(description),
    };
  }

  DataSource copyWith(
          {int? id,
          String? name,
          String? type,
          Value<String?> description = const Value.absent()}) =>
      DataSource(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        description: description.present ? description.value : this.description,
      );
  DataSource copyWithCompanion(DataSourcesCompanion data) {
    return DataSource(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DataSource(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DataSource &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.description == this.description);
}

class DataSourcesCompanion extends UpdateCompanion<DataSource> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> type;
  final Value<String?> description;
  const DataSourcesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.description = const Value.absent(),
  });
  DataSourcesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String type,
    this.description = const Value.absent(),
  })  : name = Value(name),
        type = Value(type);
  static Insertable<DataSource> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (description != null) 'description': description,
    });
  }

  DataSourcesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? type,
      Value<String?>? description}) {
    return DataSourcesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DataSourcesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class SqlSourceConfigs extends Table
    with TableInfo<SqlSourceConfigs, SqlSourceConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SqlSourceConfigs(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _dataSourceIdMeta =
      const VerificationMeta('dataSourceId');
  late final GeneratedColumn<int> dataSourceId = GeneratedColumn<int>(
      'data_source_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE');
  static const VerificationMeta _sqlTemplateMeta =
      const VerificationMeta('sqlTemplate');
  late final GeneratedColumn<String> sqlTemplate = GeneratedColumn<String>(
      'sql_template', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, dataSourceId, sqlTemplate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sql_source_configs';
  @override
  VerificationContext validateIntegrity(Insertable<SqlSourceConfig> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('data_source_id')) {
      context.handle(
          _dataSourceIdMeta,
          dataSourceId.isAcceptableOrUnknown(
              data['data_source_id']!, _dataSourceIdMeta));
    } else if (isInserting) {
      context.missing(_dataSourceIdMeta);
    }
    if (data.containsKey('sql_template')) {
      context.handle(
          _sqlTemplateMeta,
          sqlTemplate.isAcceptableOrUnknown(
              data['sql_template']!, _sqlTemplateMeta));
    } else if (isInserting) {
      context.missing(_sqlTemplateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SqlSourceConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SqlSourceConfig(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      dataSourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}data_source_id'])!,
      sqlTemplate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sql_template'])!,
    );
  }

  @override
  SqlSourceConfigs createAlias(String alias) {
    return SqlSourceConfigs(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(data_source_id)REFERENCES data_sources(id)ON DELETE CASCADE'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class SqlSourceConfig extends DataClass implements Insertable<SqlSourceConfig> {
  final int id;
  final int dataSourceId;
  final String sqlTemplate;
  const SqlSourceConfig(
      {required this.id,
      required this.dataSourceId,
      required this.sqlTemplate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['data_source_id'] = Variable<int>(dataSourceId);
    map['sql_template'] = Variable<String>(sqlTemplate);
    return map;
  }

  SqlSourceConfigsCompanion toCompanion(bool nullToAbsent) {
    return SqlSourceConfigsCompanion(
      id: Value(id),
      dataSourceId: Value(dataSourceId),
      sqlTemplate: Value(sqlTemplate),
    );
  }

  factory SqlSourceConfig.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SqlSourceConfig(
      id: serializer.fromJson<int>(json['id']),
      dataSourceId: serializer.fromJson<int>(json['data_source_id']),
      sqlTemplate: serializer.fromJson<String>(json['sql_template']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'data_source_id': serializer.toJson<int>(dataSourceId),
      'sql_template': serializer.toJson<String>(sqlTemplate),
    };
  }

  SqlSourceConfig copyWith({int? id, int? dataSourceId, String? sqlTemplate}) =>
      SqlSourceConfig(
        id: id ?? this.id,
        dataSourceId: dataSourceId ?? this.dataSourceId,
        sqlTemplate: sqlTemplate ?? this.sqlTemplate,
      );
  SqlSourceConfig copyWithCompanion(SqlSourceConfigsCompanion data) {
    return SqlSourceConfig(
      id: data.id.present ? data.id.value : this.id,
      dataSourceId: data.dataSourceId.present
          ? data.dataSourceId.value
          : this.dataSourceId,
      sqlTemplate:
          data.sqlTemplate.present ? data.sqlTemplate.value : this.sqlTemplate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SqlSourceConfig(')
          ..write('id: $id, ')
          ..write('dataSourceId: $dataSourceId, ')
          ..write('sqlTemplate: $sqlTemplate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dataSourceId, sqlTemplate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SqlSourceConfig &&
          other.id == this.id &&
          other.dataSourceId == this.dataSourceId &&
          other.sqlTemplate == this.sqlTemplate);
}

class SqlSourceConfigsCompanion extends UpdateCompanion<SqlSourceConfig> {
  final Value<int> id;
  final Value<int> dataSourceId;
  final Value<String> sqlTemplate;
  const SqlSourceConfigsCompanion({
    this.id = const Value.absent(),
    this.dataSourceId = const Value.absent(),
    this.sqlTemplate = const Value.absent(),
  });
  SqlSourceConfigsCompanion.insert({
    this.id = const Value.absent(),
    required int dataSourceId,
    required String sqlTemplate,
  })  : dataSourceId = Value(dataSourceId),
        sqlTemplate = Value(sqlTemplate);
  static Insertable<SqlSourceConfig> custom({
    Expression<int>? id,
    Expression<int>? dataSourceId,
    Expression<String>? sqlTemplate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dataSourceId != null) 'data_source_id': dataSourceId,
      if (sqlTemplate != null) 'sql_template': sqlTemplate,
    });
  }

  SqlSourceConfigsCompanion copyWith(
      {Value<int>? id, Value<int>? dataSourceId, Value<String>? sqlTemplate}) {
    return SqlSourceConfigsCompanion(
      id: id ?? this.id,
      dataSourceId: dataSourceId ?? this.dataSourceId,
      sqlTemplate: sqlTemplate ?? this.sqlTemplate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dataSourceId.present) {
      map['data_source_id'] = Variable<int>(dataSourceId.value);
    }
    if (sqlTemplate.present) {
      map['sql_template'] = Variable<String>(sqlTemplate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SqlSourceConfigsCompanion(')
          ..write('id: $id, ')
          ..write('dataSourceId: $dataSourceId, ')
          ..write('sqlTemplate: $sqlTemplate')
          ..write(')'))
        .toString();
  }
}

class JsonSourceConfigs extends Table
    with TableInfo<JsonSourceConfigs, JsonSourceConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  JsonSourceConfigs(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _dataSourceIdMeta =
      const VerificationMeta('dataSourceId');
  late final GeneratedColumn<int> dataSourceId = GeneratedColumn<int>(
      'data_source_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE');
  static const VerificationMeta _assetIdMeta =
      const VerificationMeta('assetId');
  late final GeneratedColumn<int> assetId = GeneratedColumn<int>(
      'asset_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, dataSourceId, assetId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'json_source_configs';
  @override
  VerificationContext validateIntegrity(Insertable<JsonSourceConfig> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('data_source_id')) {
      context.handle(
          _dataSourceIdMeta,
          dataSourceId.isAcceptableOrUnknown(
              data['data_source_id']!, _dataSourceIdMeta));
    } else if (isInserting) {
      context.missing(_dataSourceIdMeta);
    }
    if (data.containsKey('asset_id')) {
      context.handle(_assetIdMeta,
          assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta));
    } else if (isInserting) {
      context.missing(_assetIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JsonSourceConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JsonSourceConfig(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      dataSourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}data_source_id'])!,
      assetId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}asset_id'])!,
    );
  }

  @override
  JsonSourceConfigs createAlias(String alias) {
    return JsonSourceConfigs(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(data_source_id)REFERENCES data_sources(id)ON DELETE CASCADE',
        'FOREIGN KEY(asset_id)REFERENCES assets(id)ON DELETE CASCADE'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class JsonSourceConfig extends DataClass
    implements Insertable<JsonSourceConfig> {
  final int id;
  final int dataSourceId;
  final int assetId;
  const JsonSourceConfig(
      {required this.id, required this.dataSourceId, required this.assetId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['data_source_id'] = Variable<int>(dataSourceId);
    map['asset_id'] = Variable<int>(assetId);
    return map;
  }

  JsonSourceConfigsCompanion toCompanion(bool nullToAbsent) {
    return JsonSourceConfigsCompanion(
      id: Value(id),
      dataSourceId: Value(dataSourceId),
      assetId: Value(assetId),
    );
  }

  factory JsonSourceConfig.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JsonSourceConfig(
      id: serializer.fromJson<int>(json['id']),
      dataSourceId: serializer.fromJson<int>(json['data_source_id']),
      assetId: serializer.fromJson<int>(json['asset_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'data_source_id': serializer.toJson<int>(dataSourceId),
      'asset_id': serializer.toJson<int>(assetId),
    };
  }

  JsonSourceConfig copyWith({int? id, int? dataSourceId, int? assetId}) =>
      JsonSourceConfig(
        id: id ?? this.id,
        dataSourceId: dataSourceId ?? this.dataSourceId,
        assetId: assetId ?? this.assetId,
      );
  JsonSourceConfig copyWithCompanion(JsonSourceConfigsCompanion data) {
    return JsonSourceConfig(
      id: data.id.present ? data.id.value : this.id,
      dataSourceId: data.dataSourceId.present
          ? data.dataSourceId.value
          : this.dataSourceId,
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JsonSourceConfig(')
          ..write('id: $id, ')
          ..write('dataSourceId: $dataSourceId, ')
          ..write('assetId: $assetId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dataSourceId, assetId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JsonSourceConfig &&
          other.id == this.id &&
          other.dataSourceId == this.dataSourceId &&
          other.assetId == this.assetId);
}

class JsonSourceConfigsCompanion extends UpdateCompanion<JsonSourceConfig> {
  final Value<int> id;
  final Value<int> dataSourceId;
  final Value<int> assetId;
  const JsonSourceConfigsCompanion({
    this.id = const Value.absent(),
    this.dataSourceId = const Value.absent(),
    this.assetId = const Value.absent(),
  });
  JsonSourceConfigsCompanion.insert({
    this.id = const Value.absent(),
    required int dataSourceId,
    required int assetId,
  })  : dataSourceId = Value(dataSourceId),
        assetId = Value(assetId);
  static Insertable<JsonSourceConfig> custom({
    Expression<int>? id,
    Expression<int>? dataSourceId,
    Expression<int>? assetId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dataSourceId != null) 'data_source_id': dataSourceId,
      if (assetId != null) 'asset_id': assetId,
    });
  }

  JsonSourceConfigsCompanion copyWith(
      {Value<int>? id, Value<int>? dataSourceId, Value<int>? assetId}) {
    return JsonSourceConfigsCompanion(
      id: id ?? this.id,
      dataSourceId: dataSourceId ?? this.dataSourceId,
      assetId: assetId ?? this.assetId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dataSourceId.present) {
      map['data_source_id'] = Variable<int>(dataSourceId.value);
    }
    if (assetId.present) {
      map['asset_id'] = Variable<int>(assetId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JsonSourceConfigsCompanion(')
          ..write('id: $id, ')
          ..write('dataSourceId: $dataSourceId, ')
          ..write('assetId: $assetId')
          ..write(')'))
        .toString();
  }
}

class HttpSourceConfigs extends Table
    with TableInfo<HttpSourceConfigs, HttpSourceConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  HttpSourceConfigs(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _dataSourceIdMeta =
      const VerificationMeta('dataSourceId');
  late final GeneratedColumn<int> dataSourceId = GeneratedColumn<int>(
      'data_source_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE');
  static const VerificationMeta _urlTemplateMeta =
      const VerificationMeta('urlTemplate');
  late final GeneratedColumn<String> urlTemplate = GeneratedColumn<String>(
      'url_template', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
      'method', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints:
          'NOT NULL DEFAULT \'GET\' CHECK (method IN (\'GET\', \'POST\', \'PUT\', \'DELETE\', \'PATCH\', \'HEAD\', \'OPTIONS\'))',
      defaultValue: const CustomExpression('\'GET\''));
  static const VerificationMeta _headersTemplateMeta =
      const VerificationMeta('headersTemplate');
  late final GeneratedColumn<String> headersTemplate = GeneratedColumn<String>(
      'headers_template', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _bodyTemplateMeta =
      const VerificationMeta('bodyTemplate');
  late final GeneratedColumn<String> bodyTemplate = GeneratedColumn<String>(
      'body_template', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns =>
      [id, dataSourceId, urlTemplate, method, headersTemplate, bodyTemplate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'http_source_configs';
  @override
  VerificationContext validateIntegrity(Insertable<HttpSourceConfig> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('data_source_id')) {
      context.handle(
          _dataSourceIdMeta,
          dataSourceId.isAcceptableOrUnknown(
              data['data_source_id']!, _dataSourceIdMeta));
    } else if (isInserting) {
      context.missing(_dataSourceIdMeta);
    }
    if (data.containsKey('url_template')) {
      context.handle(
          _urlTemplateMeta,
          urlTemplate.isAcceptableOrUnknown(
              data['url_template']!, _urlTemplateMeta));
    } else if (isInserting) {
      context.missing(_urlTemplateMeta);
    }
    if (data.containsKey('method')) {
      context.handle(_methodMeta,
          method.isAcceptableOrUnknown(data['method']!, _methodMeta));
    }
    if (data.containsKey('headers_template')) {
      context.handle(
          _headersTemplateMeta,
          headersTemplate.isAcceptableOrUnknown(
              data['headers_template']!, _headersTemplateMeta));
    }
    if (data.containsKey('body_template')) {
      context.handle(
          _bodyTemplateMeta,
          bodyTemplate.isAcceptableOrUnknown(
              data['body_template']!, _bodyTemplateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HttpSourceConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HttpSourceConfig(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      dataSourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}data_source_id'])!,
      urlTemplate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url_template'])!,
      method: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}method'])!,
      headersTemplate: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}headers_template']),
      bodyTemplate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body_template']),
    );
  }

  @override
  HttpSourceConfigs createAlias(String alias) {
    return HttpSourceConfigs(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(data_source_id)REFERENCES data_sources(id)ON DELETE CASCADE'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class HttpSourceConfig extends DataClass
    implements Insertable<HttpSourceConfig> {
  final int id;
  final int dataSourceId;
  final String urlTemplate;
  final String method;
  final String? headersTemplate;

  /// JSON string of headers
  final String? bodyTemplate;
  const HttpSourceConfig(
      {required this.id,
      required this.dataSourceId,
      required this.urlTemplate,
      required this.method,
      this.headersTemplate,
      this.bodyTemplate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['data_source_id'] = Variable<int>(dataSourceId);
    map['url_template'] = Variable<String>(urlTemplate);
    map['method'] = Variable<String>(method);
    if (!nullToAbsent || headersTemplate != null) {
      map['headers_template'] = Variable<String>(headersTemplate);
    }
    if (!nullToAbsent || bodyTemplate != null) {
      map['body_template'] = Variable<String>(bodyTemplate);
    }
    return map;
  }

  HttpSourceConfigsCompanion toCompanion(bool nullToAbsent) {
    return HttpSourceConfigsCompanion(
      id: Value(id),
      dataSourceId: Value(dataSourceId),
      urlTemplate: Value(urlTemplate),
      method: Value(method),
      headersTemplate: headersTemplate == null && nullToAbsent
          ? const Value.absent()
          : Value(headersTemplate),
      bodyTemplate: bodyTemplate == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyTemplate),
    );
  }

  factory HttpSourceConfig.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HttpSourceConfig(
      id: serializer.fromJson<int>(json['id']),
      dataSourceId: serializer.fromJson<int>(json['data_source_id']),
      urlTemplate: serializer.fromJson<String>(json['url_template']),
      method: serializer.fromJson<String>(json['method']),
      headersTemplate: serializer.fromJson<String?>(json['headers_template']),
      bodyTemplate: serializer.fromJson<String?>(json['body_template']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'data_source_id': serializer.toJson<int>(dataSourceId),
      'url_template': serializer.toJson<String>(urlTemplate),
      'method': serializer.toJson<String>(method),
      'headers_template': serializer.toJson<String?>(headersTemplate),
      'body_template': serializer.toJson<String?>(bodyTemplate),
    };
  }

  HttpSourceConfig copyWith(
          {int? id,
          int? dataSourceId,
          String? urlTemplate,
          String? method,
          Value<String?> headersTemplate = const Value.absent(),
          Value<String?> bodyTemplate = const Value.absent()}) =>
      HttpSourceConfig(
        id: id ?? this.id,
        dataSourceId: dataSourceId ?? this.dataSourceId,
        urlTemplate: urlTemplate ?? this.urlTemplate,
        method: method ?? this.method,
        headersTemplate: headersTemplate.present
            ? headersTemplate.value
            : this.headersTemplate,
        bodyTemplate:
            bodyTemplate.present ? bodyTemplate.value : this.bodyTemplate,
      );
  HttpSourceConfig copyWithCompanion(HttpSourceConfigsCompanion data) {
    return HttpSourceConfig(
      id: data.id.present ? data.id.value : this.id,
      dataSourceId: data.dataSourceId.present
          ? data.dataSourceId.value
          : this.dataSourceId,
      urlTemplate:
          data.urlTemplate.present ? data.urlTemplate.value : this.urlTemplate,
      method: data.method.present ? data.method.value : this.method,
      headersTemplate: data.headersTemplate.present
          ? data.headersTemplate.value
          : this.headersTemplate,
      bodyTemplate: data.bodyTemplate.present
          ? data.bodyTemplate.value
          : this.bodyTemplate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HttpSourceConfig(')
          ..write('id: $id, ')
          ..write('dataSourceId: $dataSourceId, ')
          ..write('urlTemplate: $urlTemplate, ')
          ..write('method: $method, ')
          ..write('headersTemplate: $headersTemplate, ')
          ..write('bodyTemplate: $bodyTemplate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, dataSourceId, urlTemplate, method, headersTemplate, bodyTemplate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HttpSourceConfig &&
          other.id == this.id &&
          other.dataSourceId == this.dataSourceId &&
          other.urlTemplate == this.urlTemplate &&
          other.method == this.method &&
          other.headersTemplate == this.headersTemplate &&
          other.bodyTemplate == this.bodyTemplate);
}

class HttpSourceConfigsCompanion extends UpdateCompanion<HttpSourceConfig> {
  final Value<int> id;
  final Value<int> dataSourceId;
  final Value<String> urlTemplate;
  final Value<String> method;
  final Value<String?> headersTemplate;
  final Value<String?> bodyTemplate;
  const HttpSourceConfigsCompanion({
    this.id = const Value.absent(),
    this.dataSourceId = const Value.absent(),
    this.urlTemplate = const Value.absent(),
    this.method = const Value.absent(),
    this.headersTemplate = const Value.absent(),
    this.bodyTemplate = const Value.absent(),
  });
  HttpSourceConfigsCompanion.insert({
    this.id = const Value.absent(),
    required int dataSourceId,
    required String urlTemplate,
    this.method = const Value.absent(),
    this.headersTemplate = const Value.absent(),
    this.bodyTemplate = const Value.absent(),
  })  : dataSourceId = Value(dataSourceId),
        urlTemplate = Value(urlTemplate);
  static Insertable<HttpSourceConfig> custom({
    Expression<int>? id,
    Expression<int>? dataSourceId,
    Expression<String>? urlTemplate,
    Expression<String>? method,
    Expression<String>? headersTemplate,
    Expression<String>? bodyTemplate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dataSourceId != null) 'data_source_id': dataSourceId,
      if (urlTemplate != null) 'url_template': urlTemplate,
      if (method != null) 'method': method,
      if (headersTemplate != null) 'headers_template': headersTemplate,
      if (bodyTemplate != null) 'body_template': bodyTemplate,
    });
  }

  HttpSourceConfigsCompanion copyWith(
      {Value<int>? id,
      Value<int>? dataSourceId,
      Value<String>? urlTemplate,
      Value<String>? method,
      Value<String?>? headersTemplate,
      Value<String?>? bodyTemplate}) {
    return HttpSourceConfigsCompanion(
      id: id ?? this.id,
      dataSourceId: dataSourceId ?? this.dataSourceId,
      urlTemplate: urlTemplate ?? this.urlTemplate,
      method: method ?? this.method,
      headersTemplate: headersTemplate ?? this.headersTemplate,
      bodyTemplate: bodyTemplate ?? this.bodyTemplate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dataSourceId.present) {
      map['data_source_id'] = Variable<int>(dataSourceId.value);
    }
    if (urlTemplate.present) {
      map['url_template'] = Variable<String>(urlTemplate.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (headersTemplate.present) {
      map['headers_template'] = Variable<String>(headersTemplate.value);
    }
    if (bodyTemplate.present) {
      map['body_template'] = Variable<String>(bodyTemplate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HttpSourceConfigsCompanion(')
          ..write('id: $id, ')
          ..write('dataSourceId: $dataSourceId, ')
          ..write('urlTemplate: $urlTemplate, ')
          ..write('method: $method, ')
          ..write('headersTemplate: $headersTemplate, ')
          ..write('bodyTemplate: $bodyTemplate')
          ..write(')'))
        .toString();
  }
}

class RouteDataAssignments extends Table
    with TableInfo<RouteDataAssignments, RouteDataAssignment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  RouteDataAssignments(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _routeIdMeta =
      const VerificationMeta('routeId');
  late final GeneratedColumn<int> routeId = GeneratedColumn<int>(
      'route_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _dataSourceIdMeta =
      const VerificationMeta('dataSourceId');
  late final GeneratedColumn<int> dataSourceId = GeneratedColumn<int>(
      'data_source_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _contextNameMeta =
      const VerificationMeta('contextName');
  late final GeneratedColumn<String> contextName = GeneratedColumn<String>(
      'context_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _executionOrderMeta =
      const VerificationMeta('executionOrder');
  late final GeneratedColumn<int> executionOrder = GeneratedColumn<int>(
      'execution_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression('0'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, routeId, dataSourceId, contextName, executionOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'route_data_assignments';
  @override
  VerificationContext validateIntegrity(
      Insertable<RouteDataAssignment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('route_id')) {
      context.handle(_routeIdMeta,
          routeId.isAcceptableOrUnknown(data['route_id']!, _routeIdMeta));
    } else if (isInserting) {
      context.missing(_routeIdMeta);
    }
    if (data.containsKey('data_source_id')) {
      context.handle(
          _dataSourceIdMeta,
          dataSourceId.isAcceptableOrUnknown(
              data['data_source_id']!, _dataSourceIdMeta));
    } else if (isInserting) {
      context.missing(_dataSourceIdMeta);
    }
    if (data.containsKey('context_name')) {
      context.handle(
          _contextNameMeta,
          contextName.isAcceptableOrUnknown(
              data['context_name']!, _contextNameMeta));
    } else if (isInserting) {
      context.missing(_contextNameMeta);
    }
    if (data.containsKey('execution_order')) {
      context.handle(
          _executionOrderMeta,
          executionOrder.isAcceptableOrUnknown(
              data['execution_order']!, _executionOrderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {routeId, contextName},
      ];
  @override
  RouteDataAssignment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RouteDataAssignment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      routeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}route_id'])!,
      dataSourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}data_source_id'])!,
      contextName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}context_name'])!,
      executionOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}execution_order'])!,
    );
  }

  @override
  RouteDataAssignments createAlias(String alias) {
    return RouteDataAssignments(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'UNIQUE(route_id, context_name)',
        'FOREIGN KEY(route_id)REFERENCES routes(id)ON DELETE CASCADE',
        'FOREIGN KEY(data_source_id)REFERENCES data_sources(id)ON DELETE CASCADE'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class RouteDataAssignment extends DataClass
    implements Insertable<RouteDataAssignment> {
  final int id;
  final int routeId;
  final int dataSourceId;
  final String contextName;

  /// Key for this data in the template's context
  final int executionOrder;
  const RouteDataAssignment(
      {required this.id,
      required this.routeId,
      required this.dataSourceId,
      required this.contextName,
      required this.executionOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['route_id'] = Variable<int>(routeId);
    map['data_source_id'] = Variable<int>(dataSourceId);
    map['context_name'] = Variable<String>(contextName);
    map['execution_order'] = Variable<int>(executionOrder);
    return map;
  }

  RouteDataAssignmentsCompanion toCompanion(bool nullToAbsent) {
    return RouteDataAssignmentsCompanion(
      id: Value(id),
      routeId: Value(routeId),
      dataSourceId: Value(dataSourceId),
      contextName: Value(contextName),
      executionOrder: Value(executionOrder),
    );
  }

  factory RouteDataAssignment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RouteDataAssignment(
      id: serializer.fromJson<int>(json['id']),
      routeId: serializer.fromJson<int>(json['route_id']),
      dataSourceId: serializer.fromJson<int>(json['data_source_id']),
      contextName: serializer.fromJson<String>(json['context_name']),
      executionOrder: serializer.fromJson<int>(json['execution_order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'route_id': serializer.toJson<int>(routeId),
      'data_source_id': serializer.toJson<int>(dataSourceId),
      'context_name': serializer.toJson<String>(contextName),
      'execution_order': serializer.toJson<int>(executionOrder),
    };
  }

  RouteDataAssignment copyWith(
          {int? id,
          int? routeId,
          int? dataSourceId,
          String? contextName,
          int? executionOrder}) =>
      RouteDataAssignment(
        id: id ?? this.id,
        routeId: routeId ?? this.routeId,
        dataSourceId: dataSourceId ?? this.dataSourceId,
        contextName: contextName ?? this.contextName,
        executionOrder: executionOrder ?? this.executionOrder,
      );
  RouteDataAssignment copyWithCompanion(RouteDataAssignmentsCompanion data) {
    return RouteDataAssignment(
      id: data.id.present ? data.id.value : this.id,
      routeId: data.routeId.present ? data.routeId.value : this.routeId,
      dataSourceId: data.dataSourceId.present
          ? data.dataSourceId.value
          : this.dataSourceId,
      contextName:
          data.contextName.present ? data.contextName.value : this.contextName,
      executionOrder: data.executionOrder.present
          ? data.executionOrder.value
          : this.executionOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RouteDataAssignment(')
          ..write('id: $id, ')
          ..write('routeId: $routeId, ')
          ..write('dataSourceId: $dataSourceId, ')
          ..write('contextName: $contextName, ')
          ..write('executionOrder: $executionOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, routeId, dataSourceId, contextName, executionOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RouteDataAssignment &&
          other.id == this.id &&
          other.routeId == this.routeId &&
          other.dataSourceId == this.dataSourceId &&
          other.contextName == this.contextName &&
          other.executionOrder == this.executionOrder);
}

class RouteDataAssignmentsCompanion
    extends UpdateCompanion<RouteDataAssignment> {
  final Value<int> id;
  final Value<int> routeId;
  final Value<int> dataSourceId;
  final Value<String> contextName;
  final Value<int> executionOrder;
  const RouteDataAssignmentsCompanion({
    this.id = const Value.absent(),
    this.routeId = const Value.absent(),
    this.dataSourceId = const Value.absent(),
    this.contextName = const Value.absent(),
    this.executionOrder = const Value.absent(),
  });
  RouteDataAssignmentsCompanion.insert({
    this.id = const Value.absent(),
    required int routeId,
    required int dataSourceId,
    required String contextName,
    this.executionOrder = const Value.absent(),
  })  : routeId = Value(routeId),
        dataSourceId = Value(dataSourceId),
        contextName = Value(contextName);
  static Insertable<RouteDataAssignment> custom({
    Expression<int>? id,
    Expression<int>? routeId,
    Expression<int>? dataSourceId,
    Expression<String>? contextName,
    Expression<int>? executionOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routeId != null) 'route_id': routeId,
      if (dataSourceId != null) 'data_source_id': dataSourceId,
      if (contextName != null) 'context_name': contextName,
      if (executionOrder != null) 'execution_order': executionOrder,
    });
  }

  RouteDataAssignmentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? routeId,
      Value<int>? dataSourceId,
      Value<String>? contextName,
      Value<int>? executionOrder}) {
    return RouteDataAssignmentsCompanion(
      id: id ?? this.id,
      routeId: routeId ?? this.routeId,
      dataSourceId: dataSourceId ?? this.dataSourceId,
      contextName: contextName ?? this.contextName,
      executionOrder: executionOrder ?? this.executionOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (routeId.present) {
      map['route_id'] = Variable<int>(routeId.value);
    }
    if (dataSourceId.present) {
      map['data_source_id'] = Variable<int>(dataSourceId.value);
    }
    if (contextName.present) {
      map['context_name'] = Variable<String>(contextName.value);
    }
    if (executionOrder.present) {
      map['execution_order'] = Variable<int>(executionOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RouteDataAssignmentsCompanion(')
          ..write('id: $id, ')
          ..write('routeId: $routeId, ')
          ..write('dataSourceId: $dataSourceId, ')
          ..write('contextName: $contextName, ')
          ..write('executionOrder: $executionOrder')
          ..write(')'))
        .toString();
  }
}

abstract class _$UIDatabase extends GeneratedDatabase {
  _$UIDatabase(QueryExecutor e) : super(e);
  $UIDatabaseManager get managers => $UIDatabaseManager(this);
  late final Assets assets = Assets(this);
  late final Templates templates = Templates(this);
  late final Routes routes = Routes(this);
  late final DataSources dataSources = DataSources(this);
  late final SqlSourceConfigs sqlSourceConfigs = SqlSourceConfigs(this);
  late final JsonSourceConfigs jsonSourceConfigs = JsonSourceConfigs(this);
  late final HttpSourceConfigs httpSourceConfigs = HttpSourceConfigs(this);
  late final RouteDataAssignments routeDataAssignments =
      RouteDataAssignments(this);
  late final Index idxAssetsName =
      Index('idx_assets_name', 'CREATE INDEX idx_assets_name ON assets (name)');
  late final Index idxAssetsMimeType = Index('idx_assets_mime_type',
      'CREATE INDEX idx_assets_mime_type ON assets (mime_type)');
  late final Index idxTemplatesName = Index('idx_templates_name',
      'CREATE INDEX idx_templates_name ON templates (name)');
  late final Index idxTemplatesAssetId = Index('idx_templates_asset_id',
      'CREATE INDEX idx_templates_asset_id ON templates (asset_id)');
  late final Index idxRoutesPath =
      Index('idx_routes_path', 'CREATE INDEX idx_routes_path ON routes (path)');
  late final Index idxRoutesTemplateId = Index('idx_routes_template_id',
      'CREATE INDEX idx_routes_template_id ON routes (template_id)');
  late final Index idxRoutesAssetId = Index('idx_routes_asset_id',
      'CREATE INDEX idx_routes_asset_id ON routes (asset_id)');
  late final Index idxDataSourcesName = Index('idx_data_sources_name',
      'CREATE INDEX idx_data_sources_name ON data_sources (name)');
  late final Index idxDataSourcesType = Index('idx_data_sources_type',
      'CREATE INDEX idx_data_sources_type ON data_sources (type)');
  late final Index idxSqlSourceConfigsDataSourceId = Index(
      'idx_sql_source_configs_data_source_id',
      'CREATE INDEX idx_sql_source_configs_data_source_id ON sql_source_configs (data_source_id)');
  late final Index idxJsonSourceConfigsDataSourceId = Index(
      'idx_json_source_configs_data_source_id',
      'CREATE INDEX idx_json_source_configs_data_source_id ON json_source_configs (data_source_id)');
  late final Index idxJsonSourceConfigsAssetId = Index(
      'idx_json_source_configs_asset_id',
      'CREATE INDEX idx_json_source_configs_asset_id ON json_source_configs (asset_id)');
  late final Index idxHttpSourceConfigsDataSourceId = Index(
      'idx_http_source_configs_data_source_id',
      'CREATE INDEX idx_http_source_configs_data_source_id ON http_source_configs (data_source_id)');
  late final Index idxRouteDataAssignmentsRouteId = Index(
      'idx_route_data_assignments_route_id',
      'CREATE INDEX idx_route_data_assignments_route_id ON route_data_assignments (route_id)');
  late final Index idxRouteDataAssignmentsDataSourceId = Index(
      'idx_route_data_assignments_data_source_id',
      'CREATE INDEX idx_route_data_assignments_data_source_id ON route_data_assignments (data_source_id)');
  Future<int> insertAsset(
      String name, String mimeType, Uint8List content, String? description) {
    return customInsert(
      'INSERT INTO assets (name, mime_type, content, description) VALUES (?1, ?2, ?3, ?4)',
      variables: [
        Variable<String>(name),
        Variable<String>(mimeType),
        Variable<Uint8List>(content),
        Variable<String>(description)
      ],
      updates: {assets},
    );
  }

  Future<int> updateAsset(String name, String mimeType, Uint8List content,
      String? description, int id) {
    return customUpdate(
      'UPDATE assets SET name = ?1, mime_type = ?2, content = ?3, description = ?4 WHERE id = ?5',
      variables: [
        Variable<String>(name),
        Variable<String>(mimeType),
        Variable<Uint8List>(content),
        Variable<String>(description),
        Variable<int>(id)
      ],
      updates: {assets},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> deleteAsset(int id) {
    return customUpdate(
      'DELETE FROM assets WHERE id = ?1',
      variables: [Variable<int>(id)],
      updates: {assets},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> insertTemplate(String name, int assetId, String? description) {
    return customInsert(
      'INSERT INTO templates (name, asset_id, description) VALUES (?1, ?2, ?3)',
      variables: [
        Variable<String>(name),
        Variable<int>(assetId),
        Variable<String>(description)
      ],
      updates: {templates},
    );
  }

  Future<int> updateTemplate(
      String name, int assetId, String? description, int id) {
    return customUpdate(
      'UPDATE templates SET name = ?1, asset_id = ?2, description = ?3 WHERE id = ?4',
      variables: [
        Variable<String>(name),
        Variable<int>(assetId),
        Variable<String>(description),
        Variable<int>(id)
      ],
      updates: {templates},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> deleteTemplate(int id) {
    return customUpdate(
      'DELETE FROM templates WHERE id = ?1',
      variables: [Variable<int>(id)],
      updates: {templates},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> insertRoute(String path, int? templateId, int? assetId,
      String? description, String? redirectTo) {
    return customInsert(
      'INSERT INTO routes (path, template_id, asset_id, description, redirect_to) VALUES (?1, ?2, ?3, ?4, ?5)',
      variables: [
        Variable<String>(path),
        Variable<int>(templateId),
        Variable<int>(assetId),
        Variable<String>(description),
        Variable<String>(redirectTo)
      ],
      updates: {routes},
    );
  }

  Future<int> updateRoute(String path, int? templateId, int? assetId,
      String? description, String? redirectTo, int id) {
    return customUpdate(
      'UPDATE routes SET path = ?1, template_id = ?2, asset_id = ?3, description = ?4, redirect_to = ?5 WHERE id = ?6',
      variables: [
        Variable<String>(path),
        Variable<int>(templateId),
        Variable<int>(assetId),
        Variable<String>(description),
        Variable<String>(redirectTo),
        Variable<int>(id)
      ],
      updates: {routes},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> deleteRoute(int id) {
    return customUpdate(
      'DELETE FROM routes WHERE id = ?1',
      variables: [Variable<int>(id)],
      updates: {routes},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> insertDataSource(String name, String type, String? description) {
    return customInsert(
      'INSERT INTO data_sources (name, type, description) VALUES (?1, ?2, ?3)',
      variables: [
        Variable<String>(name),
        Variable<String>(type),
        Variable<String>(description)
      ],
      updates: {dataSources},
    );
  }

  Future<int> updateDataSource(
      String name, String type, String? description, int id) {
    return customUpdate(
      'UPDATE data_sources SET name = ?1, type = ?2, description = ?3 WHERE id = ?4',
      variables: [
        Variable<String>(name),
        Variable<String>(type),
        Variable<String>(description),
        Variable<int>(id)
      ],
      updates: {dataSources},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> deleteDataSource(int id) {
    return customUpdate(
      'DELETE FROM data_sources WHERE id = ?1',
      variables: [Variable<int>(id)],
      updates: {dataSources},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> insertSqlSourceConfig(int dataSourceId, String sqlTemplate) {
    return customInsert(
      'INSERT INTO sql_source_configs (data_source_id, sql_template) VALUES (?1, ?2)',
      variables: [Variable<int>(dataSourceId), Variable<String>(sqlTemplate)],
      updates: {sqlSourceConfigs},
    );
  }

  Future<int> updateSqlSourceConfig(String sqlTemplate, int dataSourceId) {
    return customUpdate(
      'UPDATE sql_source_configs SET sql_template = ?1 WHERE data_source_id = ?2',
      variables: [Variable<String>(sqlTemplate), Variable<int>(dataSourceId)],
      updates: {sqlSourceConfigs},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> deleteSqlSourceConfig(int dataSourceId) {
    return customUpdate(
      'DELETE FROM sql_source_configs WHERE data_source_id = ?1',
      variables: [Variable<int>(dataSourceId)],
      updates: {sqlSourceConfigs},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> insertJsonSourceConfig(int dataSourceId, int assetId) {
    return customInsert(
      'INSERT INTO json_source_configs (data_source_id, asset_id) VALUES (?1, ?2)',
      variables: [Variable<int>(dataSourceId), Variable<int>(assetId)],
      updates: {jsonSourceConfigs},
    );
  }

  Future<int> updateJsonSourceConfig(int assetId, int dataSourceId) {
    return customUpdate(
      'UPDATE json_source_configs SET asset_id = ?1 WHERE data_source_id = ?2',
      variables: [Variable<int>(assetId), Variable<int>(dataSourceId)],
      updates: {jsonSourceConfigs},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> deleteJsonSourceConfig(int dataSourceId) {
    return customUpdate(
      'DELETE FROM json_source_configs WHERE data_source_id = ?1',
      variables: [Variable<int>(dataSourceId)],
      updates: {jsonSourceConfigs},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> insertHttpSourceConfig(int dataSourceId, String urlTemplate,
      String method, String? headersTemplate, String? bodyTemplate) {
    return customInsert(
      'INSERT INTO http_source_configs (data_source_id, url_template, method, headers_template, body_template) VALUES (?1, ?2, ?3, ?4, ?5)',
      variables: [
        Variable<int>(dataSourceId),
        Variable<String>(urlTemplate),
        Variable<String>(method),
        Variable<String>(headersTemplate),
        Variable<String>(bodyTemplate)
      ],
      updates: {httpSourceConfigs},
    );
  }

  Future<int> updateHttpSourceConfig(String urlTemplate, String method,
      String? headersTemplate, String? bodyTemplate, int dataSourceId) {
    return customUpdate(
      'UPDATE http_source_configs SET url_template = ?1, method = ?2, headers_template = ?3, body_template = ?4 WHERE data_source_id = ?5',
      variables: [
        Variable<String>(urlTemplate),
        Variable<String>(method),
        Variable<String>(headersTemplate),
        Variable<String>(bodyTemplate),
        Variable<int>(dataSourceId)
      ],
      updates: {httpSourceConfigs},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> deleteHttpSourceConfig(int dataSourceId) {
    return customUpdate(
      'DELETE FROM http_source_configs WHERE data_source_id = ?1',
      variables: [Variable<int>(dataSourceId)],
      updates: {httpSourceConfigs},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> insertRouteDataAssignment(
      int routeId, int dataSourceId, String contextName, int executionOrder) {
    return customInsert(
      'INSERT INTO route_data_assignments (route_id, data_source_id, context_name, execution_order) VALUES (?1, ?2, ?3, ?4)',
      variables: [
        Variable<int>(routeId),
        Variable<int>(dataSourceId),
        Variable<String>(contextName),
        Variable<int>(executionOrder)
      ],
      updates: {routeDataAssignments},
    );
  }

  Future<int> updateRouteDataAssignment(
      int dataSourceId, String contextName, int executionOrder, int id) {
    return customUpdate(
      'UPDATE route_data_assignments SET data_source_id = ?1, context_name = ?2, execution_order = ?3 WHERE id = ?4',
      variables: [
        Variable<int>(dataSourceId),
        Variable<String>(contextName),
        Variable<int>(executionOrder),
        Variable<int>(id)
      ],
      updates: {routeDataAssignments},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> deleteRouteDataAssignment(int id) {
    return customUpdate(
      'DELETE FROM route_data_assignments WHERE id = ?1',
      variables: [Variable<int>(id)],
      updates: {routeDataAssignments},
      updateKind: UpdateKind.delete,
    );
  }

  Selectable<Asset> getAssetById(int id) {
    return customSelect('SELECT * FROM assets WHERE id = ?1', variables: [
      Variable<int>(id)
    ], readsFrom: {
      assets,
    }).asyncMap(assets.mapFromRow);
  }

  Selectable<Asset> getAssetByName(String name) {
    return customSelect('SELECT * FROM assets WHERE name = ?1', variables: [
      Variable<String>(name)
    ], readsFrom: {
      assets,
    }).asyncMap(assets.mapFromRow);
  }

  Selectable<Asset> getAllAssets() {
    return customSelect('SELECT * FROM assets', variables: [], readsFrom: {
      assets,
    }).asyncMap(assets.mapFromRow);
  }

  Selectable<GetTemplateByIdResult> getTemplateById(int id) {
    return customSelect(
        'SELECT t.*, a.content AS template_content, a.mime_type AS template_mime_type FROM templates AS t JOIN assets AS a ON t.asset_id = a.id WHERE t.id = ?1',
        variables: [
          Variable<int>(id)
        ],
        readsFrom: {
          assets,
          templates,
        }).map((QueryRow row) => GetTemplateByIdResult(
          id: row.read<int>('id'),
          name: row.read<String>('name'),
          assetId: row.read<int>('asset_id'),
          description: row.readNullable<String>('description'),
          templateContent: row.read<Uint8List>('template_content'),
          templateMimeType: row.read<String>('template_mime_type'),
        ));
  }

  Selectable<GetAllTemplatesResult> getAllTemplates() {
    return customSelect(
        'SELECT t.*, a.content AS template_content, a.mime_type AS template_mime_type FROM templates AS t JOIN assets AS a ON t.asset_id = a.id',
        variables: [],
        readsFrom: {
          assets,
          templates,
        }).map((QueryRow row) => GetAllTemplatesResult(
          id: row.read<int>('id'),
          name: row.read<String>('name'),
          assetId: row.read<int>('asset_id'),
          description: row.readNullable<String>('description'),
          templateContent: row.read<Uint8List>('template_content'),
          templateMimeType: row.read<String>('template_mime_type'),
        ));
  }

  Selectable<Route> getAllRoutes() {
    return customSelect('SELECT * FROM routes', variables: [], readsFrom: {
      routes,
    }).asyncMap(routes.mapFromRow);
  }

  Selectable<Route> getRouteById(int id) {
    return customSelect('SELECT * FROM routes WHERE id = ?1', variables: [
      Variable<int>(id)
    ], readsFrom: {
      routes,
    }).asyncMap(routes.mapFromRow);
  }

  Selectable<Route> getRouteByMatchingPath(String inputPath) {
    return customSelect(
        'SELECT * FROM routes WHERE route_matches(?1, path) = 1',
        variables: [
          Variable<String>(inputPath)
        ],
        readsFrom: {
          routes,
        }).asyncMap(routes.mapFromRow);
  }

  Selectable<Asset> getAssetByServedPath(String inputPath) {
    return customSelect(
        'SELECT a.* FROM assets AS a JOIN routes AS r ON a.id = r.asset_id WHERE route_matches(?1, r.path) = 1 AND r.asset_id IS NOT NULL',
        variables: [
          Variable<String>(inputPath)
        ],
        readsFrom: {
          assets,
          routes,
        }).asyncMap(assets.mapFromRow);
  }

  Selectable<DataSource> getDataSourceById(int id) {
    return customSelect('SELECT * FROM data_sources WHERE id = ?1', variables: [
      Variable<int>(id)
    ], readsFrom: {
      dataSources,
    }).asyncMap(dataSources.mapFromRow);
  }

  Selectable<DataSource> getAllDataSources() {
    return customSelect('SELECT * FROM data_sources',
        variables: [],
        readsFrom: {
          dataSources,
        }).asyncMap(dataSources.mapFromRow);
  }

  Selectable<SqlSourceConfig> getSqlSourceConfigByDataSourceId(
      int dataSourceId) {
    return customSelect(
        'SELECT * FROM sql_source_configs WHERE data_source_id = ?1',
        variables: [
          Variable<int>(dataSourceId)
        ],
        readsFrom: {
          sqlSourceConfigs,
        }).asyncMap(sqlSourceConfigs.mapFromRow);
  }

  Selectable<JsonSourceConfig> getJsonSourceConfigByDataSourceId(
      int dataSourceId) {
    return customSelect(
        'SELECT * FROM json_source_configs WHERE data_source_id = ?1',
        variables: [
          Variable<int>(dataSourceId)
        ],
        readsFrom: {
          jsonSourceConfigs,
        }).asyncMap(jsonSourceConfigs.mapFromRow);
  }

  Selectable<HttpSourceConfig> getHttpSourceConfigByDataSourceId(
      int dataSourceId) {
    return customSelect(
        'SELECT * FROM http_source_configs WHERE data_source_id = ?1',
        variables: [
          Variable<int>(dataSourceId)
        ],
        readsFrom: {
          httpSourceConfigs,
        }).asyncMap(httpSourceConfigs.mapFromRow);
  }

  Selectable<RouteDataAssignment> getRouteDataAssignmentsByRouteId(
      int routeId) {
    return customSelect(
        'SELECT * FROM route_data_assignments WHERE route_id = ?1 ORDER BY execution_order ASC',
        variables: [
          Variable<int>(routeId)
        ],
        readsFrom: {
          routeDataAssignments,
        }).asyncMap(routeDataAssignments.mapFromRow);
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        assets,
        templates,
        routes,
        dataSources,
        sqlSourceConfigs,
        jsonSourceConfigs,
        httpSourceConfigs,
        routeDataAssignments,
        idxAssetsName,
        idxAssetsMimeType,
        idxTemplatesName,
        idxTemplatesAssetId,
        idxRoutesPath,
        idxRoutesTemplateId,
        idxRoutesAssetId,
        idxDataSourcesName,
        idxDataSourcesType,
        idxSqlSourceConfigsDataSourceId,
        idxJsonSourceConfigsDataSourceId,
        idxJsonSourceConfigsAssetId,
        idxHttpSourceConfigsDataSourceId,
        idxRouteDataAssignmentsRouteId,
        idxRouteDataAssignmentsDataSourceId
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('assets',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('templates', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('templates',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('routes', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('assets',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('routes', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('data_sources',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('sql_source_configs', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('data_sources',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('json_source_configs', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('assets',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('json_source_configs', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('data_sources',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('http_source_configs', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('routes',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('route_data_assignments', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('data_sources',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('route_data_assignments', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $AssetsCreateCompanionBuilder = AssetsCompanion Function({
  Value<int> id,
  required String name,
  required String mimeType,
  required Uint8List content,
  Value<String?> description,
});
typedef $AssetsUpdateCompanionBuilder = AssetsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> mimeType,
  Value<Uint8List> content,
  Value<String?> description,
});

class $AssetsFilterComposer extends Composer<_$UIDatabase, Assets> {
  $AssetsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mimeType => $composableBuilder(
      column: $table.mimeType, builder: (column) => ColumnFilters(column));

  ColumnFilters<Uint8List> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));
}

class $AssetsOrderingComposer extends Composer<_$UIDatabase, Assets> {
  $AssetsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mimeType => $composableBuilder(
      column: $table.mimeType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<Uint8List> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));
}

class $AssetsAnnotationComposer extends Composer<_$UIDatabase, Assets> {
  $AssetsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<Uint8List> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);
}

class $AssetsTableManager extends RootTableManager<
    _$UIDatabase,
    Assets,
    Asset,
    $AssetsFilterComposer,
    $AssetsOrderingComposer,
    $AssetsAnnotationComposer,
    $AssetsCreateCompanionBuilder,
    $AssetsUpdateCompanionBuilder,
    (Asset, BaseReferences<_$UIDatabase, Assets, Asset>),
    Asset,
    PrefetchHooks Function()> {
  $AssetsTableManager(_$UIDatabase db, Assets table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $AssetsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $AssetsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $AssetsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> mimeType = const Value.absent(),
            Value<Uint8List> content = const Value.absent(),
            Value<String?> description = const Value.absent(),
          }) =>
              AssetsCompanion(
            id: id,
            name: name,
            mimeType: mimeType,
            content: content,
            description: description,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String mimeType,
            required Uint8List content,
            Value<String?> description = const Value.absent(),
          }) =>
              AssetsCompanion.insert(
            id: id,
            name: name,
            mimeType: mimeType,
            content: content,
            description: description,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $AssetsProcessedTableManager = ProcessedTableManager<
    _$UIDatabase,
    Assets,
    Asset,
    $AssetsFilterComposer,
    $AssetsOrderingComposer,
    $AssetsAnnotationComposer,
    $AssetsCreateCompanionBuilder,
    $AssetsUpdateCompanionBuilder,
    (Asset, BaseReferences<_$UIDatabase, Assets, Asset>),
    Asset,
    PrefetchHooks Function()>;
typedef $TemplatesCreateCompanionBuilder = TemplatesCompanion Function({
  Value<int> id,
  required String name,
  required int assetId,
  Value<String?> description,
});
typedef $TemplatesUpdateCompanionBuilder = TemplatesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> assetId,
  Value<String?> description,
});

class $TemplatesFilterComposer extends Composer<_$UIDatabase, Templates> {
  $TemplatesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get assetId => $composableBuilder(
      column: $table.assetId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));
}

class $TemplatesOrderingComposer extends Composer<_$UIDatabase, Templates> {
  $TemplatesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get assetId => $composableBuilder(
      column: $table.assetId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));
}

class $TemplatesAnnotationComposer extends Composer<_$UIDatabase, Templates> {
  $TemplatesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get assetId =>
      $composableBuilder(column: $table.assetId, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);
}

class $TemplatesTableManager extends RootTableManager<
    _$UIDatabase,
    Templates,
    Template,
    $TemplatesFilterComposer,
    $TemplatesOrderingComposer,
    $TemplatesAnnotationComposer,
    $TemplatesCreateCompanionBuilder,
    $TemplatesUpdateCompanionBuilder,
    (Template, BaseReferences<_$UIDatabase, Templates, Template>),
    Template,
    PrefetchHooks Function()> {
  $TemplatesTableManager(_$UIDatabase db, Templates table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TemplatesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TemplatesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TemplatesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> assetId = const Value.absent(),
            Value<String?> description = const Value.absent(),
          }) =>
              TemplatesCompanion(
            id: id,
            name: name,
            assetId: assetId,
            description: description,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required int assetId,
            Value<String?> description = const Value.absent(),
          }) =>
              TemplatesCompanion.insert(
            id: id,
            name: name,
            assetId: assetId,
            description: description,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $TemplatesProcessedTableManager = ProcessedTableManager<
    _$UIDatabase,
    Templates,
    Template,
    $TemplatesFilterComposer,
    $TemplatesOrderingComposer,
    $TemplatesAnnotationComposer,
    $TemplatesCreateCompanionBuilder,
    $TemplatesUpdateCompanionBuilder,
    (Template, BaseReferences<_$UIDatabase, Templates, Template>),
    Template,
    PrefetchHooks Function()>;
typedef $RoutesCreateCompanionBuilder = RoutesCompanion Function({
  Value<int> id,
  required String path,
  Value<int?> templateId,
  Value<int?> assetId,
  Value<String?> description,
  Value<String?> redirectTo,
});
typedef $RoutesUpdateCompanionBuilder = RoutesCompanion Function({
  Value<int> id,
  Value<String> path,
  Value<int?> templateId,
  Value<int?> assetId,
  Value<String?> description,
  Value<String?> redirectTo,
});

class $RoutesFilterComposer extends Composer<_$UIDatabase, Routes> {
  $RoutesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get templateId => $composableBuilder(
      column: $table.templateId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get assetId => $composableBuilder(
      column: $table.assetId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get redirectTo => $composableBuilder(
      column: $table.redirectTo, builder: (column) => ColumnFilters(column));
}

class $RoutesOrderingComposer extends Composer<_$UIDatabase, Routes> {
  $RoutesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get templateId => $composableBuilder(
      column: $table.templateId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get assetId => $composableBuilder(
      column: $table.assetId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get redirectTo => $composableBuilder(
      column: $table.redirectTo, builder: (column) => ColumnOrderings(column));
}

class $RoutesAnnotationComposer extends Composer<_$UIDatabase, Routes> {
  $RoutesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<int> get templateId => $composableBuilder(
      column: $table.templateId, builder: (column) => column);

  GeneratedColumn<int> get assetId =>
      $composableBuilder(column: $table.assetId, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get redirectTo => $composableBuilder(
      column: $table.redirectTo, builder: (column) => column);
}

class $RoutesTableManager extends RootTableManager<
    _$UIDatabase,
    Routes,
    Route,
    $RoutesFilterComposer,
    $RoutesOrderingComposer,
    $RoutesAnnotationComposer,
    $RoutesCreateCompanionBuilder,
    $RoutesUpdateCompanionBuilder,
    (Route, BaseReferences<_$UIDatabase, Routes, Route>),
    Route,
    PrefetchHooks Function()> {
  $RoutesTableManager(_$UIDatabase db, Routes table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $RoutesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $RoutesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $RoutesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<int?> templateId = const Value.absent(),
            Value<int?> assetId = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> redirectTo = const Value.absent(),
          }) =>
              RoutesCompanion(
            id: id,
            path: path,
            templateId: templateId,
            assetId: assetId,
            description: description,
            redirectTo: redirectTo,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String path,
            Value<int?> templateId = const Value.absent(),
            Value<int?> assetId = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> redirectTo = const Value.absent(),
          }) =>
              RoutesCompanion.insert(
            id: id,
            path: path,
            templateId: templateId,
            assetId: assetId,
            description: description,
            redirectTo: redirectTo,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $RoutesProcessedTableManager = ProcessedTableManager<
    _$UIDatabase,
    Routes,
    Route,
    $RoutesFilterComposer,
    $RoutesOrderingComposer,
    $RoutesAnnotationComposer,
    $RoutesCreateCompanionBuilder,
    $RoutesUpdateCompanionBuilder,
    (Route, BaseReferences<_$UIDatabase, Routes, Route>),
    Route,
    PrefetchHooks Function()>;
typedef $DataSourcesCreateCompanionBuilder = DataSourcesCompanion Function({
  Value<int> id,
  required String name,
  required String type,
  Value<String?> description,
});
typedef $DataSourcesUpdateCompanionBuilder = DataSourcesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> type,
  Value<String?> description,
});

class $DataSourcesFilterComposer extends Composer<_$UIDatabase, DataSources> {
  $DataSourcesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));
}

class $DataSourcesOrderingComposer extends Composer<_$UIDatabase, DataSources> {
  $DataSourcesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));
}

class $DataSourcesAnnotationComposer
    extends Composer<_$UIDatabase, DataSources> {
  $DataSourcesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);
}

class $DataSourcesTableManager extends RootTableManager<
    _$UIDatabase,
    DataSources,
    DataSource,
    $DataSourcesFilterComposer,
    $DataSourcesOrderingComposer,
    $DataSourcesAnnotationComposer,
    $DataSourcesCreateCompanionBuilder,
    $DataSourcesUpdateCompanionBuilder,
    (DataSource, BaseReferences<_$UIDatabase, DataSources, DataSource>),
    DataSource,
    PrefetchHooks Function()> {
  $DataSourcesTableManager(_$UIDatabase db, DataSources table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $DataSourcesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $DataSourcesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $DataSourcesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String?> description = const Value.absent(),
          }) =>
              DataSourcesCompanion(
            id: id,
            name: name,
            type: type,
            description: description,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String type,
            Value<String?> description = const Value.absent(),
          }) =>
              DataSourcesCompanion.insert(
            id: id,
            name: name,
            type: type,
            description: description,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $DataSourcesProcessedTableManager = ProcessedTableManager<
    _$UIDatabase,
    DataSources,
    DataSource,
    $DataSourcesFilterComposer,
    $DataSourcesOrderingComposer,
    $DataSourcesAnnotationComposer,
    $DataSourcesCreateCompanionBuilder,
    $DataSourcesUpdateCompanionBuilder,
    (DataSource, BaseReferences<_$UIDatabase, DataSources, DataSource>),
    DataSource,
    PrefetchHooks Function()>;
typedef $SqlSourceConfigsCreateCompanionBuilder = SqlSourceConfigsCompanion
    Function({
  Value<int> id,
  required int dataSourceId,
  required String sqlTemplate,
});
typedef $SqlSourceConfigsUpdateCompanionBuilder = SqlSourceConfigsCompanion
    Function({
  Value<int> id,
  Value<int> dataSourceId,
  Value<String> sqlTemplate,
});

class $SqlSourceConfigsFilterComposer
    extends Composer<_$UIDatabase, SqlSourceConfigs> {
  $SqlSourceConfigsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dataSourceId => $composableBuilder(
      column: $table.dataSourceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sqlTemplate => $composableBuilder(
      column: $table.sqlTemplate, builder: (column) => ColumnFilters(column));
}

class $SqlSourceConfigsOrderingComposer
    extends Composer<_$UIDatabase, SqlSourceConfigs> {
  $SqlSourceConfigsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dataSourceId => $composableBuilder(
      column: $table.dataSourceId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sqlTemplate => $composableBuilder(
      column: $table.sqlTemplate, builder: (column) => ColumnOrderings(column));
}

class $SqlSourceConfigsAnnotationComposer
    extends Composer<_$UIDatabase, SqlSourceConfigs> {
  $SqlSourceConfigsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dataSourceId => $composableBuilder(
      column: $table.dataSourceId, builder: (column) => column);

  GeneratedColumn<String> get sqlTemplate => $composableBuilder(
      column: $table.sqlTemplate, builder: (column) => column);
}

class $SqlSourceConfigsTableManager extends RootTableManager<
    _$UIDatabase,
    SqlSourceConfigs,
    SqlSourceConfig,
    $SqlSourceConfigsFilterComposer,
    $SqlSourceConfigsOrderingComposer,
    $SqlSourceConfigsAnnotationComposer,
    $SqlSourceConfigsCreateCompanionBuilder,
    $SqlSourceConfigsUpdateCompanionBuilder,
    (
      SqlSourceConfig,
      BaseReferences<_$UIDatabase, SqlSourceConfigs, SqlSourceConfig>
    ),
    SqlSourceConfig,
    PrefetchHooks Function()> {
  $SqlSourceConfigsTableManager(_$UIDatabase db, SqlSourceConfigs table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $SqlSourceConfigsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $SqlSourceConfigsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $SqlSourceConfigsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> dataSourceId = const Value.absent(),
            Value<String> sqlTemplate = const Value.absent(),
          }) =>
              SqlSourceConfigsCompanion(
            id: id,
            dataSourceId: dataSourceId,
            sqlTemplate: sqlTemplate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dataSourceId,
            required String sqlTemplate,
          }) =>
              SqlSourceConfigsCompanion.insert(
            id: id,
            dataSourceId: dataSourceId,
            sqlTemplate: sqlTemplate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $SqlSourceConfigsProcessedTableManager = ProcessedTableManager<
    _$UIDatabase,
    SqlSourceConfigs,
    SqlSourceConfig,
    $SqlSourceConfigsFilterComposer,
    $SqlSourceConfigsOrderingComposer,
    $SqlSourceConfigsAnnotationComposer,
    $SqlSourceConfigsCreateCompanionBuilder,
    $SqlSourceConfigsUpdateCompanionBuilder,
    (
      SqlSourceConfig,
      BaseReferences<_$UIDatabase, SqlSourceConfigs, SqlSourceConfig>
    ),
    SqlSourceConfig,
    PrefetchHooks Function()>;
typedef $JsonSourceConfigsCreateCompanionBuilder = JsonSourceConfigsCompanion
    Function({
  Value<int> id,
  required int dataSourceId,
  required int assetId,
});
typedef $JsonSourceConfigsUpdateCompanionBuilder = JsonSourceConfigsCompanion
    Function({
  Value<int> id,
  Value<int> dataSourceId,
  Value<int> assetId,
});

class $JsonSourceConfigsFilterComposer
    extends Composer<_$UIDatabase, JsonSourceConfigs> {
  $JsonSourceConfigsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dataSourceId => $composableBuilder(
      column: $table.dataSourceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get assetId => $composableBuilder(
      column: $table.assetId, builder: (column) => ColumnFilters(column));
}

class $JsonSourceConfigsOrderingComposer
    extends Composer<_$UIDatabase, JsonSourceConfigs> {
  $JsonSourceConfigsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dataSourceId => $composableBuilder(
      column: $table.dataSourceId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get assetId => $composableBuilder(
      column: $table.assetId, builder: (column) => ColumnOrderings(column));
}

class $JsonSourceConfigsAnnotationComposer
    extends Composer<_$UIDatabase, JsonSourceConfigs> {
  $JsonSourceConfigsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dataSourceId => $composableBuilder(
      column: $table.dataSourceId, builder: (column) => column);

  GeneratedColumn<int> get assetId =>
      $composableBuilder(column: $table.assetId, builder: (column) => column);
}

class $JsonSourceConfigsTableManager extends RootTableManager<
    _$UIDatabase,
    JsonSourceConfigs,
    JsonSourceConfig,
    $JsonSourceConfigsFilterComposer,
    $JsonSourceConfigsOrderingComposer,
    $JsonSourceConfigsAnnotationComposer,
    $JsonSourceConfigsCreateCompanionBuilder,
    $JsonSourceConfigsUpdateCompanionBuilder,
    (
      JsonSourceConfig,
      BaseReferences<_$UIDatabase, JsonSourceConfigs, JsonSourceConfig>
    ),
    JsonSourceConfig,
    PrefetchHooks Function()> {
  $JsonSourceConfigsTableManager(_$UIDatabase db, JsonSourceConfigs table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $JsonSourceConfigsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $JsonSourceConfigsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $JsonSourceConfigsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> dataSourceId = const Value.absent(),
            Value<int> assetId = const Value.absent(),
          }) =>
              JsonSourceConfigsCompanion(
            id: id,
            dataSourceId: dataSourceId,
            assetId: assetId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dataSourceId,
            required int assetId,
          }) =>
              JsonSourceConfigsCompanion.insert(
            id: id,
            dataSourceId: dataSourceId,
            assetId: assetId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $JsonSourceConfigsProcessedTableManager = ProcessedTableManager<
    _$UIDatabase,
    JsonSourceConfigs,
    JsonSourceConfig,
    $JsonSourceConfigsFilterComposer,
    $JsonSourceConfigsOrderingComposer,
    $JsonSourceConfigsAnnotationComposer,
    $JsonSourceConfigsCreateCompanionBuilder,
    $JsonSourceConfigsUpdateCompanionBuilder,
    (
      JsonSourceConfig,
      BaseReferences<_$UIDatabase, JsonSourceConfigs, JsonSourceConfig>
    ),
    JsonSourceConfig,
    PrefetchHooks Function()>;
typedef $HttpSourceConfigsCreateCompanionBuilder = HttpSourceConfigsCompanion
    Function({
  Value<int> id,
  required int dataSourceId,
  required String urlTemplate,
  Value<String> method,
  Value<String?> headersTemplate,
  Value<String?> bodyTemplate,
});
typedef $HttpSourceConfigsUpdateCompanionBuilder = HttpSourceConfigsCompanion
    Function({
  Value<int> id,
  Value<int> dataSourceId,
  Value<String> urlTemplate,
  Value<String> method,
  Value<String?> headersTemplate,
  Value<String?> bodyTemplate,
});

class $HttpSourceConfigsFilterComposer
    extends Composer<_$UIDatabase, HttpSourceConfigs> {
  $HttpSourceConfigsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dataSourceId => $composableBuilder(
      column: $table.dataSourceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get urlTemplate => $composableBuilder(
      column: $table.urlTemplate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get headersTemplate => $composableBuilder(
      column: $table.headersTemplate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bodyTemplate => $composableBuilder(
      column: $table.bodyTemplate, builder: (column) => ColumnFilters(column));
}

class $HttpSourceConfigsOrderingComposer
    extends Composer<_$UIDatabase, HttpSourceConfigs> {
  $HttpSourceConfigsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dataSourceId => $composableBuilder(
      column: $table.dataSourceId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get urlTemplate => $composableBuilder(
      column: $table.urlTemplate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get headersTemplate => $composableBuilder(
      column: $table.headersTemplate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bodyTemplate => $composableBuilder(
      column: $table.bodyTemplate,
      builder: (column) => ColumnOrderings(column));
}

class $HttpSourceConfigsAnnotationComposer
    extends Composer<_$UIDatabase, HttpSourceConfigs> {
  $HttpSourceConfigsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dataSourceId => $composableBuilder(
      column: $table.dataSourceId, builder: (column) => column);

  GeneratedColumn<String> get urlTemplate => $composableBuilder(
      column: $table.urlTemplate, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get headersTemplate => $composableBuilder(
      column: $table.headersTemplate, builder: (column) => column);

  GeneratedColumn<String> get bodyTemplate => $composableBuilder(
      column: $table.bodyTemplate, builder: (column) => column);
}

class $HttpSourceConfigsTableManager extends RootTableManager<
    _$UIDatabase,
    HttpSourceConfigs,
    HttpSourceConfig,
    $HttpSourceConfigsFilterComposer,
    $HttpSourceConfigsOrderingComposer,
    $HttpSourceConfigsAnnotationComposer,
    $HttpSourceConfigsCreateCompanionBuilder,
    $HttpSourceConfigsUpdateCompanionBuilder,
    (
      HttpSourceConfig,
      BaseReferences<_$UIDatabase, HttpSourceConfigs, HttpSourceConfig>
    ),
    HttpSourceConfig,
    PrefetchHooks Function()> {
  $HttpSourceConfigsTableManager(_$UIDatabase db, HttpSourceConfigs table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $HttpSourceConfigsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $HttpSourceConfigsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $HttpSourceConfigsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> dataSourceId = const Value.absent(),
            Value<String> urlTemplate = const Value.absent(),
            Value<String> method = const Value.absent(),
            Value<String?> headersTemplate = const Value.absent(),
            Value<String?> bodyTemplate = const Value.absent(),
          }) =>
              HttpSourceConfigsCompanion(
            id: id,
            dataSourceId: dataSourceId,
            urlTemplate: urlTemplate,
            method: method,
            headersTemplate: headersTemplate,
            bodyTemplate: bodyTemplate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dataSourceId,
            required String urlTemplate,
            Value<String> method = const Value.absent(),
            Value<String?> headersTemplate = const Value.absent(),
            Value<String?> bodyTemplate = const Value.absent(),
          }) =>
              HttpSourceConfigsCompanion.insert(
            id: id,
            dataSourceId: dataSourceId,
            urlTemplate: urlTemplate,
            method: method,
            headersTemplate: headersTemplate,
            bodyTemplate: bodyTemplate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $HttpSourceConfigsProcessedTableManager = ProcessedTableManager<
    _$UIDatabase,
    HttpSourceConfigs,
    HttpSourceConfig,
    $HttpSourceConfigsFilterComposer,
    $HttpSourceConfigsOrderingComposer,
    $HttpSourceConfigsAnnotationComposer,
    $HttpSourceConfigsCreateCompanionBuilder,
    $HttpSourceConfigsUpdateCompanionBuilder,
    (
      HttpSourceConfig,
      BaseReferences<_$UIDatabase, HttpSourceConfigs, HttpSourceConfig>
    ),
    HttpSourceConfig,
    PrefetchHooks Function()>;
typedef $RouteDataAssignmentsCreateCompanionBuilder
    = RouteDataAssignmentsCompanion Function({
  Value<int> id,
  required int routeId,
  required int dataSourceId,
  required String contextName,
  Value<int> executionOrder,
});
typedef $RouteDataAssignmentsUpdateCompanionBuilder
    = RouteDataAssignmentsCompanion Function({
  Value<int> id,
  Value<int> routeId,
  Value<int> dataSourceId,
  Value<String> contextName,
  Value<int> executionOrder,
});

class $RouteDataAssignmentsFilterComposer
    extends Composer<_$UIDatabase, RouteDataAssignments> {
  $RouteDataAssignmentsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get routeId => $composableBuilder(
      column: $table.routeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dataSourceId => $composableBuilder(
      column: $table.dataSourceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contextName => $composableBuilder(
      column: $table.contextName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get executionOrder => $composableBuilder(
      column: $table.executionOrder,
      builder: (column) => ColumnFilters(column));
}

class $RouteDataAssignmentsOrderingComposer
    extends Composer<_$UIDatabase, RouteDataAssignments> {
  $RouteDataAssignmentsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get routeId => $composableBuilder(
      column: $table.routeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dataSourceId => $composableBuilder(
      column: $table.dataSourceId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contextName => $composableBuilder(
      column: $table.contextName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get executionOrder => $composableBuilder(
      column: $table.executionOrder,
      builder: (column) => ColumnOrderings(column));
}

class $RouteDataAssignmentsAnnotationComposer
    extends Composer<_$UIDatabase, RouteDataAssignments> {
  $RouteDataAssignmentsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get routeId =>
      $composableBuilder(column: $table.routeId, builder: (column) => column);

  GeneratedColumn<int> get dataSourceId => $composableBuilder(
      column: $table.dataSourceId, builder: (column) => column);

  GeneratedColumn<String> get contextName => $composableBuilder(
      column: $table.contextName, builder: (column) => column);

  GeneratedColumn<int> get executionOrder => $composableBuilder(
      column: $table.executionOrder, builder: (column) => column);
}

class $RouteDataAssignmentsTableManager extends RootTableManager<
    _$UIDatabase,
    RouteDataAssignments,
    RouteDataAssignment,
    $RouteDataAssignmentsFilterComposer,
    $RouteDataAssignmentsOrderingComposer,
    $RouteDataAssignmentsAnnotationComposer,
    $RouteDataAssignmentsCreateCompanionBuilder,
    $RouteDataAssignmentsUpdateCompanionBuilder,
    (
      RouteDataAssignment,
      BaseReferences<_$UIDatabase, RouteDataAssignments, RouteDataAssignment>
    ),
    RouteDataAssignment,
    PrefetchHooks Function()> {
  $RouteDataAssignmentsTableManager(_$UIDatabase db, RouteDataAssignments table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $RouteDataAssignmentsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $RouteDataAssignmentsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $RouteDataAssignmentsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> routeId = const Value.absent(),
            Value<int> dataSourceId = const Value.absent(),
            Value<String> contextName = const Value.absent(),
            Value<int> executionOrder = const Value.absent(),
          }) =>
              RouteDataAssignmentsCompanion(
            id: id,
            routeId: routeId,
            dataSourceId: dataSourceId,
            contextName: contextName,
            executionOrder: executionOrder,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int routeId,
            required int dataSourceId,
            required String contextName,
            Value<int> executionOrder = const Value.absent(),
          }) =>
              RouteDataAssignmentsCompanion.insert(
            id: id,
            routeId: routeId,
            dataSourceId: dataSourceId,
            contextName: contextName,
            executionOrder: executionOrder,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $RouteDataAssignmentsProcessedTableManager = ProcessedTableManager<
    _$UIDatabase,
    RouteDataAssignments,
    RouteDataAssignment,
    $RouteDataAssignmentsFilterComposer,
    $RouteDataAssignmentsOrderingComposer,
    $RouteDataAssignmentsAnnotationComposer,
    $RouteDataAssignmentsCreateCompanionBuilder,
    $RouteDataAssignmentsUpdateCompanionBuilder,
    (
      RouteDataAssignment,
      BaseReferences<_$UIDatabase, RouteDataAssignments, RouteDataAssignment>
    ),
    RouteDataAssignment,
    PrefetchHooks Function()>;

class $UIDatabaseManager {
  final _$UIDatabase _db;
  $UIDatabaseManager(this._db);
  $AssetsTableManager get assets => $AssetsTableManager(_db, _db.assets);
  $TemplatesTableManager get templates =>
      $TemplatesTableManager(_db, _db.templates);
  $RoutesTableManager get routes => $RoutesTableManager(_db, _db.routes);
  $DataSourcesTableManager get dataSources =>
      $DataSourcesTableManager(_db, _db.dataSources);
  $SqlSourceConfigsTableManager get sqlSourceConfigs =>
      $SqlSourceConfigsTableManager(_db, _db.sqlSourceConfigs);
  $JsonSourceConfigsTableManager get jsonSourceConfigs =>
      $JsonSourceConfigsTableManager(_db, _db.jsonSourceConfigs);
  $HttpSourceConfigsTableManager get httpSourceConfigs =>
      $HttpSourceConfigsTableManager(_db, _db.httpSourceConfigs);
  $RouteDataAssignmentsTableManager get routeDataAssignments =>
      $RouteDataAssignmentsTableManager(_db, _db.routeDataAssignments);
}

class GetTemplateByIdResult {
  final int id;
  final String name;
  final int assetId;
  final String? description;
  final Uint8List templateContent;
  final String templateMimeType;
  GetTemplateByIdResult({
    required this.id,
    required this.name,
    required this.assetId,
    this.description,
    required this.templateContent,
    required this.templateMimeType,
  });
}

class GetAllTemplatesResult {
  final int id;
  final String name;
  final int assetId;
  final String? description;
  final Uint8List templateContent;
  final String templateMimeType;
  GetAllTemplatesResult({
    required this.id,
    required this.name,
    required this.assetId,
    this.description,
    required this.templateContent,
    required this.templateMimeType,
  });
}
