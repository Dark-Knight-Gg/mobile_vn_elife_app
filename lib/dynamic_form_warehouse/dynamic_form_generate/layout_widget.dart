import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_io_builder/styles/theme_app.dart';
import 'package:form_io_builder/utils/utils.dart';

import 'data_builder.dart';

Widget columns(
  Item,
  map,
  StreamController<dynamic> streamController, {
  show = false,
}) {
  return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (Item['columns'] != null && Item['columns'].length > 0)
          for (var colum in Item['columns'])
            Wrap(
              spacing: 0.0,
              crossAxisAlignment: WrapCrossAlignment.start,
              // direction: Axis.horizontal,
              verticalDirection: VerticalDirection.down,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              runSpacing: 0.0,
              children: dataBuilder(
                colum['components'],
                map,
                streamController,
                pType: 2,
                show: show,
              ),
            ),
      ]);
}

Widget panel(
  Item,
  map,
  StreamController<dynamic> streamController, {
  show = false,
}) {
  return ExpansionTile(
    title: Text(
      "${Item['label'] != null ? Item['label'] : ''}",
      style: const TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 16,
          //color: const Color(0xff42487e),
          height: 1),
    ),
    maintainState: true,
    children: dataBuilder(
      Item['components'],
      map,
      streamController,
      pType: 2,
      show: show,
    ),
  );
}

Widget gridDataW(
  Item,
  Map<String, dynamic> map,
  StreamController<dynamic> streamController, {
  show = false,
}) {
  List<Map<String, dynamic>> listMap = [];
  printO(
      "Contains  ${Item["key"]}  ${map.containsKey(Item["key"])}   ${map[Item["key"]]}");

  StreamController stream = StreamController.broadcast();
  List<List<Widget>> listparent = [];
  if (map.containsKey(Item["key"]))
    //int i=0;
    for (int i = 0; i < (map[Item["key"]] as List).length; i++) {
      Map<String, dynamic> val = (map[Item["key"]] as List)[i];

      List<Widget> list = Item['components']!
          .map<Widget>((e) => widgetBuilder(
                e,
                val,
                streamController,
                2,
                show: show,
              ))
          .toList();

      listMap.add(val);

      listparent.add(list);
    }
  else {
    listMap.add(Map<String, dynamic>());
    List<Widget> list = Item['components']!
        .map<Widget>((e) => Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            child: Row(
                mainAxisSize: MainAxisSize.min,
              children: [
                widgetBuilder(
                  e,
                  listMap.first,
                  streamController,
                  1,
                  show: show,
                ),
              ],
            ),
          ),
        )
        .toList();
    // list.insert(0, IconButton(onPressed: (){}, icon: Icon(Icons.remove_circle)),);

    listparent.add(list);
  }

  Future.delayed(const Duration(milliseconds: 500), () {
    stream.add(listparent);
  });
  return FormBuilderField(
      name: Item['key'],
      // Item['key'],
      enabled: !show,
      onSaved: (value) {
        map[Item['key']] = listMap;
      },
      builder: (FormFieldState<dynamic> field) {
        field.value;
        return StreamBuilder(
            stream: stream.stream,
            builder: (context, snapshot) {
              return Column(
                  mainAxisSize: MainAxisSize.min,
                  //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (Item['hideLabel'] == null || !Item['hideLabel'])
                      Container(
                        padding: const EdgeInsets.only(
                            bottom: 5.0, right: 8.0, left: 8.0, top: 5.0),
                        child: Text(
                          "${Item['hideLabel'] != null && Item['hideLabel'] ? '' : Item['label']}",
                          style: const TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 14,
                              //color: const Color(0xff42487e),
                              height: 1),
                        ),
                      ),

                    // for (List<Widget> list in snapshot)
                    if (snapshot.hasData && snapshot.data != null)
                      for (List<Widget> list
                          in (snapshot.data as List<List<Widget>>))
                        Container(
                          margin: const EdgeInsets.only(
                            top: 5.0,
                            right: 5,
                            left: 5,
                            bottom: 10,
                          ),
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: ThemeApp!.borderColor, width: 1)),
                          child: Wrap(
                            spacing: 5.0,
                            children: list,

                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.horizontal,
                            //    verticalDirection: VerticalDirection.down,
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.start,
                            runSpacing: 5.0,
                          ),
                        ),

                    //  settingRes.formTypeShow.value?SizedBox():
                    Item['disableAddingRemovingRows'] != true
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CupertinoButton(
                                  color: ThemeApp!.primaryColor,
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  onPressed: () {
                                    listMap.add(Map<String, dynamic>());
                                    //   map[Item['key']]=listMap;
                                    listparent.add(Item['components']!
                                        .map<Widget>((e) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8, top: 8),
                                            child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  widgetBuilder(
                                                    e,
                                                    listMap.last,
                                                    streamController,
                                                    1,
                                                    row: listparent.length,
                                                  )
                                                ])))
                                        .toList());
                                    stream.add(listparent);
                                  },
                                  child: Text(
                                    "${Item['addAnother']}",
                                    style: ThemeApp?.buttonTextStyle,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Item['disableAddingRemovingRows'] != true &&
                                        listparent.length > 1
                                    ? CupertinoButton(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                        ),
                                        color: Colors.redAccent,
                                        onPressed: () {
                                          listMap
                                              .removeLast(); //.add(new Map<String,dynamic>());
                                          listparent.removeLast();

                                          stream.add(listparent);
                                        },
                                        child: Text(
                                          "delete",
                                          style: ThemeApp?.buttonTextStyle,
                                        ),
                                        // style: ButtonStyle(
                                        //     backgroundColor:
                                        //         MaterialStateProperty.all(
                                        //             Colors.redAccent)),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          )
                        : const SizedBox()
                  ]);
            });
      });
}

Widget taps(
  Item,
  map,
  StreamController<dynamic> streamController, {
  show = false,
}) {
  return TabBar(
      tabs: Item["components"].length < 1
          ? []
          : Item["components"]
              .map<Widget>(
                (e) => panel(
                  e,
                  map,
                  streamController,
                  show: show,
                ),
              )
              .toList());
}

Widget fieldSet(
  Item,
  map,
  StreamController<dynamic> streamController, {
  show = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
        //    width: config.App(settingRes.navigatorKey.currentContext).appWidth(60),
        child: Text(
            "${Item['legend'] != null && Item['legend'].toString().isNotEmpty ? Item['legend'] : Item['label'] != null ? Item['label'] : ''}",
            style: ThemeApp?.headline1),
      ),
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
        children: dataBuilder(
          Item['components'],
          map,
          streamController,
          pType: 2,
          show: show,
        ),
      ),
    ],
  ); //FormListWedgit(Item['components'], map, pType: 2),
  // maintainState: true,
  //);
  //return Column(children: FormListWedgit(Item['components'], map, pType: 2));
}
