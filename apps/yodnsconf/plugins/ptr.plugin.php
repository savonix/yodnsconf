<?php
/* <!--
Program: YoDNSConf
Component: ptr.plugin.php
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
-->*/

class Nexista_PtrAction extends Nexista_Action
{

    /**
     * Function parameter array
     *
     * @var array
     */

    protected  $params = array(
        'myip' => '' // optional
        );


    /**
     * Applies action
     *
     * @return  boolean success
     */

    protected function main()
    {
        $mip        = Nexista_Flow::getByPath($this->params['myip']);
        $ip_parts   = explode('.',$mip);
        $ip_parts   = array_reverse($ip_parts);
        $ip         = implode('.',$ip_parts);
        $ptr_record = $ip.".in-addr.arpa.";

        Nexista_Flow::add("ptr_record", $ptr_record);
        return true;

    }
} //end class


?>
