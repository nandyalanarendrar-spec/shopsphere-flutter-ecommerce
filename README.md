# 🛍️ ShopSphere - Modern Flutter E-Commerce Application

A professional, feature-rich Flutter E-Commerce application designed with modern Material 3 aesthetics, robust state management via `Provider`, and full REST API integration. Built for mobile, tablet, and web platforms.

---

## 🌟 Key Highlights & Features

- **🎨 Modern UI / UX Design**:
  - Precision-proportioned product cards with responsive layout (zero blank gaps).
  - Clean Indigo & Slate design tokens with subtle borders and smooth elevations.
  - Desktop web responsiveness with centered maximum-width constraints (`maxWidth: 1200`).
  - Interactive hero banner, quick category filters, and value proposition cards.

- **⚡ State Management with Provider**:
  - `ProductProvider`: Fetches real-time products via FakeStoreAPI, handles category filtering, search queries, multi-criteria sorting (Price, Rating, Alphabetical), and Wishlist / Favorites.
  - `CartProvider`: Real-time cart calculations, item increment/decrement, promotional discount codes (`SAVE10`, `SUPER20`), dynamic free-shipping progress indicator, and tax calculations.

- **🌐 REST API Integration**:
  - Connects to [FakeStoreAPI](https://fakestoreapi.com/) for products, categories, pricing, ratings, and image assets.
  - Comprehensive loading, empty, and offline retry error states.

- **📝 Form Validation & Checkout**:
  - Multi-field checkout form: Full Name, Email (Regex validated), Mobile Phone (10-15 digits), Street Address, City, and Postal Code.
  - Interactive payment method selector (Credit/Debit Card, UPI / Google Pay, Cash on Delivery).
  - Order confirmation receipt modal with generated Order ID and delivery summary.

- **✨ Animations & Micro-Interactions**:
  - Smooth page transitions and Hero animations for product image transitions.
  - Dynamic notification badge on cart and wishlist with scale animations.
  - Smooth category filter selection pills and promotional coupon feedback.

---

## 📋 Course / Project Requirements Checklist

| Requirement | Implementation Detail | Status |
| :--- | :--- | :---: |
| **Multiple Screens (Min. 3)** | 5 Screens: Home, Catalog, Product Detail, Cart, and Checkout | ✅ Passed |
| **Navigation** | Named routing (`/`, `/products`, `/product-detail`, `/cart`, `/checkout`) & MaterialPageRoute transitions | ✅ Passed |
| **State Management** | MultiProvider with `ProductProvider` and `CartProvider` | ✅ Passed |
| **REST API Integration** | HTTP `get` to `https://fakestoreapi.com/products` with model deserialization | ✅ Passed |
| **Form with Validation** | 6 validated fields in `CheckoutScreen` with regex checks and error hints | ✅ Passed |
| **Animations** | `Hero` image tags, `AnimatedContainer` badges, `FadeTransition` page entrance | ✅ Passed |
| **Theming** | Comprehensive `ThemeData` with Material 3, custom `ColorScheme`, and Typography | ✅ Passed |

---

## 📱 App Screens Overview

1. **Home Screen (`home_screen.dart`)**:
   - Hero banner with coupon announcement and CTA.
   - 4 Value propositions (Free Shipping, 100% Authentic, Easy Returns, Secure Checkout).
   - Quick Category browser with custom icons and color schemes.
   - Activity metrics (Available Items, Wishlist Count, Cart Subtotal).
   - Horizontal Featured Products carousel with instant Add-to-Cart and Wishlist toggling.

2. **Product Catalog (`product_list_screen.dart`)**:
   - Integrated search bar with live filtering.
   - Category filter pills with count badge indicators.
   - Sort bottom sheet (Price: Low/High, Rating, A-Z).
   - Responsive, gap-free product grid using `SliverGridDelegateWithMaxCrossAxisExtent`.

3. **Product Detail (`product_detail_screen.dart`)**:
   - High-resolution hero image container.
   - Category pill and stock availability badge.
   - Star rating breakdown with review count.
   - Quantity selector (+ / -) with live price updates.
   - "Add to Cart" and instant "Buy Now" direct checkout.

4. **Shopping Cart (`cart_screen.dart`)**:
   - Free shipping progress bar (`$50` threshold).
   - Cart item list with thumbnail, quantity controls, and delete actions.
   - Promo coupon code engine (try `SAVE10` or `SUPER20`).
   - Detailed cost breakdown (Subtotal, Discount, Shipping, Tax, Grand Total).

5. **Checkout Screen (`checkout_screen.dart`)**:
   - Itemized order review thumbnail strip.
   - Validated shipping information form fields.
   - Selectable payment method tiles.
   - Order confirmation dialog with instant cart reset.

---

## 📂 Project Architecture

```
my_app/
├── lib/
│   ├── main.dart                      # App entry point, MultiProvider & ThemeData
│   ├── models/
│   │   ├── product.dart               # Product model with JSON parser
│   │   └── cart_item.dart             # CartItem wrapper with total price logic
│   ├── providers/
│   │   ├── product_provider.dart      # Catalog state, search, sort, wishlist
│   │   └── cart_provider.dart         # Cart state, promos, tax & shipping logic
│   ├── services/
│   │   └── api_service.dart           # REST API client for FakeStoreAPI
│   └── screens/
│       ├── home_screen.dart           # Landing screen with hero and featured carousel
│       ├── product_list_screen.dart   # Search, filters, sort, and zero-gap product grid
│       ├── product_detail_screen.dart # Detail view, quantity selector, Buy Now
│       ├── cart_screen.dart           # Cart management, coupon code, shipping bar
│       └── checkout_screen.dart       # Validated shipping form, payment, confirmation
├── pubspec.yaml                       # Dependencies: flutter, provider, http, cupertino_icons
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (v3.12.0 or higher)
- Chrome (for web) or an Android / iOS device/emulator

### Installation & Run

1. Clone or navigate to the project directory:
   ```bash
   cd my_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run on your desired platform:
   - **Chrome (Web)**:
     ```bash
     flutter run -d chrome
     ```
   - **Windows Desktop**:
     ```bash
     flutter run -d windows
     ```
   - **Mobile (Android / iOS)**:
     ```bash
     flutter run
     ```

---

## 💡 Promo Codes for Testing

In the Cart screen, test these promo codes:
- `SAVE10` : 10% Discount on subtotal
- `SUPER20` : 20% Discount on subtotal
- `FREESHIP` : 5% Discount
