class ReportModel {
  int? offersCount;
  int? pendingReservationsCount;
  int? completedReservationsCount;
  int? totalReservations;
  int? totalSales;
  dynamic totalIncome;

  ReportModel(
      {this.offersCount,
        this.pendingReservationsCount,
        this.completedReservationsCount,
        this.totalReservations,
        this.totalSales,
        this.totalIncome});

  ReportModel.fromJson(Map<String, dynamic> json) {
    offersCount = json['offersCount'];
    pendingReservationsCount = json['pendingReservationsCount'];
    completedReservationsCount = json['completedReservationsCount'];
    totalReservations = json['total_reservations'];
    totalSales = json['totalSales'];
    totalIncome = json['totalIncome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offersCount'] = this.offersCount;
    data['pendingReservationsCount'] = this.pendingReservationsCount;
    data['completedReservationsCount'] = this.completedReservationsCount;
    data['total_reservations'] = this.totalReservations;
    data['totalSales'] = this.totalSales;
    data['totalIncome'] = this.totalIncome;
    return data;
  }
}