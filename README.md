# Tie-mobile
Teaching is easy mobile application, which helps teaching english.

## How to use

### Pre-build commands
Build everything:
```
./scripts/build.sh
``` 

Build models:
```
cd packages/domain
flutter pub run build_runner build --delete-conflicting-outputs  
```

Build Freezed data classes:
```
flutter pub run build_runner build --delete-conflicting-outputs  
``` 

Build Freezed data classes:

```
flutter pub run build_runner build --delete-conflicting-outputs
```

Generate translations:
``` 
flutter gen-l10n  
``` 

## Build & run

Before building prod Android, you need to add keystore.jks and key.properties to the project. Here's the info: https://swps.atlassian.net/wiki/spaces/AM/pages/680165377/Release+Android

Build prod:
```  
flutter run lib/main_prod.dart --flavor prod  
```  

Build dev:
```  
flutter run lib/main_dev.dart --flavor dev  
```  

## Build release

Build prod:
```  
flutter build ipa lib/main_prod.dart --flavor prod  
flutter build apk lib/main_prod.dart --flavor prod  
```  

Build dev:
```  
flutter build ipa lib/main_dev.dart --flavor dev  
flutter build apk lib/main_dev.dart --flavor dev  
```  
## Application overview

### Architecture
SWPS application uses Clean Architecture.

Application layer is in `/lib` directory. Directories are created 'by feature'.

Data layer is stored as separate project in `/packages/data` directory.

Domain layer is stored as separate project in `/packages/domain` directory.

Usecases are stored as separate project in `/packages/usecase` directory.

### State management

Application uses Bloc as state management. Dependencies are being provided via providers in root widget of the app.
