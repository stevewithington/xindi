/*
	Xindi - http://www.getxindi.com/
	
	Copyright (c) 2012, Simon Bingham
	
	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
	files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, 
	modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software 
	is furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
	LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR 
	IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

component persistent="true" table="enquiries" cacheuse="transactional"{
	
	// ------------------------ PROPERTIES ------------------------ //
	
	property name="enquiryid" column="enquiry_id" fieldtype="id" setter="false" generator="native";
	
	property name="firstname" column="enquiry_firstname" ormtype="string" length="50";
	property name="lastname" column="enquiry_lastname" ormtype="string" length="50";
	property name="email" column="enquiry_email" ormtype="string" length="150";
	property name="message" column="enquiry_message" ormtype="text";
	property name="read" column="enquiry_read" ormtype="boolean";
	property name="created" column="enquiry_created" ormtype="timestamp";

	// ------------------------ PUBLIC METHODS ------------------------ //

	/**
	 * I initialise this component
	 */	
	Enquiry function init(){
		variables.firstname = "";
		variables.lastname = "";
		variables.read = false;
		return this;
	}
	
	/**
	 * I return the message formatted for display
	 */	
	string function getDisplayMessage(){
		return REReplace( HTMLEditFormat( variables.message ), "[\r\n]+", "<br /><br />", "ALL" );
	}	

	/**
	 * I return the full name
	 */		
	string function getFullName(){
		return variables.firstname & " " & variables.lastname;
	}

	/**
	 * I return true if the enquiry is persisted
	 */	
	boolean function isPersisted(){
		return !IsNull( variables.enquiryid );
	}
	
	/**
	 * I return true if the enquiry is read
	 */		
	boolean function isRead(){
		return variables.read;
	}
	
}