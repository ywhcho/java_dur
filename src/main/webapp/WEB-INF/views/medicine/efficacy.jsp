<%@ include file="../common/header.jsp" %>

<style>
    .search-form {
        max-width: 600px;
        margin: 2rem auto;
        display: flex;
        gap: 1rem;
    }
    
    .search-form select {
        flex: 1;
        padding: 0.75rem;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 1rem;
    }
    
    .search-form select:focus {
        outline: none;
        border-color: #3498db;
    }
    
    .medicine-list {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 1.5rem;
        margin-top: 2rem;
    }
    
    .medicine-card {
        background: white;
        padding: 1.5rem;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        transition: transform 0.3s;
    }
    
    .medicine-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.15);
    }
    
    .medicine-card h3 {
        color: #2c3e50;
        margin-bottom: 0.5rem;
    }
    
    .medicine-card .ingredient {
        color: #3498db;
        font-weight: 600;
        margin-bottom: 0.5rem;
    }
    
    .medicine-card .efficacy {
        color: #27ae60;
        margin-bottom: 1rem;
    }
    
    .no-results {
        text-align: center;
        padding: 3rem;
        color: #7f8c8d;
    }
</style>

<h1>효능별 보기</h1>

<form method="get" action="${pageContext.request.contextPath}/medicine/efficacy" class="search-form">
    <select name="efficacy" required>
        <option value="">효능을 선택하세요</option>
        <option value="진통제" ${searchTerm == '진통제' ? 'selected' : ''}>진통제</option>
        <option value="해열제" ${searchTerm == '해열제' ? 'selected' : ''}>해열제</option>
        <option value="소화제" ${searchTerm == '소화제' ? 'selected' : ''}>소화제</option>
        <option value="항생제" ${searchTerm == '항생제' ? 'selected' : ''}>항생제</option>
        <option value="감기약" ${searchTerm == '감기약' ? 'selected' : ''}>감기약</option>
        <option value="알레르기약" ${searchTerm == '알레르기약' ? 'selected' : ''}>알레르기약</option>
        <option value="고혈압약" ${searchTerm == '고혈압약' ? 'selected' : ''}>고혈압약</option>
        <option value="당뇨약" ${searchTerm == '당뇨약' ? 'selected' : ''}>당뇨약</option>
    </select>
    <button type="submit" class="btn">조회</button>
</form>

<c:if test="${not empty searchTerm}">
    <h2 style="margin-top: 2rem;">조회 결과: ${searchTerm}</h2>
    
    <c:choose>
        <c:when test="${empty medicines}">
            <div class="no-results">
                <p>해당 효능의 의약품이 없습니다.</p>
                <p>다른 효능을 선택해보세요.</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="medicine-list">
                <c:forEach var="medicine" items="${medicines}">
                    <div class="medicine-card">
                        <h3>${medicine.name}</h3>
                        <div class="ingredient">성분: ${medicine.ingredient}</div>
                        <div class="efficacy">효능: ${medicine.efficacy}</div>
                        <a href="${pageContext.request.contextPath}/medicine/${medicine.id}" class="btn">상세보기</a>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</c:if>

<%@ include file="../common/footer.jsp" %>
