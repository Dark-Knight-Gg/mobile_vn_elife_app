import 'package:flutter/material.dart';

import 'dynamic_form_gen_page_type/form_screen.dart';
import 'dynamic_form_gen_page_type/wizard.dart';

class PageBuilder extends StatelessWidget {
  Map<String, dynamic>? formData;
  Map<String, dynamic>? mapAnswers;
  String? title;
  Color? backgroundBodyColor;

  PageBuilder({
    super.key,
    this.formData,
    this.title,
    this.mapAnswers,
    this.backgroundBodyColor,
  });

  @override
  Widget build(BuildContext context) {
    return formPage();
  }

  Widget formPage() {
    if (formData != null) {
      switch (formData?['display']) {
        case 'wizard':
          return Wizard(
            title: title,
            pages: formData!['components'],
            mapAnswers: mapAnswers,
            backgroundBodyColor: backgroundBodyColor,
          );

        case 'form':
          return FormScreen(
            title: title,
            formdata: formData!['components'],
            mapAnswers: mapAnswers,
          );
      }
    }
    return const SizedBox(
      child: Text('Not Found Form Type'),
    );
  }
}
