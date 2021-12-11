<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
	<xsl:output method="html" indent="yes"/>

	<xsl:variable name="ileAutorow" select="count(strona/autor)">
		</xsl:variable>

	<xsl:template match="/">

		<html>
			<head>
				<title>Świat seriali</title>
				<link rel="stylesheet" href="main.css" type="text/css"/>
				<meta charset="UTF-8"/>
				<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
				<meta name="keywords" content="seriale, filmy, netflix, recenzja"/>
				<meta name="description" content="Blog w tematyce seriali wartych obejrzenia."/>
				<meta name="author" content="Marek Brandt"/>
				<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
			</head>
			<body>
				<div class="wrapper">
					<header>
						<div class ="logo">
							<xsl:apply-templates select="strona/tytul"/>
						</div>
						<xsl:call-template name="nav"/>
					</header>
					<div class="content">
						<div>
							<xsl:apply-templates select="strona/seriale"/>
						</div>
						<div>
							<xsl:call-template name="kategorie"/>
						</div>
						<div>
							<br/>
							<br/><h1>Wszystkie seriale:</h1>
							<xsl:apply-templates select="strona/seriale/serial"/>
						</div>
						<div id="autor">
							<h1>Info o autorze</h1>
							Autorów jest: <xsl:value-of select="$ileAutorow"/><br/>
							<xsl:apply-templates select="strona/autor"/>
						</div>
						<xsl:call-template name="footer"/>
					</div>
				</div>
			</body>
		</html>

	</xsl:template>
	
	<xsl:template match="tytul">
		<span class="logoswiat">
			<xsl:value-of select="firsthalf"/>
		</span>
	<xsl:value-of select="secondhalf"/>
	</xsl:template>

	<xsl:template name="nav">
		<nav>
			<ul>
				<li>
					<a href="#seriale">Seriale</a>
				</li>
				<li>
					Kategorie
					<ol>
						<li>
							<a href="#dramat">Dramat</a>
						</li>
						<li>
							<a href="#komedia">Komedia</a>
						</li>
						<li>
							<a href="#kryminal">Kryminał</a>
						</li>
						<li>
							<a href="#dramhist">Dramat historyczny</a>
						</li>
						<li>
							<a href="#fantasy">Fantasy</a>
						</li>
						<li>
							<a href="#horror">Horror</a>
						</li>
						<li>
							<a href="#scifi">Sci-Fi</a>
						</li>
					</ol>
				</li>
				<li>
					<a href="#autor">O blogu</a>
				</li>
			</ul>
		</nav>
	</xsl:template>

	<xsl:template match="seriale">
		<h1>
			<xsl:text>Seriale</xsl:text>
		</h1>
		<xsl:for-each select="serial">
			<xsl:sort select="@mojaOcena" order="descending" data-type="number"/>
			<xsl:variable name="tytul">
				<xsl:value-of select="daneSerialu/kluczowe/tytul"/>
			</xsl:variable>
			<a href="#{translate($tytul, ' ', '')}">
				<div class="post">
				<xsl:number value="position()" format="I. "/>
				
				<span class="tytul2">
						<xsl:copy-of select="$tytul"/>
				</span>
				<xsl:text> | Ocena: </xsl:text>
				<xsl:value-of select="@mojaOcena"/>
				<xsl:text>/10</xsl:text>
				<br/>
				<xsl:value-of select="daneSerialu/kluczowe/krotkiOpis"/>
			</div>
			</a>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="serial[@gatunek='Dramat']
				  | serial[@gatunek='Komedia']
				  | serial[@gatunek='Kryminał']
				  | serial[@gatunek='Dramat historyczny']
				  | serial[@gatunek='Sci-Fi']
				  | serial[@gatunek='Fantasy']
				  | serial[@gatunek='Horror']
				  " mode="kategorie">
			<div class="post">
				<span class="tytul2">
					<xsl:value-of select="daneSerialu/kluczowe/tytul"/>
				</span>
			</div>
	</xsl:template>

	<xsl:template name="kategorie">
		<div id="dramat">
			<h1>Dramat</h1>
			<xsl:apply-templates select="strona/seriale/serial[@gatunek='Dramat']" mode="kategorie"/>
		</div>
		<div id="komedia">
			<h1>Komedia</h1>
			<xsl:apply-templates select="strona/seriale/serial[@gatunek='Komedia']" mode="kategorie"/>
		</div>
		<div id="kryminal">
			<h1>Kryminał</h1>
			<xsl:apply-templates select="strona/seriale/serial[@gatunek='Kryminał']" mode="kategorie"/>
		</div>
		<div id="dramhist">
			<h1>Dramat historyczny</h1>
			<xsl:apply-templates select="strona/seriale/serial[@gatunek='Dramat historyczny']" mode="kategorie"/>
		</div>
		<div id="fantasy">
			<h1>Fantasy</h1>
			<xsl:apply-templates select="strona/seriale/serial[@gatunek='Fantasy']" mode="kategorie"/>
		</div>
		<div id="horror">
			<h1>Horror</h1>
			<xsl:apply-templates select="strona/seriale/serial[@gatunek='Horror']" mode="kategorie"/>
		</div>
		<div id="scifi">
			<h1>Sci-Fi</h1>
			<xsl:apply-templates select="strona/seriale/serial[@gatunek='Sci-Fi']" mode="kategorie"/>
		</div>
	</xsl:template>

	<xsl:template match="serial">
		<xsl:variable name="tytul">
			<xsl:value-of select="daneSerialu/kluczowe/tytul"/>
		</xsl:variable>
		<div class="post" id="{translate($tytul, ' ', '')}">
			<div class="about">
				<xsl:number value="position()" format="A. "/>
				<xsl:apply-templates select="daneSerialu/kluczowe"/>
				<xsl:apply-templates select="daneSerialu/poboczne"/>
			</div>
			<div class="mainjpg">
				<xsl:apply-templates select="daneSerialu/poboczne/zdjecie"/>
			</div>
			<div style="clear: both;"></div>
		</div>
	</xsl:template>

	<xsl:template match="kluczowe">
		<span class="kluczowe">Tytuł: <span class="tytul2">
			<xsl:value-of select="tytul"/>
		</span>
		<br/>
		Krótki opis: <xsl:value-of select="krotkiOpis"/></span>
	</xsl:template>

	<xsl:template match="poboczne">
		<span class="poboczne">
			<br/>
			Twórca: <xsl:value-of select="tworca"/>
			<br/>
			Opis: <xsl:value-of select="opis"/>
			<br/>
			Linki:<br/><xsl:apply-templates select="linki/link"/>
		</span>
	</xsl:template>

	<xsl:template match="zdjecie">
		<image>
			<xsl:attribute name="src">
				<xsl:value-of select="@source"/>
			</xsl:attribute>
			<xsl:attribute name="alt">
				<xsl:value-of select="."/>
			</xsl:attribute>
		</image>
	</xsl:template>

	<xsl:template match="linki/link">
		<span class="links"><br/>		
		<a>
					<xsl:attribute name="href">
						<xsl:value-of select="@source"/>
					</xsl:attribute>
					<xsl:value-of select="."/>
				</a>
		<br/></span>
	</xsl:template>

	<xsl:template match="autor">
		<xsl:variable name="imie">
			<xsl:value-of select="imie"/>
		</xsl:variable>
		<xsl:variable name="nazwisko">
			<xsl:value-of select="nazwisko"/>
		</xsl:variable>
		Autorem jest 
		<xsl:if test ="@plec='male'">
			<span style="color:blue;">
				<xsl:value-of select="$imie"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="$nazwisko"/>.
			</span>
		</xsl:if>
		<xsl:if test ="@plec='female'">
			<span style="color:pink;">
				<xsl:value-of select="$imie"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="$nazwisko"/>.
			</span>
		</xsl:if>
			<xsl:choose>
				<xsl:when test="@wiek >= 18">
					Autor jest pełnoletni. Ma przynajmniej <xsl:value-of select="ceiling(17.5)"/> lat.
				</xsl:when>
				<xsl:otherwise>
					Autor jest niepełnoletni.
				</xsl:otherwise>
			</xsl:choose>
		<br/>
		Strona utworzona dnia:
		<xsl:value-of select="../data"/>
	</xsl:template>

	<xsl:template name="footer">
		<footer>
			Rekord <xsl:value-of select='format-number(703785, "###,###.00")' /> odwiedzeń w ciągu jednego dnia, dziękuję.
			<br />
			<xsl:value-of select='format-number(0.7425, "#%")' /> Pozostało na dłużej niż 20 minut. Dziękuję!
				<a href="#">Wróć na górę strony</a>
		</footer>
	</xsl:template>
	
</xsl:stylesheet>