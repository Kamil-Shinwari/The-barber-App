class BookServicesModel {
  String? haircutm;
  String? bearedm;
  String? trimmingm;
  String? skincarem;
  String? facialm;
  String? treatmentm;
  String? maskm;
  String? curem;
  String? othersm;
  String? servicetimedatem;
  String? status;

  BookServicesModel(
      {this.haircutm,
      this.bearedm,
      this.trimmingm,
      this.skincarem,
      this.facialm,
      this.treatmentm,
      this.maskm,
      this.curem,
      this.othersm,
      this.servicetimedatem,
      this.status,
      });

  Map<String, dynamic> toMap() {
    return {
      'haircut': haircutm,
      'beared': bearedm,
      'trimming': trimmingm,
      'skincare': skincarem,
      'facial': facialm,
      'treatment': treatmentm,
      'mask': maskm,
      'cure': curem,
      'servicetimedate': servicetimedatem,
      'others': othersm,
      'status': status,
    };
  }
}
