# 프로젝트 기능 명세서

## 의약정보 웹사이트 - 구현된 기능

이 문서는 구현된 모든 기능을 상세히 설명합니다.

---

## 1. 레이아웃 및 네비게이션

### 구현 사항
✅ **상단 네비게이션 바**
- Bootstrap 5 기반 반응형 네비게이션
- 브랜드 로고 및 메뉴 항목
- 모바일에서 햄버거 메뉴로 전환

✅ **메뉴 구성**
- 홈 (/)
- 게시판 (/board/list)
- 의약정보 (/medicine/search)
- About Us (/about)
- 로그인/회원가입 (비로그인 시)
- 사용자명/로그아웃 (로그인 시)

✅ **반응형 디자인**
- Desktop, Tablet, Mobile 모든 화면 크기 지원
- Bootstrap Grid System 활용
- Media Query를 통한 추가 최적화

### 파일
- `src/main/webapp/WEB-INF/views/common/header.jsp`
- `src/main/webapp/WEB-INF/views/common/footer.jsp`
- `src/main/webapp/css/style.css`

---

## 2. 회원 관리 기능

### 2.1 회원가입

✅ **입력 항목**
- 아이디 (3-20자, 영문/숫자)
- 비밀번호 (최소 6자)
- 비밀번호 확인
- 이름
- 이메일

✅ **유효성 검증**
- 클라이언트 측: JavaScript 실시간 검증
- 서버 측: SecurityUtil을 통한 검증
- 중복 아이디 확인
- 이메일 형식 검증

✅ **보안**
- BCrypt를 이용한 비밀번호 해싱
- SQL Injection 방지 (PreparedStatement)
- XSS 방지 (HTML 이스케이프)

### 파일
- `src/main/java/com/pharmacy/servlet/UserServlet.java`
- `src/main/java/com/pharmacy/service/UserService.java`
- `src/main/java/com/pharmacy/dao/UserDAO.java`
- `src/main/webapp/WEB-INF/views/user/register.jsp`

### 2.2 로그인

✅ **기능**
- 아이디/비밀번호 인증
- 세션 기반 사용자 인증
- 리다이렉트 URL 지원 (로그인 후 원래 페이지로 이동)

✅ **보안**
- 비밀번호 BCrypt 검증
- 세션 하이재킹 방지 (HttpOnly 쿠키)
- 실패 시 명확한 에러 메시지

### 파일
- `src/main/java/com/pharmacy/servlet/UserServlet.java`
- `src/main/webapp/WEB-INF/views/user/login.jsp`

### 2.3 로그아웃

✅ **기능**
- 세션 무효화
- 홈페이지로 리다이렉트

### 2.4 회원정보 수정

✅ **수정 가능 항목**
- 이름
- 이메일

✅ **제약 사항**
- 아이디 변경 불가
- 로그인한 사용자만 접근 가능

✅ **보안**
- AuthFilter를 통한 인증 확인
- 세션 정보 업데이트

### 파일
- `src/main/java/com/pharmacy/servlet/UserServlet.java`
- `src/main/webapp/WEB-INF/views/user/profile.jsp`

---

## 3. 게시판 기능

### 3.1 게시글 목록 보기

✅ **기능**
- 게시글 목록 표시 (번호, 제목, 작성자, 작성일)
- 페이징 처리 (페이지당 10개)
- 총 게시글 수 표시
- 클릭하여 상세보기 이동

✅ **페이징**
- 이전/다음 버튼
- 페이지 번호 표시
- 현재 페이지 강조

### 파일
- `src/main/java/com/pharmacy/servlet/BoardServlet.java`
- `src/main/java/com/pharmacy/service/BoardService.java`
- `src/main/java/com/pharmacy/dao/BoardDAO.java`
- `src/main/webapp/WEB-INF/views/board/list.jsp`

### 3.2 게시글 상세 보기

✅ **표시 정보**
- 제목
- 내용 (줄바꿈 유지)
- 작성자
- 작성일
- 수정일

✅ **작성자 기능**
- 수정 버튼 (작성자만 표시)
- 삭제 버튼 (작성자만 표시)

### 파일
- `src/main/webapp/WEB-INF/views/board/view.jsp`

### 3.3 게시글 작성

✅ **기능**
- 제목, 내용 입력
- 로그인 필수 (AuthFilter)
- 작성 완료 후 목록으로 이동

✅ **보안**
- HTML 이스케이프 (XSS 방지)
- 세션 기반 작성자 식별

### 파일
- `src/main/webapp/WEB-INF/views/board/create.jsp`

### 3.4 게시글 수정

✅ **기능**
- 제목, 내용 수정
- 작성자 본인만 수정 가능
- 수정 완료 후 상세보기로 이동

