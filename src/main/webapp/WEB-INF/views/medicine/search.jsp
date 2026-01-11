<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param name="title" value="의약정보 검색 - 의약정보 시스템" />
</jsp:include>

<div class="row">
    <div class="col-12">
        <h2 class="mb-4">의약정보 검색</h2>
        
        <div class="card mb-4">
            <div class="card-body">
                <form method="get" action="${pageContext.request.contextPath}/medicine/search">
                    <div class="row">
                        <div class="col-md-3">
                            <select class="form-select" name="searchType" id="searchType">
                                <option value="ingredient" ${searchType == 'ingredient' ? 'selected' : ''}>성분명</option>
                                <option value="efficacy" ${searchType == 'efficacy' ? 'selected' : ''}>효능</option>
                            </select>
                        </div>
                        <div class="col-md-7">
                            <input type="text" class="form-control" name="keyword" id="keyword" 
                                   placeholder="검색어를 입력하세요" value="${keyword}">
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary w-100">검색</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-header">
                <h5>효능별 분류</h5>
            </div>
            <div class="card-body">
                <div class="d-flex flex-wrap gap-2">
                    <c:forEach var="efficacy" items="${efficacies}">
                        <a href="${pageContext.request.contextPath}/medicine/search?searchType=efficacy&keyword=${efficacy}" 
                           class="btn btn-outline-primary btn-sm">${efficacy}</a>
                    </c:forEach>
                </div>
            </div>
        </div>

        <c:if test="${not empty medicines}">
            <div class="card">
                <div class="card-header">
                    <h5>검색 결과 (${medicines.size()}개)</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th style="width: 20%">의약품명</th>
                                    <th style="width: 20%">성분명</th>
                                    <th style="width: 15%">효능</th>
                                    <th style="width: 35%">용법</th>
                                    <th style="width: 10%"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="medicine" items="${medicines}">
                                    <tr>
                                        <td>${medicine.name}</td>
                                        <td>${medicine.ingredient}</td>
                                        <td><span class="badge bg-info">${medicine.efficacy}</span></td>
                                        <td>${medicine.usage.length() > 50 ? medicine.usage.substring(0, 50) + '...' : medicine.usage}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/medicine/view/${medicine.id}" 
                                               class="btn btn-sm btn-outline-primary">상세</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${keyword != null && keyword != '' && empty medicines}">
            <div class="alert alert-info">
                검색 결과가 없습니다.
            </div>
        </c:if>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
