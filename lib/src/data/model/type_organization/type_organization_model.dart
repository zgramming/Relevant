import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'type_organization_model.g.dart';

@immutable
@JsonSerializable()
class TypeOrganization extends Equatable {
  final int id;
  final String name;
  final String description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TypeOrganization({
    required this.id,
    required this.name,
    required this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory TypeOrganization.fromJson(Map<String, dynamic> json) => _$TypeOrganizationFromJson(json);
  Map<String, dynamic> toJson() => _$TypeOrganizationToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;

  TypeOrganization copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TypeOrganization(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
