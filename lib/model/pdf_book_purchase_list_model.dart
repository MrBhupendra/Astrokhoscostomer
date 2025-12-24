class PdfBookPurchaseListModel {
  PdfBookPurchaseListModel({
      this.status, 
      this.offset, 
      this.data, 
      this.msg,});

  PdfBookPurchaseListModel.fromJson(dynamic json) {
    status = json['status'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  num? status;
  num? offset;
  List<Data>? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['offset'] = offset;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.pdfBookId, 
      this.userUniId, 
      this.orderId, 
      this.totalAmount, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.title, 
      this.description, 
      this.pdfImage, 
      this.samplePdf, 
      this.mainPdf, 
      this.pdfBookCategoryTitle, 
      this.pdfBookCategoryImage,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    pdfBookId = json['pdf_book_id'];
    userUniId = json['user_uni_id'];
    orderId = json['order_id'];
    totalAmount = json['total_amount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    description = json['description'];
    pdfImage = json['pdf_image'];
    samplePdf = json['sample_pdf'];
    mainPdf = json['main_pdf'];
    pdfBookCategoryTitle = json['pdf_book_category_title'];
    pdfBookCategoryImage = json['pdf_book_category_image'];
  }
  num? id;
  num? pdfBookId;
  String? userUniId;
  String? orderId;
  num? totalAmount;
  num? status;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? description;
  String? pdfImage;
  String? samplePdf;
  String? mainPdf;
  String? pdfBookCategoryTitle;
  String? pdfBookCategoryImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['pdf_book_id'] = pdfBookId;
    map['user_uni_id'] = userUniId;
    map['order_id'] = orderId;
    map['total_amount'] = totalAmount;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['title'] = title;
    map['description'] = description;
    map['pdf_image'] = pdfImage;
    map['sample_pdf'] = samplePdf;
    map['main_pdf'] = mainPdf;
    map['pdf_book_category_title'] = pdfBookCategoryTitle;
    map['pdf_book_category_image'] = pdfBookCategoryImage;
    return map;
  }

}