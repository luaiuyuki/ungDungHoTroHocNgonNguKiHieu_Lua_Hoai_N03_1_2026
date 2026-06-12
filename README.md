# Sign Language Alphabet (SASL)

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/firebase-ffca28?style=for-the-badge&logo=firebase&logoColor=black)
![TensorFlow](https://img.shields.io/badge/TensorFlow-FF6F00?style=for-the-badge&logo=tensorflow&logoColor=white)

An interactive, AI-powered educational application built with Flutter to help users learn and practice the American Sign Language (ASL) alphabet in real-time.

---

## 📑 Table of Contents

1. [Project Overview](#-project-overview)
2. [Key Features](#-key-features)
3. [System Requirements](#-system-requirements)
4. [Installation Guide](#-installation-guide)
5. [Application Architecture](#-application-architecture)
6. [Usage & Modes](#-usage--modes)
7. [Screenshots](#-screenshots)
8. [License](#-license)
9. [Acknowledgments](#-acknowledgments)

---

## 📖 Project Overview

The **Sign Language Alphabet (SASL)** app leverages on-device Machine Learning (MediaPipe/TensorFlow) and the device camera to accurately detect and classify hand gestures. It offers a structured learning path ranging from a basic dictionary to high-speed challenges, making it an engaging tool for anyone aiming to master the ASL alphabet. Data is seamlessly synchronized across devices using Firebase.

---

## ✨ Key Features

- **Real-Time Hand Tracking:** Utilizes cutting-edge ML models to detect hand landmarks instantly.
- **Interactive Dictionary:** A comprehensive guide to all 26 ASL alphabet signs with visual references.
- **Test Mode:** A randomized assessment to test your knowledge without time pressure.
- **Speed Challenge:** A gamified experience testing how quickly and accurately you can sign under a strict time limit.
- **Daily Challenges:** Special daily tasks to keep learners engaged and motivated.
- **Cloud Synchronization:** Securely saves your highest scores, current streaks, and progress via Firebase.
- **Customizable Experience:** Supports Dark Mode and toggleable sound effects for an optimal user experience.

---

## 💻 System Requirements

Please ensure your development environment meets the following specifications before proceeding:

- **Flutter SDK:** Version 3.19.0 or higher
- **Dart SDK:** Version 3.3.0 or higher
- **Android Studio / VS Code:** Latest stable versions recommended
- **Operating System:** Windows 10/11, macOS, or Linux
- **Physical Device:** A smartphone with a functional front-facing camera is required for hand detection features (Emulators may not support camera-based ML tracking efficiently).

---

## ⚙️ Installation Guide

Follow these steps meticulously to set up the project on your local machine:

**1. Clone the repository:**
```bash
git clone https://github.com/your-username/Sign-Language-Alphabet.git
```

**2. Navigate to the project directory:**
```bash
cd Sign-Language-Alphabet
```

**3. Install dependencies:**
```bash
flutter pub get
```

**4. Configure Firebase:**
- Create a new project on the [Firebase Console](https://console.firebase.google.com/).
- Follow the instructions to add an Android and/or iOS app.
- Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) and place them in their respective directories.

**5. Run the application:**
Ensure your physical device is connected, then execute:
```bash
flutter run
```

---

## 🏗️ Application Architecture

The project adheres to a clean and maintainable directory structure:

```text
lib/
 ├── main.dart               # Application entry point
 ├── models/                 # Data structures and models (e.g., StatsModel)
 ├── screens/                # UI Views (MainShell, Dictionary, TestMode, etc.)
 ├── services/               # Core business logic and external APIs
 │    ├── firebaseService.dart
 │    ├── handLandmarkerService.dart
 │    └── signClassifierService.dart
 └── widgets/                # Reusable UI components (CameraPreview, HandPainter)
```

---

## 🎮 Usage & Modes

- **Dictionary:** Open the dictionary tab to view illustrations of the ASL alphabet. Practice forming the signs in front of your camera to receive real-time feedback.
- **Test Mode:** Select this mode to receive random letters. You must sign correctly to proceed and accumulate points.
- **Settings:** Access the settings menu to reset your progress, toggle Dark Mode, or turn on/off audio feedback.

---

## 📸 Screenshots

https://www.youtube.com/watch?v=Nnkk5ex0Mfc&t=155s


## 📜 License

This software is released under the **MIT License**.
Please refer to the `LICENSE` file for more details.

---

## Acknowledgments

We would like to express our deepest gratitude to:
- The [Flutter](https://flutter.dev/) team for providing an exceptional framework.
- The [MediaPipe](https://developers.google.com/mediapipe) team for their robust hand tracking solutions.
- All contributors and users who have provided valuable feedback to improve this application.

Should you have any inquiries or require support, please feel free to open an issue in the repository. Thank you for your interest in our application!
