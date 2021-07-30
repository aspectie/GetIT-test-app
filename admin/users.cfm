<!---Delete User--->
<cfif structKeyExists(url,'delete') >
	<cfset application.userService.deleteUser(url.delete) />
</cfif>
<!---Get all users--->
<cfset activeUsers = application.userService.getUsers() />
<cf_admin title="Users">
	<!---Delete confirm--->
	<script>
		function confirmDelete(account_id)
		{
			if(window.confirm('Точно удалить?'))
			{
				window.location.href = 'users.cfm?delete='+account_id;
			}
			else
			{
				null;
			}
		}
	</script>
	<!---page body--->
	<div id="pageBody">
		<!---page message--->
		<cfif structKeyExists(url, 'updated')>
			<p style="color:green;">Пользовательские данные обновлены</p>
		</cfif>
		<cfif structKeyExists(url, 'add')>
			<p style="color:blue;">Пользователь добавлен</p>
		</cfif>
		<h1>Пользователи</h1>
		<!---users table--->
		<table>
			<tr>
				<th>Имя</th>
				<th>Фамилия</th>
				<th>Роль</th>
			</tr>
			<cfoutput query="activeUsers">
			<tr>
				<td>#name#</td>
				<td>#surname#</td>
				<td>#role#</td>
				<td><a href="userEdit.cfm?userID=#account_id#">Изменить</a></td>
				<td><a href="javascript:confirmDelete(#account_id#);">Удалить</a></td>
			</tr>
			</cfoutput>
		</table>
	</div>
</cf_admin>