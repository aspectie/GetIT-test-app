<cfcomponent output="false">
	<!---Add user--->
	<cffunction name="addUser" access="public" output="false" returntype="void">
		<cfargument name="userName" type="string" required="true" />
		<cfargument name="userSurname" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		<cfargument name="userRole" type="string" required="true" />
		<cfquery  >
			INSERT INTO users
			(name, surname, password, role)
			VALUES
			(
				<cfqueryparam value="#form.userName#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.userSurname#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.userPassword#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.userRole#" cfsqltype="cf_sql_varchar" />
			)
		</cfquery>
	</cffunction>
	<!---Validate user method--->
	<cffunction name="validateUser" access="public" output="false" returntype="array">
		<cfargument name="userName" type="string" required="true" />
		<cfargument name="userSurname" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		<cfargument name="userPasswordConfirm" type="string" required="true" />
		<cfset var aErrorMessages = arrayNew(1) />
		<!---Validate name--->
		<cfif arguments.userName EQ ''>
			<cfset arrayAppend(aErrorMessages,'Введите имя') />
		</cfif>
		<!---Validate surname--->
		<cfif arguments.userSurname EQ ''>
			<cfset arrayAppend(aErrorMessages,'Введите фамилию') />
		</cfif>
		<!---Validate password--->
		<cfif arguments.userPassword EQ '' >
			<cfset arrayAppend(aErrorMessages,'Введите пароль')/>
		</cfif>
		<!---Validate password confirmation--->
		<cfif arguments.userPasswordConfirm EQ '' >
			<cfset arrayAppend(aErrorMessages,'Подтвердите пароль')/>
		</cfif>
		<!---validate password and password confirmation --->
		<cfif arguments.userPassword NEQ arguments.userPasswordConfirm >
			<cfset arrayAppend(aErrorMessages,'Пароли не совпадают')/>
		</cfif>
		<cfreturn aErrorMessages />
	</cffunction>
	<!---Get user by id--->
	<cffunction name="getUserByID" access="public" output="false" returntype="query">
		<cfargument name="userID" type="numeric" required="true" />
		<cfset var rsSingleUser = '' />
		<cfquery  name="rsSingleUser">
			SELECT account_id, name, surname, password, role
			FROM users
			WHERE account_id = <cfqueryparam value="#arguments.userID#" cfsqltype="cf_sql_integer" /> 
		</cfquery>
		<cfreturn rsSingleUser />
	</cffunction>
	<!---Update user query--->
	<cffunction name="updateUser" access="public" output="false" returntype="void">
		<cfargument name="userName" type="string" required="true" />
		<cfargument name="userSurname" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		<cfargument name="userRole" type="string" required="true" />
		<cfargument name="userID" type="numeric" required="true" />
		<cfquery>
			UPDATE users
			SET
				name = <cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar" />,
				surname = <cfqueryparam value="#arguments.userSurname#" cfsqltype="cf_sql_varchar" />,
				password = <cfqueryparam value="#arguments.userPassword#" cfsqltype="cf_sql_varchar" />,
				role = <cfqueryparam value="#arguments.userRole#" cfsqltype="cf_sql_varchar" />
			WHERE account_id = <cfqueryparam value="#arguments.userID#" cfsqltype="cf_sql_integer" />
		</cfquery>
	</cffunction>
	<!---Get all users--->
	<cffunction name="getUsers" returntype="Query">
		<cfquery name="usersList">
			SELECT account_id, name, surname, role
			FROM users
			WHERE role="user";
		</cfquery>
		<cfreturn usersList/>
	</cffunction> 
	<!---Delete user query--->
	<cffunction name="deleteUser" returntype="void" roles="admin">
		<cfargument name="userID" type="numeric" required="true" />
		<cfquery>
			DELETE FROM users
			WHERE account_id = <cfqueryparam value="#arguments.userID#" cfsqltype="cf_sql_integer" />
		</cfquery>
	</cffunction>
</cfcomponent>