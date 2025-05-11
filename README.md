# 📱 iOS Developer Assignment

## Objective

A feature-rich iOS application demonstrating user authentication, offline data management with Core Data, PDF viewing, image handling, and real-time push notifications using Firebase Cloud Messaging (FCM).

---

## 🔐 Features

### 1. User Authentication
- Integrated **Google Sign-In** using Firebase Authentication.
- Persisted user details using **Core Data** for offline access.

### 2. PDF Viewer
- Displays PDF from a URL:
  [`BalanceSheet.pdf`](https://fssservices.bookxpert.co/GeneratedPDF/Companies/nadc/2024-2025/BalanceSheet.pdf)
- Embedded PDF rendering using built-in support or 3rd-party PDFKit alternatives.

### 3. Image Handling
- Capture images using the device **Camera**.
- Select images from **Photo Library**.
- Displays the chosen image directly in the app.

### 4. Core Data with API Integration
- Fetches data from: [`https://api.restful-api.dev/objects`](https://api.restful-api.dev/objects)
- Stores API response in Core Data.
- Includes:
  - **List View**
  - **Update & Delete** actions
  - **Validations & Error Handling**

### 5. Push Notifications (Local)

- Sends **local notifications** when an item is deleted.
- Notification includes details of the **deleted item** (e.g., name, ID).
- Users can **enable or disable** notifications via in-app toggle.
- Implemented using `UNUserNotificationCenter`.


---

## 🛠 Technical Stack

- **Language**: Swift
- **Architecture**: MVVM
- **UI**: Storyboards + UIKit (Modern styling)
- **Local DB**: Core Data
- **Authentication**: Firebase Google Sign-In
- **Notifications**: Firebase Cloud Messaging (FCM)
- **PDF Viewing**: PDFKit / 3rd-party viewer
- **Image Handling**: UIImagePickerController
- **Permissions**: Camera & Photo Library with runtime checks
- **Theme Support**: Light & Dark Mode compatible

---

 

## 📸 App Screenshot

![App Screenshot](https://github.com/user-attachments/assets/7c2c3344-54db-4efd-9e55-c20707efb119)


## 🔧 Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/AbhayChaurasia/Assignment_CoreData.git
