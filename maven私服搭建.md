# Sonatype Nexus Repository
https://help.sonatype.com/repomanager3/download



## 引用与发布
```xml
    <dependencies>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-core</artifactId>
            <version>4.2.6.RELEASE</version>
        </dependency>
    </dependencies>
    <!-- 发布到私服 -->
    <distributionManagement>
        <repository>
            <id>releases</id>
            <url>http://localhost:8091/nexus/content/repositories/releases</url>
        </repository>

        <snapshotRepository>
            <id>snapshots</id>
            <url>http://localhost:8091/nexus/content/repositories/snapshots</url>
        </snapshotRepository>
    </distributionManagement>
```