<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page session="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>tinyTODO list for real geeks</title>

    <style type="text/css">
        table {
            font-family: Georgia, serif;
        }

        td {
            text-align: center;
            padding: 0.5em;
        }

        th {
            text-align: center;
            padding: 1em;
            background-color: maroon;
            color: white;
        }

        tr {
            height: 1em;
        }

        table tr:nth-child(even) {
            background-color: #eee;
        }

        table tr:nth-child(odd) {
            background-color: #fff;
        }

        a {
            font-family: Georgia, serif;
            color: maroon;
            text-decoration: none;
        }

        a:hover {
            color: brown;
        }

        .modalDialog {
            position: fixed;
            font-family: Georgia, serif;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            background: rgba(0, 0, 0, 0.8);
            z-index: 99999;
            opacity: 0;
            -webkit-transition: opacity 400ms ease-in;
            -moz-transition: opacity 400ms ease-in;
            transition: opacity 400ms ease-in;
            pointer-events: none;
        }

        .modalDialog:target {
            opacity: 1;
            pointer-events: auto;
        }

        .modalDialog > div {
            width: 400px;
            position: relative;
            margin: 10% auto;
            padding: 5px 20px 13px 20px;
            border-radius: 10px;
            background: #fff;
        }

        /* The Close Button */
        .close {
            background: #606061;
            color: #FFFFFF;
            line-height: 25px;
            position: absolute;
            right: -12px;
            text-align: center;
            top: -10px;
            width: 24px;
            text-decoration: none;
            font-weight: bold;
            -webkit-border-radius: 12px;
            -moz-border-radius: 12px;
            border-radius: 12px;
            -moz-box-shadow: 1px 1px 3px #000;
            -webkit-box-shadow: 1px 1px 3px #000;
            box-shadow: 1px 1px 3px #000;
        }

        .close:hover {
            color: brown;
        }
    </style>

</head>
<body>

<h1>Your tinyTODO organizer</h1>
<br>
<hr color="maroon">
<br>

<h3><a href="#openModal">Add new TODO</a></h3>
<br>
<a href="${pageContext.request.contextPath}/todolist">SHOW ALL TODOS&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
<a href="${pageContext.request.contextPath}/sortedlist/?showDone=true">SHOW DONE TODOS&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
<a href="${pageContext.request.contextPath}/sortedlist/?showDone=false">SHOW NOT DONE TODOS</a>

<!--MAIN-->
<br><br>
<c:if test="${!empty listItems}">
    <table>
        <tr>
            <th width="20">№</th>
            <th width="40">Date</th>
            <th width="190">What to do</th>
            <th width="80">Is done?</th>
            <th width="60">Edit</th>
            <th width="60">Delete</th>
        </tr>
        <c:forEach items="${listItems}" var="item" varStatus="status">
            <tr>
                <td>${status.index+1}</td>
                <td>${item.dateTime}</td>
                <td>${item.description}</td>
                <td>
                    <c:if test="${item.done==true}"><a href="/edit/${item.id}#openModal"><img
                            src="${pageContext.request.contextPath}/resources/check-mark-box-done.png"
                            style="width: 30px"></a> </c:if>
                    <c:if test="${item.done==false}"><a href="/edit/${item.id}#openModal"><img
                            src="${pageContext.request.contextPath}/resources/check-mark-box-not-done.png"
                            style="width: 30px"></a></c:if>
                </td>
                <td><a href="<c:url value='/edit/${item.id}#openModal'/>" title="Edit">Edit</a></td>

                <td><a href="<c:url value='/delete/${item.id}'/>">Delete</a></td>
            </tr>
        </c:forEach>
    </table>

</c:if>

<div id="openModal" class="modalDialog">
    <div align="center">
        <a href="#" title="Close" class="close">X</a>

        <c:if test="${empty item.description}"><h2>Add new TODO</h2></c:if>
        <c:if test="${!empty item.description}"><h2>Edit your TODO</h2></c:if>

        <c:url var="addAction" value="/todolist/add"/>

        <form:form action="${addAction}" modelAttribute="item">
            <table style="text-align: left">
                <c:if test="${!empty item.description}">
                    <tr bgcolor="white">
                        <td>ID</td>
                        <td><form:input path="id" readonly="true" size="8" disabled="true"/>
                            <form:hidden path="id"/></td>
                    </tr>
                </c:if>

                <tr bgcolor="white">
                    <td>Your TODO</td>
                    <td><form:input path="description"/></td>
                </tr>

                <tr bgcolor="white">
                    <td>Is done?</td>
                    <td><form:checkbox path="done" label=""/></td>
                </tr>

                <tr bgcolor="white">
                    <td colspan="2">
                        <c:if test="${!empty item.description}">
                            <input type="submit"
                                   value="<spring:message text="Edit"/>"/>
                        </c:if>

                        <c:if test="${empty item.description}">
                            <input type="submit"
                                   value="<spring:message text="Add"/>"/>
                        </c:if>
                    </td>
                </tr>

            </table>
        </form:form>
    </div>
</div>

</body>
</html>