// ignore_for_file: must_be_immutable, use_build_context_synchronously, avoid_print
import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rxdart/rxdart.dart';
import '../../dynamic_form_features/dynamic_form_utilities/color_app.dart';
import 'core_dialog.dart';
import 'core_text.dart';

class ListenInternet extends StatefulWidget {
  const ListenInternet({super.key, required this.body});

  final Widget body;

  @override
  State<ListenInternet> createState() => _ListenInternetState();
}

class _ListenInternetState extends State<ListenInternet> {
  StreamSubscription<List<ConnectivityResult>>? subscription;

  @override
  initState() {
    super.initState();
    if (subscription != null) {
      subscription!.cancel();
    } else {
      subscription = Connectivity()
          .onConnectivityChanged
          .listen((List<ConnectivityResult> result) {
        // Got a new connectivity status!
        checkInternet();
      });
    }
    checkInternet();
  }

  checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com.vn');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // Co mang roi
      }
    } on SocketException catch (_) {
      try {
        final resultBaseUrl =
        await InternetAddress.lookup("gateway-union.vnpt.vn");
        if (resultBaseUrl.isNotEmpty &&
            resultBaseUrl[0].rawAddress.isNotEmpty) {
          // Co mang roi
        }
      } on SocketException catch (_) {
        print('not connected');
        OneUiDialog.showDialogByType(
            context: context,
            type: DIALOG_ERROR,
            title: "Thông báo",
            titleAction: "Đóng",
            content: 'Không có internet!',
            buttonCallback: () async {});
      }
    }
  }

// Be sure to cancel subscription after you are done
  @override
  dispose() {
    super.dispose();
    if (subscription != null) {
      subscription!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.body;
  }
}

class BaseScreen extends StatelessWidget {
  Widget body;
  late String title;
  late Color backgroundColorBody;
  final VoidCallback? onLeftTap;
  late bool hideLeftIcon;
  late bool hideSearchBar;
  late IconData leftIcon;
  final VoidCallback? onRightTap;
  final VoidCallback? onCloseSearchBar;
  final Function(String value)? onSubmitSearch;
  late bool hideRightIcon;
  late IconData rightIcon;
  late Widget? drawer;
  late Widget? leading;
  late Widget? rightIconWidget;
  final bool isTouchDrawer;
  final bool showAppBar;
  late List<Widget>? actions;
  late Widget? floatingActionButton;
  final GlobalKey<ScaffoldState>? keyBase;
  Widget? formSave;
  late bool resizeToAvoidBottomInset;
  late bool pressBack;
  late int? maxLineTitleNav;
  final PreferredSizeWidget? customAppBar;

  final searchController = TextEditingController();
  final _textUpdates = StreamController<String>();
  final duration = const Duration(milliseconds: 500);

  BaseScreen({Key? key,
    this.keyBase,
    this.title = "",
    required this.body,
    this.onLeftTap,
    this.onRightTap,
    this.onCloseSearchBar,
    this.onSubmitSearch,
    this.isTouchDrawer = true,
    this.leftIcon = Icons.arrow_back_ios,
    this.hideLeftIcon = false,
    this.hideSearchBar = true,
    this.rightIcon = Icons.arrow_forward_ios,
    this.hideRightIcon = true,
    this.backgroundColorBody = Colors.white,
    this.drawer,
    this.actions,
    this.floatingActionButton,
    this.pressBack = false,
    this.maxLineTitleNav = 2,
    this.resizeToAvoidBottomInset = false,
    this.showAppBar = true,
    this.customAppBar,
    this.rightIconWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    formSave ??= WillPopScope(
      onWillPop: () async {
        if (onLeftTap != null) {
          onLeftTap!.call();
        } else {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        }
        return false;
      },
      // onWillPop: () async {
      //   pressBack ? onBackPressed(context) : null;
      //   return false;
      // },
      child: Scaffold(
        key: keyBase ?? GlobalKey(),

        endDrawerEnableOpenDragGesture: isTouchDrawer,
        drawerEnableOpenDragGesture: isTouchDrawer,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: backgroundColorBody,
        appBar: showAppBar
            ? (customAppBar != null)
            ? customAppBar
            : buildAppBar(context)
            : null,
        endDrawer: drawer,
        floatingActionButton: floatingActionButton ?? const SizedBox(),
        body: ProgressHUD(
          // padding: const EdgeInsets.all(16),
            backgroundColor: Colors.white,
            indicatorWidget: buildIndicator(),
            textStyle:
            const TextStyle(fontSize: 14, color: ColorApp.textDefault),
            child: SizedBox(
                height: double.infinity, child: ListenInternet(body: body))),
      ),
    );
    return formSave!;
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: SvgPicture.asset(
        'assets/images/ic_navi_bg.svg',
        package: 'cdv_utilities',
        height: double.infinity + 10,
        // width: double.infinity +10,
        fit: BoxFit.cover,
      ),
      bottom: PreferredSize(
        preferredSize: const Size(0.0, 0.0),
        child: hideSearchBar ? buildContentBar() : buildSearchBar(),
      ),
      // actions: actions,
    );
  }

  Widget buildContentBar() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Opacity(
                  opacity: hideLeftIcon ? 0.0 : 1.0,
                  child: IconButton(
                      onPressed: hideLeftIcon ? () {} : onLeftTap,
                      icon: Icon(leftIcon, color: Colors.white)),
                )
              ],
            ),
          ),
          // const Spacer(),
          Flexible(
              child: Text(title,
                  maxLines: maxLineTitleNav ?? 2,
                  overflow: TextOverflow.ellipsis,
                  style: OneUiText()
                      .getSemiBoldStyle(color: Colors.black, fontSize: 16))),
          // const Spacer(),
          SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Opacity(
                  opacity: hideRightIcon ? 0.0 : 1.0,
                  child: rightIconWidget ??
                      IconButton(
                          onPressed: hideRightIcon ? () {} : onRightTap,
                          icon: Icon(
                            rightIcon,
                            color: Colors.white,
                          )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    searchController.addListener(_handleControllerChanged);
    _textUpdates.stream
        .distinct()
        .debounceTime(duration)
        .forEach(_onSubmitSearch);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: CupertinoSearchTextField(
              autofocus: true,
              controller: searchController,
              onSubmitted: _onSubmitSearch,
              padding: const EdgeInsets.all(8.0),
              placeholderStyle: OneUiText.hintTextStyle,
              placeholder: 'Nhập từ khóa',
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    _onCloseSearchBar();
                  },
                  child: const Text(
                    'Hủy',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return Container(
      padding: const EdgeInsets.all(4),
      width: 40.0,
      height: 40.0,
      child: const CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation(ColorApp.textDefault),
      ),
    );
  }

  void onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onSubmitSearch(String s) {
    if (onSubmitSearch != null) {
      onSubmitSearch!(s.trim());
    }
  }

  void _handleControllerChanged() {
    _textUpdates.add(searchController.text);
  }

  void _onCloseSearchBar() {
    searchController.removeListener(_handleControllerChanged);
    _textUpdates.close();
    if (onCloseSearchBar != null) {
      onCloseSearchBar!.call();
    }
  }
}
