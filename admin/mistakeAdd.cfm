<!---Form add mistake process--->
<cfif structKeyExists(form,'addMistakeSubmit')>
	<cfset aErrorMessages = application.mistakesService.validateMistake(form.mistakeShortDesc,form.mistakeDesc,form.mistakeStatus,form.mistakeUrgency,form.mistakeCriticality) />
	<cfif ArrayIsEmpty(aErrorMessages)>
		<cfset application.mistakesService.addMistake(form.mistakeShortDesc,form.mistakeDesc,form.mistakeStatus,form.mistakeUrgency,form.mistakeCriticality) />
		<cflocation url="mistakes.cfm?add=true" />
	</cfif>
</cfif>
<cf_admin title="auth">
	<!---Page body--->
	<div id="pageBody">
		<h1>Добавить ошибку</h1>
			<cfform id="addMistake" preservedata="true">
				<!---Output error messages--->
				<cfif isDefined('variables.aErrorMessages') AND NOT arrayIsEmpty(variables.aErrorMessages)>
					<cfoutput>
					<cfloop array="#variables.aErrorMessages#" index="message">
						<p class="errorMessage" style="color:red">#message#</p>
					</cfloop>
					</cfoutput>
				</cfif>
				<!---Form body--->
				<div class="formWrap">
					<div>
						<p><label>Короткое описание</label></p>
						<cfinput type="text" name="mistakeShortDesc" id="mistakeShortDesc" required="true" message="Введите короткое описание" validateAt="onSubmit" />
					</div>
					<div>
						<p><label>Подробное описание</label></p>
						<cftextarea name="mistakeDesc" id="mistakeDesc" richtext="false"></cftextarea>
					</div>
					<div>
						<p><label>Статус</label></p>
						<cfselect name="mistakeStatus" id="mistakeStatus" required="true" >
							<option value="1">Новая</option>
						</cfselect>
					</div>						
					<div>
						<p><label>Срочность</label></p>
						<cfselect name="mistakeUrgency" id="mistakeUrgency" required="true" >
							<option value="1">Очень срочно</option>
							<option value="2">Срочно</option>
							<option value="4">Не срочно</option>
							<option value="8">Совсем не срочно</option>
						</cfselect>
					</div>
					<div>
						<p><label>Критичность</label></p>
						<cfselect name="mistakeCriticality" id="mistakeCriticality" required="true" >
							<option value="1">Авария</option>
							<option value="2">Критичная</option>
							<option value="4">Не критичная</option>
							<option value="8">Запрос на изменение</option>
						</cfselect>
					</div>	
					<div>
						<input type="submit" name="addMistakeSubmit" id="addMistakeSubmit" value="Добавить" />
					</div>
				</div>
		</cfform>
	</div>
</cf_admin>