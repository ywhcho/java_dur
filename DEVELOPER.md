# 개발 가이드 (Developer Guide)

## 로컬 개발 환경 설정

### IDE 설정 (IntelliJ IDEA / Eclipse)

#### IntelliJ IDEA
1. File → Open → 프로젝트 디렉토리 선택
2. Maven 프로젝트로 자동 인식
3. Run → Edit Configurations → Add New → Tomcat Server → Local
4. Deployment 탭에서 WAR 파일 추가
5. Run 실행

#### Eclipse
1. File → Import → Existing Maven Projects
2. 프로젝트 디렉토리 선택
3. 프로젝트 우클릭 → Run As → Run on Server
4. Tomcat 서버 선택

### 개발 워크플로우

1. **코드 수정**
2. **빌드**: `mvn clean compile`
3. **테스트**: 수동 테스트 또는 브라우저에서 확인
4. **패키징**: `mvn package`
5. **배포**: Tomcat에 WAR 파일 배포
6. **검증**: 브라우저에서 기능 테스트

### 핫 리로드 설정 (개발 모드)

Tomcat에서 자동 리로드 활성화:
```xml
<!-- $TOMCAT_HOME/conf/context.xml -->
<Context reloadable="true">
    ...
</Context>
```

## 프로젝트 구조 상세

### 패키지 구조
```
com.pharmacy
├── dao/          # Data Access Objects
│   ├── UserDAO.java
│   ├── BoardDAO.java
│   └── MedicineDAO.java
├── filter/       # Servlet Filters
│   └── AuthFilter.java
├── model/        # Domain Models
│   ├── User.java
│   ├── Board.java
│   └── Medicine.java
├── service/      # Business Logic
│   ├── UserService.java
│   ├── BoardService.java
│   └── MedicineService.java
├── servlet/      # Controllers
│   ├── HomeServlet.java
│   ├── UserServlet.java
│   ├── BoardServlet.java
│   └── MedicineServlet.java
└── util/         # Utilities
    ├── DatabaseUtil.java
    └── SecurityUtil.java
```

### 레이어별 역할

#### Model Layer
- 데이터베이스 테이블과 매핑되는 Java 객체
- Getter/Setter 메서드 포함
- 비즈니스 로직 없음

#### DAO Layer
- 데이터베이스 CRUD 작업
- PreparedStatement 사용 (SQL Injection 방지)
- SQLException 처리

#### Service Layer
- 비즈니스 로직 구현
- 트랜잭션 관리
- DAO 레이어 호출

#### Servlet Layer (Controller)
- HTTP 요청/응답 처리
- 입력 유효성 검증
- Service 레이어 호출
- JSP로 데이터 전달

#### Filter Layer
- 인증 검사
- 세션 관리
- 로깅

### URL 매핑

| URL | Servlet | 기능 |
|-----|---------|------|
| `/` | HomeServlet | 홈페이지 |
| `/about` | HomeServlet | 회사소개 |
| `/user/login` | UserServlet | 로그인 |
| `/user/register` | UserServlet | 회원가입 |
| `/user/logout` | UserServlet | 로그아웃 |
| `/user/profile` | UserServlet | 프로필 |
| `/board/list` | BoardServlet | 게시판 목록 |
| `/board/view/{id}` | BoardServlet | 게시글 보기 |
| `/board/create` | BoardServlet | 글쓰기 |
| `/board/edit/{id}` | BoardServlet | 글 수정 |
| `/board/delete/{id}` | BoardServlet | 글 삭제 |
| `/medicine/search` | MedicineServlet | 의약정보 검색 |
| `/medicine/view/{id}` | MedicineServlet | 의약정보 상세 |

## 코딩 컨벤션

### Java 코드
- 클래스명: PascalCase (예: `UserService`)
- 메서드명: camelCase (예: `getUserById`)
- 상수: UPPER_SNAKE_CASE (예: `PAGE_SIZE`)
- 들여쓰기: 4 spaces
- UTF-8 인코딩 사용

### JSP/HTML
- 들여쓰기: 4 spaces
- 태그 소문자 사용
- 속성값 쌍따옴표 사용

### SQL
- 키워드: 대문자 (예: `SELECT`, `FROM`)
- 테이블/컬럼명: 소문자 snake_case
- PreparedStatement 사용

## 보안 가이드라인

### 1. SQL Injection 방지
```java
// ❌ 나쁜 예
String sql = "SELECT * FROM users WHERE username = '" + username + "'";

// ✅ 좋은 예
String sql = "SELECT * FROM users WHERE username = ?";
PreparedStatement stmt = conn.prepareStatement(sql);
stmt.setString(1, username);
```

### 2. XSS 방지
```java
// HTML 이스케이프 사용
String safeContent = SecurityUtil.escapeHtml(userInput);
```

### 3. 비밀번호 해싱
```java
// BCrypt 사용
String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
boolean matches = BCrypt.checkpw(password, hashedPassword);
```

### 4. 세션 관리
```java
// 로그인 시 새 세션 생성
HttpSession session = request.getSession(true);
session.setAttribute("user", user);

// 로그아웃 시 세션 무효화
session.invalidate();
```

