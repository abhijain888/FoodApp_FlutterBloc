class CheckHomeOrder {
  String? sId;
  double? distance;
  String? pickupDateTime;
  String? pickupTime;
  String? pickupDate;
  String? status;

  CheckHomeOrder(
      {this.sId,
      this.distance,
      this.pickupDateTime,
      this.pickupTime,
      this.pickupDate,
      this.status});

  CheckHomeOrder.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    distance = json['distance'];
    pickupDateTime = json['pickup_dateTime'];
    pickupTime = json['pickup_time'];
    pickupDate = json['pickup_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['distance'] = distance;
    data['pickup_dateTime'] = pickupDateTime;
    data['pickup_time'] = pickupTime;
    data['pickup_date'] = pickupDate;
    data['status'] = status;
    return data;
  }
}