✅ **권한 검증**
- 작성자 ID와 현재 사용자 ID 비교
- 권한 없을 시 403 Forbidden

### 파일
- `src/main/webapp/WEB-INF/views/board/edit.jsp`

### 3.5 게시글 삭제

✅ **기능**
- 작성자 본인만 삭제 가능
- 삭제 확인 (JavaScript confirm)
- 삭제 완료 후 목록으로 이동

✅ **보안**
- CASCADE 삭제 (데이터베이스 레벨)
- 권한 검증

---

## 4. 의약정보 보기 기능

### 4.1 성분명 검색

✅ **기능**
- 검색어로 의약품 성분 검색
- 부분 일치 검색 (LIKE 쿼리)
- 검색 결과 목록 표시

✅ **검색 결과**
- 의약품명
- 성분명
- 효능 (배지로 표시)
- 용법 (요약)
- 상세보기 버튼

### 파일
- `src/main/java/com/pharmacy/servlet/MedicineServlet.java`
- `src/main/java/com/pharmacy/service/MedicineService.java`
- `src/main/java/com/pharmacy/dao/MedicineDAO.java`
- `src/main/webapp/WEB-INF/views/medicine/search.jsp`

### 4.2 효능별 보기

✅ **기능**
- 효능 카테고리 버튼으로 표시
- 클릭 시 해당 효능의 의약품 목록
- 현재 샘플 효능:
  - 해열진통제
  - 소화제
  - 항히스타민제
  - 항생제(외용)
  - 피부재생제
  - 영양제

✅ **동적 카테고리**
- 데이터베이스에서 자동으로 효능 목록 추출
- 새 의약품 추가 시 자동으로 카테고리에 표시

### 4.3 의약품 상세 정보

✅ **표시 정보**
- 의약품명
- 성분명
- 효능 (배지)
- 용법 (상세)
- 주의사항 (빨간색 강조)

✅ **UI**
- 카드 레이아웃
- 구분선으로 섹션 분리
- 가독성 높은 디자인

### 파일
- `src/main/webapp/WEB-INF/views/medicine/view.jsp`

### 4.4 샘플 데이터

✅ **포함된 의약품 (10개)**
1. 타이레놀 (아세트아미노펜 - 해열진통제)
2. 게보린 (아세트아미노펜, 카페인 - 해열진통제)
3. 판피린 (이부프로펜 - 소염진통제)
4. 아스피린 (아세틸살리실산 - 해열진통제)
5. 종근당 비타민C (아스코르브산 - 영양제)
6. 센시아 (로라타딘 - 항히스타민제)
7. 훼스탈 (판크레아틴, 디메티콘 - 소화제)
8. 베아제 (디아스타제, 판크레아틴 - 소화제)
9. 후시딘 (푸시드산 - 항생제(외용))
10. 마데카솔 (센텔라정량추출물 - 피부재생제)

---

## 5. About Us 페이지

✅ **포함 정보**
- 회사 소개: "의약품 안전사용 전문회사"
- 비전: 의약품 안전사용 지원
- 미션: 정보 제공 및 관리
- 연락처:
  - 주소
  - 전화번호
  - 이메일
  - 운영시간

### 파일
- `src/main/java/com/pharmacy/servlet/HomeServlet.java`
- `src/main/webapp/WEB-INF/views/about.jsp`

---

## 6. 보안 기능

### 6.1 SQL Injection 방지

✅ **구현 방법**
- 모든 데이터베이스 쿼리에 PreparedStatement 사용
- 사용자 입력을 직접 SQL 문자열에 포함하지 않음

### 예시
```java
String sql = "SELECT * FROM users WHERE username = ?";
PreparedStatement stmt = conn.prepareStatement(sql);
stmt.setString(1, username);
```

### 6.2 XSS (Cross-Site Scripting) 방지

✅ **구현 방법**
- Apache Commons Text의 StringEscapeUtils 사용
- 사용자 입력 HTML 이스케이프
- 게시글 제목, 내용에 적용

### 파일
- `src/main/java/com/pharmacy/util/SecurityUtil.java`

### 6.3 비밀번호 보안

✅ **구현 방법**
- BCrypt 해싱 알고리즘 사용
- Salt 자동 생성
- 평문 비밀번호 저장하지 않음

### 6.4 세션 보안

✅ **설정**
- HttpOnly 쿠키 설정 (XSS 방지)
- 30분 세션 타임아웃
- 로그아웃 시 세션 무효화

### 파일
- `src/main/webapp/WEB-INF/web.xml`

### 6.5 인증 필터

✅ **보호 경로**
- `/board/create` - 글쓰기
- `/board/edit` - 글 수정
- `/board/delete` - 글 삭제
- `/user/profile` - 프로필

