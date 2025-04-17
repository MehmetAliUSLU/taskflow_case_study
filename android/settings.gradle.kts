pluginManagement {
    val flutterSdkPath = run {
        val p = java.util.Properties()
        file("local.properties").inputStream().use { p.load(it) }
        p.getProperty("flutter.sdk") ?: error("flutter.sdk not set in local.properties")
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }

    // -------------- PLUG‑IN SÜRÜMLERİ --------------
    plugins {
        id("dev.flutter.flutter-plugin-loader") version "1.0.0"

        // Android Gradle Plugin (8.4 alpha sürümü Kotlin 2.1 uyumlu)
        id("com.android.application") version "8.4.2" apply false

        // Google Services
        id("com.google.gms.google-services") version "4.4.2" apply false

        // Kotlin Gradle Plugin (2.1.x ≥ Firebase 23.2’nin gerektirdiği 2.1 metadata)
        id("org.jetbrains.kotlin.android") version "2.1.0" apply false
    }
}

include(":app")
