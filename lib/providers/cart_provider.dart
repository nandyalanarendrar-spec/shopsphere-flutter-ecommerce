import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, CartItem> _cartItems = {};
  String _promoCode = '';
  double _discountPercentage = 0.0;
  String _promoError = '';

  // Getters
  Map<int, CartItem> get cartItems => _cartItems;
  String get promoCode => _promoCode;
  double get discountPercentage => _discountPercentage;
  String get promoError => _promoError;

  int get totalItems {
    int total = 0;
    _cartItems.forEach((key, item) {
      total += item.quantity;
    });
    return total;
  }

  double get rawSubtotal {
    double total = 0.0;
    _cartItems.forEach((key, item) {
      total += item.totalPrice;
    });
    return total;
  }

  // Alias for backward compatibility
  double get totalPrice => rawSubtotal;

  // Free shipping threshold: $50
  double get freeShippingThreshold => 50.0;
  
  double get shippingFee {
    if (rawSubtotal == 0 || rawSubtotal >= freeShippingThreshold) {
      return 0.0;
    }
    return 4.99;
  }

  double get discountAmount => rawSubtotal * (_discountPercentage / 100);

  double get taxAmount => (rawSubtotal - discountAmount) * 0.08; // 8% standard tax

  double get grandTotal {
    if (rawSubtotal == 0) return 0.0;
    return (rawSubtotal - discountAmount + shippingFee + taxAmount).clamp(0.0, double.infinity);
  }

  // Check if a product is in the cart
  bool isInCart(int productId) {
    return _cartItems.containsKey(productId);
  }

  // Add a product to the cart
  void addToCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems[product.id]!.quantity += 1;
    } else {
      _cartItems[product.id] = CartItem(product: product);
    }
    notifyListeners();
  }

  // Remove a product from the cart
  void removeFromCart(int productId) {
    _cartItems.remove(productId);
    if (_cartItems.isEmpty) {
      _promoCode = '';
      _discountPercentage = 0.0;
      _promoError = '';
    }
    notifyListeners();
  }

  // Increase quantity
  void increaseQuantity(int productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems[productId]!.quantity += 1;
      notifyListeners();
    }
  }

  // Decrease quantity
  void decreaseQuantity(int productId) {
    if (_cartItems.containsKey(productId)) {
      if (_cartItems[productId]!.quantity > 1) {
        _cartItems[productId]!.quantity -= 1;
      } else {
        _cartItems.remove(productId);
      }
      if (_cartItems.isEmpty) {
        _promoCode = '';
        _discountPercentage = 0.0;
        _promoError = '';
      }
      notifyListeners();
    }
  }

  // Apply promo code (e.g. SAVE10 = 10% off, PROMO20 = 20% off)
  bool applyPromo(String code) {
    final clean = code.trim().toUpperCase();
    _promoError = '';

    if (clean == 'SAVE10' || clean == 'DISCOUNT10') {
      _promoCode = clean;
      _discountPercentage = 10.0;
      notifyListeners();
      return true;
    } else if (clean == 'SUPER20' || clean == 'WELCOME20') {
      _promoCode = clean;
      _discountPercentage = 20.0;
      notifyListeners();
      return true;
    } else if (clean == 'FREESHIP') {
      _promoCode = clean;
      _discountPercentage = 5.0;
      notifyListeners();
      return true;
    } else {
      _promoError = 'Invalid promo code. Try "SAVE10" or "SUPER20"';
      notifyListeners();
      return false;
    }
  }

  void removePromo() {
    _promoCode = '';
    _discountPercentage = 0.0;
    _promoError = '';
    notifyListeners();
  }

  // Clear the entire cart
  void clearCart() {
    _cartItems.clear();
    _promoCode = '';
    _discountPercentage = 0.0;
    _promoError = '';
    notifyListeners();
  }
}
