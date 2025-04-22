import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../dynamic_form_generate/data_builder.dart';
import '../dynamic_form_widget/base_screen.dart';
import '../dynamic_form_widget/core_text.dart';

class Wizard extends StatefulWidget {
  final pages;
  final mapAnswers;
  final title;
  final backgroundBodyColor;

  Wizard({
    super.key,
    this.pages,
    this.mapAnswers,
    this.title,
    this.backgroundBodyColor,
  });

  @override
  State<Wizard> createState() => _WizardState();
}

class _WizardState extends State<Wizard> {
  String? currentPageId;
  late Map<String, dynamic> _mapAnswers;

  final ScrollController customScrollController = ScrollController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final channel = MethodChannel('flutter_back_channel');

  List<dynamic> pages = [];
  double padding = 16.0;

  @override
  void initState() {
    _mapAnswers = widget.mapAnswers;
    if (widget.pages?.isNotEmpty ?? false) {
      pages = widget.pages!;
      currentPageId = widget.pages?.first['key'] ?? '0';
    }

    for (final fields in pages) {
      fields['wedgits'] = dataBuilder(
        fields?['components'] ?? [],
        _mapAnswers,
      );
    }

    super.initState();
  }

  void changePage(id) {
    setState(() {
      currentPageId = id;
      FocusScope.of(context).unfocus();
      customScrollController.animateTo(
        customScrollController.position.minScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
      );
      // formKey.currentState?.
    });
  }

  final GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      customAppBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        centerTitle: false,
        leading: InkWell(
          onTap: () {
/*            Navigator.pop(context);*/
            channel.invokeMethod('finishActivity');
          },
          child: const Icon(Icons.arrow_back, color: Color(0xffC10800)),
        ),
        titleSpacing: 0,
        title: OneUiText.textWidget(
          title: widget.title,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColorBody: widget.backgroundBodyColor,
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: CustomScrollView(
            controller: customScrollController,
            slivers: [
              SliverPadding(
                padding: EdgeInsets.only(
                    // bottom: 0),
                    bottom: MediaQuery.of(context).viewInsets.bottom * 0.5),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final fields in pages
                          .where((element) => element['key'] == currentPageId))
                        ...fields['wedgits']
                      //FormListWedgit(fields?['components']??[], widget.map)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
