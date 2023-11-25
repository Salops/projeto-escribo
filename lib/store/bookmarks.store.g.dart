// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarks.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BookmarksStore on _BookmarksStore, Store {
  late final _$initDataAsyncAction =
      AsyncAction('_BookmarksStore.initData', context: context);

  @override
  Future initData() {
    return _$initDataAsyncAction.run(() => super.initData());
  }

  late final _$addBookmarkAsyncAction =
      AsyncAction('_BookmarksStore.addBookmark', context: context);

  @override
  Future addBookmark(int ebookId) {
    return _$addBookmarkAsyncAction.run(() => super.addBookmark(ebookId));
  }

  late final _$deleteBookmarkAsyncAction =
      AsyncAction('_BookmarksStore.deleteBookmark', context: context);

  @override
  Future deleteBookmark(int ebookId) {
    return _$deleteBookmarkAsyncAction.run(() => super.deleteBookmark(ebookId));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
