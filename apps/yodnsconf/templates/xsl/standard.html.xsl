<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml">

  <xsl:param name="analytics_key"></xsl:param>
  <xsl:param name="analytics_path">/</xsl:param>

  <!-- UI PRIMARY MENU -->
  <xsl:template name="nav-menu">
    <ul id="nav">
      <xsl:for-each select="//menu/item[not(@active=0)]">
        <xsl:call-template name="list-button">
          <xsl:with-param name="key" select="key"/>
        </xsl:call-template>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <!-- UI LIST BUTTON -->
  <xsl:template name="list-button">
    <xsl:param name="key"/>
    <li>
      <a href="#" class="head">
        <xsl:value-of select="/_R_/i18n/*[name()=$key]"/>
      </a>
      <ul>
        <xsl:for-each select="//menu/item[key=$key]/item">
          <xsl:variable name="my_key" select="key"/>
          <li>
            <a href="{//runtime/link_prefix}{url}" id="{key}">
              <xsl:value-of select="/_R_/i18n/*[name()=$my_key]"/>
            </a>
          </li>
        </xsl:for-each>
      </ul>
    </li>
  </xsl:template>

  <!-- UI HEADER -->
  <xsl:template name="header">
    <xsl:param name="i18n"/>
    <div id="header">&#160;
      <span id="company-name">
        <xsl:value-of select="//runtime/company_name"/>
      </span>
      <h1 class="page-title">
        <xsl:value-of select="/_R_/i18n/*[name()=/_R_/_get/nid]"/>
      </h1>
    </div>
  </xsl:template>

  <!-- HTML SHELL -->
  <xsl:template name="page">
    <html>

      <xsl:call-template name="head" />
      <body>
        <xsl:for-each select="//pre_body_content">
          <xsl:sort select="priority" order="ascending"/>
          <xsl:apply-templates select="nodes/*"/>
        </xsl:for-each>

        <xsl:apply-templates />

        <xsl:for-each select="//footer_nodes">
          <xsl:sort select="priority" order="ascending"/>
          <xsl:apply-templates select="nodes/*"/>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>


  <!-- HTML HEAD -->
  <xsl:template name="head">
    <head>
      <title>
      <xsl:value-of select="(//h1|//h2)[1]" />
      </title>
    </head>
  </xsl:template>


  <!-- DEPRECATED TEMPLATES -->
  <xsl:template name="main-menu">
    <xsl:comment>As of 2009-12, main-menu is deprecated. Use nav-menu.</xsl:comment>
  </xsl:template>
  <xsl:template name="main" />
  <xsl:template name="drop-downs" />

<xsl:template name="g_analytics_code">
<xsl:if test="not($analytics_key='')">
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', '<xsl:value-of select="$analytics_key"/>']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
</xsl:if>
</xsl:template>
  
  
  
  <!-- XHTML FRIENDLY IDENTITY TEMPLATE FOR ELEMENTS-->
  <xsl:template match="node()">
    <xsl:element name="{name()}">
      <xsl:apply-templates select="@*|node()"/>
    </xsl:element>
  </xsl:template>

  <!-- XHTML FRIENDLY IDENTITY TEMPLATE FOR CONTENT AND ATTRIBUTES -->
  <xsl:template match="@*|text()">
    <xsl:copy/>
  </xsl:template>
  
  <xsl:template match="comment()">
    <xsl:copy/>
  </xsl:template>

</xsl:stylesheet>
