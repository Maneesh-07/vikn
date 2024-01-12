import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vikn/core/color.dart';
import 'package:vikn/core/constants.dart';
import 'package:vikn/model/salesitem.dart';
import 'package:vikn/services/sales_list.dart';
import 'package:vikn/utils/appbarwidget.dart';

TextEditingController searchController = TextEditingController();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppbarWidget(title: 'Sales Estimate')),
      body: FutureProvider<List<SaleItem>>(
        create: (_) => DataListingProvider().getData(),
        initialData: const [],
        child: Consumer<List<SaleItem>>(
          builder: (context, saleItems, child) {
            if (saleItems.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: Color.fromARGB(255, 1, 43, 255),
                ),
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoSearchTextField(
                      controller: searchController,
                      backgroundColor: Colors.grey.withOpacity(0.4),
                      prefixIcon: const Icon(
                        CupertinoIcons.search,
                        color: Colors.grey,
                      ),
                      suffixIcon: const Icon(
                        CupertinoIcons.xmark_circle_fill,
                        color: Colors.grey,
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: saleItems.length,
                      itemBuilder: (context, index) {
                        final saleItem = saleItems[index];
                        return Container(
                          height: 120,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 47, 44, 44)
                                    .withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 1,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
                                            height: 30,
                                            width: 160,
                                            child: Text(
                                              '#Invoice No',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            )),
                                        // style: bookingPageTiltle,
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                            saleItem.status,
                                            style: ktextTitle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(
                                            height: 30,
                                            width: 160,
                                            child: Text(
                                              'Customer Name',
                                              style: ktextTitle,
                                            )),
                                        // style: bookingPageTiltle,
                                        // Flexible(
                                        //   flex: 1,
                                        //   child: Text(
                                        //     'SAR : ${saleItem.grandTotalRounded}',
                                        //     style: ktextTitle,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            height: 30,
                                            width: 160,
                                            child: Text(
                                              saleItem.ledgerName,
                                              style: ktextTitle,
                                            )),
                                        // style: bookingPageTiltle,
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                            'SAR : ${saleItem.grandTotalRounded}',
                                            style: ktextTitle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
