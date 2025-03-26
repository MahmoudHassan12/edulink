import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:flutter/material.dart';

class QAForumViewBody extends StatelessWidget {
  const QAForumViewBody({super.key});
  @override
  CustomScrollView build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverAppBar(
        expandedHeight: MediaQuery.sizeOf(context).height * 0.25,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.zero,
          title: const ListTile(
            title: EText('Q&A Forum\n'),
            subtitle: EText(
              'Ask questions and get instant answers.\n'
              'Engage in discussions with professors and students.\n'
              'Stay updated with the latest course announcements.',
              style: TextStyle(height: 2),
              softWrap: true,
            ),
          ),
          background: CachedNetworkImage(
            imageUrl:
                'https://s3-alpha-sig.figma.com/img/bd66/c69e/40464c0d1d8ac792277c082db1450a30?Expires=1743984000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=bOE9sV~vY6f8hmod-FYKGUInUR67ChZTY3yx7siq9b7K5ZI9FQIoYTNfp5gnJW4QgdiMmZpOc2OTd25te4oVD~bTxzOs1rvTmEOZPDkanOKRKZ9MKqwuNsolPk7b0ZlgmS31947BAoDnnXzdlqJENZfA-Rc8qA7zMsUl~8kxXB1-sGfpEczn4qZiotg7-Q1SIhripfqRpv1EDmW9f--HI88HrurQ4pVQ639Vv7fAMCuMVjBtVpAXdTLgSeK3HhmGya-4ci8Cb9SKXFUxkjpefuWjfV1B1PfL6mxL-vTALPoLGLGV6es-5WhLnJ7FzqI0QYtu71aTj6AoVbS2V-sVYA__',
            fit: BoxFit.cover,
          ),
          centerTitle: false,
          expandedTitleScale: 1,
        ),
      ),
      const SliverToBoxAdapter(child: EText('Q&A Forum')),
    ],
  );
}
