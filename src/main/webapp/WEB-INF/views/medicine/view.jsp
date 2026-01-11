<%@ include file="../common/header.jsp" %>

<style>
    .medicine-detail {
        max-width: 900px;
        margin: 0 auto;
    }
    
    .medicine-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 2rem;
        border-radius: 8px;
        margin-bottom: 2rem;
    }
    
    .medicine-header h1 {
        margin-bottom: 1rem;
    }
    
    .medicine-header .meta {
        display: flex;
        gap: 2rem;
        flex-wrap: wrap;
    }
    
    .info-section {
        background: white;
        padding: 2rem;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        margin-bottom: 2rem;
    }
    
    .info-section h2 {
        color: #2c3e50;
        border-bottom: 2px solid #3498db;
        padding-bottom: 0.5rem;
        margin-bottom: 1rem;
    }
    
    .info-section p {
        line-height: 1.8;
        color: #555;
        white-space: pre-wrap;
    }
    
    .back-button {
        margin-top: 2rem;
    }
</style>

<div class="medicine-detail">
    <div class="medicine-header">
        <h1>${medicine.name}</h1>
        <div class="meta">
            <span><strong>성분:</strong> ${medicine.ingredient}</span>
            <span><strong>효능:</strong> ${medicine.efficacy}</span>
            <c:if test="${not empty medicine.manufacturer}">
                <span><strong>제조사:</strong> ${medicine.manufacturer}</span>
            </c:if>
        </div>
    </div>
    
    <c:if test="${not empty medicine.usage}">
        <div class="info-section">
            <h2>사용법</h2>
            <p>${medicine.usage}</p>
        </div>
    </c:if>
    
    <c:if test="${not empty medicine.sideEffects}">
        <div class="info-section">
            <h2>부작용</h2>
            <p>${medicine.sideEffects}</p>
        </div>
    </c:if>
    
    <c:if test="${not empty medicine.precautions}">
        <div class="info-section">
            <h2>주의사항</h2>
            <p>${medicine.precautions}</p>
        </div>
    </c:if>
    
    <div class="back-button">
        <a href="${pageContext.request.contextPath}/medicine" class="btn btn-secondary">목록으로</a>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
