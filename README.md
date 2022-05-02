# Electrometer

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A companion app to be used with my LoRA-WAN Electro meter project.

---

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Electrometer works on iOS, Android, and Web._

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

    ```arb
    {
        "@@locale": "en",
        "counterAppBarTitle": "Counter",
        "@counterAppBarTitle": {
            "description": "Text shown in the AppBar of the Counter Page"
        }
    }
    ```

2. Then add a new key/value and description

    ```arb
    {
        "@@locale": "en",
        "counterAppBarTitle": "Counter",
        "@counterAppBarTitle": {
            "description": "Text shown in the AppBar of the Counter Page"
        },
        "helloWorld": "Hello World",
        "@helloWorld": {
            "description": "Hello World Text"
        }
    }
    ```

3. Use the new string

    ```dart
    import 'package:electrometer/l10n/l10n.dart';

    @override
    Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Text(l10n.helloWorld);
    }
    ```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
    <array>
    <string>en</string>
    <string>es</string>
    </array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

    ```markdown
    ├── l10n
    │   ├── arb
    │   │   ├── app_en.arb
    │   │   └── app_es.arb
    ```

2. Add the translated strings to each `.arb` file:

    `app_en.arb`

    ```arb
    {
        "@@locale": "en",
        "counterAppBarTitle": "Counter",
        "@counterAppBarTitle": {
            "description": "Text shown in the AppBar of the Counter Page"
        }
    }
    ```

    `app_es.arb`

    ```arb
    {
        "@@locale": "es",
        "counterAppBarTitle": "Contador",
        "@counterAppBarTitle": {
            "description": "Texto mostrado en la AppBar de la página del contador"
        }
    }
    ```

## Flutter Doctor Output

```out
[√] Flutter (Channel stable, 2.10.5, on Microsoft Windows [Version 10.0.19044.1645], locale en-IN)
    • Flutter version 2.10.5 at D:\flutter
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision 5464c5bac7 (2 weeks ago), 2022-04-18 09:55:37 -0700
    • Engine revision 57d3bac3dd
    • Dart version 2.16.2
    • DevTools version 2.9.2

[√] Android toolchain - develop for Android devices (Android SDK version 30.0.2)
    • Android SDK at D:\androidsdks
    • Platform android-31, build-tools 30.0.2
    • ANDROID_SDK_ROOT = D:\androidsdks
    • Java binary at: D:\Program Files\JetBrains\apps\AndroidStudio\ch-0\193.6626763\jre\bin\java
    • Java version OpenJDK Runtime Environment (build 1.8.0_242-release-1644-b01)
    • All Android licenses accepted.

[√] Chrome - develop for the web
    • Chrome at C:\Program Files (x86)\Google\Chrome\Application\chrome.exe

[√] Visual Studio - develop for Windows (Visual Studio Community 2019 16.8.3)
    • Visual Studio at D:\Program Files\Visual Studio
    • Visual Studio Community 2019 version 16.8.30804.86
    • Windows 10 SDK version 10.0.18362.0

[√] Android Studio (version 4.0)
    • Android Studio at D:\Program Files\JetBrains\apps\AndroidStudio\ch-0\193.6626763
    • Flutter plugin version 51.0.1
    • Dart plugin version 193.7547
    • Java version OpenJDK Runtime Environment (build 1.8.0_242-release-1644-b01)

[√] IntelliJ IDEA Ultimate Edition (version 2020.2)
    • IntelliJ at D:\Program Files\JetBrains\apps\IDEA-U\ch-0\202.6397.94
    • Flutter plugin can be installed from:
       https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
       https://plugins.jetbrains.com/plugin/6351-dart

[√] VS Code (version 1.66.2)
    • VS Code at C:\Users\dhi13man\AppData\Local\Programs\Microsoft VS Code
    • Flutter extension version 3.38.1

[√] Connected device (3 available)
    • Windows (desktop) • windows • windows-x64    • Microsoft Windows [Version 10.0.19044.1645]
    • Chrome (web)      • chrome  • web-javascript • Google Chrome 100.0.4896.127
    • Edge (web)        • edge    • web-javascript • Microsoft Edge 100.0.1185.50

[√] HTTP Host Availability
    • All required HTTP hosts are available

• No issues found!
```

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
