<cfcomponent output="false" mixin="model">

    <cffunction name="init">
        <cfset this.version = "1.1,1.1.1,1.1.2">
        <cfreturn this>
    </cffunction>
	
	<!--- We need to override the return included for objects, otherwise it tries to make the property after the structs --->
	<cffunction name="$serializeQueryToObjects" access="public" output="false" returntype="any">
		<cfargument name="query" type="query" required="true" />
		<cfargument name="include" type="string" required="false" default="" />
		<cfargument name="callbacks" type="string" required="false" default="true" />
		<cfargument name="returnIncluded" type="string" required="false" default="true" />
		<cfargument name="integrateSingleRelation" type="string" default="false" />
		
		<cfscript>
			if(integrateSingleRelation){ arguments.returnIncluded = false; }
			return core.$serializeQueryToObjects(argumentCollection=arguments);
		</cfscript>
	</cffunction>
	
	<cffunction name="$serializeQueryToStructs" access="public" output="false" returntype="any">
		<cfargument name="query" type="query" required="true" />
		<cfargument name="include" type="string" required="true" />
		<cfargument name="callbacks" type="string" required="true" />
		<cfargument name="returnIncluded" type="string" required="true" />
		<cfargument name="integrateSingleRelation" type="string" default="false" />
		<cfscript>
			ret = core.$serializeQueryToStructs(argumentCollection=arguments);
			
			if(integrateSingleRelation){
				//Loop through the structures, and integrate if the key exists
				for (i=1;i lte ArrayLen(ret);i++) {
					for(j=1; j lte listLen(include); j++){
						included = listGetAt(arguments.include,j);
						
						if(StructKeyExists(ret[i],included)){
							//Make sure it is not an array
							if(!isArray(ret[i][included])){
								StructAppend(ret[i],ret[i][included]);
								StructDelete(ret[i],included);
							}
						}
					}
				}
			}
			
		</cfscript>
		<cfreturn ret />
	</cffunction>

</cfcomponent>