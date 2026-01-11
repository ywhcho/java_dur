<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param name="title" value="게시판 - 의약정보 시스템" />
</jsp:include>

<div class="row">
    <div class="col-12">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2>게시판</h2>
            <c:if test="${sessionScope.user != null}">
                <a href="${pageContext.request.contextPath}/board/create" class="btn btn-primary">글쓰기</a>
            </c:if>
        </div>

        <div class="card">
            <div class="card-body">
                <p class="text-muted">총 ${totalCount}개의 게시글</p>
                
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th style="width: 10%">번호</th>
                                <th style="width: 50%">제목</th>
                                <th style="width: 15%">작성자</th>
                                <th style="width: 25%">작성일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty boards}">
                                    <tr>
                                        <td colspan="4" class="text-center">게시글이 없습니다.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="board" items="${boards}">
                                        <tr onclick="location.href='${pageContext.request.contextPath}/board/view/${board.id}'" 
                                            style="cursor: pointer;">
                                            <td>${board.id}</td>
                                            <td>${board.title}</td>
                                            <td>${board.authorName}</td>
                                            <td>
                                                <fmt:formatDate value="${board.createdAt}" pattern="yyyy-MM-dd HH:mm" />
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav>
                        <ul class="pagination justify-content-center">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPage - 1}">이전</a>
                                </li>
                            </c:if>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                            
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPage + 1}">다음</a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
