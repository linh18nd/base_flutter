import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import com.android.build.gradle.internal.api.BaseVariantOutputImpl

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.base_flutter"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.base_flutter"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    flavorDimensions += "environment"
    productFlavors {
        create("dev") {
            dimension = "environment"
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
            resValue("string", "app_name", "Base Flutter Dev")
        }
        create("stag") {
            dimension = "environment"
            applicationIdSuffix = ".stag"
            versionNameSuffix = "-stag"
            resValue("string", "app_name", "Base Flutter Stag")
        }
        create("prod") {
            dimension = "environment"
            resValue("string", "app_name", "Base Flutter")
        }
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    // Auto-rename APK files with variant name, date, and version
    applicationVariants.all {
        val variant = this
        variant.outputs.all {
            val variantName = variant.name
            val versionName = variant.versionName
            val formattedDate = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault())
                .format(Date())
            val output = this as BaseVariantOutputImpl
            output.outputFileName = "${variantName}_${formattedDate}_${versionName}.apk"
        }
    }
}

flutter {
    source = "../.."
}
