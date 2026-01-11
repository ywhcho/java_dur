<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .board-view {
        max-width: 900px;
        margin: 0 auto;
    }
    
    .board-title {
        font-size: 2rem;
        color: #2c3e50;
        margin-bottom: 1rem;
        padding-bottom: 1rem;
        border-bottom: 2px solid #3498db;
    }
    
    .board-meta {
        display: flex;
        gap: 2rem;
        color: #7f8c8d;
        margin-bottom: 2rem;
        padding-bottom: 1rem;
        border-bottom: 1px solid #ddd;
    }
    
    .board-content {
        line-height: 1.8;
        min-height: 300px;
        padding: 2rem 0;
        white-space: pre-wrap;
    }
    
    .board-actions {
        display: flex;
        gap: 1rem;
        margin-top: 2rem;
        padding-top: 2rem;
        border-top: 1px solid #ddd;
    }
</style>

<div class="board-view">
    <h1 class="board-title">${board.title}</h1>
    
    <div class="board-meta">
        <span>작성자: ${board.author}</span>
        <span>조회수: ${board.viewCount}</span>
        <span>작성일: <fmt:formatDate value="${board.createdAt}" pattern="yyyy-MM-dd HH:mm" type="both"/></span>
    </div>
    
    <div class="board-content">
        ${board.content}
    </div>
    
    <div class="board-actions">
        <a href="${pageContext.request.contextPath}/board" class="btn btn-secondary">목록</a>
        
        <c:if test="${sessionScope.user.username == board.author}">
            <a href="${pageContext.request.contextPath}/board/edit/${board.id}" class="btn">수정</a>
            <form method="post" action="${pageContext.request.contextPath}/board/delete/${board.id}" 
                  style="display: inline;"
                  onsubmit="return confirm('정말 삭제하시겠습니까?');">
                <button type="submit" class="btn btn-danger">삭제</button>
            </form>
        </c:if>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
