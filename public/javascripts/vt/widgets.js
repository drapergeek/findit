// Create first and last list classes

function  firstLastList() {
	if(!document.getElementsByTagName) return false;

	var ul = document.getElementsByTagName("ul");

	for (var i = 0; i < ul.length; i++ )
	{
		var li = ul[i].getElementsByTagName("li");
		if (!li.length) continue;
		li[0].className += " first";
		li[li.length-1].className += " last";
	}

	var ol = document.getElementsByTagName("ol");

	for (var i = 0; i < ol.length; i++ )
	{
		var li = ol[i].getElementsByTagName("li");
		if (!li.length) continue;
		li[0].className += " first";
		li[li.length-1].className += " last";
	}
}

// Open links in a new window

function openWindow() {
	if (!document.getElementsByTagName) return false;
	
	var links = document.getElementsByTagName("a");
	
	for ( var i = 0; i < links.length; i++ )
	{
		if (links[i].className.search(/open-window/) != -1)
		{
			links[i].onclick = function() {
				if(!document.getElementById) return true;
				//open a new window with the anchors url
				window.open(this.getAttribute("href"));
				return false;
			}
		}
	}
}

// Stripe tables

// This function is need to work around 
// a bug in IE related to element attributes
function hasClass(obj) {
	
	var result = false;
	
	if (obj.getAttributeNode("class") != null) {
		result = obj.getAttributeNode("class").value;
		}
		return result;
		} 

onload = function() {
	stripeTable ()
	};

function stripeTable() {
	
	var even = true;
	var tables = document.getElementsByTagName("table");	
	
	for(x=0;x!=tables.length;x++){
		table = tables[x];
		if (! table) { return; }
		
		var tbodies = table.getElementsByTagName("tbody");
		
		for (var h = 0; h < tbodies.length; h++) {
			var trs = tbodies[h].getElementsByTagName("tr");
			
			for (var i = 0; i < trs.length; i++) {
				
				for (var i = 0; i < trs.length; i += 2) {
					trs[i].className += "odd";
				}
			}
		}
	}
}

// Choose search criteria

function assignURL()  {
   for( i = 0; i < document.vtsearchform.url.length;i++)    {
   if( document.vtsearchform.url[ i ].checked ) document.vtsearchform.action =  document.vtsearchform.url[ i ].value;
	  document.vtsearchform.submit();
	  }
   }

// Clear search query

function clearquery(id) {
	if(!document.getElementById(id)) return false;
	if (document.getElementById(id).value == "Enter your search here")
	{
		document.getElementById(id).value = "";
	}
}

// Submit search form

function submitForm(formId) {
	document.getElementById(formId).submit();
}

// Event handlers

function addLoadEvent(func) {
	var oldOnLoad = window.onload
	if (typeof window.onload != 'function') 
	{
		window.onload = func;
	}
	else {
		window.onload = function() {
			oldOnLoad();
			func();
		}
	}
}

addLoadEvent(firstLastList);
addLoadEvent(openWindow);
