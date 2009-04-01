<?php
/* <!--
Program: YoDNSConf
Component: net_dns.plugin.php
Copyright: Savonix Corporation
Author: Albert L. Lash, IV
License: Gnu Affero Public License version 3
http://www.gnu.org/licenses

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program; if not, see http://www.gnu.org/licenses
or write to the Free Software Foundation, Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301 USA
--> */

class Nexista_Net_dnsAction extends Nexista_Action
{

    /**
     * Function parameter array
     *
     * @var array
     */

    protected  $params = array(
        'zone' => '', // required
        'dns' => '', // required,
        'type' => '' // optional
        );


    /**
     * Applies action
     *
     * @return  boolean success
     */

    protected  function main()
    {

        if(!@include_once('Net/DNS.php')) {
            Nexista_Flow::add("net_dns_response", 
                "This feature requires the PEAR Net_DNS Package.");
            return false;
        }
        $my_zone = $this->params['zone'];
        $yo_dns = $this->params['dns'];
        $my_type = $this->params['type'];

        if($my_type=="CNAME") { 
            $my_type = "A";
        }

        $resolver = new Net_DNS_Resolver();
        $resolver->debug = 1; 
        $resolver->usevc = 1; 
        $resolver->nameservers = array(
                                   $yo_dns
                                   );
        ob_start();
        $resolver->rawquery($my_zone,$my_type);
        $response = ob_get_clean();
        Nexista_Flow::add("net_dns_response", $response);
        return true;

    }
} //end class

?>
