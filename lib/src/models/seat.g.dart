// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seat _$SeatFromJson(Map<String, dynamic> json) {
  return Seat(
    json['col'] as int,
    json['row'] as int,
    json['seatName'] as String,
  );
}

Map<String, dynamic> _$SeatToJson(Seat instance) => <String, dynamic>{
      'row': instance.row,
      'col': instance.col,
      'seatName': instance.seatName,
    };
