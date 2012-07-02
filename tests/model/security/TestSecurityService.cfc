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

component extends="mxunit.framework.TestCase"{

	// ------------------------ INTEGRATION TESTS ------------------------ //
	
	function testDeleteCurrentUser(){
		assertFalse( CUT.hasCurrentUser() );
		var User = EntityLoadByPK( "User", 1 );
		CUT.setCurrentUser( User=User );
		assertTrue( CUT.hasCurrentUser() );
		CUT.deleteCurrentUser();
		assertFalse( CUT.hasCurrentUser() );
	}
	
	function testHasCurrentUser(){
		assertFalse( CUT.hasCurrentUser() );
		var User = EntityLoadByPK( "User", 1 );
		CUT.setCurrentUser( User=User );
		assertTrue( CUT.hasCurrentUser() );
	}
	
	function testIsAllowedForSecureActionWhereUserIsLoggedIn(){
		var User = EntityLoadByPK( "User", 1 );
		CUT.setCurrentUser( User=User );
		var result = CUT.isAllowed( action="admin:pages", whitelist="^admin:security,^public:" );
		assertTrue( result );
	}	

	function testIsAllowedForSecureActionWhereUserIsNotLoggedIn(){
		var result = CUT.isAllowed( action="admin:pages", whitelist="^admin:security,^public:" );
		assertFalse( result );
	}	

	function testIsAllowedForUnsecureActionWhereUserIsLoggedIn(){
		var result = CUT.isAllowed( action="admin:security", whitelist="^admin:security,^public:" );
		assertTrue( result );
	}	
	
	function testIsAllowedForUnsecureActionWhereUserIsNotLoggedIn(){
		var result = CUT.isAllowed( action="admin:security", whitelist="^admin:security,^public:" );
		assertTrue( result );
	}		
	
	function testLoginUserForValidUser(){
		var properties = { username="admin", password="admin" };
		var result = CUT.loginUser( properties=properties );
		assertTrue( StructKeyExists( result.messages, "success" ) ); 
	}

	function testLoginUserForInvalidUser(){
		var properties = { username="", password="" };
		var result = CUT.loginUser( properties=properties );
		assertTrue( StructKeyExists( result.messages, "error" ) );
	}

	function testResetPasswordByEmailWhereUsernameIsInvalid(){
		var result = CUT.resetPassword( properties={ email="foo@bar.com" }, name="Default", config={ resetpasswordemailfrom="example@example.com", resetpasswordemailsubject="Test" }, emailtemplatepath="../../admin/views/security/email.cfm" );
		assertTrue( StructKeyExists( result.messages, "error" ) );
	}
	
	function testResetPasswordByEmailWhereUsernameIsValid(){
		var result = CUT.resetPassword( properties={ email="example@example.com" }, name="Default", config={ resetpasswordemailfrom="example@example.com", resetpasswordemailsubject="Test" }, emailtemplatepath="../../admin/views/security/email.cfm" );
		assertTrue( StructKeyExists( result.messages, "success" ) );
	}
	
	function testResetPasswordByUsernameWhereUsernameIsInvalid(){
		var result = CUT.resetPassword( properties={ username="foobar" }, name="Default", config={ resetpasswordemailfrom="example@example.com", resetpasswordemailsubject="Test" }, emailtemplatepath="../../admin/views/security/email.cfm" );
		assertTrue( StructKeyExists( result.messages, "error" ) );
	}
	
	function testResetPasswordByUsernameWhereUsernameIsValid(){
		var result = CUT.resetPassword( properties={ username="admin" }, name="Default", config={ resetpasswordemailfrom="example@example.com", resetpasswordemailsubject="Test" }, emailtemplatepath="../../admin/views/security/email.cfm" );
		assertTrue( StructKeyExists( result.messages, "success" ) );
	}
	
	function testSetCurrentUser(){
		var User = EntityLoadByPK( "User", 1 );
		CUT.setCurrentUser( User=User );
		assertTrue( CUT.hasCurrentUser() );
	}

	// ------------------------ IMPLICIT ------------------------ //
	 
	/**
	* this will run before every single test in this test case
	*/
	function setUp(){
		// initialise component under test
		CUT = new model.security.SecurityService();
		var ValidateThisConfig = { definitionPath="/model/", JSIncludes=false };
		Validator = new ValidateThis.ValidateThis( ValidateThisConfig );
		var SecurityGateway = new model.security.SecurityGateway();
		var UserGateway = new model.user.UserGateway();
		UserGateway.setValidator( Validator );
		var $config = { security={ whitelist="^admin:security,^public:" } };
		SecurityGateway.setConfig( $config );
		SecurityGateway.setValidator( Validator );
		SecurityGateway.setUserGateway( UserGateway );
		CUT.setSecurityGateway( SecurityGateway );
		
		// reinitialise ORM for the application (create database table)
		ORMReload();
		
		// insert test data into database
		var q = new Query();
		q.setSQL( "
			INSERT INTO Users ( user_id, user_firstname, user_lastname, user_email, user_username, user_password, user_created, user_updated ) 
			VALUES ( 1, 'Default', 'User', 'example@example.com', 'admin', '1492D0A411AD79F0D1897DB928AA05612023D222D7E4D6B802C68C6F750E0BDB', '2012-04-22 08:39:07', '2012-04-22 08:39:09' );
		" );
		q.execute();
	}
	
	/**
	* this will run after every single test in this test case
	*/
	function tearDown(){
		// destroy test data
		var q = new Query();
		q.setSQL( "DROP TABLE Users;");
		q.execute();
		
		// clear first level cache and remove any unsaved objects
		ORMClearSession( "xindi_testsuite" );		
	}
	
	/**
	* this will run once after initialization and before setUp()
	*/
	function beforeTests(){}
	
	/**
	* this will run once after all tests have been run
	*/
	function afterTests(){}

}