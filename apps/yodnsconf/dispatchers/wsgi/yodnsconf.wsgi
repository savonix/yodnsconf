"""
Loader for YoDNSConf to use Schematronic

Copyright: Savonix Corporation
Author: Albert Lash
License: Affero GPL v3 or later
"""
import cgi
from time import gmtime, strftime
from StringIO import StringIO
import time
import os
import libxml2
from beaker.middleware import SessionMiddleware

# Import classes
from schematronic import Singleton as Singleton
from schematronic.kernel.flow import Flow
from schematronic.kernel.initializer import Initializer
from schematronic.kernel.config import Config
from schematronic.kernel.fence import Fence
from schematronic.modules.handlers.xsl import XslHandler
from schematronic.modules.handlers.xml import XmlHandler
from schematronic.modules.handlers.query import Query
import schematronic.kernel.flow
try:
    import psyco
    psyco.full(memory=10)

except ImportError:
    pass

libxml2.initParser()



# What about the app config?
# "/var/www/dev/example/apps/example/config/config.xml"
# These shouldn't be in here anyway.
#config = etree.parse("/var/www/dev/example/config/config.xml").getroot()
#config_list = []
#environ['SCRIPT_NAME'] = posixpath.dirname(environ['SCRIPT_NAME'])

thexsl   = XslHandler()
thexml   = XmlHandler()
thequery = Query()
myinit   = Initializer(thexsl,thexml,thequery)

import hotshot
prof = hotshot.Profile("/tmp/schema.log")


def _application(environ, start_response):
    prof.start()
    res = myapplication(environ, start_response)
    prof.stop()
    #prof.close()
    return res


def yodnsconf_app(environ, start_response):

    server_config = environ['server_config']
    app_config    = environ['app_config']
    myconfig = Config(server_config, app_config)
    config = myconfig.getConfig()

    myinit.start(environ)

    theflow = Flow()

    qs_dict = cgi.parse_qs(environ["QUERY_STRING"], \
        keep_blank_values = True, strict_parsing = False)

    theflow.start(qs_dict,environ)

    mynid = qs_dict.get('nid','index')[0]

    myinit.process_gate(mynid)

    output = myinit.display()

    if(qs_dict.get('view_flow','none')[0] == "true"):
        flowdump = theflow.toXml()
        output = output + "<textarea rows='14' cols='200'>"+flowdump+"</textarea>"

    content_type  = myinit.content_type
    cache_control = myinit.cache_control

    """Simplest possible application object"""
    status = '200 OK'
    response_headers = [('Content-type',content_type),('Cache-Control',cache_control)]
    start_response(status, response_headers)
    return output

    
application = SessionMiddleware(yodnsconf_app, type='memory', data_dir='/tmp/')


"""
# Example conf:
# SetEnv demo.templates /usr/local/wsgi/templates
<IfModule mod_wsgi.c>
    WSGIScriptAlias /schematronic /var/www/dev/example/apps/example/dispatchers/wsgi/example.wsgi
    WSGIProcessGroup schematronic
    WSGIDaemonProcess schematronic user=www-data group=www-data threads=2
    WSGIPythonOptimize 1
</IfModule>
"""
