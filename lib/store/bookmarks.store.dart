import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'bookmarks.store.g.dart';

class BookmarksStore = _BookmarksStore with _$BookmarksStore;

abstract class _BookmarksStore with Store {
  final SharedPreferences preferences;
  _BookmarksStore(this.preferences) {
    initData();
  }

  ObservableList<String> bookmarks = ObservableList<String>();

  static const _keyBookmarks = 'bookmarks';

  @action
  initData() async {
    bookmarks = ObservableList<String>.of(
        preferences.getStringList(_keyBookmarks) ?? []);
  }

  @action
  addBookmark(int ebookId) async {
    bookmarks.add(ebookId.toString());
    await preferences.setStringList(_keyBookmarks, bookmarks);
  }

  @action
  deleteBookmark(int ebookId) async {
    final index = bookmarks.indexOf(ebookId.toString());
    bookmarks.removeAt(index);
    await preferences.setStringList(_keyBookmarks, bookmarks);
  }
}
