void setupConfigPage1(String token) {
  final pageConfig =
      appUrls.firstWhere((element) => element.typePage == PageType.page1);
  InitPage.configPageUrls(pageConfig);
  InitPage.configToken(token);
}

void setupConfigPage2(String token) {
  final pageConfig =
      appUrls.firstWhere((element) => element.typePage == PageType.page2);
  InitPage.configPageUrls(pageConfig);
  InitPage.configToken(token);
}

void setupConfigPage3(String token) {
  final pageConfig =
      appUrls.firstWhere((element) => element.typePage == PageType.page3);
  InitPage.configPageUrls(pageConfig);
  InitPage.configToken(token);
}

List<PageUrls> appUrls = [
  PageUrls(
    'https://ttdl-gateway.vnpt.vn/cong-dvc/v1/user/get-eform-by-id-app-congdvc',
    'https://ttdl-gateway.vnpt.vn/cong-dvc/v1/eform/get-by-id',
    PageType.page1,
  ),
  PageUrls(
    'https://ttdl-gateway.vnpt.vn/cong-dvc/v1/user/get-eform-by-id-app-congdvc',
    'https://ttdl-gateway.vnpt.vn/cong-dvc/v1/eform/get-by-id',
    PageType.page2,
  ),
  PageUrls(
    'https://ttdl-gateway.vnpt.vn/cong-dvc/v1/user/get-eform-by-id-app-congdvc',
    'https://ttdl-gateway.vnpt.vn/cong-dvc/v1/eform/get-by-id',
    PageType.page3,
  ),
];

class PageUrls {
  PageUrls(
    this.getFormJsonUrl,
    this.getMapDataUrl,
    this.typePage,
  );

  final String getFormJsonUrl;
  final String getMapDataUrl;
  final PageType typePage;
}

enum PageType {
  page1,
  page2,
  page3,
}

class InitPage {
  static PageUrls? pageUrls;
  static String? token;

  static void configPageUrls(PageUrls value) {
    pageUrls ??= value;
  }

  static void configToken(String value) {
    token ??= value;
  }
}
