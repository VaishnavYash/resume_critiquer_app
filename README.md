# Resume Critiquer App (Flutter Frontend)

A cross-platform **Flutter application** that allows users to upload resumes and receive AI-powered, ATS-optimized feedback in real time. The app communicates with a Python + OpenAI backend deployed on Google Cloud Platform.

---

## 🚀 Features

* Upload resumes (PDF/DOCX) directly from the mobile or web app
* Real-time resume analysis and feedback
* ATS-friendly recommendations (keywords, formatting, structure)
* Clean and responsive cross-platform UI
* Secure API communication with backend services

---

## 🛠 Tech Stack

**Frontend**

* Flutter (Dart)
* Material UI
* [.apk File](https://drive.google.com/drive/folders/162srqPMmlUKqp9T9hxa15b-OUKEm_c_R?usp=sharing)

**Backend (Integrated)**

* Python
* OpenAI API
* [Github Repository](https://github.com/VaishnavYash/resume_critique)

**Infrastructure**

* Docker
* Google Cloud Platform (GCP)

---

## 📂 Project Structure

```
lib/
├── main.dart
├── screens/
│   ├── upload_screen.dart
│   ├── result_screen.dart
├── services/
│   ├── api_service.dart
├── widgets/
│   ├── resume_card.dart
│   ├── feedback_tile.dart
```

---

## 🔌 API Integration

The Flutter app communicates with a RESTful backend API to:

* Upload resume files
* Send job descriptions (optional)
* Receive structured AI-generated feedback

All API endpoints are securely managed and containerized using Docker.

---

## ▶️ Getting Started

### Prerequisites

* Flutter SDK
* Dart
* Android Studio / VS Code
* Backend API running (local or deployed)

### Installation

```bash
flutter pub get
flutter run
```

---

## ☁️ Deployment

* Flutter App can be built using:

```bash
flutter build apk --release
```

* Backend services are containerized using Docker and deployed on **Google Cloud Platform**.

---

## 📈 Future Enhancements

* User authentication
* Resume version history
* Job-specific resume tailoring
* Multi-language support

---

## 👤 Author

**Yash Vaishnav**
Flutter Developer | Backend & AI Integration
