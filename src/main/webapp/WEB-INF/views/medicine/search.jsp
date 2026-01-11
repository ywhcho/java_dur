<%@ include file="../common/header.jsp" %>

<style>
    .search-form {
        max-width: 600px;
        margin: 2rem auto;
        display: flex;
        gap: 1rem;
    }
    
    .search-form input {
        flex: 1;
        padding: 0.75rem;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 1rem;
    }
    
    .search-form input:focus {
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

<h1>성분명 검색</h1>

<form method="get" action="${pageContext.request.contextPath}/medicine/search" class="search-form">
    <input type="text" name="ingredient" placeholder="성분명을 입력하세요..." 
           value="${searchTerm}" required>
    <button type="submit" class="btn">검색</button>
</form>

<c:if test="${not empty searchTerm}">
    <h2 style="margin-top: 2rem;">검색 결과: "${searchTerm}"</h2>
    
    <c:choose>
        <c:when test="${empty medicines}">
            <div class="no-results">
                <p>검색 결과가 없습니다.</p>
                <p>다른 검색어로 시도해보세요.</p>
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
