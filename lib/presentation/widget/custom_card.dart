import 'package:flutter/material.dart';
import '../../core/constant.dart';
import 'custom_container.dart';


class CustomCard extends StatelessWidget {
  final String orderId;
  final String status;
  final double totalPrice;
  final String date;

  const CustomCard({
    super.key,
    required this.orderId,
    required this.status,
    required this.totalPrice,
    required this.date,
  });

  String _getStatusName(String status) {
    switch (status) {
      case "0":
        return 'New';
      case "1":
        return 'In Progress';
      case "2":
        return 'Delivered';
      default:
        return 'Returned';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "0":
        return Color(0xff29D40F);
      case "1":
        return Colors.blue;
      case "2":
        return Color(0xff707070);
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "#$orderId",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Status
                      CustomConatiner(
                        varible1: 'Status',
                        varible2: _getStatusName(status),
                        color: _getStatusColor(status),
                      ),
                      // Total Price
                      CustomConatiner(
                        varible1: 'Total Price',
                        varible2: "${totalPrice.toStringAsFixed(2)} LE",
                        color: AppThem.primary,
                      ),
                      // Date
                      CustomConatiner(
                        varible1: 'Date',
                        varible2: date,
                        color: AppThem.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 60,
            height: 100,
            decoration: const BoxDecoration(
              color: Color(0xff29D40F),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Order \nDetails",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 20,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
