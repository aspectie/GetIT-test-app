<cfparam name="attributes.title" default="auth" >
<cfif thistag.executionMode EQ 'start'>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title><cfoutput>#attributes.title#</cfoutput></title>
</head>

<body>
<div id="wrapper">
  <div id="header">
	<ul id="menu">
      <li><a href="/auth/admin/main.cfm">Панель администратора</a></li>
      <li><a href="/auth/admin/users.cfm">Пользователи</a></li>
      <li><a href="/auth/admin/userAdd.cfm">Добавить нового пользователя</a></li>
      <li><a href="/auth/admin/mistakes.cfm">Список ошибок</a></li>
      <li><a href="/auth/admin/mistakeAdd.cfm">Добавить новую ошибку</a></li>
    </ul>
    <cfinclude template="../includes/loginForm.cfm" />
  </div>
</div>
</body>
</cfif>
</html>