import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  List<String> _categories = [];
  String _selectedCategory = 'All';
  bool _isLoading = false;
  String _error = '';
  String _searchQuery = '';
  final Set<int> _favoriteIds = {};
  String _sortBy = 'default'; // 'default', 'price_asc', 'price_desc', 'rating', 'name'
  bool _showOnlyFavorites = false;

  // Getters
  List<Product> get products => _filteredProducts;
  List<Product> get allProducts => _products;
  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String get error => _error;
  String get searchQuery => _searchQuery;
  Set<int> get favoriteIds => _favoriteIds;
  int get favoriteCount => _favoriteIds.length;
  String get sortBy => _sortBy;
  bool get showOnlyFavorites => _showOnlyFavorites;

  // Fetch all products from the API
  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _products = await _apiService.fetchProducts();
      
      // Extract categories
      final cats = _products.map((p) => p.category).toSet().toList();
      _categories = ['All', ...cats];

      _applyFilters();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Could not load products. Please check your internet connection and try again.';
      notifyListeners();
    }
  }

  // Filter products by category
  void filterByCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  // Search products by name
  void searchProducts(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  // Toggle favorite
  void toggleFavorite(int productId) {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }
    if (_showOnlyFavorites) {
      _applyFilters();
    }
    notifyListeners();
  }

  bool isFavorite(int productId) {
    return _favoriteIds.contains(productId);
  }

  // Toggle show only favorites
  void toggleFavoritesOnly() {
    _showOnlyFavorites = !_showOnlyFavorites;
    _applyFilters();
    notifyListeners();
  }

  // Set sort mode
  void setSortBy(String sortMode) {
    _sortBy = sortMode;
    _applyFilters();
    notifyListeners();
  }

  // Apply filters & sorting
  void _applyFilters() {
    List<Product> list = _products.where((product) {
      final matchesCategory =
          _selectedCategory == 'All' || product.category == _selectedCategory;
      final matchesSearch =
          _searchQuery.isEmpty ||
          product.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.category.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFavorite =
          !_showOnlyFavorites || _favoriteIds.contains(product.id);
      return matchesCategory && matchesSearch && matchesFavorite;
    }).toList();

    // Apply sorting
    switch (_sortBy) {
      case 'price_asc':
        list.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_desc':
        list.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'rating':
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'name':
        list.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
      default:
        break;
    }

    _filteredProducts = list;
  }

  // Get a single product by id
  Product? getProductById(int id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}
