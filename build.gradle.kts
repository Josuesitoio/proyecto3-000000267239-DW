plugins {
    id("java")
    id("war")
}

group = "mx.edu.itson"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    // API de Jakarta Servlet 6.0 (provista por Apache Tomcat 10.1+)
    compileOnly("jakarta.servlet:jakarta.servlet-api:6.0.0")

    // Driver JDBC para SQLite local auto-contenida
    implementation("org.xerial:sqlite-jdbc:3.46.1.3")
    // SLF4J NOP para silenciar advertencias de logging de sqlite-jdbc en consola
    implementation("org.slf4j:slf4j-nop:2.0.16")

    // JSTL 3.0 API + Implementación oficial Eclipse GlassFish WaSP/Standard
    implementation("jakarta.servlet.jsp.jstl:jakarta.servlet.jsp.jstl-api:3.0.2")
    implementation("org.glassfish.web:jakarta.servlet.jsp.jstl:3.0.1")

    // Testing (JUnit 5)
    testImplementation(platform("org.junit:junit-bom:5.10.3"))
    testImplementation("org.junit.jupiter:junit-jupiter")
    testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}

tasks.withType<JavaCompile> {
    options.encoding = "UTF-8"
}

tasks.test {
    useJUnitPlatform()
}
