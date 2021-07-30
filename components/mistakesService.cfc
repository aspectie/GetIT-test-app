<cfcomponent output="true">
	<!---Add mistake query--->
	<cffunction name="addMistake" access="public" output="false" returntype="void">
		<cfargument name="mistakeShortDesc" type="string" required="true" />
		<cfargument name="mistakeDesc" type="string" required="true" />
		<cfargument name="mistakeStatus" type="string" required="true" />
		<cfargument name="mistakeUrgency" type="string" required="true" />
		<cfargument name="mistakeCriticality" type="string" required="true" />
		<cfquery>
			INSERT INTO mistakes
			(user, shortDesc, description, status, urgency, criticality)
			VALUES
			(
				<cfqueryparam value="#session.stLoggedInUser.userID#" cfsqltype="cf_sql_integer" />,
				<cfqueryparam value="#form.mistakeShortDesc#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.mistakeDesc#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.mistakeStatus#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.mistakeUrgency#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.mistakeCriticality#" cfsqltype="cf_sql_varchar" />
			)
		</cfquery>
	</cffunction>
	<!---Validate mistake form--->
	<cffunction name="validateMistake" access="public" output="false" returntype="array">
		<cfargument name="mistakeShortDesc" type="string" required="true" />
		<cfargument name="mistakeDesc" type="string" required="true" />
		<cfargument name="mistakeStatus" type="string" required="true" />
		<cfargument name="mistakeUrgency" type="string" required="true" />
		<cfargument name="mistakeCriticality" type="string" required="true" />
		<cfset var aErrorMessages = arrayNew(1) />
		<!---Validate short description--->
		<cfif arguments.mistakeShortDesc EQ ''>
			<cfset arrayAppend(aErrorMessages,'Введите краткое описание') />
		</cfif>
		<!---Validate description--->
		<cfif arguments.mistakeDesc EQ ''>
			<cfset arrayAppend(aErrorMessages,'Введите полное описание') />
		</cfif>
		<cfreturn aErrorMessages />
	</cffunction>
	<!---Get mistakes list--->
	<cffunction name="getMistakes" returntype="Query">
		<cfquery name="mistakesList">
			SELECT mistake_id, shortDesc, status, urgency, criticality
			FROM mistakes
			ORDER BY mistake_id
		</cfquery>
		<cfreturn mistakesList/>
	</cffunction> 
	<!---Get mistake by id--->
	<cffunction name="getMistakeByID" access="public" output="false" returntype="query">
		<cfargument name="mistakeID" type="numeric" required="true" />
		<cfset var mistakeById = '' />
		<cfquery name="mistakeById">
			SELECT mistake_id, shortDesc, description, status, urgency, criticality
			FROM mistakes
			WHERE mistake_id = <cfqueryparam value="#arguments.mistakeID#" cfsqltype="cf_sql_integer" /> 
		</cfquery>
		<cfreturn mistakeById />
	</cffunction>
	<!---Update mistake query--->
	<cffunction name="updateMistake" access="public" output="false" returntype="void">
		<cfargument name="mistakeShortDesc" type="string" required="true" />
		<cfargument name="mistakeDesc" type="string" required="true" />
		<cfargument name="mistakeStatus" type="string" required="true" />
		<cfargument name="mistakeUrgency" type="string" required="true" />
		<cfargument name="mistakeCriticality" type="string" required="true" />
		<cfargument name="mistakeID" type="numeric" required="true" />
		<cfquery>
			UPDATE mistakes
			SET
				shortDesc = <cfqueryparam value="#arguments.mistakeShortDesc#" cfsqltype="cf_sql_varchar" />,
				description = <cfqueryparam value="#arguments.mistakeDesc#" cfsqltype="cf_sql_varchar" />,
				status = <cfqueryparam value="#arguments.mistakeStatus#" cfsqltype="cf_sql_varchar" />,
				urgency = <cfqueryparam value="#arguments.mistakeUrgency#" cfsqltype="cf_sql_varchar" />,
				criticality = <cfqueryparam value="#arguments.mistakeCriticality#" cfsqltype="cf_sql_varchar" />
			WHERE mistake_id = <cfqueryparam value="#arguments.mistakeID#" cfsqltype="cf_sql_integer" />
		</cfquery>
	</cffunction>
	<!---Add new story of mistake--->
	<cffunction name="addStory" access="public" output="false" returntype="void">
		<cfargument name="mistake_Id" type="numeric" required="true" />
		<cfargument name="mistakeComment" type="string" required="true" />
		<cfargument name="mistakeAction" type="string" required="true" />
		<cfargument name="user_id" type="numeric" required="true" />
		<cfquery>
			INSERT INTO mistake_story
			(mistake, comment, action, user)
			VALUES
			(
				<cfqueryparam value="#form.mistake_Id#" cfsqltype="cf_sql_integer" />,
				<cfqueryparam value="#form.mistakeComment#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.mistakeAction#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#form.user_id#" cfsqltype="cf_sql_integer" />
			)
		</cfquery>
	</cffunction>
	<!---Get mistake story by mistake id --->
	<cffunction name="getMistakeStory" access="public" output="false" returntype="Query">
		<cfargument name="mistake_Id" type="numeric" required="true" />
		<cfset var storyList = '' />
		<cfquery name="storyList">
			SELECT action, comment, date, user, mistake
			FROM mistake_story
			WHERE mistake = <cfqueryparam value="#arguments.mistake_Id#" cfsqltype="cf_sql_integer" /> 
		</cfquery>
		<cfreturn storyList/>
	</cffunction> 
	<!---Validate story form --->
	<cffunction name="validateStory" access="public" output="false" returntype="array">
		<cfargument name="mistakeAction" type="string" required="true" />
		<cfargument name="mistakeComment" type="string" required="true" />
		<cfset var aErrorMessages = arrayNew(1) />
		<!---Validate action--->
		<cfif arguments.mistakeAction EQ ''>
			<cfset arrayAppend(aErrorMessages,'Введите действие') />
		</cfif>
		<!---Validate comment--->
		<cfif arguments.mistakeComment EQ ''>
			<cfset arrayAppend(aErrorMessages,'Введите комментарий') />
		</cfif>		
		<cfreturn aErrorMessages />
	</cffunction>
	
</cfcomponent>