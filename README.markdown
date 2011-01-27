IntegrateSingleRelation
========================

IntegrateSingleRelation is a CFWheels plugin for easily integrating all properties of a 1:1 relationship when returned as either an object or struct. By default, wheels returns all properties of the joined table under a sub property named the same as the table. This is especially useful when talking about inheritance type relationships, since the properties should all be returned at the same level. This also matches the behavior when returned as a query.

Usage
----------

After installing the plugin, simply add the argument `integrateSingleRelation="true"` to any of the `findXX` functions on models when you are doing a 1:1 join. This also works for dynamic finders in CFWheels. Note: This will only have an effect if you are returning as either an object or struct.

Example
-----------

Say we have two tables in our database: `users` and `teachers`. The two tables have a 1:1 correspondence. If I use one of the `findXX()` methods and return as `struct` or `object`, I will end up with something that looks like this:

* username
* address
* phone
* teacher
	* roomnumber
	* classid
	* etc
* etc
	
Depending on the application, you might want to combine these properties together - think object inheritance. By using the plugin, the data will be returned like this:

* username
* address
* roomnumber
* classid
* etc

History
------------

Version 0.1 - Initial Release