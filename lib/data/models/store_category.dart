// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StoreCategory {
  String id;
  String storeType;
  bool isActive;
  bool isDelete;
  String createdAt;
  String lowerName;
  String updatedAt;
  String image;
  String arStoreType;

  StoreCategory({
    required this.id,
    required this.storeType,
    required this.isActive,
    required this.isDelete,
    required this.createdAt,
    required this.lowerName,
    required this.updatedAt,
    required this.image,
    required this.arStoreType,
  });

  StoreCategory copyWith({
    String? id,
    String? storeType,
    bool? isActive,
    bool? isDelete,
    String? createdAt,
    String? lowerName,
    String? updatedAt,
    String? image,
    String? arStoreType,
  }) {
    return StoreCategory(
      id: id ?? this.id,
      storeType: storeType ?? this.storeType,
      isActive: isActive ?? this.isActive,
      isDelete: isDelete ?? this.isDelete,
      createdAt: createdAt ?? this.createdAt,
      lowerName: lowerName ?? this.lowerName,
      updatedAt: updatedAt ?? this.updatedAt,
      image: image ?? this.image,
      arStoreType: arStoreType ?? this.arStoreType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'storeType': storeType,
      'isActive': isActive,
      'isDelete': isDelete,
      'createdAt': createdAt,
      'lower_name': lowerName,
      'updatedAt': updatedAt,
      'image': image,
      'ar_storeType': arStoreType,
    };
  }

  factory StoreCategory.fromMap(Map<String, dynamic> map) {
    return StoreCategory(
      id: map['_id'] as String,
      storeType: map['storeType'] as String,
      isActive: map['isActive'] as bool,
      isDelete: map['isDelete'] as bool,
      createdAt: map['createdAt'] as String,
      lowerName: map['lower_name'] as String,
      updatedAt: map['updatedAt'] as String,
      image: map['image'] as String,
      arStoreType: map['ar_storeType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreCategory.fromJson(String source) =>
      StoreCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StoreCategory(id: $id, storeType: $storeType, isActive: $isActive, isDelete: $isDelete, createdAt: $createdAt, lowerName: $lowerName, updatedAt: $updatedAt, image: $image, arStoreType: $arStoreType)';
  }

  @override
  bool operator ==(covariant StoreCategory other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.storeType == storeType &&
        other.isActive == isActive &&
        other.isDelete == isDelete &&
        other.createdAt == createdAt &&
        other.lowerName == lowerName &&
        other.updatedAt == updatedAt &&
        other.image == image &&
        other.arStoreType == arStoreType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        storeType.hashCode ^
        isActive.hashCode ^
        isDelete.hashCode ^
        createdAt.hashCode ^
        lowerName.hashCode ^
        updatedAt.hashCode ^
        image.hashCode ^
        arStoreType.hashCode;
  }
}
