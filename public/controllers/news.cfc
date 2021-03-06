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

component accessors="true" extends="abstract"{

	// ------------------------ DEPENDENCY INJECTION ------------------------ //

	property name="NewsService" setter="true" getter="false";
	
	// ------------------------ PUBLIC METHODS ------------------------ //		

	void function article( required struct rc ){
		param name="rc.label" default="";
		rc.Article = variables.NewsService.getArticleByLabel( rc.label );
		if( rc.Article.isPersisted() ){
			rc.MetaData.setMetaTitle( rc.Article.getMetaTitle() ); 
			rc.MetaData.setMetaDescription( rc.Article.getMetaDescription() );
			rc.MetaData.setMetaKeywords( rc.Article.getMetaKeywords() );
		}else{
			variables.fw.redirect( "main.notfound" );
		}		
	}
	
	void function default( required struct rc ){
		param name="rc.maxresults" default=rc.config.news.recordsperpage;
		param name="rc.offset" default="0";	
		rc.articles = variables.NewsService.getArticles( published=true, maxresults=rc.maxresults, offset=rc.offset );
		rc.articlecount = variables.NewsService.getArticleCount();
		rc.MetaData.setMetaTitle( "News" );
		rc.MetaData.setMetaDescription( "" );
		rc.MetaData.setMetaKeywords( "" );
	}
	
	void function rss( required struct rc ){
		rc.articles = variables.NewsService.getArticles( published=true );
	}	

}