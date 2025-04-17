allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// build klasörünü kökte tek noktaya toplama (opsiyonel)
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)
subprojects {
    layout.buildDirectory.value(newBuildDir.dir(name))
}

// “clean” görevi
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
