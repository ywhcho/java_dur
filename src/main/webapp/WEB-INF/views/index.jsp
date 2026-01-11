<%@ include file="common/header.jsp" %>

<style>
    .hero {
        text-align: center;
        padding: 3rem 0;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-radius: 8px;
        margin-bottom: 2rem;
    }
    
    .hero h1 {
        font-size: 2.5rem;
        margin-bottom: 1rem;
    }
    
    .hero p {
        font-size: 1.2rem;
    }
    
    .features {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 2rem;
        margin-top: 2rem;
    }
    
    .feature-card {
        background: white;
        padding: 2rem;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        text-align: center;
        transition: transform 0.3s;
    }
    
    .feature-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 20px rgba(0,0,0,0.2);
    }
    
    .feature-icon {
        font-size: 3rem;
        margin-bottom: 1rem;
    }
    
    .feature-card h3 {
        color: #2c3e50;
        margin-bottom: 0.5rem;
    }
    
    .feature-card p {
        color: #7f8c8d;
    }
</style>

<div class="hero">
    <h1>의약품 안전사용 전문회사</h1>
    <p>Java Dur에 오신 것을 환영합니다</p>
</div>

<div class="features">
    <div class="feature-card">
        <div class="feature-icon">👥</div>
        <h3>회원 관리</h3>
        <p>회원가입, 로그인, 프로필 관리</p>
        <c:if test="${empty sessionScope.user}">
            <a href="${pageContext.request.contextPath}/user/register" class="btn" style="margin-top: 1rem;">회원가입</a>
        </c:if>
    </div>
    
    <div class="feature-card">
        <div class="feature-icon">📋</div>
        <h3>게시판</h3>
        <p>정보 공유 및 소통 공간</p>
        <c:if test="${not empty sessionScope.user}">
            <a href="${pageContext.request.contextPath}/board" class="btn" style="margin-top: 1rem;">게시판 보기</a>
        </c:if>
    </div>
    
    <div class="feature-card">
        <div class="feature-icon">💊</div>
        <h3>의약정보</h3>
        <p>성분명 검색, 효능별 조회</p>
        <c:if test="${not empty sessionScope.user}">
            <a href="${pageContext.request.contextPath}/medicine" class="btn" style="margin-top: 1rem;">의약정보 보기</a>
        </c:if>
    </div>
    
    <div class="feature-card">
        <div class="feature-icon">ℹ️</div>
        <h3>About Us</h3>
        <p>회사 소개 및 안내</p>
        <c:if test="${not empty sessionScope.user}">
            <a href="${pageContext.request.contextPath}/about" class="btn" style="margin-top: 1rem;">자세히 보기</a>
        </c:if>
    </div>
</div>

<c:if test="${empty sessionScope.user}">
    <div style="text-align: center; margin-top: 3rem; padding: 2rem; background: #ecf0f1; border-radius: 8px;">
        <h2>시작하기</h2>
        <p style="margin: 1rem 0;">Java Dur의 모든 기능을 이용하려면 로그인이 필요합니다.</p>
        <a href="${pageContext.request.contextPath}/user/login" class="btn" style="margin-right: 1rem;">로그인</a>
        <a href="${pageContext.request.contextPath}/user/register" class="btn btn-secondary">회원가입</a>
    </div>
</c:if>

<%@ include file="common/footer.jsp" %>
