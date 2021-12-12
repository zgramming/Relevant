import 'package:hive/hive.dart';

import '../model/event/event_bookmark_model.dart';

class EventLocalDataSource {
  const EventLocalDataSource({
    required this.box,
  });
  final Box<EventBookmarkModel> box;

  Future<String> saveBookmark(EventBookmarkModel model) async {
    await box.put(model.id, model);
    return 'Berhasil menambahkan ${model.title} ke bookmark';
  }

  Future<String> deleteBookmark(int id) async {
    await box.delete(id);
    return 'Berhasil menghapus dari bookmark';
  }

  List<EventBookmarkModel> fetchBookmark() {
    return box.values.toList();
  }
}
