class BookPdfListModel {
  BookPdfListModel({this.status, this.data, this.msg, this.offset});

  BookPdfListModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BookPdfData.fromJson(v));
      });
    }
    msg = json['msg'];
    offset = json['offset'];
  }

  num? status;
  List<BookPdfData>? data;
  String? msg;
  num? offset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    map['offset'] = offset;
    return map;
  }
}

class BookPdfData {
  BookPdfData({
    this.id,
    this.pdfBookCategoryId,
    this.title,
    this.description,
    this.samplePdf,
    this.mainPdf,
    this.pdfImage,
    this.slug,
    this.price,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.paymentStatus,
  });

  BookPdfData.fromJson(dynamic json) {
    id = json['id'];
    pdfBookCategoryId = json['pdf_book_category_id'];
    title = json['title'];
    description = json['description'];
    samplePdf = json['sample_pdf'];
    mainPdf = json['main_pdf'];
    pdfImage = json['pdf_image'];
    slug = json['slug'];
    price = json['price'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    paymentStatus = json['payment_status'];
  }

  num? id;
  num? pdfBookCategoryId;
  String? title;
  String? description;
  String? samplePdf;
  String? mainPdf;
  String? pdfImage;
  String? slug;
  num? price;
  num? status;
  String? createdAt;
  String? updatedAt;
  num? paymentStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['pdf_book_category_id'] = pdfBookCategoryId;
    map['title'] = title;
    map['description'] = description;
    map['sample_pdf'] = samplePdf;
    map['main_pdf'] = mainPdf;
    map['pdf_image'] = pdfImage;
    map['slug'] = slug;
    map['price'] = price;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['payment_status'] = paymentStatus;
    return map;
  }
}
