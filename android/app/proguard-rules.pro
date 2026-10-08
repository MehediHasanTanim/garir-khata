# Flutter / Dart
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Drift / SQLite
-keep class org.sqlite.** { *; }
-keep class com.github.davidmoten.** { *; }

# Local notifications
-keep class com.dexterous.** { *; }

# Secure storage / biometrics
-keep class com.it_nomads.fluttersecurestorage.** { *; }
-keep class androidx.biometric.** { *; }

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Gson / JSON reflection (if any plugin uses it)
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn javax.annotation.**
-dontwarn org.codehaus.mojo.animal_sniffer.*
