<cfcomponent output="false">
	<cfset this.name = 'mistakes'>
	<cfset this.applicationTimeout = createtimespan(0,2,0,0) />
	<cfset this.datasource = 'cf'>
	<cfset this.customTagPaths = expandPath('/auth/customTags') />
	<cfset this.sessionManagement = true />
	<cfset this.sessionTimeout = createTimespan(0,0,30,0) />
	
	<!---OnApplicationStart() method--->
	<cffunction name="onApplicationStart" returntype="boolean" >
		<cfset application.userService = createObject("component",'auth.components.userService') />
		<cfset application.mistakesService = createObject("component",'auth.components.mistakesService') />
		<cfreturn true />
	</cffunction>
	<!---OnRequestStart() method--->
	<cffunction name="onRequestStart" returntype="boolean" >
		<cfargument name="targetPage" type="string" required="true" />
		<!---Handle URL parameters--->
		<cfif isDefined('url.restartApp')>
			<cfset this.onApplicationStart() />
		</cfif>
		<!---Control 'admin' folder access--->
		<cfif listFind(arguments.targetPage,'admin', '/') AND (NOT isUserLoggedIn() OR NOT isUserInRole('admin'))>
			<cflocation url="/auth/index.cfm?noaccess" />
		</cfif>
		<cfreturn true />
	</cffunction>
</cfcomponent>