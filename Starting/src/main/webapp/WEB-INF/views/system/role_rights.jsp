<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<div class="tab-content"  style="OVERFLOW: auto; WIDTH: 100%; HEIGHT: 450px;" id="tab2">
    <table>
        <thead>
        <tr>
            <th scope="col" class="chebox">项次</th>
            <th scope="col">名称</th>
            <th scope="col">全选<input type="checkbox"  id="allline"><input name="powerIds" id="powerIds" type="hidden"></th>
            <th scope="col">查询</th>
            <th scope="col">增加</th>
            <th scope="col">导出</th>
            <th scope="col">下载</th>
            <th scope="col">签核</th>
            <th scope="col">确认</th>
            <th scope="col">编辑</th>
            <th scope="col">删除</th>
            <th scope="col">打印</th>
            <th scope="col">详情</th>
            <th scope="col">人工定位</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="power"  items="${powerList}" varStatus="status" >
            <tr class="alt-row" id="alt-row_${power.id}">
                <td><div align="center">${status.index+1}</div></td>
                <td><div align="center">${power.power_name}</div></td>
                <td><div align="center"><input type="checkbox" value="${power.id}" class="oneLine"></div></td>
                <td><div align="center"><c:if test="${not empty power.query}"><input type="checkbox" value="${power.query}"></c:if></div></td>
                <td><div align="center"><c:if test="${not empty power.add}"><input type="checkbox" value="${power.add}"></c:if></div></td>
                <td><div align="center"><c:if test="${not empty power.export}"><input type="checkbox" value="${power.export}"></c:if></div></td>
                <td><div align="center"><c:if test="${not empty power.download}"><input type="checkbox" value="${power.download}"></c:if></div></td>
                <td><div align="center"><c:if test="${not empty power.check}"><input type="checkbox" value="${power.check}"></c:if></div></td>
                <td><div align="center"><c:if test="${not empty power.confirm}"><input type="checkbox" value="${power.confirm}"></c:if></div></td>
                <td><div align="center"><c:if test="${not empty power.edit}"><input type="checkbox" value="${power.edit}"></c:if></div></td>
                <td><div align="center"><c:if test="${not empty power.delete}"><input type="checkbox" value="${power.delete}"></c:if></div></td>
                <td><div align="center"><c:if test="${not empty power.print}"><input type="checkbox" value="${power.print}"></c:if></div></td>
                <td><div align="center"><c:if test="${not empty power.detail}"><input type="checkbox" value="${power.detail}"></c:if></div></td>
                <td><div align="center"><c:if test="${not empty power.manLocate}"><input type="checkbox" value="${power.manLocate}"></c:if></div></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="clear"></div>
</div>
