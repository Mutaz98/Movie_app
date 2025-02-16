# 📽️ Movie App  

A Flutter-based movie application that integrates with The Movie Database (TMDb) API to display movie details, favorites, and ratings.  

## 🚀 Features  
- Browse popular movies  
- View detailed movie information  
- Add/remove movies from favorites  
- Offline support using `sqflite`  


## 🛠️ Setup & Installation  

### 1️⃣ Prerequisites  
Make sure you have Flutter installed. You can download it from [Flutter's official site](https://flutter.dev/docs/get-started/install).  

### 2️⃣ Clone the Repository  
```sh
git clone https://github.com/yourusername/movie_app.git  
cd movie_app  

## 📦 Dependencies & Third-Party Packages  

This project uses the following third-party packages:  

| Package                      | Purpose                                      | Documentation |
|------------------------------|----------------------------------------------|---------------|
| `flutter_bloc`               | State management using BLoC pattern         | [Docs](https://pub.dev/packages/flutter_bloc) 
| `dartz`                      | Functional programming utilities            | [Docs](https://pub.dev/packages/dartz) 
| `equatable`                  | Value equality for Dart objects             | [Docs](https://pub.dev/packages/equatable) 
| `retrofit`                   | Type-safe API requests                      | [Docs](https://pub.dev/packages/retrofit) 
| `logger`                     | Logging utility                             | [Docs](https://pub.dev/packages/logger) 
| `dio`                        | HTTP client                                 | [Docs](https://pub.dev/packages/dio) 
| `json_annotation`            | JSON serialization                          | [Docs](https://pub.dev/packages/
| `flutter_screenutil`         | Responsive UI scaling                       | [Docs](https://pub.dev/packages/
| `flutter_dotenv`             | Environment variable management             | [Docs](https://pub.dev/packages/flutter_dotenv) 
| `intl`                       | Internationalization support                | [Docs](https://pub.dev/packages/intl) 
| `cached_network_image`       | Image caching                               | [Docs](https://pub.dev/packages/
| `shared_preferences`         | Local storage                               | [Docs](https://pub.dev/packages/
| `get_it`                     | Service locator                             | [Docs](https://pub.dev/packages/get_it) 
| `freezed_annotation`         | Immutable data classes                      | [Docs](https://pub.dev/packages/
| `provider`                   | State management                            | [Docs](https://pub.dev/packages/provider) 
| `collection`                 | Collection utilities                        | [Docs](https://pub.dev/packages/collection) 
| `injectable`                 | Dependency injection                        | [Docs](https://pub.dev/packages/injectable) 
| `infinite_scroll_pagination` | Infinite list scrolling                     | [Docs](https://pub.dev/packages/
| `flutter_secure_storage`     | Secure storage                              | [Docs](https://pub.dev/packages/
| `jwt_decode`                 | JWT token parsing                           | [Docs](https://pub.dev/packages/jwt_decode) 
| `flutter_rating_bar`         | Rating bar UI                               | [Docs](https://pub.dev/packages/
| `sqflite`                    | Local database support                      | [Docs](https://pub.dev/packages/sqflite) 

### Dev Dependencies  

| Package                   | Purpose                                      |
|---------------------------|----------------------------------------------|
| `retrofit_generator`      | API code generator                           |
| `json_serializable`       | JSON serialization code generator            |
| `freezed`                 | Immutable data model generator               |
| `mockito`                 | Mocking framework for tests                  |
| `build_runner`            | Code generation tool                         |
| `injectable_generator`    | Dependency injection generator               |

🔒 Security & API Key Handling
Do not hardcode API keys in your source code. Instead, store them in a .env file and use flutter_dotenv to load them securely.




