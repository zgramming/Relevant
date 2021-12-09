import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../utils/utils.dart';

part 'event_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class Event extends Equatable {
  final int id;
  final int idOrganization;
  final int idCategory;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final double? latitude;
  final double? longitude;
  final EventType type;
  final int quota;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Event({
    this.id = 0,
    this.idOrganization = 0,
    this.idCategory = 0,
    this.title = '',
    this.description = '',
    required this.startDate,
    required this.endDate,
    this.location = '',
    this.latitude,
    this.longitude,
    required this.type,
    this.quota = 0,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      idOrganization,
      idCategory,
      title,
      description,
      startDate,
      endDate,
      location,
      latitude,
      longitude,
      type,
      quota,
      image,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;

  Event copyWith({
    int? id,
    int? idOrganization,
    int? idCategory,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? location,
    double? latitude,
    double? longitude,
    EventType? type,
    int? quota,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Event(
      id: id ?? this.id,
      idOrganization: idOrganization ?? this.idOrganization,
      idCategory: idCategory ?? this.idCategory,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      type: type ?? this.type,
      quota: quota ?? this.quota,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
