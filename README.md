# WeatherAppAPI 🌤️

A SwiftUI weather application built with MVVM architecture that fetches real-time weather data via an external API.

---

## 📁 Project Structure

```
WeatherAppAPI/
├── Config/
│   └── AppConfig.swift          # API key management via Info.plist
├── Model/
│   └── WeatherResponse.swift    # Decodable data models for API response
├── View/
│   ├── WeatherView.swift        # Main weather screen
│   ├── WeatherCard.swift        # Reusable weather info card component
│   └── ErrorMessageViews.swift  # Error state UI components
├── ViewModel/
│   ├── WeatherViewModel.swift   # Business logic & API call handling
│   └── WeatherError.swift       # Custom error type definitions
├── Assets.xcassets              # App icons and image assets
├── Config.example               # Example config file for API key setup
├── Info.plist                   # App configuration (includes API_KEY entry)
└── WeatherAppAPIApp.swift       # App entry point
```

---

## 🏗️ Architecture

This project follows the **MVVM (Model-View-ViewModel)** pattern:

| Layer | Files | Responsibility |
|-------|-------|----------------|
| **Model** | `WeatherResponse` | Defines the data structure decoded from the API |
| **View** | `WeatherView`, `WeatherCard`, `ErrorMessageViews` | UI rendering, no business logic |
| **ViewModel** | `WeatherViewModel`, `WeatherError` | API requests, state management, error handling |
| **Config** | `AppConfig` | Secure API key access from `Info.plist` |

---

## 🔑 API Key Setup

The app reads the API key securely from `Info.plist` at runtime. To set it up:

1. Copy the example config file:
   ```bash
   cp Config.example Config.xcconfig
   ```

2. Add your API key to the config file:
   ```
   API_KEY = your_api_key_here
   ```

3. Make sure `Info.plist` contains the following entry:
   ```xml
   <key>API_KEY</key>
   <string>$(API_KEY)</string>
   ```

> ⚠️ **Never commit your real API key to version control.** The `Config.xcconfig` file should be listed in `.gitignore`.

---

## 🚀 Getting Started

### Requirements

- Xcode 15+
- iOS 17+
- Swift 5.9+

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/WeatherAppAPI.git
   cd WeatherAppAPI
   ```

2. Set up the API key as described in the [API Key Setup](#-api-key-setup) section.

3. Open `WeatherAppAPI.xcodeproj` in Xcode.

4. Select a simulator or device (e.g. **iPhone 17 Pro**) and press **Run** (`⌘R`).

---

## 📱 Features

- 🌡️ Displays current weather conditions
- 🎴 Modular `WeatherCard` component for clean UI
- ❌ Graceful error handling with dedicated error views
- 🔐 Secure API key management (not hardcoded)
- 🧱 Clean MVVM separation of concerns

---

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

---
