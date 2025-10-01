class CartModel {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double subtotal;
  final double discount;
  final double total;
  final String? couponCode;
  final DateTime createdAt;
  final DateTime updatedAt;

  CartModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    this.discount = 0.0,
    required this.total,
    this.couponCode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      items: json['items'] != null 
          ? (json['items'] as List).map((e) => CartItem.fromJson(e)).toList()
          : [],
      subtotal: (json['subtotal'] ?? 0.0).toDouble(),
      discount: (json['discount'] ?? 0.0).toDouble(),
      total: (json['total'] ?? 0.0).toDouble(),
      couponCode: json['coupon_code'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'items': items.map((e) => e.toJson()).toList(),
      'subtotal': subtotal,
      'discount': discount,
      'total': total,
      'coupon_code': couponCode,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class CartItem {
  final String id;
  final String itemId;
  final String itemName;
  final String itemType; // webinar, bundle, course
  final String title;
  final double price;
  final String? imageUrl;
  final DateTime addedAt;

  CartItem({
    required this.id,
    required this.itemId,
    required this.itemName,
    required this.itemType,
    required this.title,
    required this.price,
    this.imageUrl,
    required this.addedAt,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] ?? '',
      itemId: json['item_id'] ?? '',
      itemName: json['item_name'] ?? '',
      itemType: json['item_type'] ?? '',
      title: json['title'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      imageUrl: json['image_url'],
      addedAt: DateTime.parse(json['added_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item_id': itemId,
      'item_name': itemName,
      'item_type': itemType,
      'title': title,
      'price': price,
      'image_url': imageUrl,
      'added_at': addedAt.toIso8601String(),
    };
  }
}

class AddToCartRequest {
  final String itemId;
  final String itemName;

  AddToCartRequest({
    required this.itemId,
    required this.itemName,
  });

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'item_name': itemName,
    };
  }
}

class CouponValidationRequest {
  final String coupon;

  CouponValidationRequest({required this.coupon});

  Map<String, dynamic> toJson() {
    return {
      'coupon': coupon,
    };
  }
}

class CouponValidationResponse {
  final bool valid;
  final String? message;
  final double? discount;
  final String? discountType; // percentage, fixed

  CouponValidationResponse({
    required this.valid,
    this.message,
    this.discount,
    this.discountType,
  });

  factory CouponValidationResponse.fromJson(Map<String, dynamic> json) {
    return CouponValidationResponse(
      valid: json['valid'] ?? false,
      message: json['message'],
      discount: json['discount']?.toDouble(),
      discountType: json['discount_type'],
    );
  }
}

class CheckoutRequest {
  final String gateway;
  final String? coupon;

  CheckoutRequest({
    required this.gateway,
    this.coupon,
  });

  Map<String, dynamic> toJson() {
    return {
      'gateway': gateway,
      'coupon': coupon,
    };
  }
}

class CheckoutResponse {
  final bool success;
  final String? paymentUrl;
  final String? transactionId;
  final String? message;

  CheckoutResponse({
    required this.success,
    this.paymentUrl,
    this.transactionId,
    this.message,
  });

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutResponse(
      success: json['success'] ?? false,
      paymentUrl: json['payment_url'],
      transactionId: json['transaction_id'],
      message: json['message'],
    );
  }
}
