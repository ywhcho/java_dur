<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .board-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 2rem;
    }
    
    .board-table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .board-table th,
    .board-table td {
        padding: 1rem;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }
    
    .board-table th {
        background-color: #2c3e50;
        color: white;
        font-weight: 600;
    }
    
    .board-table tr:hover {
        background-color: #f5f5f5;
    }
    
    .board-table a {
        color: #2c3e50;
        text-decoration: none;
    }
    
    .board-table a:hover {
        color: #3498db;
    }
    
    .pagination {
        display: flex;
        justify-content: center;
        gap: 0.5rem;
        margin-top: 2rem;
    }
    
    .pagination a {
        padding: 0.5rem 1rem;
        border: 1px solid #ddd;
        text-decoration: none;
        color: #2c3e50;
        border-radius: 4px;
    }
    
    .pagination a:hover {
        background-color: #3498db;
        color: white;
    }
    
    .pagination .active {
        background-color: #2c3e50;
        color: white;
    }
</style>

<div class="board-header">
    <h1>게시판</h1>
    <a href="${pageContext.request.contextPath}/board/create" class="btn">글쓰기</a>
</div>

<c:if test="${empty boards}">
    <p style="text-align: center; padding: 3rem; color: #7f8c8d;">
        게시글이 없습니다. 첫 번째 글을 작성해보세요!
    </p>
</c:if>

<c:if test="${not empty boards}">
    <table class="board-table">
        <thead>
            <tr>
                <th style="width: 10%;">번호</th>
                <th style="width: 45%;">제목</th>
                <th style="width: 15%;">작성자</th>
                <th style="width: 10%;">조회수</th>
                <th style="width: 20%;">작성일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="board" items="${boards}">
                <tr>
                    <td>${board.id}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/board/${board.id}">
                            ${board.title}
                        </a>
                    </td>
                    <td>${board.author}</td>
                    <td>${board.viewCount}</td>
                    <td>
                        <fmt:formatDate value="${board.createdAt}" pattern="yyyy-MM-dd HH:mm" type="both"/>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <c:if test="${totalPages > 1}">
        <div class="pagination">
            <c:if test="${currentPage > 0}">
                <a href="${pageContext.request.contextPath}/board?page=${currentPage - 1}">&laquo; 이전</a>
            </c:if>
            
            <c:forEach begin="0" end="${totalPages - 1}" var="i">
                <a href="${pageContext.request.contextPath}/board?page=${i}" 
                   class="${i == currentPage ? 'active' : ''}">${i + 1}</a>
            </c:forEach>
            
            <c:if test="${currentPage < totalPages - 1}">
                <a href="${pageContext.request.contextPath}/board?page=${currentPage + 1}">다음 &raquo;</a>
            </c:if>
        </div>
    </c:if>
</c:if>

<%@ include file="../common/footer.jsp" %>
