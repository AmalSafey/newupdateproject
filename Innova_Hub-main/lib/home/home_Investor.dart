import 'package:flutter/material.dart';
import 'package:innovahub_app/Custom_Widgets/Estimated_container.dart';
import 'package:innovahub_app/Custom_Widgets/container_investor.dart';
import 'package:innovahub_app/core/Api/get_table_forinvestor.dart';
import 'package:innovahub_app/core/Constants/Colors_Constant.dart';

class HomeInvestor extends StatefulWidget {
  const HomeInvestor({super.key});

  @override
  State<HomeInvestor> createState() => _HomeInvestorState();
}

class _HomeInvestorState extends State<HomeInvestor> {
  late Future<List<InvestorInvestment>> _futureInvestments;

  @override
  void initState() {
    super.initState();
    _futureInvestments = fetchInvestorInvestments();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Constant.mainColor,
            child: TextField(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                fillColor: Constant.whiteColor,
                filled: true,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Constant.greyColor2,
                ),
                hintText: 'Search any Product...',
                hintStyle:
                    const TextStyle(color: Constant.greyColor2, fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Constant.whiteColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Constant.whiteColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: Constant.whiteColor),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(13),
            child: Row(
              children: [
                Image.asset("assets/images/investor1.png"),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("User One ",
                          style: TextStyle(
                              color: Constant.blackColorDark,
                              fontSize: 18,
                              fontWeight: FontWeight.w400)),
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 10,
                              backgroundColor: Constant.blue3Color,
                              child: Icon(Icons.check,
                                  color: Constant.whiteColor, size: 18)),
                          SizedBox(width: 10),
                          Text('Verified',
                              style: TextStyle(
                                  color: Constant.greyColor3, fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID:2333669591',
                        style:
                            TextStyle(color: Constant.greyColor, fontSize: 15)),
                    SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
          const EstimatedContainer(),
          const Padding(
            padding: EdgeInsets.only(left: 14),
            child: Text(
              'Track your investments',
              style: TextStyle(
                  color: Constant.blackColorDark,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
          ),
          FutureBuilder<List<InvestorInvestment>>(
            future: _futureInvestments,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }

              final investments = snapshot.data!;

              if (investments.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'No investments for this investor',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                );
              }

              return Column(
                children: investments.map((investment) {
                  return ContainerInvestor(investment: investment);
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
