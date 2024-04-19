// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:productive_families/main.dart';
import 'package:productive_families/presentation/screens/order/model/order.dart';
import 'package:productive_families/presentation/screens/product/products_card.dart';

class OrderInformationScreen extends StatelessWidget {
  final OrderModel orderModel;
  const OrderInformationScreen({
    Key? key,
    required this.orderModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
          title: Text(
            language.orderDetails,
          ),
          backgroundColor: Colors.green),
      body: Column(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "${language.date}:",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Expanded(
                    flex: 2, child: Text(orderModel.date!.substring(0, 10)))
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "${language.time}:",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Expanded(
                    flex: 2, child: Text(orderModel.date!.substring(11, 16)))
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "${language.orderStatus}:",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Expanded(flex: 2, child: Text(orderModel.status ?? ""))
              ],
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.separated(
              shrinkWrap: false,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductWidget(
                  product: orderModel.products![index],
                ),
              ),
              itemCount: orderModel.products!.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
