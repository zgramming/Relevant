import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../utils/utils.dart';
import 'joined_event_model.dart';

part 'event_detail_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class EventDetailModel extends Equatable {
  const EventDetailModel({
    this.id = 0,
    this.title = '',
    this.type = EventType.online,
    this.description = '',
    this.image,
    this.updatedAt,
    this.namaCategory = '',
    this.namaOrganisasi = '',
    this.websiteOrganisasi,
    this.whatsappOrganisasi,
    this.emailOrganisasi,
    this.instagramOrganisasi,
    this.totalJoinedEvent = 0,
    this.joinedEvent = const [],
  });

  final int id;
  final String title;
  final EventType type;
  final String description;
  final String? image;
  final DateTime? updatedAt;
  final String namaCategory;
  final String namaOrganisasi;
  final String? websiteOrganisasi;
  final String? whatsappOrganisasi;
  final String? emailOrganisasi;
  final String? instagramOrganisasi;
  final int totalJoinedEvent;
  final List<JoinedEventModel> joinedEvent;

  factory EventDetailModel.fromJson(Map<String, dynamic> json) => _$EventDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventDetailModelToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      type,
      description,
      image,
      updatedAt,
      namaCategory,
      namaOrganisasi,
      websiteOrganisasi,
      whatsappOrganisasi,
      emailOrganisasi,
      instagramOrganisasi,
      totalJoinedEvent,
      joinedEvent,
    ];
  }

  EventDetailModel copyWith({
    int? id,
    String? title,
    EventType? type,
    String? description,
    String? image,
    DateTime? updatedAt,
    String? namaCategory,
    String? namaOrganisasi,
    String? websiteOrganisasi,
    String? whatsappOrganisasi,
    String? emailOrganisasi,
    String? instagramOrganisasi,
    int? totalJoinedEvent,
    List<JoinedEventModel>? joinedEvent,
  }) {
    return EventDetailModel(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      image: image ?? this.image,
      updatedAt: updatedAt ?? this.updatedAt,
      namaCategory: namaCategory ?? this.namaCategory,
      namaOrganisasi: namaOrganisasi ?? this.namaOrganisasi,
      websiteOrganisasi: websiteOrganisasi ?? this.websiteOrganisasi,
      whatsappOrganisasi: whatsappOrganisasi ?? this.whatsappOrganisasi,
      emailOrganisasi: emailOrganisasi ?? this.emailOrganisasi,
      instagramOrganisasi: instagramOrganisasi ?? this.instagramOrganisasi,
      totalJoinedEvent: totalJoinedEvent ?? this.totalJoinedEvent,
      joinedEvent: joinedEvent ?? this.joinedEvent,
    );
  }
}