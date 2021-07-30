<cfcomponent output="false">
	<!---validateUser() method--->
	<cffunction name="validateUser" access="public" output="false" returntype="array">
		<cfargument name="userName" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		
		<cfset var aErrorMessages = ArrayNew(1) />
		<!---Validate the eMail---->
		<cfif NOT isValid('String', arguments.userName)>
			<cfset arrayAppend(errorMessages, 'Неверное имя') />
		</cfif>
		<!---Validate the password---->
		<cfif arguments.userPassword EQ ''>
			<cfset arrayAppend(errorMessages, 'Введите пароль') />
		</cfif>
		<cfreturn aErrorMessages />
	</cffunction>
	<!---doLogin() method--->
	<cffunction name="doLogin" access="public" output="false" returntype="boolean">
		<cfargument name="userName" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		
		<!---Create the isUserLoggedIn variable--->
		<cfset var isUserLoggedIn = false />
		<!---Get the user data from the database--->
		<cfquery name="rsLoginUser">
			SELECT account_id, name, surname, password, role	
				FROM users
				WHERE name = '#arguments.userName#' AND password = '#arguments.userPassword#'	
		</cfquery>
		<!---Check if the query returns one and only one user--->
		<cfif rsLoginUser.recordCount EQ 1>
			<!---Log the user in--->
			<cflogin >
				<cfloginuser name="#rsLoginUser.name# #rsLoginUser.surname#" password="#rsLoginUser.password#" roles="#rsLoginUser.role#" >
			</cflogin>
			<!---Save user data in the session scope--->
			<cfset session.stLoggedInUser = {'userName' = rsLoginUser.name, 'userSurname' = rsLoginUser.surname, 'userID' = rsLoginUser.account_id} />
			<!---change the isUserLoggedIn variable to true--->
			<cfset var isUserLoggedIn = true />
		</cfif>
		<!---Return the isUserLoggedIn variable--->
		<cfreturn isUserLoggedIn />
	</cffunction>
	<!---doLogout() method--->
	<cffunction name="doLogout" access="public" output="false" returntype="void">
		<!---delete user data from the session scope--->
		<cfset structdelete(session,'stLoggedInUser') />
		<!---Log the user out--->
		<cflogout />
	</cffunction>

</cfcomponent>