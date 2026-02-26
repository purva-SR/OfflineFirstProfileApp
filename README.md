# OfflineFirstProfileApp

An iOS application demonstrating an **Offline-First architecture** using SwiftUI and Clean Architecture principles.

The app allows users to edit and save profile data locally when offline, and automatically syncs locally updated data when the device is connected to internet.

---

## 🚀 Features

- Edit and save profile details
- Offline data persistence using Core Data
- Auto-sync to file storage when network becomes available
- Input validation in Domain layer
- Unit test coverage
- Snapshot testing for UI regression

---

## 🏗 Architecture

The project follows **Clean Architecture** with clear separation of concerns:
```text
OfflineFirstProfileApp
│
├── Presentation
│   ├── ProfileView (SwiftUI)
│   └── ProfileViewModel
│
├── Domain
│   ├── Entities
│   │   └── Profile
│   ├── Repository Protocol (ProfileRepo)
│   ├── UseCases
│   │   ├── ProfileUseCase
│   │   └── SyncProfileUseCase
│   └── Validation
│
├── Data
│   ├── CoreDataStack
│   ├── CoreDataProfileRepo
│   ├── NetworkMonitor
│   └── FileSyncService
│
└── Application
    └── SyncManager
```


### Flow

View  
→ ViewModel  
→ UseCase (Validation + Business Rules)  
→ Repository  
→ Core Data / File Storage  

---

## 📴 Offline-First Behavior

1. Profile is saved locally in Core Data.
2. `isSynced = false` for updated records.
3. When network becomes available:
   - `SyncManager` detects connectivity.
   - Unsynced profiles are written to local file storage.
   - `isSynced` flag is updated to `true`.

---

## 🌐 Network Monitoring

Uses `NWPathMonitor` to detect connectivity changes.

Sync is triggered only when:
- Network becomes available
- Unsynced data exists

---

## ✅ Validation

All validation rules are implemented in the **Domain layer** inside `ProfileUseCase`.

Validated fields:

- Name (min 3 characters, alphabets only)
- Phone number (10 digits)
- Email (valid format)
- Address (min length 5)
- Pincode (6 digits)

---

## 🧪 Unit Testing

Unit tests cover:

- CoreDataProfileRepo
- ProfileUseCase
- SyncProfileUseCase
- FileSyncService

Uses:
- In-memory Core Data for isolation
- Mock FileSyncService for sync logic tests

---

## 📸 Snapshot Testing

Snapshot testing implemented using:

- SnapshotTesting (via Swift Package Manager)

Covers:
- ProfileView UI regression

Snapshots stored under:

OfflineFirstProfileAppTests/SnapShotsTests/__Snapshots__

---

## 🛠 Tech Stack

- Swift
- SwiftUI
- Core Data
- Combine
- NWPathMonitor
- XCTest
- SnapshotTesting (SPM)

---

## 📦 Dependencies

Added via Swift Package Manager:

- SnapshotTesting

---

## ▶️ How To Run

1. Clone repository
2. Open `.xcodeproj`
3. Run on simulator or device (device is more prefrerable as network monitoring is more accurate in device)
4. Run tests using `⌘ + U`

---

## 📌 Notes

- Designed as assignment project demonstrating offline-first architecture.
- Emphasis on clean layering and testability.
