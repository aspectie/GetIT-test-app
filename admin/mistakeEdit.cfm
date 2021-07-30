<!---Form update mistake process--->
<cfif structKeyExists(form,'editMistakeSubmit')>
	<cfset aErrorMessages = application.mistakesService.validateMistake(form.mistakeShortDesc,form.mistakeDesc,form.mistakeStatus,form.mistakeUrgency, form.mistakeCriticality, form.mistakeID) />
	<cfif ArrayIsEmpty(aErrorMessages)>
		<cfset application.mistakesService.updateMistake(form.mistakeShortDesc,form.mistakeDesc,form.mistakeStatus,form.mistakeUrgency, form.mistakeCriticality, form.mistakeID) />
		<cflocation url="mistakes.cfm?updated=true" />
	</cfif>
</cfif>
<!---Form update mistake story process--->
<cfif structKeyExists(form,'editStatusSubmit')>
	<cfset aErrorMessages = application.mistakesService.validateStory(form.mistake_Id, form.mistakeComment, form.mistakeAction) />
	<cfif ArrayIsEmpty(aErrorMessages)>
		<cfset application.mistakesService.addStory(form.mistake_Id, form.mistakeComment, form.mistakeAction, form.user_id) />
		<cflocation url="mistakes.cfm?updated=true" />
	</cfif>
</cfif>
<!---check if userID parameter is correctly passed--->
<cfif NOT structKeyExists(URL, 'mistakeID')>
	<cflocation url="mistakes.cfm" />
</cfif>
<!---get the current data of the user--->
<cfset mistakeToEdit = application.mistakesService.getMistakeByID(url.mistakeID) />
<cfset mistakeStory = application.mistakesService.getMistakeStory(url.mistakeID) />
<cf_admin title="auth">
	<div id="pageBody">
		<h1>Изменить информацию об ошибке</h1>
			<cfform id="editMistake" preservedata="true">
				<!---Output error messages--->
				<cfif isDefined('variables.aErrorMessages') AND NOT arrayIsEmpty(variables.aErrorMessages)>
					<cfoutput>
					<cfloop array="#variables.aErrorMessages#" index="message">
						<p class="errorMessage" style="color:red;">#message#</p>
					</cfloop>
					</cfoutput>
				</cfif>
				<!---Form update mistake body--->
				<div class="formWrap">
					<div>
						<p><label>Краткое описание:</label></p>
						<cfinput name="mistakeShortDesc" id="mistakeShortDesc" value="#mistakeToEdit.shortDesc#" required="true" message="Введите краткое описание" validateAt="onSubmit" />
					</div>
					<div>
						<p><label>Полное описание:</label></p>
						<cfinput name="mistakeDesc" id="mistakeDesc" value="#mistakeToEdit.description#" required="true" message="Введите полное описание" validateAt="onSubmit" />
					</div>
					<div>
						<p><label>Срочность:</label></p>
						<cfselect name="mistakeUrgency" id="mistakeUrgency" required="true">
							<option value="1">Очень срочно</option>
							<option value="2">Срочно</option>
							<option value="4">Не срочно</option>
							<option value="8">Совсем не срочно</option>
						</cfselect>	
					</div>
					<div>
						<p><label>Критичность:</label></p>
						<cfselect name="mistakeCriticality" id="mistakeCriticality" required="true">
							<option value="1">Авария</option>
							<option value="2">Критичная</option>
							<option value="4">Не критичная</option>
							<option value="8">Запрос на изменение</option>
						</cfselect>	
					</div>
					<div>
						<p><label>Статус:</label></p>
						<cfinput name="mistakeStatus" id="mistakeStatus" value="#mistakeToEdit.status#" />
					</div>
					<div>
						<cfinput type="hidden" name="mistakeID" value="#mistakeToEdit.mistake_id#" />
						<input type="submit" name="editMistakeSubmit" id="editMistakeSubmit" value="Изменить" />
					</div>
				</div>
		</cfform>				
		<cfform id="addStory" preservedata="true">
		<!---Output error messages if any--->
		<cfif isDefined('variables.aErrorMessages') AND NOT arrayIsEmpty(variables.aErrorMessages)>
			<cfoutput>
				<cfloop array="#variables.aErrorMessages#" index="message">
					<p class="errorMessage" style="color:red;">#message#</p>
				</cfloop>
			</cfoutput>
		</cfif>			
		<!---Form update story body--->
			<div class="formWrap">
				<div>
					<p><label>Действие:</label></p>
					<cfset status = "#mistakeToEdit.status#">
					<cfselect name="mistakeAction" id="mistakeAction" required="true">
                    	<cfswitch expression="#status#">
                    		<cfcase value="Новая">
                    			<option value="1" selected>Ввод</option>
								<option value="2">Открытие</option>
                    		</cfcase>
                    		<cfcase value="Открытая">
								<option value="2" selected>Открытие</option>
								<option value="4">Решение</option>
                    		</cfcase>
                    		<cfcase value="Решенная">
								<option value="2">Открытие</option>
								<option value="4" selected>Решение</option>
								<option value="8">Закрытие</option>
                    		</cfcase>
                    		<cfcase value="Закрытая">
								<option value="8">Закрытие</option>
                    		</cfcase>
                    	</cfswitch>
					</cfselect>
					</div>
				<div>
					<p><label>Комментарий:</label></p>
					<cfinput name="mistakeComment" id="mistakeComment" required="true" message="Введите комментарий" validateAt="onSubmit" />
				</div>
            	<div>
            		<cfinput type="hidden" name="mistake_Id" value="#mistakeToEdit.mistake_id#"/>
            		<cfinput type="hidden" name="user_id" value="#session.stLoggedInUser.userID#"/>
            		<input type="submit" name="editStatusSubmit" id="editStatusSubmit" value="Изменить статус"/>
            	</div>
            </div>
		</cfform>	
		<!---Output of mistake story--->
		<h1>История ошибки</h1>
		<table>
			<tr>
				<th>Дата</th>	
				<th>Пользователь</th>	
				<th>Действие</th>	
				<th>Комментарий</th>				
			</tr>
			<cfoutput query="mistakeStory">
			<tr>
				<td>#date#</td>
				<td>#user#</td>
				<td>#action#</td>
				<td>#comment#</td>
			</tr>
			</cfoutput>
		</table>
	</div>
</cf_admin>