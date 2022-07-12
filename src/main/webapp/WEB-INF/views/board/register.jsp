<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">게시글 작성</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        	글 작성후 '완료' 버튼을 누르면 게시글이 등록됩니다.
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">

                        	<form action="/board/register" method="post">
                        		<div class="form-group">
	                                <label>제목</label>
	                                <input class="form-control" name="title">
                                </div>
                        		<div class="form-group">
	                                <label>내용</label>
	                                <textarea rows="5" cols="50" class="form-control" name="content"></textarea>
                                </div>
                        		<div class="form-group">
	                                <label>작성자</label>
	                                <input class="form-control" name="writer">
                                </div>
                                <button type="submit" class="btn btn-default">완료</button>
                                <button type="reset" class="btn btn-default">다시작성</button>
                                <button type="reset" class="btn btn-default"><a href='/board/list'>글목록</a></button>
                        		
                        	</form>
                        
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>

<%@ include file="../includes/footer.jsp" %>
