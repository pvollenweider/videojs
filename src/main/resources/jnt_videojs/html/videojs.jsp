<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<template:addResources type="css" resources="video-js.min.css"/>

<%--
<!-- If you'd like to support IE8 (for Video.js versions prior to v7) -->
<script src="https://vjs.zencdn.net/ie8/1.1.2/videojs-ie8.min.js"></script>
--%>


<c:set var="posterNode" value="${currentNode.properties.poster.node}"/>
<c:choose>
    <c:when test="${! empty posterNode}">
        <c:url var="posterUrl" value="${posterNode.url}"/>
    </c:when>
    <c:otherwise>
        <c:url var="posterUrl" value="${url.currentModule}/images/play.png"/>
    </c:otherwise>
</c:choose>

<c:set var="webmNode" value="${currentNode.properties.webm.node}"/>

<c:if test="${jcr:isNodeType(currentNode, 'jmix:videojsAdvanced')}">
    <c:set var="width" value="${currentNode.properties.width.string}"/>
    <c:set var="height" value="${currentNode.properties.height.string}"/>
</c:if>
<c:if test="${empty width}">
    <c:set var="width" value="640"/>
</c:if>
<c:if test="${empty height}">
    <c:set var="height" value="264"/>
</c:if>
<video id="#video-${currentNode.identifier}" class="video-js" controls preload="auto" width="${width}" height="${height}" poster="${posterUrl}" data-setup="{}">
    <c:set var="mp4Node" value="${currentNode.properties.mp4.node}"/>
    <c:if test="${! empty mp4Node}">
        <c:url var="mp4Url" value="${mp4Node.url}"/>
        <source src="${mp4Url}" type='video/mp4'>
    </c:if>
    <c:set var="webmNode" value="${currentNode.properties.webm.node}"/>
    <c:if test="${! empty webmNode}">
        <c:url var="webmUrl" value="${webmNode.url}"/>
        <source src="${mp4Url}" type='video/webm'>
    </c:if>

    <p class="vjs-no-js">
        To view this video please enable JavaScript, and consider upgrading to a web browser that
        <a href="https://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a>
    </p>
</video>

<template:addResources type="javascript" resources="video.min.js" targetTag="body"/>
<template:addResources type="javascript" resources="${url.currentModule}/javascript/lang/${renderContext.mainResourceLocale.language}.js" targetTag="body"/>

