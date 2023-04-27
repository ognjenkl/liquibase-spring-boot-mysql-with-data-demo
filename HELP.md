## Liquibase from and to MySQL database with data

### 1. Generate changelog with data from existing MySQL database

1. Create Spring Boot project with liquibase dependency
```xml
<dependency>
    <groupId>org.liquibase</groupId>
    <artifactId>liquibase-core</artifactId>
</dependency>
```
2. Execute `resource/db/shop.sql` script to create schema and data
3. Add liquibase properties to `application.properties`
```properties
spring.liquibase.change-log=classpath:db/changelog/db.changelog-master.xml
spring.liquibase.enabled=false
```
4. Create `resource/db/db.changelog-master.xml`
```xml
<databaseChangeLog
    xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog
    http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.1.xsd">
    
    <include file="init.xml" relativeToChangelogFile="true"/>
    
</databaseChangeLog>
```
5. Create `resource/liquibase.yaml`
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/shop
    password: root
    username: root
```
6. Add liquibase plugin to `pom.xlm`
```xml
<plugin>
    <groupId>org.liquibase</groupId>
    <artifactId>liquibase-maven-plugin</artifactId>
    <version>4.21.1</version>
    <configuration>
        <propertyFile>src/main/resources/liquibase.yaml</propertyFile>
        <changeLogFile>src/main/resources/db/changelog/db.changelog-master.xml</changeLogFile>
        <outputChangeLogFile>src/main/resources/db/changelog/init.xml</outputChangeLogFile>
        <verbose>true</verbose>
        <logging>debug</logging>
        <diffTypes>tables,views,columns,indexes,foreignkeys,primarykeys,uniqueconstraints,data</diffTypes>
    </configuration>
</plugin>
```
7. Create `init-db.xml` file by executing 
`liquibase generateChangeLog` command
(for demo used Intellij's Maven plugin liquibase)

##### Result: 
Created `db/changelog/init.xml` file with all 
inital tables and data

### 2. Generate tables and data from changelog
1. Create database schema `shop` in MqSQL database
2. Execute `liquibase update` command (for demo used Intellij's Maven plugin liquibase)

##### Result:
Created four tables (with data): databasechangelog,
databasechangeloglock, order_item, purchase_order