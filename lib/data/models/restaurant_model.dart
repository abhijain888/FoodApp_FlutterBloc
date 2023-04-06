// ignore_for_file: public_member_api_docs, sort_constructors_first
class RestaurantModel {
  String? id;
  String? vendorId;
  String? branchName;
  String? fullAddress;
  String? city;
  String? image;
  num? rating;
  bool? favourite;
  bool? nearRestaurantAvailable;
  bool? isActive;
  bool? onlineStatus;
  num? hightItemAmount;
  Offer? offer;
  List<Cuisinee>? cuisinee;
  num? lat;
  num? lng;
  num? dictance;

  RestaurantModel({
    this.id,
    this.vendorId,
    this.branchName,
    this.fullAddress,
    this.city,
    this.image,
    this.rating,
    this.favourite,
    this.nearRestaurantAvailable,
    this.isActive,
    this.onlineStatus,
    this.hightItemAmount,
    this.offer,
    this.cuisinee,
    this.lat,
    this.lng,
    this.dictance,
  });

  RestaurantModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    vendorId = json['vendorId'];
    branchName = json['branchName'];
    fullAddress = json['fullAddress'];
    city = json['city'];
    image = json['image'];
    rating = json['rating'];
    favourite = json['favourite'];
    nearRestaurantAvailable = json['near_restaurantAvailable'];
    isActive = json['isActive'];
    onlineStatus = json['online_status'];
    hightItemAmount = json['hightItemAmount'];
    offer = json['offer'] != null ? Offer.fromJson(json['offer']) : null;
    if (json['cuisinee'] != null) {
      cuisinee = <Cuisinee>[];
      json['cuisinee'].forEach((v) {
        cuisinee?.add(Cuisinee.fromJson(v));
      });
    }
    lat = json['lat'];
    lng = json['lng'];
    dictance = json['dictance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['vendorId'] = vendorId;
    data['branchName'] = branchName;
    data['fullAddress'] = fullAddress;
    data['city'] = city;
    data['image'] = image;
    data['rating'] = rating;
    data['favourite'] = favourite;
    data['near_restaurantAvailable'] = nearRestaurantAvailable;
    data['isActive'] = isActive;
    data['online_status'] = onlineStatus;
    data['hightItemAmount'] = hightItemAmount;
    if (offer != null) {
      data['offer'] = offer?.toJson();
    }
    if (cuisinee != null) {
      data['cuisinee'] = cuisinee?.map((v) => v.toJson()).toList();
    }
    data['lat'] = lat;
    data['lng'] = lng;
    data['dictance'] = dictance;
    return data;
  }

  RestaurantModel likeRestaurant({
    String? id,
    String? vendorId,
    String? branchName,
    String? fullAddress,
    String? city,
    String? image,
    num? rating,
    bool? favourite,
    bool? nearRestaurantAvailable,
    bool? isActive,
    bool? onlineStatus,
    num? hightItemAmount,
    Offer? offer,
    List<Cuisinee>? cuisinee,
    num? lat,
    num? lng,
    num? dictance,
  }) {
    return RestaurantModel(
      id: id ?? this.id,
      vendorId: vendorId ?? this.vendorId,
      branchName: branchName ?? this.branchName,
      fullAddress: fullAddress ?? this.fullAddress,
      city: city ?? this.city,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      favourite: favourite ?? this.favourite,
      nearRestaurantAvailable:
          nearRestaurantAvailable ?? this.nearRestaurantAvailable,
      isActive: isActive ?? this.isActive,
      onlineStatus: onlineStatus ?? this.onlineStatus,
      hightItemAmount: hightItemAmount ?? this.hightItemAmount,
      offer: offer ?? this.offer,
      cuisinee: cuisinee ?? this.cuisinee,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      dictance: dictance ?? this.dictance,
    );
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

class Cuisinee {
  String? id;
  String? title;
  String? arTitle;
  String? storeTypeId;
  String? image;
  String? lowerTitle;
  bool? isActive;
  bool? isDelete;
  String? createdAt;
  String? updatedAt;

  Cuisinee({
    this.id,
    this.title,
    this.arTitle,
    this.storeTypeId,
    this.image,
    this.lowerTitle,
    this.isActive,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
  });

  Cuisinee.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    arTitle = json['ar_title'];
    storeTypeId = json['storeTypeId'];
    image = json['image'];
    lowerTitle = json['lower_title'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['ar_title'] = arTitle;
    data['storeTypeId'] = storeTypeId;
    data['image'] = image;
    data['lower_title'] = lowerTitle;
    data['isActive'] = isActive;
    data['isDelete'] = isDelete;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
