import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String isim;

  @HiveField(1)
  bool yapildi;

  @HiveField(2)
  int oncelik;

  @HiveField(3)
  DateTime tarih;

  Task({
    required this.isim,
    required this.yapildi,
    required this.oncelik,
    required this.tarih,
  });
}