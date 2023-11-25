import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:projeto_escribo/mixins/home_screen_mixin.dart';

import 'package:projeto_escribo/store/bookmarks.store.dart';
import 'package:projeto_escribo/theme/app_colors.dart';
import 'package:projeto_escribo/widgets/app_bar_widget.dart';
import 'package:projeto_escribo/widgets/bottom_bar_item_widget.dart';
import 'package:projeto_escribo/widgets/ebook_card_widget.dart';
import 'package:projeto_escribo/widgets/loading_widget.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with HomeScreenMixin {
  @override
  Widget build(BuildContext context) {
    BookmarksStore bookmarksStore = Provider.of<BookmarksStore>(context);

    return Scaffold(
      appBar: AppBarWidget(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              spreadRadius: -10,
              blurRadius: 20,
              offset: const Offset(0, -20),
            ),
          ],
        ),
        child: Row(
          children: [
            BottomBarItemWidget(
              label: 'Livros',
              active: activeTab == 'home',
              icon: 'assets/images/home.svg',
              onClick: () {
                setState(() {
                  activeTab = 'home';
                });
              },
            ),
            BottomBarItemWidget(
              label: 'Favoritos',
              active: activeTab == 'bookmarks',
              icon: 'assets/images/bookmarks.svg',
              onClick: () {
                setState(() {
                  activeTab = 'bookmarks';
                });
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: AppColors.light,
          child: loading
              ? LoadingWidget()
              : RefreshIndicator(
                  onRefresh: fetchBooks,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Observer(builder: (_) {
                        return Wrap(
                          runSpacing: 16,
                          spacing: 16,
                          children: getEbooks(bookmarksStore.bookmarks, ebooks)
                              .map((eBook) => EbookCardWiget(
                                  eBook: eBook,
                                  bookmark: isBookmark(
                                      bookmarksStore.bookmarks, eBook.id),
                                  onAdd: (id) => bookmarksStore.addBookmark(id),
                                  onOpen: (value) => openEbook(value),
                                  onDelete: (id) =>
                                      bookmarksStore.deleteBookmark(id),
                                  onDownload: (value) => downloadEbook(value),
                                  downloading: downloading))
                              .toList(),
                        );
                      }),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
