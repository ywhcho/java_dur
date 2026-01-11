# 데이터베이스 설정 가이드

## MySQL 설치

### Windows
1. MySQL 공식 사이트에서 MySQL Installer 다운로드
2. 설치 시 "Developer Default" 선택
3. root 비밀번호 설정

### macOS (Homebrew 사용)
```bash
brew install mysql
brew services start mysql
mysql_secure_installation
```

### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install mysql-server
sudo systemctl start mysql
sudo mysql_secure_installation
```

## 데이터베이스 생성

MySQL에 root로 접속:
```bash
mysql -u root -p
```

데이터베이스 생성:
```sql
CREATE DATABASE javadur CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

사용자 생성 (선택사항):
```sql
CREATE USER 'javadur'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON javadur.* TO 'javadur'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

## 애플리케이션 설정

`src/main/resources/application.properties` 파일에서 데이터베이스 연결 정보를 수정합니다:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/javadur?createDatabaseIfNotExist=true&useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
spring.datasource.username=root
spring.datasource.password=your_mysql_password
```

## 테이블 스키마

애플리케이션 실행 시 JPA가 자동으로 다음 테이블을 생성합니다:

### users 테이블
- id (BIGINT, Primary Key)
- username (VARCHAR(50), Unique, Not Null)
- password (VARCHAR(255), Not Null)
- email (VARCHAR(100), Not Null)
- name (VARCHAR(50))
- phone (VARCHAR(20))
- created_at (DATETIME)

### board 테이블
- id (BIGINT, Primary Key)
- title (VARCHAR(200), Not Null)
- content (TEXT, Not Null)
- author (VARCHAR(50))
- view_count (INT, Default 0)
- created_at (DATETIME)
- updated_at (DATETIME)

### medicine 테이블
- id (BIGINT, Primary Key)
- name (VARCHAR(200), Not Null)
- ingredient (VARCHAR(200), Not Null)
- efficacy (VARCHAR(100), Not Null)
- usage (TEXT)
- side_effects (TEXT)
- precautions (TEXT)
- manufacturer (VARCHAR(100))

## 초기 데이터

애플리케이션 실행 시 `DataInitializer` 클래스가 자동으로 샘플 의약품 데이터를 생성합니다.

## 문제 해결

### 연결 오류
- MySQL 서비스가 실행 중인지 확인
- 포트 3306이 열려있는지 확인
- 방화벽 설정 확인

### 인증 오류
- MySQL 비밀번호가 올바른지 확인
- MySQL 8.0 이상 사용 시 인증 플러그인 설정:
```sql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'your_password';
FLUSH PRIVILEGES;
```
