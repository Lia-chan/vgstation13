/*client
	proc/debug_html(datum/D in world)*/
/datum/admins
	proc/debug_html()
		set category = "Debug"
		set name = "nt_Test HTML support"
		//set src in world


		if(!usr.client || !usr.client.holder)
			usr << "\red You need to be an administrator to access this."
			return

		if(!check_rights(R_DEBUG))
			usr << "\red GTFO!"
			return


		var/title = ""
		var/body = ""
/*
		if(!D)	return
		if(istype(D, /atom))
			var/atom/A = D
			title = "[A.name] (\ref[A]) = [A.type]"

			#ifdef VARSICON
			if (A.icon)
				body += debug_variable("icon", new/icon(A.icon, A.icon_state, A.dir), 0)
			#endif

		var/icon/sprite

		if(istype(D,/atom))
			var/atom/AT = D
			if(AT.icon && AT.icon_state)*/
		var/sprite = new /icon('musician.dmi', "violin")
		usr << browse_rsc(sprite, "view_vars_sprite.png")
		usr << browse_rsc('code/nanotrasen/WIP/test.swf', "test.swf")
		usr << browse_rsc('code/nanotrasen/WIP/yahoo-dom-event.js', "yahoo-dom-event.js")
		usr << browse_rsc('code/nanotrasen/WIP/element-min.js', "element-min.js")
		usr << browse_rsc('code/nanotrasen/WIP/swf-min.js', "swf-min.js")
		usr << browse_rsc('code/nanotrasen/WIP/SWFExampleAdvanced.swf', "SWFExampleAdvanced.swf")


		var/nbody = file2text("code/nanotrasen/WIP/test.html")

