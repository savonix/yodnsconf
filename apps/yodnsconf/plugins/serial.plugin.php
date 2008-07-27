<?php
/*
Program: YoDNSConf
Component: serial.plugin.php
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
or write to the Free Software Foundation,Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301  USA

*/

class Nexista_SerialAction extends Nexista_Action
{

    /**
     * Function parameter array
     *
     * @var array
     */

    protected  $params = array(
        'srl' => '' // optional
        );


    /**
     * Applies action
     *
     * @return  boolean success
     */

    protected  function main()
    {
	$my_serial = Nexista_Flow::getByPath($this->params['srl']);
        // increase serial
        $serial_date = substr($my_serial, 0, 8);
        $count = intval(substr($my_serial, 8, 2));
        $current_date = intval(date("Ymd"));
        if($serial_date >= $current_date){
            $count++;
            $count = str_pad($count, 2, "0", STR_PAD_LEFT);
            $new_serial = $serial_date.$count;
        } else {
            $new_serial = $current_date.'01';
        }
        Nexista_Flow::add("new_serial", $new_serial);
        return true;

    }
} //end class


?>
