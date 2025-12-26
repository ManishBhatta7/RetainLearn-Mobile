# RetainLearn Flutter App - Backend Integration

## Overview

The Flutter app is now configured to connect to the RetainLearn backend services.

## Backend Services

| Service | Port | Description |
|---------|------|-------------|
| TSR Health | 8003 | Teacher-Student Relationship health monitoring |
| Spaced Repetition | 8001 | Adaptive learning & review scheduling |
| Cognitive Load | 8002 | Cognitive load analysis |

## Configuration

### App Constants

Edit `lib/core/constants/app_constants.dart`:

```dart
// Set to false for production
static const bool useLocalBackend = true;

// Android emulator uses 10.0.2.2 to access host machine
static const String _localHost = '10.0.2.2';
```

### For Different Environments

| Platform | Host Address |
|----------|--------------|
| Android Emulator | `10.0.2.2` |
| iOS Simulator | `localhost` |
| Physical Device | Your machine's IP (e.g., `192.168.1.6`) |

## Available API Services

### TSR Health API Service

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adaptive_ed_coach/data/providers/repository_providers.dart';

// In a ConsumerWidget:
final dashboardAsync = ref.watch(tsrDashboardProvider('teacher-id'));

dashboardAsync.when(
  data: (response) {
    // Use response.data.totalStudents, etc.
  },
  loading: () => CircularProgressIndicator(),
  error: (e, st) => Text('Error: $e'),
);
```

### Spaced Repetition API Service

```dart
final reviewsAsync = ref.watch(scheduledReviewsProvider('student-id'));

reviewsAsync.when(
  data: (response) {
    // Use response.reviews
    for (final review in response.reviews) {
      print(review.conceptName);
    }
  },
  loading: () => CircularProgressIndicator(),
  error: (e, st) => Text('Error: $e'),
);
```

## Running the Backend

Before running the Flutter app, start the backend services:

```bash
# Terminal 1: Start TSR Health Service
cd backend/services/tsr-health
pip install fastapi uvicorn pydantic
python main.py
# Runs on http://localhost:8003

# Terminal 2 (optional): Start Spaced Repetition Service
cd backend/services/spaced-repetition
pip install fastapi uvicorn pydantic
python main.py
# Runs on http://localhost:8001
```

## Running the Flutter App

```bash
# Get dependencies
flutter pub get

# Run on Android emulator (will use 10.0.2.2 for backend)
flutter run

# Run on iOS simulator (will use localhost for backend)
flutter run
```

## Troubleshooting

### Connection Refused

1. Make sure backend services are running
2. Check if using correct host (10.0.2.2 for Android emulator)
3. Ensure `usesCleartextTraffic="true"` in AndroidManifest.xml

### Timeout Errors

1. Increase timeout in `app_constants.dart`:
   ```dart
   static const Duration apiTimeout = Duration(seconds: 60);
   ```

### CORS Issues

Backend services are configured to allow all origins by default. If issues persist, check the FastAPI CORS middleware configuration.
