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
- Embedded PDF rendering using built-in support webview.

### 3. Image Handling
- Capture images using the device **Camera**.
- Select images from **Photo Library**.
- Displays the chosen image directly in the app.

### 4. Core Data with API Integration
- Fetches data from: [`https://api.restful-api.dev/objects`](https://api.restful-api.dev/objects)
- Stores API response in Core Data.
- Includes:
  - **List View**
  - **Delete** actions
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
- **Notifications**: Local notification 
- **PDF Viewing**: Webview - WKKIT
- **Image Handling**: UIImagePickerController
- **Permissions**: Camera & Photo Library with runtime checks
- **Theme Support**: Light Mode compatible

---

 

## 📸 App Screenshot and Video

![App Screenshot](https://github.com/user-attachments/assets/7c2c3344-54db-4efd-9e55-c20707efb119)
![AppVideo]([https://drive.google.com/file/d/1l0rKTZTVf_HN_kdXgrUW_s1GWmjPcPlo/view?usp=drive_link)




## 🔧 Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/AbhayChaurasia/Assignment_CoreData.git
