# 🎓 EduLink

EduLink is your gateway to a smarter academic journey! With powerful features and a user-friendly interface, EduLink connects students and instructors seamlessly, promoting an interactive and productive learning environment.

---

## 🚀 Key Features

- 👤 **Personalized Profiles:** Tailored experiences for students and instructors.
- 🔐 **Role-Based Access:** Easy sign-up for students. Professors' access is restricted and granted manually by IT through Firebase role management.
- 📚 **Effortless Course Management:** Access and organize academic content with ease.
- 💬 **Academic Discussions:** Engage in meaningful conversations and share knowledge.
- 💬 **1 to 1 Chat:** Stay connected and chat privately with other students and professors.
- 📁 **Material Sharing:** Upload and access course videos, PDFs, and other resources.
- ☁️ **Cloud Storage with Supabase:** Fast and secure media and file storage (PDFs, images, videos).
- 📱 **Cross-Device Access:** Works seamlessly on Android phones and emulators.

---

## 💡 Why EduLink?

EduLink transforms traditional learning into a dynamic experience, making education more accessible, engaging, and effective for everyone involved.

Stay tuned for more updates and features!

---

## 📁 Repository Structure

```
EduLink/
├── lib/                   # Main Flutter source code (UI, logic)
├── assets/                # Images, and other media assets
├── exe/                   # Contains the prebuilt EduLink.apk file
├── test/                  # Flutter unit and widget tests
├── android/               # Native Android project files (if needed)
├── pubspec.yaml           # Flutter project config and dependencies
├── pubspec.lock           # Locked dependency versions
├── .gitignore             # Files and folders to be ignored by Git
├── README.md              # This documentation file
├── .firebaserc            # Firebase project configuration
├── firebase.json          # Firebase hosting config (if applicable)
├── firestore.rules        # Firestore security rules
├── firestore.indexes.json # Firestore index definitions
```

---

## 📦 How to Install (For End Users)

### ✅ Android Installation (APK)

1. Go to the [`/exe`](./exe) folder or visit the [GitHub Releases](https://github.com/YousefSaber128/edulink/releases/tag/APK).
2. Download the file: `EduLink.apk`
3. Transfer the APK to your Android phone.
4. On your phone:
   - Tap the APK
   - Accept the "Install from unknown sources" prompt if shown
5. Launch the app and enjoy!

> ⚠️ APK is for Android only. iOS is currently not supported.

---

## 🛠 Developer Setup (Run from Source)

If you want to edit or test the source code:

### 📋 Prerequisites

- Flutter SDK 3.32 or newer
- Dart SDK
- Android Studio or VS Code
- Git

### 🧪 Steps to Run

```bash
git clone https://github.com/YousefSaber128/edulink
cd edulink
flutter pub get
flutter run
```

### 📤 Build APK

```bash
flutter build apk --release
```

Output APK will be found in:

```
build/app/outputs/flutter-apk/app-release.apk
```

---

## ☁️ Firebase & Supabase Integration

EduLink uses:

- 🔐 **Firebase Authentication**: Secure login and sign-up.
- 🧑‍🏫 **Role Management**: Instructor access is manually approved via Firebase by IT.
- 🔄 **Firestore**: Chat, notifications, and dynamic course metadata.
- ☁️ **Supabase Storage**: Hosting PDFs, images, and course videos efficiently.

> 📬 **Firebase and Supabase configurations and database structure will be shared upon request.**  
> Please contact the developer if you need to deploy your own backend.

---

## 🧩 Troubleshooting

| Problem                      | Suggested Fix                                      |
| ---------------------------- | -------------------------------------------------- |
| App won't install            | Enable installation from unknown sources           |
| White screen on launch       | Run `flutter clean`, then `flutter pub get`        |
| Notifications not showing    | Allow app notifications and verify Firebase config |
| Firebase errors (dev setup)  | Ensure `google-services.json` is properly added    |
| Build fails on Windows/macOS | Update Flutter SDK and Android tools               |

---

### 📘 Full Documentation

For detailed information about the Edu Link project — including setup, architecture, usage, and testing — please refer to the official documentation:

👉 [EduLink GitBook Documentation](https://hossams-organization-1.gitbook.io/edulink)

Chapters include:

- ✅ **Introduction** – Overview, goals, and target users  
- ⚙️ **Tools & Technologies** – Data sources, frameworks, and platforms used  
- 💻 **System Requirements** – For both users and developers  
- 🧠 **Challenges & Solutions** – What we faced and how we solved it  
- 🏗 **Architecture** – Design, system flow, and components  
- 📱 **User Guide** – How to install and use the app  
- 👨‍💻 **Developer Guide** – Folder structure and setup  
- 🧪 **Testing & Feedback** – Quality assurance and collected feedback  

---

## 👨‍💻 Developers

**Hossam Hassan**
**Mahmoud Hassan**  
**Yousef Saber**  

---

## 📜 License & Usage

This project was developed as part of a university graduation project at **Faculty Of Science, Ain Shams University**.  
For academic and educational purposes only.
