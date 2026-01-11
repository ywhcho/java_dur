<%@ include file="../common/header.jsp" %>

<style>
    .medicine-options {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 2rem;
        margin-top: 2rem;
    }
    
    .option-card {
        background: white;
        padding: 2rem;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        text-align: center;
        transition: transform 0.3s;
    }
    
    .option-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 20px rgba(0,0,0,0.2);
    }
    
    .option-icon {
        font-size: 4rem;
        margin-bottom: 1rem;
    }
    
    .option-card h3 {
        color: #2c3e50;
        margin-bottom: 1rem;
    }
    
    .option-card p {
        color: #7f8c8d;
        margin-bottom: 1.5rem;
    }
</style>

<h1>의약정보</h1>
<p style="color: #7f8c8d; margin-bottom: 2rem;">
    의약품의 성분명 검색 또는 효능별로 정보를 조회할 수 있습니다.
</p>

<div class="medicine-options">
    <div class="option-card">
        <div class="option-icon">🔍</div>
        <h3>성분명 검색</h3>
        <p>의약품의 주요 성분을 검색하여 관련 정보를 찾아보세요.</p>
        <a href="${pageContext.request.contextPath}/medicine/search" class="btn">검색하기</a>
    </div>
    
    <div class="option-card">
        <div class="option-icon">📊</div>
        <h3>효능별 보기</h3>
        <p>특정 효능을 가진 의약품들을 카테고리별로 조회하세요.</p>
        <a href="${pageContext.request.contextPath}/medicine/efficacy" class="btn">조회하기</a>
    </div>
</div>

<div style="margin-top: 3rem; padding: 2rem; background: #ecf0f1; border-radius: 8px;">
    <h3>의약품 안전 정보</h3>
    <ul style="margin-top: 1rem; line-height: 2;">
        <li>의약품 복용 전 반드시 사용설명서를 읽어주세요.</li>
        <li>처방된 용량과 복용 방법을 정확히 지켜주세요.</li>
        <li>부작용이 발생하면 즉시 의사나 약사와 상담하세요.</li>
        <li>어린이의 손이 닿지 않는 곳에 보관하세요.</li>
    </ul>
</div>

<%@ include file="../common/footer.jsp" %>
