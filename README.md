# Java Dur - 의약품 안전사용 전문회사

Java와 MySQL을 활용한 의약품 정보 관리 웹사이트입니다.

## 주요 기능

### 1. 사용자 관리
- **회원가입**: 신규 사용자 등록
- **로그인/로그아웃**: 세션 기반 인증
- **프로필 수정**: 회원정보 업데이트

### 2. 게시판
- **게시글 목록**: 페이징 기능이 있는 게시글 목록
- **게시글 보기**: 상세 내용 및 조회수 증가
- **게시글 작성**: 로그인한 사용자만 작성 가능
- **게시글 수정/삭제**: 작성자만 수정 및 삭제 가능

### 3. 의약정보
- **성분명 검색**: 의약품 성분으로 검색
- **효능별 조회**: 진통제, 해열제, 소화제 등 효능별 분류

### 4. About Us
- 회사 소개 및 서비스 안내

## 기술 스택

- **Backend**: Spring Boot 2.7.14, Spring Data JPA
- **Frontend**: JSP, JSTL
- **Database**: MySQL 8.0
- **Build Tool**: Maven
- **Java Version**: 11

## 프로젝트 구조

```
java_dur/
├── src/
│   ├── main/
│   │   ├── java/com/javadur/
│   │   │   ├── JavaDurApplication.java
│   │   │   ├── DataInitializer.java
│   │   │   ├── controller/
│   │   │   │   ├── HomeController.java
│   │   │   │   ├── UserController.java
│   │   │   │   ├── BoardController.java
│   │   │   │   └── MedicineController.java
│   │   │   ├── entity/
│   │   │   │   ├── User.java
│   │   │   │   ├── Board.java
│   │   │   │   └── Medicine.java
│   │   │   ├── repository/
│   │   │   │   ├── UserRepository.java
│   │   │   │   ├── BoardRepository.java
│   │   │   │   └── MedicineRepository.java
│   │   │   └── service/
│   │   │       ├── UserService.java
│   │   │       ├── BoardService.java
│   │   │       └── MedicineService.java
│   │   ├── resources/
│   │   │   └── application.properties
│   │   └── webapp/
│   │       └── WEB-INF/
│   │           └── views/
│   │               ├── index.jsp
│   │               ├── about.jsp
│   │               ├── common/
│   │               ├── user/
│   │               ├── board/
│   │               └── medicine/
│   └── test/
└── pom.xml
```

## 설치 및 실행 방법

### 사전 요구사항
- JDK 11 이상
- Maven 3.6 이상
- MySQL 8.0 이상

### 1. MySQL 데이터베이스 설정

MySQL에 접속하여 데이터베이스를 생성합니다:

```sql
CREATE DATABASE javadur CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 2. 데이터베이스 연결 설정

`src/main/resources/application.properties` 파일에서 데이터베이스 연결 정보를 수정합니다:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/javadur?createDatabaseIfNotExist=true&useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
spring.datasource.username=root
spring.datasource.password=your_password
```

### 3. 프로젝트 빌드 및 실행

```bash
# 프로젝트 디렉토리로 이동
cd java_dur

# Maven으로 빌드
mvn clean install

# 애플리케이션 실행
mvn spring-boot:run
```

### 4. 애플리케이션 접속

브라우저에서 `http://localhost:8080`으로 접속합니다.

## 초기 데이터

애플리케이션 실행 시 자동으로 샘플 의약품 데이터가 생성됩니다:
- 타이레놀 (진통제)
- 부루펜 (진통제)
- 베아제 (소화제)
- 게보린 (해열제)
- 판피린 (감기약)
- 지르텍 (알레르기약)
- 아모잘탄 (고혈압약)
- 다이아벡스 (당뇨약)

## 사용 가이드

1. **회원가입**: 메인 페이지에서 "회원가입" 버튼을 클릭하여 계정을 생성합니다.
2. **로그인**: 생성한 계정으로 로그인합니다.
3. **게시판 이용**: 상단 메뉴에서 "게시판"을 클릭하여 글을 작성하고 조회할 수 있습니다.
4. **의약정보 검색**: "의약정보" 메뉴에서 성분명으로 검색하거나 효능별로 조회할 수 있습니다.
5. **프로필 수정**: 로그인 후 "프로필" 버튼을 클릭하여 회원정보를 수정할 수 있습니다.

## 라이선스

Copyright © 2026 Java Dur - 의약품 안전사용 전문회사
