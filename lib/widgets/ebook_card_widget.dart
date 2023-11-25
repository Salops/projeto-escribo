import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:projeto_escribo/models/downloading.dart';
import 'package:projeto_escribo/models/ebook.dart';
import 'package:projeto_escribo/theme/app_colors.dart';
import 'package:projeto_escribo/widgets/vertical_spacing.dart';
import 'package:shimmer/shimmer.dart';

class EbookCardWiget extends StatelessWidget {
  final bool bookmark;
  final Ebook eBook;
  final Downloading downloading;
  final Function(int id) onAdd;
  final Function(int id) onDelete;
  final Future Function(Ebook eBook) onOpen;
  final Future Function(Ebook eBook) onDownload;

  const EbookCardWiget({
    required this.eBook,
    required this.bookmark,
    required this.onAdd,
    required this.onOpen,
    required this.onDelete,
    required this.onDownload,
    required this.downloading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(eBook),
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              width: constraints.maxWidth / 2 - 8,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 50,
                      spreadRadius: -10,
                      offset: const Offset(0, 20),
                    )
                  ]),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LayoutBuilder(builder: (context, constraints) {
                        return CachedNetworkImage(
                          imageUrl: eBook.coverUrl,
                          fit: BoxFit.cover,
                          width: constraints.maxWidth,
                          height: constraints.maxWidth * 3 / 2,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: AppColors.light,
                            highlightColor: AppColors.lighther,
                            child: Container(
                              width: constraints.maxWidth,
                              height: constraints.maxWidth * 3 / 2,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: constraints.maxWidth,
                            height: constraints.maxWidth * 3 / 2,
                            color: AppColors.light,
                            child: const Icon(
                              Icons.image_not_supported_outlined,
                              size: 40,
                              color: AppColors.medium,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 106,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const VerticalSpacing(spacing: 16),
                        Text(
                          eBook.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const VerticalSpacing(spacing: 4),
                        Text(
                          eBook.author,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 4,
              top: 4,
              child: Observer(builder: (_) {
                return InkWell(
                    onTap: () =>
                        bookmark ? onDelete(eBook.id) : onAdd(eBook.id),
                    child: Icon(
                      bookmark ? Icons.bookmark : Icons.bookmark_border,
                      size: 32,
                      color: bookmark ? AppColors.error : AppColors.light,
                    ));
              }),
            ),
            Positioned(
                right: 4,
                bottom: 8,
                child: InkWell(
                    onTap: downloading.loading && downloading.id == eBook.id
                        ? null
                        : () => onDownload(eBook),
                    child: Icon(
                        downloading.loading && downloading.id == eBook.id
                            ? Icons.downloading_outlined
                            : Icons.file_download_outlined,
                        size: 32,
                        color: downloading.loading && downloading.id == eBook.id
                            ? AppColors.success
                            : AppColors.darker))),
          ],
        );
      }),
    );
  }
}
