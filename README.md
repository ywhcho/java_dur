# 의약정보 웹사이트 (Pharmacy Information System)

Java와 MySQL을 사용한 의약품 안전사용 정보 제공 웹사이트

## 기술 스택

- **Backend**: Java 11, Servlet/JSP
- **Database**: MySQL 8.0
- **Frontend**: HTML5, CSS3, JavaScript, Bootstrap 5
- **Build Tool**: Maven
- **Server**: Apache Tomcat 9.0+

## 주요 기능

### 1. 회원 관리
- 회원가입 (아이디, 비밀번호, 이름, 이메일)
- 로그인/로그아웃 (세션 기반)
- 회원정보 수정
- BCrypt 비밀번호 해싱

### 2. 게시판
- 게시글 목록 보기 (페이징 처리)
- 게시글 상세 보기
- 게시글 작성 (로그인 필요)
- 게시글 수정/삭제 (작성자만 가능)

### 3. 의약정보 검색
- 성분명으로 검색
- 효능별 분류 및 검색
- 의약품 상세 정보 (성분명, 효능, 용법, 주의사항)

### 4. 보안
- SQL Injection 방지 (PreparedStatement 사용)
- XSS 방지 (HTML 이스케이프)
- 비밀번호 해싱 (BCrypt)
- 세션 보안 설정

## 설치 및 실행

### 사전 요구사항

1. JDK 11 이상
2. Maven 3.6 이상
3. MySQL 8.0 이상
4. Apache Tomcat 9.0 이상

### 데이터베이스 설정

1. MySQL에 접속하여 데이터베이스 생성:
```bash
mysql -u root -p
```

2. 스키마 생성:
```bash
source database/schema.sql
```

3. 샘플 데이터 삽입:
```bash
source database/sample_data.sql
```

4. `src/main/resources/db.properties` 파일에서 데이터베이스 연결 정보 수정:
```properties
db.url=jdbc:mysql://localhost:3306/pharmacy_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
db.username=root
db.password=your_password
```

### 빌드 및 실행

1. 프로젝트 클론:
```bash
git clone <repository_url>
cd java_dur
```

2. Maven으로 빌드:
```bash
mvn clean package
```

3. WAR 파일을 Tomcat의 webapps 디렉토리에 배포:
```bash
cp target/pharmacy-info.war $TOMCAT_HOME/webapps/
```

4. Tomcat 시작:
```bash
$TOMCAT_HOME/bin/startup.sh  # Linux/Mac
$TOMCAT_HOME\bin\startup.bat  # Windows
```

5. 브라우저에서 접속:
```
http://localhost:8080/pharmacy-info/
```

## 프로젝트 구조

```
java_dur/
├── database/                  # 데이터베이스 스크립트
│   ├── schema.sql            # 테이블 스키마
│   └── sample_data.sql       # 샘플 데이터
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/pharmacy/
│   │   │       ├── dao/      # 데이터 접근 계층
│   │   │       ├── filter/   # 인증 필터
│   │   │       ├── model/    # 엔티티 모델
│   │   │       ├── service/  # 비즈니스 로직
│   │   │       ├── servlet/  # 컨트롤러
│   │   │       └── util/     # 유틸리티
│   │   ├── resources/        # 리소스 파일
│   │   │   └── db.properties # DB 설정
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   ├── views/    # JSP 페이지
│   │       │   └── web.xml   # 웹 설정
│   │       ├── css/          # 스타일시트
│   │       └── js/           # JavaScript
└── pom.xml                   # Maven 설정
```

## 데이터베이스 스키마

### users (회원)
- id, username, password, name, email, created_at, updated_at

### board (게시판)
- id, title, content, author_id, created_at, updated_at

### medicine (의약정보)
- id, name, ingredient, efficacy, usage, precautions, created_at

## 개발자

- 의약품 안전사용 전문회사

## 라이센스

MIT License
