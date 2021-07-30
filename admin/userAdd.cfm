<!---Form processing--->
<cfif structKeyExists(form,'addUserSubmit')>
	<cfset aErrorMessages = application.userService.validateUser(form.userName,form.userSurname,form.userPassword,form.userPassword) />
	<cfif ArrayIsEmpty(aErrorMessages)>
		<cfset application.userService.addUser(form.userName,form.userSurname,form.userPassword,form.userRole) />
		<cflocation url="users.cfm?add=true" />
	</cfif>
</cfif>
<cf_admin title="auth">
	<div id="pageBody">
		<h1>Добавить пользователя</h1>
			<cfform id="addUser" preservedata="true">
				<!---Output error messages if any--->
				<cfif isDefined('variables.aErrorMessages') AND NOT arrayIsEmpty(variables.aErrorMessages)>
					<cfoutput>
					<cfloop array="#variables.aErrorMessages#" index="message">
						<p class="errorMessage">#message#</p>
					</cfloop>
					</cfoutput>
				</cfif>
				<!---Form body--->
				<div class="formWrap">
					<div>
						<p><label>Имя</label></p>
						<cfinput name="userName" id="userName" required="true" message="Введите имя" validateAt="onSubmit" />
					</div>
					<div>
						<p><label>Фамилия</label></p>
						<cfinput name="userSurname" id="userSurname" required="true" message="Введите фамилию" validateAt="onSubmit" />
					</div>
					<div>
						<p><label>Пароль</label></p>
						<cfinput type="userPassword" name="userPassword" id="userPassword" required="true" message="Введите пароль" validateAt="onSubmit" />
					</div>
					<div>
						<p>Роль</p>
						<label><cfinput type="radio" name="userRole" id="userRole" value="2" checked="true" />Пользователь</label>
						<label><cfinput type="radio" name="userRole" id="userRole" value="1" />Администратор</label>
					</div>
					<div>
						<input type="submit" name="addUserSubmit" id="addUserSubmit" value="Добавить" />
					</div>
				</div>
		</cfform>
	</div>
</cf_admin>