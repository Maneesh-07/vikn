class SaleItem {
  final int index;
  final String id;
  final String voucherNo;
  final String date;
  final String ledgerName;
  final double totalGrossAmtRounded;
  final double totalTaxRounded;
  final double grandTotalRounded;
  final String customerName;
  final double totalTax;
  final String status;
  final double grandTotal;
  final bool isBillWised;
  final String billwiseStatus;

  SaleItem({
    required this.index,
    required this.id,
    required this.voucherNo,
    required this.date,
    required this.ledgerName,
    required this.totalGrossAmtRounded,
    required this.totalTaxRounded,
    required this.grandTotalRounded,
    required this.customerName,
    required this.totalTax,
    required this.status,
    required this.grandTotal,
    required this.isBillWised,
    required this.billwiseStatus,
  });

  factory SaleItem.fromJson(Map<String, dynamic> json) {
    return SaleItem(
      index: json['index'],
      id: json['id'],
      voucherNo: json['VoucherNo'],
      date: json['Date'],
      ledgerName: json['LedgerName'],
      totalGrossAmtRounded: json['TotalGrossAmt_rounded'].toDouble(),
      totalTaxRounded: json['TotalTax_rounded'].toDouble(),
      grandTotalRounded: json['GrandTotal_Rounded'].toDouble(),
      customerName: json['CustomerName'],
      totalTax: json['TotalTax'].toDouble(),
      status: json['Status'],
      grandTotal: json['GrandTotal'].toDouble(),
      isBillWised: json['is_billwised'],
      billwiseStatus: json['billwise_status'],
    );
  }
}
