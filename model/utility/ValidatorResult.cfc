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

component extends="ValidateThis.util.Result"{
			
	function init( required any Translator, required struct ValidateThisConfig ){
		variables.messagetype = "";
		variables.message = "";
		return super.init( argumentCollection=arguments );
	}
	
	string function getMessage(){
		if( Len( super.getSuccessMessage() ) != 0 ) return getSuccessMessage();
		return variables.message;
	}

	string function getMessageType(){
		return variables.messagetype;
		
	}

	boolean function hasMessage(){
		return Len( getMessage() ) != 0;
	}
	
	void function setErrorMessage( required string message ){
		super.setIsSuccess( false );
		variables.message = arguments.message;
		variables.messagetype = "error";
	}
	
	void function setInfoMessage( required string message ){
		variables.message = arguments.message;
		variables.messagetype = "info";
	}	
	
	void function setSuccessMessage( required string message ){
		super.setIsSuccess( true );
		super.setSuccessMessage( arguments.message );
		variables.messagetype = "success";
	}

	void function setWarningMessage( required string message ){
		variables.message = arguments.message;
		variables.messagetype = "warning";
	}

}