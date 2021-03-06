<!---
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
--->

<cfoutput>
	<div class="page-header"><h1>News</h1></div>
	
	<cfif ArrayLen( rc.articles )>
		<cfloop array="#rc.articles#" index="local.Article">
			<div class="well">
				<h2>
					<a href="#buildURL( action='news.article', querystring='label=#local.Article.getLabel()#' )#">#local.Article.getTitle()#</a>
					
					<small class="pull-right">#DateFormat( local.Article.getPublished(), "full" )#</small>
				</h2>
				
				#local.Article.getSummary()#
			</div>
		</cfloop>
		
		<ul class="pager append-top">
			<cfif rc.offset>
				<li class="previous"><a href="#buildURL( action='news', querystring='offset=#rc.offset-rc.maxresults#' )#">&larr; Newer</a></li>
			<cfelse>
				<li class="previous disabled"><a href="">&larr; Newer</a></li>
			</cfif>
			 
			<cfif rc.maxresults + rc.offset lt rc.articlecount>
				<li class="next"><a href="#buildURL( action='news', querystring='offset=#rc.offset+rc.maxresults#' )#">Older &rarr;</a></li>
			<cfelse>
				<li class="next disabled"><a href="">Older &rarr;</a></li>
			</cfif>
		</ul>
	<cfelse>
		<p>There are currently no news stories.</p>
	</cfif>
	
	<script>
	jQuery(function($){
		$(".previous.disabled,.next.disabled").click(function(e){
			e.preventDefault();
		});
	});
	</script>	
</cfoutput>