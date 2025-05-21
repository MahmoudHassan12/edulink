import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:flutter/material.dart';

class QAForumAppBar extends StatelessWidget {
  const QAForumAppBar({super.key});
  @override
  Widget build(BuildContext context) => SliverAppBar(
    title: const EText('Q&A Forum'),
    expandedHeight: MediaQuery.sizeOf(context).height * 0.3,
    flexibleSpace: FlexibleSpaceBar(
      titlePadding: EdgeInsets.zero,
      // title: const ListTile(
      //   // subtitle: EText(
      //   //   'Ask questions and get instant answers.\n'
      //   //   'Engage in discussions with professors and students.\n'
      //   //   'Stay updated with the latest course announcements.',
      //   //   style: TextStyle(height: 2),
      //   //   softWrap: true,
      //   // ),
      // ),
      background: CachedNetworkImage(
        imageUrl:
            'https://s3-alpha-sig.figma.com/img/bd66/c69e/40464c0d1d8ac792277c082db1450a30?Expires=1745193600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Y4iH71wfhZUg45PCGEEzotEaBEC~PeIEgmxjiHGz7zoQb8gcacdSlg2YYB0gekMZsWBYxPrZGUZrJXnRTLWSP~HEZ5HWt-EyNnLkL6uxN4rbaz-QviEvAnJi-yY18Dc3h3ZnJgx2XTtIapl3~WOeCaYxTXLxC0~bDELL4XbBB2ExwpUCp8vC3CZPHBNeIaD8GRXPOzWxk3XsrWdGHJUAAlAPoxHpObGcWWDNMLnS90mNu~2IlS0Oblgbd9Gsse25iB9JrXGBPnxue7qp2NYIYdbcLjyRgmiaRIgJENQ2R6QK3h2FrlezuAB3zvYRFTDi03b5mdAUp8i~CyF-YRWF7g__',
        fit: BoxFit.cover,
        color: Colors.black.withAlpha(100),
        colorBlendMode: BlendMode.darken,
      ),
      centerTitle: false,
      expandedTitleScale: 1,
    ),
    shape: const RoundedSuperellipseBorder(
      borderRadius: BorderRadius.all(Radius.circular(100)),
    ),
  );
}
