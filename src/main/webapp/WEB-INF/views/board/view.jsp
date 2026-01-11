<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param name="title" value="${board.title} - 게시판" />
</jsp:include>

<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-header">
                <h3>${board.title}</h3>
                <div class="text-muted">
                    <small>작성자: ${board.authorName} | 
                    작성일: <fmt:formatDate value="${board.createdAt}" pattern="yyyy-MM-dd HH:mm" /> |
                    수정일: <fmt:formatDate value="${board.updatedAt}" pattern="yyyy-MM-dd HH:mm" />
                    </small>
                </div>
            </div>
            <div class="card-body">
                <div style="min-height: 200px; white-space: pre-wrap;">${board.content}</div>
            </div>
            <div class="card-footer">
                <div class="d-flex justify-content-between">
                    <a href="${pageContext.request.contextPath}/board/list" class="btn btn-secondary">목록</a>
                    <c:if test="${sessionScope.user != null && sessionScope.user.id == board.authorId}">
                        <div>
                            <a href="${pageContext.request.contextPath}/board/edit/${board.id}" class="btn btn-warning">수정</a>
                            <a href="${pageContext.request.contextPath}/board/delete/${board.id}" 
                               class="btn btn-danger" 
                               onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