//		title = "[D] (\ref[D]) = [D.type]"
		title = "Test HTML"

		body += {"<script type="text/javascript">

					function updateSearch(){
						var filter_text = document.getElementById('filter');
						var filter = filter_text.value.toLowerCase();

						if(event.keyCode == 13){	//Enter / return
							var vars_ol = document.getElementById('vars');
							var lis = vars_ol.getElementsByTagName("li");
							for ( var i = 0; i < lis.length; ++i )
							{
								try{
									var li = lis\[i\];
									if ( li.style.backgroundColor == "#ffee88" )
									{
										alist = lis\[i\].getElementsByTagName("a")
										if(alist.length > 0){
											location.href=alist\[0\].href;
										}
									}
								}catch(err) {   }
							}
							return
						}

						if(event.keyCode == 38){	//Up arrow
							var vars_ol = document.getElementById('vars');
							var lis = vars_ol.getElementsByTagName("li");
							for ( var i = 0; i < lis.length; ++i )
							{
								try{
									var li = lis\[i\];
									if ( li.style.backgroundColor == "#ffee88" )
									{
										if( (i-1) >= 0){
											var li_new = lis\[i-1\];
											li.style.backgroundColor = "white";
											li_new.style.backgroundColor = "#ffee88";
											return
										}
									}
								}catch(err) {  }
							}
							return
						}

						if(event.keyCode == 40){	//Down arrow
							var vars_ol = document.getElementById('vars');
							var lis = vars_ol.getElementsByTagName("li");
							for ( var i = 0; i < lis.length; ++i )
							{
								try{
									var li = lis\[i\];
									if ( li.style.backgroundColor == "#ffee88" )
									{
										if( (i+1) < lis.length){
											var li_new = lis\[i+1\];
											li.style.backgroundColor = "white";
											li_new.style.backgroundColor = "#ffee88";
											return
										}
									}
								}catch(err) {  }
							}
							return
						}

						//This part here resets everything to how it was at the start so the filter is applied to the complete list. Screw efficiency, it's client-side anyway and it only looks through 200 or so variables at maximum anyway (mobs).
						if(complete_list != null && complete_list != ""){
							var vars_ol1 = document.getElementById("vars");
							vars_ol1.innerHTML = complete_list
						}

						if(filter.value == ""){
							return;
						}else{
							var vars_ol = document.getElementById('vars');
							var lis = vars_ol.getElementsByTagName("li");

							for ( var i = 0; i < lis.length; ++i )
							{
								try{
									var li = lis\[i\];
									if ( li.innerText.toLowerCase().indexOf(filter) == -1 )
									{
										vars_ol.removeChild(li);
										i--;
									}
								}catch(err) {   }
							}
						}
						var lis_new = vars_ol.getElementsByTagName("li");
						for ( var j = 0; j < lis_new.length; ++j )
						{
							var li1 = lis\[j\];
							if (j == 0){
								li1.style.backgroundColor = "#ffee88";
							}else{
								li1.style.backgroundColor = "white";
							}
						}
					}



					function selectTextField(){
						var filter_text = document.getElementById('filter');
						filter_text.focus();
						filter_text.select();

					}

					function loadPage(list) {

						if(list.options\[list.selectedIndex\].value == ""){
							return;
						}

						location.href=list.options\[list.selectedIndex\].value;

					}
				</script> "}

		body += "<body onload='selectTextField(); updateSearch()' onkeyup='updateSearch()'>"

		body += "<div align='center'><table width='100%'><tr><td width='50%'>"

		if(1)
			body += "<table align='center' width='100%'><tr><td><img src='view_vars_sprite.png'></td><td>"
		else
			body += "<table align='center' width='100%'><tr><td>"

		body += "<div align='center' id='vars'>"


		body += "</div>"

		body += "</tr></td></table>"


		body += "</td>"

		body += "<td width='50%'><div align='center'><a href='?_src_=vars;datumrefresh=\ref[src]'>Refresh</a>"

		//if(ismob(D))
		//	body += "<br><a href='?_src_=vars;mob_player_panel=\ref[D]'>Show player panel</a></div></td></tr></table></div><hr>"

		body += {"	<form>
					<select name="file" size="1"
					onchange="loadPage(this.form.elements\[0\])"
					target="_parent._top"
					onmouseclick="this.focus()"
					style="background-color:#ffffff">
				"}

		body += {"	<option value>Select option</option>
  					<option value> </option>
				"}

		body += "<option value>---</option>"

		body += "</select></form>"

		body += "</div></td></tr></table></div><hr>"

		body += "<hr><table width='100%'><tr><td width='20%'><div align='center'><b>Search:</b></div></td><td width='80%'><input type='text' id='filter' name='filter_text' value='' style='width:100%;'></td></tr></table><hr>"

		body += {"Music: <audio autoplay controls><source src="http://status.nanotrasen.ru/music/test.ogg" /><source src="http://status.nanotrasen.ru/music/test.mp3" /></audio>
 <br>
Second music:<audio src="audio/music.mp3">Second audio</audio>
<br><br>
Embed:<embed src="test.swf" width="100" height="100" type="application/x-shockwave-flash">
<hr>
Img:<img src="http://nanotrasen.ru/forums/public/style_images/5_WikiLogo.png">
<a href="#" onclick="complete_list = 'Test';">test</a><br><br>
<p>Object:<object type="application/x-shockwave-flash"
      data="http://raz.z0r.de/L/z0r-de_95.swf" width="200" height="200">
    <param name="quality" value="low">
    <param name="wmode" value="opaque">
   </object></p>
"}

// HTML composition here
		var/html = "<!doctype html>\n<html><head>"
		if (title)
			html += "<title>[title]</title>"
		html += {"\n<style>
	body
	{
		font-family: Verdana, sans-serif;
		font-size: 9pt;
	}
	.value
	{
		font-family: "Courier New", monospace;
		font-size: 8pt;
	}
	</style>"}
		html += "</head><body>"
		html += nbody
		//html += body

/*		html += {"
			<script type='text/javascript'>
				var vars_ol = document.getElementById("vars");
				var complete_list = vars_ol.innerHTML;
			</script>"}*/
		html += {"
			<script type='text/javascript'>
			document.write ('<table width="100%" border="1">');
      		document.writeln("<tr><td>"+navigator.userAgent+"</td></tr>");
	  		document.writeln("<tr><td>"+navigator.appName+"</td></tr>");


    		document.write ("</table> ");
    		</script>
		"}

		html += "</body></html>"

		usr << browse(html, "window=debughtml\ref[src];size=475x650")

		return
