import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:projeto_escribo/models/downloading.dart';
import 'package:projeto_escribo/models/ebook.dart';
import 'package:projeto_escribo/screens/home_screen.dart';
import 'package:projeto_escribo/theme/app_colors.dart';
import 'package:projeto_escribo/utils/show_toast.dart';
import 'package:projeto_escribo/widgets/loading_widget.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

mixin HomeScreenMixin<T extends StatefulWidget> on State<HomeScreen> {
  String filePath = '';
  String activeTab = 'home';
  bool loading = false;
  Downloading downloading = Downloading(id: 0, loading: false);
  List<Ebook> ebooks = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await fetchBooks();
    });

    super.initState();
  }

  // Retorna livro de acordo com aba ativa
  List<Ebook> getEbooks(List<String> bookmarksId, List<Ebook> ebooks) {
    if (activeTab == 'home') {
      return ebooks;
    } else {
      List<Ebook> matchEbooks = ebooks
          .where((Ebook) => bookmarksId.contains(Ebook.id.toString()))
          .toList();

      return matchEbooks;
    }
  }

  // Verifica se o livro está favoritado
  bool isBookmark(List<String> bookmarksId, int ebookId) {
    return bookmarksId.contains(ebookId.toString());
  }

  // Donwload do livro
  Future downloadEbook(Ebook ebook) async {
    try {
      setState(() {
        downloading = Downloading(id: ebook.id, loading: true);
      });

      // Obtendo diretórios
      String iosPath = (await getApplicationDocumentsDirectory()).path;
      String androidPath = '/storage/emulated/0/Download';

      Directory androidDirectory = Directory(androidPath);
      if (Platform.isAndroid && !await androidDirectory.exists()) {
        final dir = await getExternalStorageDirectory();

        androidPath = dir!.path;
      }

      // Fazendo download do arquivo
      var request = await HttpClient().getUrl(Uri.parse(ebook.downloadUrl));
      var response = await request.close();

      final bytes = await consolidateHttpClientResponseBytes(response);

      // Salvando no dispositivo
      File file = await File(
              '${Platform.isAndroid ? androidPath : iosPath}/${ebook.title}.epub')
          .create(recursive: true);
      await file.writeAsBytes(bytes);

      showToast(context: context, message: 'Download concluído com sucesso!');
    } catch (_) {
      showToast(
          context: context,
          color: AppColors.error,
          message:
              'Ocorreu um erro ao fazer o download. Por favor, tente novamente.');
    } finally {
      setState(() {
        downloading = Downloading(id: 0, loading: false);
      });
    }
  }

  // Busca lista de livros
  Future fetchBooks() async {
    try {
      setState(() {
        loading = true;
      });

      const escriboApiUrl = "https://escribo.com/books.json";

      final client = Dio();
      Response response = await client.get(escriboApiUrl);
      setState(() {
        ebooks = (response.data as List)
            .map((json) => Ebook.fromJson(json))
            .toList();
      });
    } catch (e) {
      showToast(
          context: context,
          color: AppColors.error,
          message: 'Ocorreu um erro ao recuperar os dados.');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  // Abri livro para visualização
  Future openEbook(Ebook Ebook) async {
    try {
      await loadFile(Ebook);

      if (filePath != '') {
        VocsyEpub.setConfig(
          themeColor: AppColors.primary,
          scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
          allowSharing: true,
          enableTts: true,
        );

        VocsyEpub.open(
          filePath,
        );
      }
    } catch (e) {
      showToast(
          context: context,
          color: AppColors.error,
          message:
              'Ocorreu um erro ao abrir o livro. Por favor, tente novamente.');
    }
  }

  // Carrega filePath do livro
  loadFile(Ebook Ebook) async {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.black12,
          builder: (context) => LoadingWidget());

      final tempDir = await getApplicationDocumentsDirectory();

      String path = '${tempDir.path}/${Ebook.title}.epub';
      File file = File(path);

      await file.create();
      await Dio()
          .download(
        Ebook.downloadUrl,
        path,
        deleteOnError: true,
      )
          .whenComplete(() {
        setState(() {
          filePath = path;
        });
      });
      return file;
    } catch (error) {
      showToast(
          context: context,
          color: AppColors.error,
          message:
              'Ocorreu um erro ao carregar o livro. Por favor, tente novamente.');
    } finally {
      Navigator.of(context).pop();
    }
    return null;
  }
}
