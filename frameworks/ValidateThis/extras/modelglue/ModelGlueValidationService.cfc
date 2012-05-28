<!---
	
	Copyright 2010, Bob Silverberg
	
	Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in 
	compliance with the License.  You may obtain a copy of the License at 
	
		http://www.apache.org/licenses/LICENSE-2.0
	
	Unless required by applicable law or agreed to in writing, software distributed under the License is 
	distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or 
	implied.  See the License for the specific language governing permissions and limitations under the 
	License.
	
--->
<cfcomponent output="false" extends="ValidateThis.ValidateThis" hint="I act as a ValidationService for Model-Glue, used by GDMs.">

	<cffunction name="validate" access="public" output="false" returntype="any">
		<cfargument name="table" type="any" required="true" />
		<cfargument name="record" type="any" required="true" />

		<cfreturn super.validate(arguments.record,arguments.table) />

	</cffunction>
	
</cfcomponent>
