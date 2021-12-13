import 'package:equatable/equatable.dart';

class MyEventQueryModel extends Equatable {
  const MyEventQueryModel({
    required this.dateTime,
  });

  final DateTime dateTime;

  @override
  bool get stringify => true;
  @override
  List<Object> get props => [dateTime];

  MyEventQueryModel copyWith({
    DateTime? dateTime,
  }) {
    return MyEventQueryModel(
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