✅ **동작**
- 로그인하지 않은 사용자는 로그인 페이지로 리다이렉트
- 로그인 후 원래 페이지로 돌아감

### 파일
- `src/main/java/com/pharmacy/filter/AuthFilter.java`

---

## 7. 데이터베이스 설계

### 7.1 Users 테이블
```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### 7.2 Board 테이블
```sql
CREATE TABLE board (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    author_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE CASCADE
);
```

### 7.3 Medicine 테이블
```sql
CREATE TABLE medicine (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    ingredient VARCHAR(200) NOT NULL,
    efficacy VARCHAR(100) NOT NULL,
    usage TEXT NOT NULL,
    precautions TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

## 8. 기술 스택 상세

### Backend
- **Java**: 11
- **Servlet**: 4.0
- **JSP**: 2.3
- **JSTL**: 1.2

### Database
- **MySQL**: 8.0
- **JDBC Driver**: mysql-connector-j 8.3.0 (patched security vulnerabilities)

### Security
- **Password Hashing**: jBCrypt 0.4
- **XSS Prevention**: Apache Commons Text 1.10.0

### Frontend
- **HTML5**: 시맨틱 마크업
- **CSS3**: 커스텀 스타일
- **Bootstrap**: 5.1.3 (CDN)
- **JavaScript**: ES6+

### Build & Deploy
- **Build Tool**: Maven 3.x
- **Server**: Apache Tomcat 9.0+
- **Package**: WAR

---

## 9. 프로젝트 구조

### 계층 아키텍처

```
Presentation Layer (JSP/Servlet)
         ↓
Service Layer (Business Logic)
         ↓
DAO Layer (Data Access)
         ↓
Database (MySQL)
```

### 패키지 구조

- **dao**: 데이터 접근 객체
- **filter**: 서블릿 필터
- **model**: 도메인 모델
- **service**: 비즈니스 로직
- **servlet**: HTTP 컨트롤러
- **util**: 유틸리티 클래스

---

## 10. 추가 기능 및 특징

### 10.1 에러 처리

✅ **구현 사항**
- 404 에러 페이지
- 500 에러 페이지
- 사용자 친화적 에러 메시지
- 로깅

### 10.2 입력 유효성 검증

✅ **클라이언트 측**
- HTML5 validation
- JavaScript 실시간 검증
- 정규표현식 패턴

✅ **서버 측**
- SecurityUtil을 통한 검증
- 이메일 형식 검증
- 아이디/비밀번호 규칙 검증

### 10.3 UX/UI 개선

✅ **구현 사항**
- 반응형 디자인
- 호버 효과
- 로딩 피드백
- 성공/실패 메시지
- 확인 다이얼로그

### 10.4 성능 최적화

✅ **구현 사항**
- 페이징 처리 (게시판)
- 인덱스 설정 (데이터베이스)
- 커넥션 풀 준비 (설정 파일)

---

## 11. 테스트 시나리오

### 회원 관리
1. 회원가입 → 자동 로그인 → 프로필 확인
2. 로그아웃 → 로그인 → 프로필 수정
3. 중복 아이디로 회원가입 시도 (실패 확인)
4. 잘못된 비밀번호로 로그인 시도 (실패 확인)

### 게시판
1. 비로그인 상태에서 글쓰기 시도 → 로그인 페이지 리다이렉트
2. 로그인 후 글 작성 → 목록에서 확인
3. 작성한 글 수정 → 변경사항 확인
4. 다른 사용자 글 수정 시도 → 권한 없음 확인
5. 글 삭제 → 목록에서 사라짐 확인

### 의약정보
1. 성분명 검색 (예: "아세트아미노펜") → 결과 확인
2. 효능별 보기 (예: "해열진통제") → 결과 확인
3. 의약품 상세보기 → 모든 정보 표시 확인
4. 존재하지 않는 검색어 → "검색 결과 없음" 메시지

---

## 12. 향후 개선 가능 사항

### 기능 추가
- [ ] 댓글 기능
- [ ] 게시글 검색
- [ ] 좋아요/북마크
- [ ] 비밀번호 찾기
- [ ] 이메일 인증
- [ ] 관리자 페이지

### 성능 개선
- [ ] Redis 캐싱
- [ ] CDN 사용
- [ ] 이미지 최적화
- [ ] 데이터베이스 쿼리 최적화

### 보안 강화
- [ ] HTTPS 적용
- [ ] CSRF 토큰
- [ ] Rate Limiting
- [ ] 2단계 인증

### UX 개선
- [ ] AJAX를 통한 비동기 처리
- [ ] 실시간 알림
- [ ] 다크 모드
- [ ] 다국어 지원

---

**프로젝트 버전**: 1.0.0  
**최종 업데이트**: 2026-01-11
