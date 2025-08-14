# Shiftly Mobile App (Flutter)

Employee Management System (EMS) mobile client built with Flutter, integrated with a Spring Boot backend (JWT auth, timesheets, profile).

## Prerequisites

- Flutter stable (3.22+)
- Android SDK Platform 35 and Build-Tools 35.0.0
- Java/Kotlin toolchain via Android Studio (JBR 21)
- Running backend on your machine or LAN

## Backend API base URL

Configured in `lib/services/api_config.dart`:

- Android emulator: `http://10.0.2.2:8080`
- iOS simulator/desktop: `http://localhost:8080`
- Physical device: change base to your PC IP (e.g., `http://192.168.1.50:8080`) or bind backend to `0.0.0.0`.

## Install & run

```bash
flutter clean
flutter pub get
flutter run
```

Build a debug APK:

```bash
flutter build apk --debug
```

## Features

- Authentication (login only) against Spring Boot `/api/auth/login` using username/password
- JWT persisted in `SharedPreferences` and auto-attached to all API requests
- Resolve `employeeId` after login via `/api/v1/shiftly/ems/employee/{userId}`
- Timesheet create and fetch by week/date
- Dashboard with weekly tabs (Mon–Sun), totals and overtime
- Profile page shows name/email from backend + local photo picker

## Key flows

- Auth storage keys in `SharedPreferences`:
  - `jwttoken`
  - `userDTO` (JSON string)
  - `employee_id` (int)

- Endpoints used by the app:
  - `POST /api/auth/login`
  - `GET  /api/v1/shiftly/ems/employee/{userId}`
  - `POST /api/v1/shiftly/ems/timesheets/add/{employeeId}`
  - `GET  /api/v1/shiftly/ems/timesheets/employee/{employeeId}`

## Android configuration

- compileSdkVersion: 35
- targetSdkVersion: 35
- `AndroidManifest.xml`: `android:enableOnBackInvokedCallback="true"` and `INTERNET` permission

## Troubleshooting

- Gradle daemon disappeared / JVM crash
  - Ensure SDK 35 installed
  - See `android/gradle.properties` stability flags (reduced heap, workers=1, Kotlin in-process)

- Cannot reach backend from emulator
  - Use `http://10.0.2.2:8080` (Android emulator) instead of `localhost`
  - For physical devices, use your PC IP and ensure both are on the same network

- Layout issues in dashboard
  - Dashboard uses `ListView.builder` with `shrinkWrap: true` and parent `SingleChildScrollView` to avoid unbounded height errors

## Project structure

- `lib/services/` HTTP client, auth, employee, timesheets
- `lib/update_time_sheet/` create timesheet UI + logic
- `lib/dashboard/` weekly view and totals
- `lib/profile/` profile info and local image picker

## Contributing

Create a feature branch and submit a PR. Follow Flutter lints in `analysis_options.yaml`.

