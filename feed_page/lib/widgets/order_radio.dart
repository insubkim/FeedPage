import 'package:feed_page/models/filter_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderRadio extends StatelessWidget {
  const OrderRadio({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterModel>(
      builder: (context, filter, child) {
        EOrder order = filter.getOrder();
        return Row(
          children: [
            SizedBox(
              width: 20,
              child: Transform.scale(
                scale: 0.5,
                child: Radio(
                  value: EOrder.ascending,
                  groupValue: order,
                  onChanged: (value) {
                    order = EOrder.ascending;
                    filter.setOrder(order);
                  },
                ),
              ),
            ),
            GestureDetector(
              child: Text(
                '오름차순',
                style: TextStyle(
                    color: order == EOrder.ascending
                        ? Colors.black
                        : Colors.black.withOpacity(0.5)),
              ),
              onTap: () {
                order = EOrder.ascending;
                filter.setOrder(order);
              },
            ),
            SizedBox(
              width: 20,
              child: Transform.scale(
                scale: 0.5,
                child: Radio(
                  value: EOrder.descending,
                  groupValue: order,
                  onChanged: (value) {
                    order = EOrder.descending;
                    filter.setOrder(order);
                  },
                ),
              ),
            ),
            GestureDetector(
              child: Text(
                '내림차순',
                style: TextStyle(
                    color: order == EOrder.descending
                        ? Colors.black
                        : Colors.black.withOpacity(0.5)),
              ),
              onTap: () {
                order = EOrder.descending;
                filter.setOrder(order);
              },
            ),
          ],
        );
      },
    );
  }
}
