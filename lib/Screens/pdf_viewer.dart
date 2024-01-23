import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:yaseen/Theme/colors.dart';

class PDFViewerFromAsset extends StatefulWidget {
  PDFViewerFromAsset({Key? key, required this.pdfAssetPath}) : super(key: key);
  final String pdfAssetPath;

  @override
  State<PDFViewerFromAsset> createState() => _PDFViewerFromAssetState();
}

class _PDFViewerFromAssetState extends State<PDFViewerFromAsset> {
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();

  final StreamController<String> _pageCountController =
      StreamController<String>();

  bool value = false;
  bool isNightMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          (value) ? MyColors.backgroundDark : MyColors.backgroundLight,
      appBar: AppBar(
        shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          null,
          0,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        title: Text(
          'Surah Yaseen',
          style: TextStyle(
              fontSize: 18, color: Theme.of(context).colorScheme.outline),
        ),
        toolbarHeight: 50,
        //centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          SizedBox(
              height: 30,
              width: 50,
        ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: Container(
        child: PDF(
          nightMode: isNightMode,
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: false,
          pageFling: false,
          onPageChanged: (int? current, int? total) =>
              _pageCountController.add('${current! + 1} - $total'),
          onViewCreated: (PDFViewController pdfViewController) async {
            _pdfViewController.complete(pdfViewController);
            final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
            final int? pageCount = await pdfViewController.getPageCount();
            _pageCountController.add('${currentPage + 1} - $pageCount');
          },
        ).fromAsset(
          widget.pdfAssetPath,
          errorWidget: (dynamic error) => Center(child: Text(error.toString())),
        ),
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _pdfViewController.future,
        builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: '-',
                  child: Text(
                    '-',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.outline),
                  ),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data!;
                    final int currentPage =
                        (await pdfController.getCurrentPage())! - 1;
                    if (currentPage >= 0) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
                FloatingActionButton(
                  heroTag: '+',
                  child: Text(
                    '+',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.outline),
                  ),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data!;
                    final int currentPage =
                        (await pdfController.getCurrentPage())! + 1;
                    final int numberOfPages =
                        await pdfController.getPageCount() ?? 0;
                    if (numberOfPages > currentPage) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
