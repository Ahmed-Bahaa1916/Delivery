import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/cubit_model.dart';
import '../../application/cubit_state.dart';
import '../widget/custom_header.dart';
import '../widget/custom_card.dart';
import 'order_other.dart';

class OrderNews extends StatefulWidget {
  const OrderNews({super.key});

  @override
  State<OrderNews> createState() => _OrderNewsState();
}

class _OrderNewsState extends State<OrderNews> {
  String selectedTab = "New"; // الافتراضي على New

  @override
  void initState() {
    super.initState();
    // جلب الطلبات عند بدء الشاشة
    context.read<OrderCubit>().fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomHeader(),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.symmetric(horizontal: 60),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = "New";
                      context.read<OrderCubit>().fetchOrders();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: selectedTab == "New"
                          ? const Color(0xff004F62)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        "New",
                        style: TextStyle(
                          color: selectedTab == "New"
                              ? Colors.white
                              : Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 70),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = "Others";
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => OrderOther()),
                      );
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: selectedTab == "Others"
                          ? const Color(0xff004F62)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        "Others",
                        style: TextStyle(
                          color: selectedTab == "Others"
                              ? Colors.white
                              : Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                if (state is OrderLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is OrderLoaded) {
                  final newOrders = state.orders
                      .where((order) => order.status == "0")
                      .toList();

                  if (newOrders.isEmpty) {
                    return const Center(child: Text("No new orders"));
                  }

                  return ListView.builder(
                    itemCount: newOrders.length,
                    itemBuilder: (context, index) {
                      final order = newOrders[index];
                      return CustomCard(
                        orderId: order.billSrl,
                        status: order.status,
                        totalPrice: order.totalPrice,
                        date: order.date,
                      );
                    },
                  );
                } else if (state is OrderError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
