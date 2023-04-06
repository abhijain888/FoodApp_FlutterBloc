class HomeOffer {
  String? id;
  String? addBy;
  String? image;
  String? couponCode;
  String? title;
  String? description;
  String? offerType;
  num? offerAmount;
  String? startDate;
  String? arTitle;
  String? arDescription;
  num? minimumAmount;
  num? uptoAmount;
  String? expiryDate;
  bool? isActive;
  bool? isDelete;
  String? createdAt;
  String? updatedAt;
  List<Storetypes>? storetypes;
  List<Vendorstores>? vendorstores;
  StoreTypeId? storeTypeId;

  HomeOffer(
      {this.id,
      this.addBy,
      this.image,
      this.couponCode,
      this.title,
      this.description,
      this.offerType,
      this.offerAmount,
      this.startDate,
      this.arTitle,
      this.arDescription,
      this.minimumAmount,
      this.uptoAmount,
      this.expiryDate,
      this.isActive,
      this.isDelete,
      this.createdAt,
      this.updatedAt,
      this.storetypes,
      this.vendorstores,
      this.storeTypeId});

  HomeOffer.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    addBy = json['addBy'];
    image = json['image'];
    couponCode = json['couponCode'];
    title = json['title'];
    description = json['description'];
    offerType = json['offer_type'];
    offerAmount = json['offer_amount'];
    startDate = json['startDate'];
    arTitle = json['ar_title'];
    arDescription = json['ar_description'];
    minimumAmount = json['minimum_amount'];
    uptoAmount = json['upto_Amount'];
    expiryDate = json['expiryDate'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['storetypes'] != null) {
      storetypes = <Storetypes>[];
      json['storetypes'].forEach((v) {
        storetypes!.add(Storetypes.fromJson(v));
      });
    }
    if (json['vendorstores'] != null) {
      vendorstores = <Vendorstores>[];
      json['vendorstores'].forEach((v) {
        vendorstores!.add(Vendorstores.fromJson(v));
      });
    }
    storeTypeId = json['storeTypeId'] != null
        ? StoreTypeId.fromJson(json['storeTypeId'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['addBy'] = addBy;
    data['image'] = image;
    data['couponCode'] = couponCode;
    data['title'] = title;
    data['description'] = description;
    data['offer_type'] = offerType;
    data['offer_amount'] = offerAmount;
    data['startDate'] = startDate;
    data['ar_title'] = arTitle;
    data['ar_description'] = arDescription;
    data['minimum_amount'] = minimumAmount;
    data['upto_Amount'] = uptoAmount;
    data['expiryDate'] = expiryDate;
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (storetypes != null) {
      data['storetypes'] = storetypes!.map((v) => v.toJson()).toList();
    }
    if (vendorstores != null) {
      data['vendorstores'] = vendorstores!.map((v) => v.toJson()).toList();
    }
    if (storeTypeId != null) {
      data['storeTypeId'] = storeTypeId!.toJson();
    }
    return data;
  }
}

class Storetypes {
  String? id;
  String? storeType;
  bool? isActive;
  bool? isDelete;
  String? createdAt;
  String? lowerName;
  String? image;
  String? updatedAt;
  String? arStoreType;

  Storetypes(
      {this.id,
      this.storeType,
      this.isActive,
      this.isDelete,
      this.createdAt,
      this.lowerName,
      this.image,
      this.updatedAt,
      this.arStoreType});

  Storetypes.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    storeType = json['storeType'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdAt = json['createdAt'];
    lowerName = json['lower_name'];
    image = json['image'];
    updatedAt = json['updatedAt'];
    arStoreType = json['ar_storeType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['storeType'] = storeType;
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['createdAt'] = createdAt;
    data['lower_name'] = lowerName;
    data['image'] = image;
    data['updatedAt'] = updatedAt;
    data['ar_storeType'] = arStoreType;
    return data;
  }
}

class Vendorstores {
  String? id;
  String? userId;
  String? image;
  String? branchName;
  String? fullAddress;
  num? rating;
  bool? onlineStatus;
  int? hightItemAmount;
  num? lat;
  num? lng;
  bool? isActive;
  String? arBranchName;
  List<double>? location;
  List<Cuisinee>? cuisinee;
  num? dictance;
  bool? favourite;
  Offer? offer;
  String? vendorId;
  bool? nearRestaurantAvailable;

  Vendorstores(
      {this.id,
      this.userId,
      this.image,
      this.branchName,
      this.fullAddress,
      this.rating,
      this.onlineStatus,
      this.hightItemAmount,
      this.lat,
      this.lng,
      this.isActive,
      this.arBranchName,
      this.location,
      this.cuisinee,
      this.dictance,
      this.favourite,
      this.offer,
      this.vendorId,
      this.nearRestaurantAvailable});

  Vendorstores.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    image = json['image'];
    branchName = json['branchName'];
    fullAddress = json['fullAddress'];
    rating = json['rating'];
    onlineStatus = json['online_status'];
    hightItemAmount = json['hightItemAmount'];
    lat = json['lat'];
    lng = json['lng'];
    isActive = json['isActive'];
    arBranchName = json['ar_branchName'];
    location = json['location'].cast<double>();
    if (json['cuisinee'] != null) {
      cuisinee = <Cuisinee>[];
      json['cuisinee'].forEach((v) {
        cuisinee!.add(Cuisinee.fromJson(v));
      });
    }
    dictance = json['dictance'];
    favourite = json['favourite'];
    offer = json['offer'] != null ? Offer.fromJson(json['offer']) : null;
    vendorId = json['vendorId'];
    nearRestaurantAvailable = json['near_restaurantAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['userId'] = userId;
    data['image'] = image;
    data['branchName'] = branchName;
    data['fullAddress'] = fullAddress;
    data['rating'] = rating;
    data['online_status'] = onlineStatus;
    data['hightItemAmount'] = hightItemAmount;
    data['lat'] = lat;
    data['lng'] = lng;
    data['isActive'] = isActive;
    data['ar_branchName'] = arBranchName;
    data['location'] = location;
    if (cuisinee != null) {
      data['cuisinee'] = cuisinee!.map((v) => v.toJson()).toList();
    }
    data['dictance'] = dictance;
    data['favourite'] = favourite;
    if (offer != null) {
      data['offer'] = offer!.toJson();
    }
    data['vendorId'] = vendorId;
    data['near_restaurantAvailable'] = nearRestaurantAvailable;
    return data;
  }
}

class Cuisinee {
  String? id;
  String? title;
  String? arTitle;
  String? image;
  String? lowerTitle;
  bool? isActive;
  bool? isDelete;
  String? createdAt;
  String? updatedAt;
  String? storeTypeId;

  Cuisinee(
      {this.id,
      this.title,
      this.arTitle,
      this.image,
      this.lowerTitle,
      this.isActive,
      this.isDelete,
      this.createdAt,
      this.updatedAt,
      this.storeTypeId});

  Cuisinee.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    arTitle = json['ar_title'];
    image = json['image'];
    lowerTitle = json['lower_title'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    storeTypeId = json['storeTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['ar_title'] = arTitle;
    data['image'] = image;
    data['lower_title'] = lowerTitle;
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['storeTypeId'] = storeTypeId;
    return data;
  }
}

class Offer {
  String? id;
  String? offerType;
  int? offerAmount;
  String? expiryDate;

  Offer({this.id, this.offerType, this.offerAmount, this.expiryDate});

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    offerType = json['offer_type'];
    offerAmount = json['offer_amount'];
    expiryDate = json['expiryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['offer_type'] = offerType;
    data['offer_amount'] = offerAmount;
    data['expiryDate'] = expiryDate;
    return data;
  }
}

class StoreTypeId {
  String? id;
  String? storeType;
  String? arStoreType;
  bool? isActive;

  StoreTypeId({this.id, this.storeType, this.arStoreType, this.isActive});

  StoreTypeId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    storeType = json['storeType'];
    arStoreType = json['ar_storeType'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['storeType'] = storeType;
    data['ar_storeType'] = arStoreType;
    data['isActive'] = isActive;
    return data;
  }
}
