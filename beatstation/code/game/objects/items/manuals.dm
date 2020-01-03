/obj/item/book/manual/wiki/initialize_wikibook()
	var/wikiurl = "https://tgstation13.org/wiki" // makes /tg/ the default wiki, more updated things
  var/hippiewiki = "https://wiki.hippiestation.com/index.php" // for things like cobby chem that we don't have here, custom drinks and foods, etc
	if(wikiurl)
		dat = {"
			<html><head>[UTF8HEADER]
			<style>
				iframe {
					display: none;
				}
			</style>
			</head>
			<body>
			<script type="text/javascript">
				function pageloaded(myframe) {
					document.getElementById("loading").style.display = "none";
					myframe.style.display = "inline";
    			}
			</script>
			<p id='loading'>You start skimming through the manual...</p>
			<iframe width='100%' height='97%' onload="pageloaded(this)" src="[wikiurl]/[page_link]?printable=yes&remove_links=1" frameborder="0" id="main_frame"></iframe>
			</body>
			</html>
			"}

/obj/item/book/manual/wiki/chemistry
  wikiurl = hippiewiki

/obj/item/book/manual/wiki/barman_recipes
  wikiurl = hippiewiki
  
/obj/item/book/manual/wiki/cooking_to_serve_man
  wikiurl = hippiewiki
