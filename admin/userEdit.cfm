<!---Form processing--->
<cfif structKeyExists(form,'editUserSubmit')>
	<cfset aErrorMessages = application.userService.validateUser(form.userName,form.userSurname,form.userPassword,form.userPassword) />
	<cfif ArrayIsEmpty(aErrorMessages)>
		<cfset application.userService.updateUser(form.userName,form.userSurname,form.userPassword,form.userRole, form.userID) />
		<cflocation url="users.cfm?updated=true" />
	</cfif>
</cfif>
<!---Check if userID parameter is correctly passed--->
<cfif NOT structKeyExists(URL, 'userID')>
	<cflocation url="users.cfm" />
</cfif>
<!---Get user data by id--->
<cfset userToEdit = application.userService.getUserByID(url.userID) />
<cf_admin title="auth">
	<div id="pageBody">
		<h1>Изменить данные пользователя</h1>
			<cfform id="editUser" preservedata="true">
				<!---Output error messages if any--->
				<cfif isDefined('variables.aErrorMessages') AND NOT arrayIsEmpty(variables.aErrorMessages)>
					<cfoutput>
					<cfloop array="#variables.aErrorMessages#" index="message">
						<p class="errorMessage" style="color:red;">#message#</p>
					</cfloop>
					</cfoutput>
				</cfif>
				<!---Form body--->
				<div class="formWrap">
					<div>
						<p><label>Имя</label></p>
						<cfinput name="userName" id="userName" value="#userToEdit.name#" required="true" message="Введите имя" validateAt="onSubmit" />
					</div>
					<div>
						<p><label>Фамилия</label></p>
						<cfinput name="userSurname" id="userSurname" value="#userToEdit.surname#" required="true" message="Введите фамилия" validateAt="onSubmit" />
					</div>
					<div>
						<p><label>Пароль</label></p>
						<cfinput type="userPassword" name="userPassword" id="userPassword" value="#userToEdit.password#" required="true" message="Введите пароль" validateAt="onSubmit" />
					</div>
					<div>
						<p>Роль</p>
						<label><cfinput type="radio" name="userRole" id="userRole" value="2" checked="#iif(userToEdit.role EQ 'user', 'true', 'false')#"  />Пользователь</label>
						<label><cfinput type="radio" name="userRole" id="userRole" value="1" checked="#iif(userToEdit.role EQ 'admin', 'true', 'false')#"  />Администратор</label>
					</div>
					<div>
						<cfinput type="hidden" name="userID" value="#userToEdit.account_id#" />
						<input type="submit" name="editUserSubmit" id="editUserSubmit" value="Изменить" />
					</div>
				</div>
		</cfform>
	</div>
</cf_admin>