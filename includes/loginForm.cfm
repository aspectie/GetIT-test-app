<!---Handle logout--->
<cfif structKeyExists(URL,'logout')>
	<cfset createObject("component",'auth.components.authenticationService').doLogout() />
</cfif>
<!---Form process--->
<cfif structkeyExists(form,'submitLogin')>
	<cfset authenticationService = createobject("component",'auth.components.authenticationService') />
	<cfset aErrorMessages = authenticationService.validateUser(form.userName,form.userPassword) />
	<cfif ArrayisEmpty(aErrorMessages)>
		<cfset isUserLoggedIn = authenticationService.doLogin(form.userName,form.userPassword) />
	</cfif>
</cfif>
<!---Form body--->
<cfform preservedata="true">
    <cfif structKeyExists(url,'noaccess')>
    	<p class="errorMessage">Войдите в систему</p>
    </cfif>
	<!---Error messages--->
    <cfif structKeyExists(variables,'aErrorMessages') AND NOT ArrayIsEmpty(aErrorMessages)>
    	<cfoutput>
    		<cfloop array="#aErrorMessages#" item="message">
    			<p class="errorMessage" style="color:red;>#message#</p>
    		</cfloop>
    	</cfoutput>
    </cfif>
    <!---No users found--->
    <cfif structKeyExists(variables,'isUserLoggedIn') AND isUserLoggedIn EQ false>
    	<p class="errorMessage">Пользователь не найден</p>
    </cfif>
    <cfif structKeyExists(session,'stLoggedInUser')>
    <!---Display welcome message--->
    	<p><cfoutput>Добро пожаловать, #session.stLoggedInUser.userName# #session.stLoggedInUser.userSurname#</cfoutput></p>
    	<p><a href="/auth/index.cfm?logout">Выход из системы</a></p>
    	<cfif isUserInRole('admin')>
    		<p><a href="/auth/admin/main.cfm">Панель администратора</a></p>
    	</cfif>
    <cfelse>
    <!---Form inputs--->
    <div>
	    <label for="userName">Имя</label>
	       <cfinput type="text" name="userName" id="userName" required="true" validateAt="onSubmit" message="Введите ваше имя" />
	</div>
	<div>
		<label for="userPassword">Пароль</label>
	    <cfinput type="password" name="userPassword" id="userPassword" required="true"  validateAt="onSubmit" message="Введите пароль" />
	</div>
	<div>
	    <cfinput type="submit" name="submitLogin" id="submitLogin" value="Войти" />
	</div>
    </cfif>
</cfform>
