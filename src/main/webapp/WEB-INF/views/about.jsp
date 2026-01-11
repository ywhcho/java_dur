<%@ include file="common/header.jsp" %>

<style>
    .about-section {
        margin-bottom: 2rem;
    }
    
    .about-section h2 {
        color: #2c3e50;
        border-bottom: 3px solid #3498db;
        padding-bottom: 0.5rem;
        margin-bottom: 1rem;
    }
    
    .about-section p {
        line-height: 1.8;
        margin-bottom: 1rem;
    }
    
    .company-info {
        background: #ecf0f1;
        padding: 2rem;
        border-radius: 8px;
        margin-top: 2rem;
    }
    
    .company-info h3 {
        color: #2c3e50;
        margin-bottom: 1rem;
    }
    
    .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 1rem;
        margin-top: 1rem;
    }
    
    .info-item {
        background: white;
        padding: 1rem;
        border-radius: 4px;
    }
    
    .info-item strong {
        color: #3498db;
        display: block;
        margin-bottom: 0.5rem;
    }
</style>

<h1>About Us</h1>

<div class="about-section">
    <h2>회사 소개</h2>
    <p>
        Java Dur는 <strong>의약품 안전사용 전문회사</strong>로서, 
        국민의 건강과 안전을 최우선으로 생각하며 의약품에 대한 정확하고 신뢰할 수 있는 정보를 제공합니다.
    </p>
    <p>
        우리는 의약품의 올바른 사용을 돕고, 의약품 관련 정보를 쉽게 접근할 수 있도록 
        최신 웹 기술을 활용한 플랫폼을 제공하고 있습니다.
    </p>
</div>

<div class="about-section">
    <h2>우리의 미션</h2>
    <p>
        의약품 정보의 접근성을 높이고, 안전한 의약품 사용 문화를 조성하여 
        국민 건강 증진에 기여하는 것이 우리의 사명입니다.
    </p>
</div>

<div class="about-section">
    <h2>주요 서비스</h2>
    <div class="info-grid">
        <div class="info-item">
            <strong>성분명 검색</strong>
            <p>의약품의 주요 성분을 기준으로 상세한 정보를 검색할 수 있습니다.</p>
        </div>
        <div class="info-item">
            <strong>효능별 조회</strong>
            <p>특정 효능을 가진 의약품들을 카테고리별로 쉽게 찾아볼 수 있습니다.</p>
        </div>
        <div class="info-item">
            <strong>사용자 커뮤니티</strong>
            <p>게시판을 통해 의약품 관련 정보와 경험을 공유할 수 있습니다.</p>
        </div>
        <div class="info-item">
            <strong>안전 정보 제공</strong>
            <p>의약품 부작용, 주의사항 등 안전사용을 위한 종합 정보를 제공합니다.</p>
        </div>
    </div>
</div>

<div class="company-info">
    <h3>회사 정보</h3>
    <div class="info-grid">
        <div class="info-item">
            <strong>회사명</strong>
            <p>Java Dur</p>
        </div>
        <div class="info-item">
            <strong>설립</strong>
            <p>2026년</p>
        </div>
        <div class="info-item">
            <strong>사업 분야</strong>
            <p>의약품 안전사용 정보 제공</p>
        </div>
        <div class="info-item">
            <strong>연락처</strong>
            <p>info@javadur.com</p>
        </div>
    </div>
</div>

<div style="text-align: center; margin-top: 2rem; padding: 2rem; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border-radius: 8px;">
    <h3>의약품 안전사용, Java Dur와 함께하세요</h3>
    <p style="margin-top: 1rem;">정확한 정보, 안전한 사용</p>
</div>

<%@ include file="common/footer.jsp" %>
