class CuisineModel {
  String? id;
  String? storeTypeId;
  String? title;
  String? lowerTitle;
  String? addBy;
  String? arTitle;
  String? image;
  bool? isActive;
  bool? isDelete;
  String? createdAt;
  String? updatedAt;
  int? resturantCount;

  CuisineModel({
    this.id,
    this.storeTypeId,
    this.title,
    this.lowerTitle,
    this.addBy,
    this.arTitle,
    this.image,
    this.isActive,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
    this.resturantCount,
  });

  CuisineModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    storeTypeId = json['storeTypeId'];
    title = json['title'];
    lowerTitle = json['lower_title'];
    addBy = json['addBy'];
    arTitle = json['ar_title'];
    image = json['image'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    resturantCount = json['resturantCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['storeTypeId'] = storeTypeId;
    data['title'] = title;
    data['lower_title'] = lowerTitle;
    data['addBy'] = addBy;
    data['ar_title'] = arTitle;
    data['image'] = image;
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['resturantCount'] = resturantCount;
    return data;
  }
}
