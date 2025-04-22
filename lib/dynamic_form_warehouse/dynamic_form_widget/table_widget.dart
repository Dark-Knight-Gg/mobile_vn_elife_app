import 'package:flutter/material.dart';
import 'package:form_io_builder/widgets/Form_widget.dart';

Widget table(Item, map, {show = false}) {
  return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Table(
        defaultColumnWidth: const IntrinsicColumnWidth(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(
            color: Colors.black26, width: 0.5, style: BorderStyle.solid),
        children: Item['rows']
            .map<TableRow>((e) => TableRow(
                children: e
                    .map<Widget>((es) => Padding(
                          padding: const EdgeInsets.only(bottom: 8, top: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: FormListWedgit(es['components'], map,
                                pType: 1, show: show),
                          ),
                        ))
                    .toList()))
            .toList(),
      ));
}

Widget tableShow(Item, map, {show = false}) {
  return Column(
    children: Item['rows']
        .map<Widget>((e) => Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            //    verticalDirection: VerticalDirection.down,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            runSpacing: 5.0,
            children: e
                .map<Widget>((es) => Container(
                      // width: 200,
                      padding: const EdgeInsets.only(bottom: 8, top: 8),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        // direction: Axis.horizontal,
                        verticalDirection: VerticalDirection.down,
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        runSpacing: 0.0,

                        children: FormListWedgit(es['components'], map,
                            pType: 2, show: show),
                      ),
                    ))
                .toList()))
        .toList(),
  );
}
