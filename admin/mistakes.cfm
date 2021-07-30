<!---Get mistakes--->
<cfset allMistakes = application.mistakesService.getMistakes() />
<cf_admin title="Mistakes">
	<!---Page body--->
	<div id="pageBody">
		<!---Page alert--->
		<cfif structKeyExists(url, 'updated')>
			<p style="color:green;">Данные об ошибке обновлены</p>
		</cfif>
		<cfif structKeyExists(url, 'add')>
			<p style="color:blue;">Ошибка добавлена</p>
		</cfif>
		<h1>Ошибки</h1>
		<!---Table body--->
		<table>
			<cfparam name="sort" default="mistake_id">
			<cfquery name="mistakess">
				SELECT mistake_id, shortDesc, status, urgency, criticality
				FROM mistakes
				ORDER BY #sort#
			</cfquery>
			<!---Sort links--->
			<tr>
				<th><a href="mistakes.cfm?sort=shortDesc <cfif sort is "shortDesc">DESC</cfif>">Краткое описание</a></th>				
				<th><a href="mistakes.cfm?sort=status <cfif sort is "status">DESC</cfif>">Статус</a></th>				
				<th><a href="mistakes.cfm?sort=urgency <cfif sort is "urgency">DESC</cfif>">Срочность</a></th>				
				<th><a href="mistakes.cfm?sort=criticality <cfif sort is "criticality">DESC</cfif>">Критичность</a></th>
			</tr>
			<!---Query results--->
			<cfoutput query="mistakess">
			<tr>
				<td>#shortDesc#</td>
				<td>#status#</td>
				<td>#urgency#</td>
				<td>#criticality#</td>
				<td><a href="mistakeEdit.cfm?mistakeID=#mistake_id#">Изменить</a></td>
			</tr>
			</cfoutput>
		</table>
	</div>
</cf_admin>