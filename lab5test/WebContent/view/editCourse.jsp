<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="by.vsu.course.*"%>
<%@page import="by.vsu.teacher.*"%>
<%@page import="by.vsu.user.*"%>
<%@page import="by.vsu.dbGeneral.*"%>
<%
	Course object = (Course)request.getAttribute("object");
	HttpSession ses = request.getSession();
	User obj = (User)ses.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Lb 5</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
    <style>
       * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        .btn {
            height: fit-content;
            display: block;
            padding: 10px 10px;
            text-align: center;
            border-radius: 4px;
            background-color: #ffdb4d;
            text-decoration: none;
            color: #000;
            border: none;
        }
        .btn:hover {
            background-color: #fdd32a;
        }
        h1 {
            color: #ffdb4d;
        }
        .header {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            height: 8vh;
            background-color: rgb(79, 30, 128);
            box-shadow: 0px 4px 8px rgba(79, 30, 128,0.95);
            align-items: center;
        }
        .nav, .auth {
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-start;
            align-items: center;
        }
        .nav__item, .auth a {
            margin-right: 15px;
            padding: 10px;
        }
        .teacher__form {
            margin: 0 auto;
        }
        .form__input {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        input, select {
            width: 300px;
            padding: 11px 0;
            border: none;
            background-color: #eee;
            padding-left: 20px;
            padding-right: 20px;
            border-radius: 3px;
        }

        .teacher {
            margin: 0 auto;
            width: 50%;
            padding-top: 26px;
        }

        .teacher h2 {
            font-size: 25px;
        }

        .teacher .form__input {
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <header class="header">
        <h1 class="logo">Lb 5</h1>
        <nav class="nav">
        	<c:if test="<%= obj != null && obj.getRole_id() == 1%>">
			    <a href="/lab5test/ListUsersServlet" class="nav__item btn">users</a>
			</c:if>
            <a href="/lab5test/index.html" class="nav__item btn">teachers</a>
            <a href="/lab5test/ListCoursesServlet" class="nav__item btn">courses</a>
        </nav>
        <div class="auth">
			<c:if test="<%= obj == null %>">
			    <a href="view/login.html" class="reg btn">Войти</a>
			</c:if>
			<c:if test="<%= obj != null %>">
			    <h2 class="login"><%= obj.getLogin() %></h2>
			    <a href="/lab5test/LogoutServlet" class="reg btn">Выйти</a>
			</c:if>
        </div>
    </header>
    <section class="teacher">
        <h3 class="teacher__header">Teachers</h3>
        <form class="teacher__form" action="/lab5test/SaveCourseServlet" method="POST">
        	<div class="form__input" style="display: none">
                <label for="id">
                    Id:
                </label>
                <div class="input">
                    <input id="id" type="text" name="id" value="<%= object != null ? object.getId() : "" %>">   
                </div>
            </div>
            <div class="form__input">
                <label for="title">
                    Название курса:
                </label>
                <div class="input">
                    <input id="title" type="text" name="title"  placeholder="Введите имя" value="<%= object != null ? object.getTitle() : "" %>">   
                </div>
            </div>
            <div class="form__input">
                <label for="teacher">
                    Преподаватель
                </label>
                <div class="input">
                    <select id="teacher" name="teacher">
   						<option <%= object == null ? "selected" : "" %> value=0>Выберите преподавателя</option>
   						<%
			                 for(Teacher item : Teachers.select("id")) {
			             %>
   							<option <%= object != null && object.getTeacherId() == item.getId() ? "selected" : "" %> value=<%= item.getId() %>><%= item.getFullName()  %></option>
 						<%
			                 }
			             %> 					
  					</select>   
                </div>
            </div>
            <div class="form__input">
                <label for="specialty">
                    Специальность
                </label>
                <div class="input">
                    <select id="specialty" name="specialty">
   						<option <%= object == null ? "selected" : "" %> value=0>Выберите специальночть</option>
   						<%
			                 for(Table item : Specialty.select()) {
			             %>
   							<option <%= object != null && object.getSpecialtyId() == item.getId() ? "selected" : "" %> value=<%= item.getId() %>><%= item.getTitle()  %></option>
 						<%
			                 }
			             %> 					
  					</select>   
                </div>
            </div>
            <div class="form__input">
                <label for="numberCourse">
                    Номер курса
                </label>
                <div class="input">
                    <input id="numberCourse" type="text" name="numberCourse" placeholder="Введите номер курса"  value="<%= object != null ? object.getNumberCourse() : "" %>">   
                </div>
            </div>
           <div class="form__input">
                <label for="semester">
                    Семестер
                </label>
                <div class="input">
                    <select name="semester">
   						<option <%= object == null ? "selected" : "" %> value=0>Выберите семестер</option>
   						<option <%= object != null && object.getSemester() == 1 ? "selected" : "" %> value="1">1</option>
   						<option <%= object != null && object.getSemester() == 2 ? "selected" : "" %> value="2">2</option>
  					</select>   
                </div>
            </div>
            <div class="form__input">
                <label for="countStudents">
                    Количество студентов
                </label>
                <div class="input">
                    <input id="countStudents" type="text" name="countStudents" placeholder="Введите кол-во студентов"  value="<%= object != null ? object.getCountStudents() : "" %>">   
                </div>
            </div>
            <div class="form__input">
                <label for="lectureHours">
                    lectureHours
                </label>
                <div class="input">
                    <input id="lectureHours" type="text" name="lectureHours" placeholder="Введите lectureHours"  value="<%= object != null ? object.getLectureHours() : "" %>">   
                </div>
            </div>
            <div class="form__input">
                <label for="practicalHours">
                    lectureHours
                </label>
                <div class="input">
                    <input id="practicalHours" type="text" name="practicalHours" placeholder="Введите practicalHours"  value="<%= object != null ? object.getPracticalHours() : "" %>">   
                </div>
            </div>
            <div class="form__input">
                <label for="laborotoryHours">
                    lectureHours
                </label>
                <div class="input">
                    <input id="laborotoryHours" type="text" name="laborotoryHours" placeholder="Введите laborotoryHours"  value="<%= object != null ? object.getLaborotoryHours() : "" %>">   
                </div>
            </div>
            <div class="form__input">
                <label for="credit">
                    credit
                </label>
                <div class="input">
                    <input id="credit" type="checkbox" name="credit" <%= object != null && object.isCredit() ? "checked" : "" %>>   
                </div>
            </div>
            <div class="form__input">
                <label for="exam">
                    exam
                </label>
                <div class="input">
                    <input id="exam" type="checkbox" name="exam" <%= object != null && object.isExam() ? "checked" : "" %>>   
                </div>
            </div>
            <div class="form__input">
                <label for="countTests">
                    countTests
                </label>
                <div class="input">
                    <input id="countTests" type="text" name="countTests" placeholder="Введите countTests"  value="<%= object != null ? object.getCountTests() : "" %>">   
                </div>
            </div>
            <div class="teacher__save">
	            <BUTTON class="btn" type="submit">Сохранить</BUTTON>
	        </div>
        </form>
    </section>
</body>
</html>