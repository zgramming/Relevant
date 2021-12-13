import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../utils/utils.dart';
import 'event_for_you_model.dart';

part 'event_bookmark_model.g.dart';

@HiveType(typeId: 0)
class EventBookmarkModel extends Equatable {
  const EventBookmarkModel({
    required this.id,
    required this.idUser,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.quota,
    required this.image,
    required this.namaCategory,
    required this.namaOrganisasi,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final int idUser;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final DateTime startDate;
  @HiveField(4)
  final DateTime endDate;
  @HiveField(5)
  final EventType type;
  @HiveField(6)
  final int quota;
  @HiveField(7)
  final String? image;
  @HiveField(8)
  final String namaCategory;
  @HiveField(9)
  final String namaOrganisasi;

  EventForYouModel toEventForYouModel() {
    return EventForYouModel(
      id: id,
      title: title,
      startDate: startDate,
      endDate: endDate,
      type: type,
      quota: quota,
      image: image,
      namaCategory: namaCategory,
      namaOrganisasi: namaOrganisasi,
    );
  }

  @override
  bool get stringify => true;
  @override
  List<Object?> get props {
    return [
      id,
      idUser,
      title,
      startDate,
      endDate,
      type,
      quota,
      image,
      namaCategory,
      namaOrganisasi,
    ];
  }

  EventBookmarkModel copyWith({
    int? id,
    int? idUser,
    String? title,
    DateTime? startDate,
    DateTime? endDate,
    EventType? type,
    int? quota,
    String? image,
    String? namaCategory,
    String? namaOrganisasi,
  }) {
    return EventBookmarkModel(
      id: id ?? this.id,
      idUser: idUser ?? this.idUser,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      type: type ?? this.type,
      quota: quota ?? this.quota,
      image: image ?? this.image,
      namaCategory: namaCategory ?? this.namaCategory,
      namaOrganisasi: namaOrganisasi ?? this.namaOrganisasi,
    );
  }
}
