import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_vn_elife_app/dynamic_form_warehouse/dynamic_form_event/map_change.dart';

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
/*  late Map<String, dynamic> _partnerMap;*/

  final ScrollController customScrollController = ScrollController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final channel = MethodChannel('flutter_back_channel');
  StreamController<dynamic> streamController =
      StreamController<dynamic>.broadcast();
  final GlobalKey key = GlobalKey();

  List<dynamic> pages = [];
  double padding = 16.0;

  void listenStream() {
    streamController.stream.listen((event) {
      if (event is MapChange) {
        final key = event.map.keys.first;
        final value = event.map.values.first;
        setState(() {
          _mapAnswers[key] = value;
        });
      }
    });
  }

  @override
  void initState() {
    _mapAnswers = widget.mapAnswers;
/*    getPartMap();*/
    listenStream();
    if (widget.pages?.isNotEmpty ?? false) {
      pages = widget.pages!;
      currentPageId = widget.pages?.first['key'] ?? '0';
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

/*  void getPartMap() {
    final formData =
        pages.firstWhere((element) => element['key'] == currentPageId ??);
    final fromJson = json.decode(formData);
    final partnerMapLinks = extractPartnerMap(fromJson);
    _partnerMap = partnerMapLinks;
  }*/

/*  Map<String, dynamic> extractPartnerMap(dynamic node) {
    final Map<String, dynamic> result = {};

    void recurse(dynamic node) {
      if (node is Map<String, dynamic>) {
        if (node.containsKey("key") && node.containsKey("partnerMap")) {
          final key = node["key"];
          final partnerMap = node["partnerMap"];
          if (key is String && partnerMap is String) {
            result[key] = partnerMap;
          }
        }

        node.forEach((k, v) => recurse(v));
      } else if (node is List) {
        for (var item in node) {
          recurse(item);
        }
      }
    }

    recurse(node);
    return result;
  }*/

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
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              channel.invokeMethod(
                'finishActivity',
                _mapAnswers,
              );
            }
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
        autovalidateMode: AutovalidateMode.disabled,
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
                            ...dataBuilder(
                              fields?['components'] ?? [],
                              _mapAnswers,
                              streamController,
                            ),
                          //FormListWedgit(fields?['components']??[], widget.map)
                        ],
                      ),
                  const SizedBox(
                    height: 20,
                  ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }
}
