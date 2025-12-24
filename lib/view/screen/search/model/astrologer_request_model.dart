class AstrologerRequestModel {
  final num? offset;
  final String? search;
  final String? gender;
  final String? language;
  final String? category;
  final String? skill;
  final String? type;
  final String? sortBy;
  final String? architectPriceFor;
  final String? astrologerUniId;
  final String? slotPermission;
  final String? isVirtual;
  final String? userCategoryId;
  final String? state;
  final String? languageName;
  final String? isSlotAvailable;
  final String? slug;
  final String? userUniId;

  AstrologerRequestModel({
    required this.offset,
    required this.search,
    required this.gender,
    required this.language,
    required this.category,
    required this.skill,
    required this.type,
    required this.sortBy,
    required this.astrologerUniId,
    required this.slug,
    required this.isVirtual,
    required this.slotPermission,
    required this.isSlotAvailable,
    this.userUniId,
    this.userCategoryId,
    this.state,
    this.languageName,
    this.architectPriceFor,
  });

  Map<String, dynamic> toJson() {
    return {
      if (userUniId != null) 'user_uni_id': userUniId,
      if (search != null) 'search': search,
      if (gender != null) 'gender': gender,
      if (language != null) 'language': language,
      if (category != null) 'category': category,
      if (skill != null) 'skill': skill,
      if (type != null) 'type': type,
      if (sortBy != null) 'sortby': sortBy,
      if (offset != null) 'offset': offset,
      if (architectPriceFor != null) 'architect_price_for': architectPriceFor,
      if (astrologerUniId != null) 'astrologer_uni_id': astrologerUniId,
      if (slotPermission != null) 'slot_permission': slotPermission,
      if (isVirtual != null) 'is_virtual': isVirtual,
      if (userCategoryId != null) 'user_category_id': userCategoryId,
      if (state != null) 'state': state,
      if (languageName != null) 'language_name': languageName,
      if (isSlotAvailable != null) 'is_slot_available': isSlotAvailable,
      if (slug != null) 'slug': slug,
    };
  }
}
