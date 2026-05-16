<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
  xmlns:xhtml="http://www.w3.org/1999/xhtml">
  <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml" lang="zh-TW">
      <head>
        <title>Sitemap - BenzHub</title>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <style type="text/css">
          * { margin: 0; padding: 0; box-sizing: border-box; }
          body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif; color: #333; background: #f8fafc; line-height: 1.6; }
          .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
          h1 { font-size: 1.5rem; color: #1e293b; margin-bottom: 4px; }
          .meta { color: #64748b; font-size: 0.875rem; margin-bottom: 20px; }
          table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 8px; overflow: hidden; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
          th { background: #3b82f6; color: #fff; text-align: left; padding: 12px 16px; font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.05em; }
          td { padding: 10px 16px; border-bottom: 1px solid #e2e8f0; font-size: 0.875rem; }
          tr:last-child td { border-bottom: none; }
          tr:hover td { background: #f1f5f9; }
          a { color: #3b82f6; text-decoration: none; word-break: break-all; }
          a:hover { text-decoration: underline; }
          .alt-links { font-size: 0.75rem; margin-top: 4px; }
          .alt-links a { color: #64748b; margin-right: 8px; }
          .alt-links span { background: #e2e8f0; padding: 1px 6px; border-radius: 3px; font-size: 0.7rem; }
          .number { color: #94a3b8; font-size: 0.8rem; text-align: center; }
        </style>
      </head>
      <body>
        <div class="container">
          <h1>Sitemap</h1>
          <p class="meta">
            <xsl:choose>
              <xsl:when test="sitemap:urlset">
                URLs: <xsl:value-of select="count(sitemap:urlset/sitemap:url)"/>
              </xsl:when>
              <xsl:when test="sitemap:sitemapindex">
                Sitemaps: <xsl:value-of select="count(sitemap:sitemapindex/sitemap:sitemap)"/>
              </xsl:when>
            </xsl:choose>
          </p>

          <xsl:apply-templates select="sitemap:sitemapindex"/>
          <xsl:apply-templates select="sitemap:urlset"/>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="sitemap:sitemapindex">
    <table>
      <thead>
        <tr>
          <th style="width:40px">#</th>
          <th>Sitemap</th>
          <th style="width:200px">Last Modified</th>
        </tr>
      </thead>
      <tbody>
        <xsl:for-each select="sitemap:sitemap">
          <tr>
            <td class="number"><xsl:value-of select="position()"/></td>
            <td><a href="{sitemap:loc}"><xsl:value-of select="sitemap:loc"/></a></td>
            <td><xsl:value-of select="substring(sitemap:lastmod, 1, 10)"/></td>
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>

  <xsl:template match="sitemap:urlset">
    <table>
      <thead>
        <tr>
          <th style="width:40px">#</th>
          <th>URL</th>
          <th style="width:200px">Last Modified</th>
        </tr>
      </thead>
      <tbody>
        <xsl:for-each select="sitemap:url">
          <tr>
            <td class="number"><xsl:value-of select="position()"/></td>
            <td>
              <a href="{sitemap:loc}"><xsl:value-of select="sitemap:loc"/></a>
              <xsl:if test="xhtml:link">
                <div class="alt-links">
                  <xsl:for-each select="xhtml:link">
                    <a href="{@href}"><span><xsl:value-of select="@hreflang"/></span></a>
                  </xsl:for-each>
                </div>
              </xsl:if>
            </td>
            <td><xsl:value-of select="substring(sitemap:lastmod, 1, 10)"/></td>
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>
</xsl:stylesheet>
