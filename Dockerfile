FROM registry.access.redhat.com/ubi8/openjdk-17@sha256:af89db92dc06af468e0899843981878b8b7c448007ab0fdc7abee2398f2528fe as build
WORKDIR /workspace/app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

RUN ./mvnw install -DskipTests
RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)

FROM registry.access.redhat.com/ubi8/openjdk-17@sha256:af89db92dc06af468e0899843981878b8b7c448007ab0fdc7abee2398f2528fe
VOLUME /tmp
ARG DEPENDENCY=/workspace/app/target/dependency
COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app
ENTRYPOINT ["java","-cp","app:app/lib/*","com.example.demo.DemoApplication"]