## 자주 하는 실수와 해결

### 1. 한글 인코딩 문제
```java
// Servlet에서
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");
```

### 2. 세션 타임아웃
```xml
<!-- web.xml -->
<session-config>
    <session-timeout>30</session-timeout> <!-- 30분 -->
</session-config>
```

### 3. 리다이렉트 vs 포워드
```java
// 리다이렉트 (URL 변경, 새로운 요청)
response.sendRedirect("/pharmacy-info/board/list");

// 포워드 (URL 유지, 같은 요청)
request.getRequestDispatcher("/WEB-INF/views/board/list.jsp").forward(request, response);
```

## 데이터베이스 마이그레이션

새로운 테이블이나 컬럼 추가 시:

1. `database/migrations/` 디렉토리에 SQL 파일 생성
   - 파일명 형식: `YYYYMMDD_description.sql`
   - 예: `20260111_add_user_phone_column.sql`

2. SQL 작성:
```sql
ALTER TABLE users ADD COLUMN phone VARCHAR(20) AFTER email;
```

3. 적용:
```bash
mysql -u root -p pharmacy_db < database/migrations/20260111_add_user_phone_column.sql
```

## 새 기능 추가 가이드

### 예: 댓글 기능 추가

#### 1. 데이터베이스 테이블 생성
```sql
CREATE TABLE comment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    board_id INT NOT NULL,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (board_id) REFERENCES board(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
```

#### 2. Model 클래스 생성
```java
// src/main/java/com/pharmacy/model/Comment.java
public class Comment {
    private int id;
    private int boardId;
    private int userId;
    private String content;
    private Timestamp createdAt;
    // getters and setters
}
```

#### 3. DAO 클래스 생성
```java
// src/main/java/com/pharmacy/dao/CommentDAO.java
public class CommentDAO {
    public List<Comment> findByBoardId(int boardId) { ... }
    public boolean createComment(Comment comment) { ... }
    public boolean deleteComment(int id) { ... }
}
```

#### 4. Service 클래스 생성
```java
// src/main/java/com/pharmacy/service/CommentService.java
public class CommentService {
    private CommentDAO commentDAO;
    
    public List<Comment> getCommentsByBoardId(int boardId) { ... }
    public boolean addComment(int boardId, int userId, String content) { ... }
}
```

#### 5. Servlet 수정 또는 새 Servlet 생성
```java
// BoardServlet에 댓글 기능 추가
@WebServlet(name = "CommentServlet", urlPatterns = {"/comment/*"})
public class CommentServlet extends HttpServlet { ... }
```

#### 6. JSP 페이지 수정
```jsp
<!-- board/view.jsp에 댓글 섹션 추가 -->
<div class="comments">
    <c:forEach var="comment" items="${comments}">
        <div class="comment">
            ${comment.content}
        </div>
    </c:forEach>
</div>
```

## 테스팅

### 수동 테스트 체크리스트

#### 회원 관리
- [ ] 회원가입 (정상)
- [ ] 회원가입 (중복 아이디)
- [ ] 회원가입 (유효하지 않은 이메일)
- [ ] 로그인 (정상)
- [ ] 로그인 (잘못된 비밀번호)
- [ ] 로그아웃
- [ ] 프로필 수정

#### 게시판
- [ ] 목록 보기 (페이징)
- [ ] 게시글 작성 (로그인 상태)
- [ ] 게시글 작성 (비로그인 상태 - 리다이렉트)
- [ ] 게시글 보기
- [ ] 게시글 수정 (작성자)
- [ ] 게시글 수정 (비작성자 - 권한 없음)
- [ ] 게시글 삭제 (작성자)

#### 의약정보
- [ ] 검색 (성분명)
- [ ] 검색 (효능)
- [ ] 효능별 분류 클릭
- [ ] 상세 정보 보기

## 유용한 Maven 명령어

```bash
# 컴파일
mvn compile

# 테스트 (테스트가 있는 경우)
mvn test

# 패키징 (테스트 스킵)
mvn package -DskipTests

# 클린 빌드
mvn clean package

# 의존성 트리 확인
mvn dependency:tree

# 의존성 업데이트 확인
mvn versions:display-dependency-updates
```

## 트러블슈팅

### 빌드 실패
```bash
# Maven 캐시 클리어
rm -rf ~/.m2/repository

# 다시 빌드
mvn clean install
```

### Tomcat 배포 실패
```bash
# Tomcat 로그 확인
tail -f $TOMCAT_HOME/logs/catalina.out

# 권한 확인
chmod +x $TOMCAT_HOME/bin/*.sh
```

## 참고 자료

- [Java Servlet Specification](https://javaee.github.io/servlet-spec/)
- [JSP Specification](https://javaee.github.io/javaee-spec/javadocs/javax/servlet/jsp/package-summary.html)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Apache Tomcat Documentation](https://tomcat.apache.org/tomcat-9.0-doc/)
- [Bootstrap Documentation](https://getbootstrap.com/docs/5.1/)

---

**Happy Coding! 🚀**
