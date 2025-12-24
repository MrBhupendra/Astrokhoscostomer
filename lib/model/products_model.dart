class ProductsModel {
  ProductsModel({
      this.status, 
      this.data, 
      this.msg,});

  ProductsModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProductsData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  List<ProductsData>? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class ProductsData {
  ProductsData({
      this.id, 
      this.vendorUniId, 
      this.productCategoryId, 
      this.productName, 
      this.slug, 
      this.productImage, 
      this.price, 
      this.mrp,
      this.quantity, 
      this.productDescription, 
      this.status, 
      this.createdAt, 
      this.updatedAt,
      this.galleryImageList,});

  ProductsData.fromJson(dynamic json) {
    id = json['id'];
    vendorUniId = json['vendor_uni_id'];
    productCategoryId = json['product_category_id'];
    productName = json['product_name'];
    slug = json['slug'];
    productImage = json['product_image'];
    price = json['price'];
    mrp = json['mrp'];
    quantity = json['quantity'];
    productDescription = json['product_description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    galleryImageList = json['gallery_image_list'] != null ? json['gallery_image_list'].cast<String>() : [];
  }
  num? id;
  String? vendorUniId;
  num? productCategoryId;
  String? productName;
  String? slug;
  String? productImage;
  num? price;
  num? mrp;
  num? quantity;
  String? productDescription;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<String>? galleryImageList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['vendor_uni_id'] = vendorUniId;
    map['product_category_id'] = productCategoryId;
    map['product_name'] = productName;
    map['slug'] = slug;
    map['product_image'] = productImage;
    map['price'] = price;
    map['mrp'] = mrp;
    map['quantity'] = quantity;
    map['product_description'] = productDescription;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['gallery_image_list'] = galleryImageList;
    return map;
  }

}