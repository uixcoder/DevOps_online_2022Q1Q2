## 1. Install

https://docs.sonarqube.org/latest/setup/install-server/

I used sonarqube image for docker compose

https://www.cprime.com/resources/blog/running-sonarqube/

Set parameters on docker host machine

```
$ sudo sysctl -w vm.max_map_count=524288
$ sudo sysctl -w fs.file-max=131072
$ ulimit -n 131072
$ ulimit -u 8192
```

`$ docker compose -f config.yml up`

OR SEPARATELY

```
$ docker volume create --name sonarqube_data
$ docker volume create --name sonarqube_logs
$ docker volume create --name sonarqube_extensions

$ docker run -d --name sonarqube \
    -p 9000:9000 \
    -e SONAR_JDBC_URL=... \
    -e SONAR_JDBC_USERNAME=... \
    -e SONAR_JDBC_PASSWORD=... \
    -v sonarqube_data:/opt/sonarqube/data \
    -v sonarqube_extensions:/opt/sonarqube/extensions \
    -v sonarqube_logs:/opt/sonarqube/logs \
    sonarqube
```

Login (admin/admin) and change password 

`http://10.1.1.60:9000`

## 2. Install java, maven

`$ sudo apt-get install openjdk-11`

`$ sudo apt-get install maven`

## 3. Configure SonarQube and add SonarScanner for Maven

https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-maven/

Add to pom.xml file into corresponding sections

```

  <dependencies>
    <dependency>
      <groupId>com.google.guava</groupId>
      <artifactId>guava</artifactId>
      <version>29.0-jre</version>
    </dependency>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.13.1</version>
      <scope>test</scope>
    </dependency>
  </dependencies>

  <build>
    <pluginManagement>
      <plugins>
        <plugin>
          <groupId>org.apache.maven.plugins</groupId>
          <artifactId>maven-compiler-plugin</artifactId>
          <version>3.8.1</version>
        </plugin>
        <plugin>
          <groupId>org.sonarsource.scanner.maven</groupId>
          <artifactId>sonar-maven-plugin</artifactId>
          <version>3.7.0.1746</version>
        </plugin>
        <plugin>
          <groupId>org.jacoco</groupId>
          <artifactId>jacoco-maven-plugin</artifactId>
          <version>0.8.6</version>
        </plugin>
      </plugins>
    </pluginManagement>
  </build>

  <profiles>
    <profile>
      <id>coverage</id>
      <activation>
        <activeByDefault>true</activeByDefault>
      </activation>
      <build>
        <plugins>
          <plugin>
            <groupId>org.jacoco</groupId>
            <artifactId>jacoco-maven-plugin</artifactId>
            <executions>
              <execution>
                <id>prepare-agent</id>
                <goals>
                  <goal>prepare-agent</goal>
                </goals>
              </execution>
              <execution>
                <id>report</id>
                <goals>
                  <goal>report</goal>
                </goals>
              </execution>
            </executions>
          </plugin>
        </plugins>
      </build>
    </profile>
  </profiles>
</project>

``` 


Generate access token (My Account -> Security) and use it to check project

`$ mvn clean verify sonar:sonar -Dsonar.login=c3d2b63c64ba995feb39f86180413238eac3715b`
