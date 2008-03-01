<?php
/*
Copyright (c) 2005, Till Brehm, projektfarm Gmbh
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice,
      this list of conditions and the following disclaimer in the documentation
      and/or other materials provided with the distribution.
    * Neither the name of ISPConfig nor the names of its contributors
      may be used to endorse or promote products derived from this software without
      specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

require_once('../../lib/config.inc.php');
require_once('../../lib/app.inc.php');

// Login Formular wurde abgesandt
if(count($_POST) > 0) {

    // importiere Variablen
    $username = $app->db->quote($_POST["username"]);
    $passwort = $app->db->quote($_POST["passwort"]);

    if($username != '' and $passwort != '') {
        $sql = "SELECT * FROM sys_user WHERE USERNAME = '$username' and ( PASSWORT = '".md5($passwort)."')";
        if($user = $app->db->queryOneRecord($sql)) {
            if($user["active"] == 1) {
                $user = $app->db->toLower($user);
                $_SESSION = array();
                $_SESSION["s"]["user"] = $user;
                $_SESSION["s"]["user"]["theme"] = "grey";
                $_SESSION["s"]["language"] = "en";

                header("Location: ../capp.php?mod=".$user["startmodule"]."&phpsessid=".$_SESSION["s"]["id"]);
                exit;
            } else {
                $error = $app->lng(1003);
            }
        } else {
            // Username oder Passwort falsch
            $error = $app->lng(1002);
            if($app->db->errorMessage != '') $error .= "<br>".$app->db->errorMessage != '';
        }
    } else {
        // Username oder Passwort leer
        $error = $app->lng(1001);
    }
}
if($error != ''){
  $error = '<table width="100%" border="0" cellspacing="0" cellpadding="2">
<tr>
<td class="error"><b>Error:</b><br>'.$error.'</td>
</tr>
</table>';
} 


?>
<form action="index.php" method="post" name="login" target="_self" id="login">
<?php echo $error; ?>
<table width="248" border="0" align="center" cellpadding="4" cellspacing="0">
  <tr>
    <td height="20" colspan="2" class="tblHead">Login</td>
  </tr>
  <tr>
    <td width="109" class="frmText11">Username</td>
    <td width="159"><input name="username" type="text" id="username" class="text"></td>
  </tr>
  <tr>
    <td class="frmText11">Passwort</td>
    <td><input name="passwort" type="password" id="passwort" class="text"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="Login" class="button"></td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
</table>
</form>