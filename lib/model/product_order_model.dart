class ProductOrderModel {
  ProductOrderModel({
      this.status, 
      this.data, 
      this.msg,});

  ProductOrderModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProductOrderData.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  List<ProductOrderData>? data;
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

class ProductOrderData {
  ProductOrderData({
    this.id,
    this.orderId,
    this.vendorUniId,
    this.userUniId,
    this.subTotalAmount,
    this.gstPercent,
    this.gstAmount,
    this.offerAmount,
    this.totalAmount,
    this.status,
    this.paymentStatus,
    this.returnValidDate,
    this.createdAt,
    this.updatedAt,
    this.invoiceUrl,
    this.subscriptionAssignId,
    this.orderProducts,
    this.user,
    this.address,});

  ProductOrderData.fromJson(dynamic json) {
    id = json['id'];
    orderId = json['order_id'];
    vendorUniId = json['vendor_uni_id'];
    userUniId = json['user_uni_id'];
    subTotalAmount = json['sub_total_amount'];
    gstPercent = json['gst_percent'];
    gstAmount = json['gst_amount'];
    offerAmount = json['offer_amount'];
    totalAmount = json['total_amount'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    returnValidDate = json['return_valid_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    invoiceUrl = json['invoice_url'];
    subscriptionAssignId = json['subscription_assign_id'];
    if (json['order_products'] != null) {
      orderProducts = [];
      json['order_products'].forEach((v) {
        orderProducts?.add(OrderProducts.fromJson(v));
      });
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
  }
  num? id;
  String? orderId;
  String? vendorUniId;
  String? userUniId;
  String? subTotalAmount;
  String? gstPercent;
  String? gstAmount;
  String? offerAmount;
  String? totalAmount;
  String? status;
  String? paymentStatus;
  String? returnValidDate;
  String? createdAt;
  String? updatedAt;
  String? invoiceUrl;
  num? subscriptionAssignId;
  List<OrderProducts>? orderProducts;
  User? user;
  Address? address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_id'] = orderId;
    map['vendor_uni_id'] = vendorUniId;
    map['user_uni_id'] = userUniId;
    map['sub_total_amount'] = subTotalAmount;
    map['gst_percent'] = gstPercent;
    map['gst_amount'] = gstAmount;
    map['offer_amount'] = offerAmount;
    map['total_amount'] = totalAmount;
    map['status'] = status;
    map['payment_status'] = paymentStatus;
    map['return_valid_date'] = returnValidDate;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['invoice_url'] = invoiceUrl;
    map['subscription_assign_id'] = subscriptionAssignId;
    if (orderProducts != null) {
      map['order_products'] = orderProducts?.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (address != null) {
      map['address'] = address?.toJson();
    }
    return map;
  }

}

class Address {
  Address({
    this.id,
    this.userUniId,
    this.name,
    this.email,
    this.phone,
    this.houseNo,
    this.streetArea,
    this.landmark,
    this.city,
    this.state,
    this.country,
    this.address,
    this.latitude,
    this.longitude,
    this.pincode,
    this.status,
    this.createdAt,
    this.updatedAt,});

  Address.fromJson(dynamic json) {
    id = json['id'];
    userUniId = json['user_uni_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    houseNo = json['house_no'];
    streetArea = json['street_area'];
    landmark = json['landmark'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    pincode = json['pincode'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? userUniId;
  String? name;
  String? email;
  String? phone;
  String? houseNo;
  String? streetArea;
  String? landmark;
  String? city;
  String? state;
  String? country;
  String? address;
  String? latitude;
  String? longitude;
  num? pincode;
  num? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_uni_id'] = userUniId;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['house_no'] = houseNo;
    map['street_area'] = streetArea;
    map['landmark'] = landmark;
    map['city'] = city;
    map['state'] = state;
    map['country'] = country;
    map['address'] = address;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['pincode'] = pincode;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

class User {
  User({
    this.id,
    this.roleId,
    this.userUniId,
    this.name,
    this.email,
    this.phone,
    this.avgRating,
    this.welcomeMail,
    this.isRecharge,
    this.trash,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.fullInfo,});

  User.fromJson(dynamic json) {
    id = json['id'];
    roleId = json['role_id'];
    userUniId = json['user_uni_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    avgRating = json['avg_rating'];
    welcomeMail = json['welcome_mail'];
    isRecharge = json['is_recharge'];
    trash = json['trash'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullInfo = json['full_info'];
  }
  num? id;
  num? roleId;
  String? userUniId;
  String? name;
  String? email;
  String? phone;
  String? avgRating;
  num? welcomeMail;
  num? isRecharge;
  num? trash;
  num? status;
  String? createdAt;
  String? updatedAt;
  String? fullInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['role_id'] = roleId;
    map['user_uni_id'] = userUniId;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['avg_rating'] = avgRating;
    map['welcome_mail'] = welcomeMail;
    map['is_recharge'] = isRecharge;
    map['trash'] = trash;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['full_info'] = fullInfo;
    return map;
  }

}

class OrderProducts {
  OrderProducts({
    this.id,
    this.orderId,
    this.productId,
    this.price,
    this.quality,
    this.totalAmount,
    this.createdAt,
    this.updatedAt,
    this.product,});

  OrderProducts.fromJson(dynamic json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    price = json['price'];
    quality = json['quality'];
    totalAmount = json['total_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
  num? id;
  String? orderId;
  String? productId;
  String? price;
  num? quality;
  num? totalAmount;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_id'] = orderId;
    map['product_id'] = productId;
    map['price'] = price;
    map['quality'] = quality;
    map['total_amount'] = totalAmount;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (product != null) {
      map['product'] = product?.toJson();
    }
    return map;
  }

}

class Product {
  Product({
    this.id,
    this.vendorUniId,
    this.productCategoryId,
    this.productName,
    this.slug,
    this.productImage,
    this.price,
    this.mrp,
    this.unit,
    this.quantity,
    this.productDescription,
    this.status,
    this.createdAt,
    this.updatedAt,});

  Product.fromJson(dynamic json) {
    id = json['id'];
    vendorUniId = json['vendor_uni_id'];
    productCategoryId = json['product_category_id'];
    productName = json['product_name'];
    slug = json['slug'];
    productImage = json['product_image'];
    price = json['price'];
    mrp = json['mrp'];
    unit = json['unit'];
    quantity = json['quantity'];
    productDescription = json['product_description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? vendorUniId;
  num? productCategoryId;
  String? productName;
  String? slug;
  String? productImage;
  num? price;
  num? mrp;
  String? unit;
  num? quantity;
  String? productDescription;
  String? status;
  String? createdAt;
  String? updatedAt;

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
    map['unit'] = unit;
    map['quantity'] = quantity;
    map['product_description'] = productDescription;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}