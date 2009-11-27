<!--
Program: YoDNSConf - http://www.yodnsconf.com/
Component: firewall_rules.xsl
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
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="main.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
		<!-- ADAPTED FROM pfSense -->
<form action="firewall_rules_edit.php" method="post" name="iform" id="iform">
	<table width="100%" border="0" cellpadding="6" cellspacing="0">
    	<tr>
			<td width="22%" valign="top" class="vncellreq">Action</td>
			<td width="78%" class="vtable">
				<select name="type" class="formfld">
          <option value="pass">Pass</option>
          <option value="block">Block</option>
          <option value="reject" >Reject</option>
        </select>
				<br/>
				<span class="vexpl">
					Choose what to do with packets that match the criteria specified below. <br/>
					Hint: the difference between block and reject is that with reject, a packet (TCP RST or ICMP port unreachable for UDP) is returned to the sender, whereas with block the packet is dropped silently. In either case, the original packet is discarded. Reject only works when the protocol is set to either TCP or UDP (but not &quot;TCP/UDP&quot;) below.
				</span>
			</td>
		</tr>
		<tr>
			<td width="22%" valign="top" class="vncellreq">Disabled</td>

			<td width="78%" class="vtable">
				<input name="disabled" type="checkbox" id="disabled" value="yes" />
				<strong>Disable this rule</strong><br />
				<span class="vexpl">Set this option to disable this rule without removing it from the list.</span>
			</td>
		</tr>
		<tr>
			<td width="22%" valign="top" class="vncellreq">Interface</td>

			<td width="78%" class="vtable">
				<select name="interface" class="formfld">
						<option value="wan" >WAN</option>
						<option value="lan" >LAN</option>
						<option value="pptp" >PPTP</option>
						<option value="pppoe" >PPPOE</option>
						<option value="enc0" >IPSEC</option>
						<option value="opt1" >OPT1</option>
				</select>
				<br />
				<span class="vexpl">Choose on which interface packets must come in to match this rule.</span>
			</td>
		</tr>
		<tr>
			<td width="22%" valign="top" class="vncellreq">Protocol</td>
			<td width="78%" class="vtable">
				<select name="proto" class="formfld" onchange="proto_change()">
					<option value="tcp" >TCP</option>
					<option value="udp" >UDP</option>
					<option value="tcp/udp" >TCP/UDP</option>
					<option value="icmp" >ICMP</option>
					<option value="esp" >ESP</option>
					<option value="ah" >AH</option>
					<option value="gre" >GRE</option>
					<option value="igmp" >IGMP</option>
					<option value="any" >any</option>
					<option value="carp" >carp</option>
					<option value="pfsync" >pfsync</option>
				</select>
				<br />
				<span class="vexpl">Choose which IP protocol this rule should match. <br /> Hint: in most cases, you should specify <em>TCP</em> &#160;here.</span>
			</td>
		</tr>
		<tr id="icmpbox" name="icmpbox">
			<td valign="top" class="vncell">ICMP type</td>
			<td class="vtable">
				<select name="icmptype" class="formfld">
					<option value="" >any</option>
					<option value="echorep" >Echo reply</option>
					<option value="unreach" >Destination unreachable</option>
					<option value="squench" >Source quench</option>
					<option value="redir" >Redirect</option>
					<option value="althost" >Alternate Host</option>
					<option value="echoreq" >Echo</option>
					<option value="routeradv" >Router advertisement</option>
					<option value="routersol" >Router solicitation</option>
					<option value="timex" >Time exceeded</option>
					<option value="paramprob" >Invalid IP header</option>
					<option value="timereq" >Timestamp</option>
					<option value="timerep" >Timestamp reply</option>
					<option value="inforeq" >Information request</option>
					<option value="inforep" >Information reply</option>
					<option value="maskreq" >Address mask request</option>
					<option value="maskrep" >Address mask reply</option>
			</select>
			<br />
			<span class="vexpl">If you  ICMP for the protocol above, you may specify an ICMP type here.</span>
		</td>
		</tr>
		<tr>
			<td width="22%" valign="top" class="vncellreq">Source</td>
			<td width="78%" class="vtable">
				<input name="srcnot" type="checkbox" id="srcnot" value="yes" />
				<strong>not</strong>
				<br />
				Use this option to invert the sense of the match.
				<br />
				<br />
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>Type:&#160;&#160;</td>
						<td>
							<select name="srctype" class="formfld" onChange="typesel_change()">
								<option value="any"     >any</option>
								<option value="single"  >Single host or alias</option>
								<option value="network" >Network</option>
								<option value="wanip" 	>WAN address</option>
								<option value="lanip" 	>LAN address</option>
								<option value="lan"     >LAN subnet</option>
								<option value="pptp"    >PPTP clients</option>
								<option value="pppoe"   >PPPoE clients</option>
									<option value="opt1" >OPT1 subnet</option>
									<option value="opt1ip">OPT1 address</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>Address:&#160;&#160;</td>
						<td>
							<input autocomplete='off' name="src" type="text" class="formfldalias" id="src" size="20" value=""/> /
							<select name="srcmask" class="formfld" id="srcmask">
								<option value="31" >31</option>
								<option value="30" >30</option>
								<option value="29" >29</option>
								<option value="28" >28</option>
								<option value="27" >27</option>
								<option value="26" >26</option>
								<option value="25" >25</option>
								<option value="24" >24</option>
								<option value="23" >23</option>
								<option value="22" >22</option>
								<option value="21" >21</option>
								<option value="20" >20</option>
								<option value="19" >19</option>
								<option value="18" >18</option>
								<option value="17" >17</option>
								<option value="16" >16</option>
								<option value="15" >15</option>
								<option value="14" >14</option>
								<option value="13" >13</option>
								<option value="12" >12</option>
								<option value="11" >11</option>
								<option value="10" >10</option>
								<option value="9" >9</option>
								<option value="8" >8</option>
								<option value="7" >7</option>
								<option value="6" >6</option>
								<option value="5" >5</option>
								<option value="4" >4</option>
								<option value="3" >3</option>
								<option value="2" >2</option>
								<option value="1" >1</option>
							</select>
						</td>
					</tr>
				</table>
				<div id="showadvancedboxspr">
				</div>
			</td>
		</tr>
		<tr style="display:none" id="sprtable" name="sprtable">
			<td width="22%" valign="top" class="vncellreq">Source port range</td>
			<td width="78%" class="vtable">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>from:&#160;&#160;</td>
						<td>
							<select name="srcbeginport" class="formfld" onchange="src_rep_change();ext_change()">
								<option value="">(other)</option>
								<option value="any" >any</option>
									<option value="3389" >MS RDP</option>
									<option value="21" >FTP</option>
									<option value="22" >SSH</option>
									<option value="23" >Telnet</option>
									<option value="25" >SMTP</option>
									<option value="53" >DNS</option>
									<option value="69" >TFTP</option>
									<option value="80" >HTTP</option>
									<option value="110" >POP3</option>
									<option value="113" >IDENT/AUTH</option>
									<option value="119" >NNTP</option>
									<option value="123" >NTP</option>
									<option value="137" >NetBIOS-NS</option>
									<option value="138" >NetBIOS-DGM</option>
									<option value="139" >NetBIOS-SSN</option>
									<option value="143" >IMAP</option>
									<option value="161" >SNMP</option>
									<option value="162" >SNMP-Trap</option>
									<option value="389" >LDAP</option>
									<option value="443" >HTTPS</option>
									<option value="445" >MS DS</option>
									<option value="465" >SMTP/S</option>
									<option value="500" >isakmp</option>
									<option value="993" >IMAP/S</option>
									<option value="995" >POP3/S</option>
									<option value="1194" >OpenVPN</option>
									<option value="1512" >MS WINS</option>
									<option value="1701" >L2TP</option>
									<option value="1723" >PPTP</option>
									<option value="1812" >Radius</option>
									<option value="1813" >Radius-accounting</option>
									<option value="3000" >HBCI</option>
									<option value="4500" >IPSec NAT-T</option>
									<option value="5190" >ICQ</option>
									<option value="5900" >VNC</option>
									<option value="5999" >CVSup</option>
							</select>
							<input autocomplete='off' class="formfldalias" name="srcbeginport_cust" id="srcbeginport_cust" type="text" size="5" value=""/>
						</td>

					</tr>
					<tr>
						<td>to:</td>
						<td>
							<select name="srcendport" class="formfld" onchange="ext_change()">
								<option value="">(other)</option>
								<option value="any" >any</option>
									<option value="3389" >MS RDP</option>
									<option value="21" >FTP</option>
									<option value="22" >SSH</option>
									<option value="23" >Telnet</option>
									<option value="25" >SMTP</option>
									<option value="53" >DNS</option>
									<option value="69" >TFTP</option>
									<option value="80" >HTTP</option>
									<option value="110" >POP3</option>
									<option value="113" >IDENT/AUTH</option>
									<option value="119" >NNTP</option>
									<option value="123" >NTP</option>
									<option value="137" >NetBIOS-NS</option>
									<option value="138" >NetBIOS-DGM</option>
									<option value="139" >NetBIOS-SSN</option>
									<option value="143" >IMAP</option>
									<option value="161" >SNMP</option>
									<option value="162" >SNMP-Trap</option>
									<option value="389" >LDAP</option>
									<option value="443" >HTTPS</option>
									<option value="445" >MS DS</option>
									<option value="465" >SMTP/S</option>
									<option value="500" >isakmp</option>
									<option value="993" >IMAP/S</option>
									<option value="995" >POP3/S</option>
									<option value="1194" >OpenVPN</option>
									<option value="1512" >MS WINS</option>
									<option value="1701" >L2TP</option>
									<option value="1723" >PPTP</option>
									<option value="1812" >Radius</option>
									<option value="1813" >Radius-accounting</option>
									<option value="3000" >HBCI</option>
									<option value="4500" >IPSec NAT-T</option>
									<option value="5190" >ICQ</option>
									<option value="5900" >VNC</option>
									<option value="5999" >CVSup</option>
							</select>
							<input autocomplete='off' class="formfldalias" name="srcendport_cust" id="srcendport_cust" type="text" size="5" value=""/>
						</td>
					</tr>
				</table>
				<br />
				<span class="vexpl">Specify the port or port range for the source of the packet for this rule. This is usually not equal to the destination port range (and is often &quot;any&quot;). <br /> Hint: you can leave the <em>'to'</em> field empty if you only want to filter a single port</span><br/>
				<span class="vexpl"><B>NOTE:</B> You will not need to enter anything here in 99.99999% of the circumstances.  If you're unsure, do not enter anything here!</span>
			</td>
		</tr>
		<tr>
			<td width="22%" valign="top" class="vncellreq">Source OS</td>
			<td width="78%" class="vtable">OS Type:&#160;
				<select name="os" id="os" class="formfld">
						<option value="" >any</option>
						<option value="AIX" >AIX</option>
						<option value="Linux" >Linux</option>
						<option value="FreeBSD" >FreeBSD</option>
						<option value="NetBSD" >NetBSD</option>
						<option value="OpenBSD" >OpenBSD</option>
						<option value="Solaris" >Solaris</option>
						<option value="MacOS" >MacOS</option>
						<option value="Windows" >Windows</option>
						<option value="Novell" >Novell</option>
						<option value="NMAP" >NMAP</option>
				</select>
				<br />
				Note: this only works for TCP rules
			</td>
		</tr>
		<tr>
			<td width="22%" valign="top" class="vncellreq">Destination</td>
			<td width="78%" class="vtable">
				<input name="dstnot" type="checkbox" id="dstnot" value="yes" />

				<strong>not</strong>
					<br />
				Use this option to invert the sense of the match.
					<br />
					<br />
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>Type:&#160;&#160;</td>

						<td>
							<select name="dsttype" class="formfld" onChange="typesel_change()">
								<option value="any" >any</option>
								<option value="single" >Single host or alias</option>
								<option value="network" >Network</option>
								<option value="wanip" >WAN address</option>
								<option value="lanip" >LAN address</option>

								<option value="lan" >LAN subnet</option>
								<option value="pptp" >PPTP clients</option>
								<option value="pppoe" >PPPoE clients</option>
									<option value="opt1" >OPT1 subnet</option>
									<option value="opt1ip">
										OPT1 address
									</option>

							</select>
						</td>
					</tr>
					<tr>
						<td>Address:&#160;&#160;</td>
						<td>
							<input name="dst" type="text" class="formfldalias" id="dst" size="20" value=""/>
							/
							<select name="dstmask" class="formfld" id="dstmask">

								<option value="31" >31</option>
								<option value="30" >30</option>
								<option value="29" >29</option>
								<option value="28" >28</option>
								<option value="27" >27</option>
								<option value="26" >26</option>

								<option value="25" >25</option>
								<option value="24" >24</option>
								<option value="23" >23</option>
								<option value="22" >22</option>
								<option value="21" >21</option>
								<option value="20" >20</option>

								<option value="19" >19</option>
								<option value="18" >18</option>
								<option value="17" >17</option>
								<option value="16" >16</option>
								<option value="15" >15</option>
								<option value="14" >14</option>

								<option value="13" >13</option>
								<option value="12" >12</option>
								<option value="11" >11</option>
								<option value="10" >10</option>
								<option value="9" >9</option>
								<option value="8" >8</option>

								<option value="7" >7</option>
								<option value="6" >6</option>
								<option value="5" >5</option>
								<option value="4" >4</option>
								<option value="3" >3</option>
								<option value="2" >2</option>

								<option value="1" >1</option>
							</select>
						</td>
					</tr>
				</table>

			</td>
		</tr>
		<tr id="dprtr" name="dprtr">

			<td width="22%" valign="top" class="vncellreq">Destination port range </td>
			<td width="78%" class="vtable">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>from:&#160;&#160;</td>
						<td>
							<select name="dstbeginport" class="formfld" onchange="dst_rep_change();ext_change()">
								<option value="">(other)</option>

								<option value="any" >any</option>
									<option value="3389" >MS RDP</option>
									<option value="21" >FTP</option>
									<option value="22" >SSH</option>
									<option value="23" >Telnet</option>
									<option value="25" >SMTP</option>

									<option value="53" >DNS</option>
									<option value="69" >TFTP</option>
									<option value="80" >HTTP</option>
									<option value="110" >POP3</option>
									<option value="113" >IDENT/AUTH</option>
									<option value="119" >NNTP</option>

									<option value="123" >NTP</option>
									<option value="137" >NetBIOS-NS</option>
									<option value="138" >NetBIOS-DGM</option>
									<option value="139" >NetBIOS-SSN</option>
									<option value="143" >IMAP</option>
									<option value="161" >SNMP</option>

									<option value="162" >SNMP-Trap</option>
									<option value="389" >LDAP</option>
									<option value="443" >HTTPS</option>
									<option value="445" >MS DS</option>
									<option value="465" >SMTP/S</option>
									<option value="500" >isakmp</option>

									<option value="993" >IMAP/S</option>
									<option value="995" >POP3/S</option>
									<option value="1194" >OpenVPN</option>
									<option value="1512" >MS WINS</option>
									<option value="1701" >L2TP</option>
									<option value="1723" >PPTP</option>

									<option value="1812" >Radius</option>
									<option value="1813" >Radius-accounting</option>
									<option value="3000" >HBCI</option>
									<option value="4500" >IPSec NAT-T</option>
									<option value="5190" >ICQ</option>
									<option value="5900" >VNC</option>

									<option value="5999" >CVSup</option>
							</select>
							<input autocomplete='off' class="formfldalias" name="dstbeginport_cust" id="dstbeginport_cust" type="text" size="5" value=""/>
						</td>
					</tr>
					<tr>
						<td>to:</td>
						<td>

							<select name="dstendport" class="formfld" onchange="ext_change()">
								<option value="">(other)</option>
								<option value="any" >any</option>
									<option value="3389" >MS RDP</option>
									<option value="21" >FTP</option>
									<option value="22" >SSH</option>

									<option value="23" >Telnet</option>
									<option value="25" >SMTP</option>
									<option value="53" >DNS</option>
									<option value="69" >TFTP</option>
									<option value="80" >HTTP</option>
									<option value="110" >POP3</option>

									<option value="113" >IDENT/AUTH</option>
									<option value="119" >NNTP</option>
									<option value="123" >NTP</option>
									<option value="137" >NetBIOS-NS</option>
									<option value="138" >NetBIOS-DGM</option>
									<option value="139" >NetBIOS-SSN</option>

									<option value="143" >IMAP</option>
									<option value="161" >SNMP</option>
									<option value="162" >SNMP-Trap</option>
									<option value="389" >LDAP</option>
									<option value="443" >HTTPS</option>
									<option value="445" >MS DS</option>

									<option value="465" >SMTP/S</option>
									<option value="500" >isakmp</option>
									<option value="993" >IMAP/S</option>
									<option value="995" >POP3/S</option>
									<option value="1194" >OpenVPN</option>
									<option value="1512" >MS WINS</option>

									<option value="1701" >L2TP</option>
									<option value="1723" >PPTP</option>
									<option value="1812" >Radius</option>
									<option value="1813" >Radius-accounting</option>
									<option value="3000" >HBCI</option>
									<option value="4500" >IPSec NAT-T</option>

									<option value="5190" >ICQ</option>
									<option value="5900" >VNC</option>
									<option value="5999" >CVSup</option>
							</select>
							<input autocomplete='off' class="formfldalias" name="dstendport_cust" id="dstendport_cust" type="text" size="5" value=""/>
						</td>
					</tr>

				</table>
				<br />
				<span class="vexpl">
					Specify the port or port range for the destination of the packet for this rule.
						<br />
					Hint: you can leave the <em>'to'</em> field empty if you only want to filter a single port
				</span>
			</td>

		</tr>
		<tr>
			<td width="22%" valign="top" class="vncellreq">Log</td>
			<td width="78%" class="vtable">
				<input name="log" type="checkbox" id="log" value="yes" />
				<strong>Log packets that are handled by this rule</strong>
					<br />
				<span class="vexpl">Hint: the firewall has limited local log space. Don't turn on logging for everything. If you want to do a lot of logging, consider using a remote syslog server (see the <a href="diag_logs_settings.php">Diagnostics: System logs: Settings</a> page).</span>

			</td>
		</tr>
		<tr>
			<td width="22%" valign="top" class="vncell">State Type</td>
			<td width="78%" class="vtable">
				<div id="showadvstatebox">

				</div>
				<div id="showstateadv" style="display:none">
					<select name="statetype">
						<option value="keep state" >keep state</option>
						<option value="modulate state" >modulate state</option>
						<option value="synproxy state">synproxy state</option>
						<option value="none">none</option>

					</select><br/>HINT: Select which type of state tracking mechanism you would like to use.  
					If in doubt, use keep state.
					
					<table width="90%">
						<tr><td width="25%"><ul><li>keep state</li><li>Works with all IP protocols.</li></ul></td></tr>
						<tr><td width="25%"><ul><li>modulate state</li><li>>Works only with TCP. pfSense will generate strong 
						Initial Sequence Numbers (ISNs) for packets matching this rule.</li></ul></td></tr>
						<tr><td width="25%"><ul><li>synproxy state</li><li>Proxies incoming TCP connections to help protect 
						servers from spoofed TCP SYN floods. This option includes the functionality of keep state and modulate state combined.</li></ul></td></tr>

						<tr><td width="25%"><ul><li>none</li><li>do not use state mechanisms to keep track.  This is only useful if you're doing advanced queueing in certain situations.  Please check the documentation.</li></ul></td></tr>
					</table>
					
			  </div>
			</td>
		</tr>
		<tr>
			<td width="22%" valign="top" class="vncell">No XMLRPC Sync</td>

			<td width="78%" class="vtable">
				<input type="checkbox" name="nosync"/><br/>
				HINT: This prevents the rule from automatically syncing to other carp members.
			</td>
		</tr>
				<tr>
			<td width="22%" valign="top" class="vncell">Schedule</td>
			<td width="78%" class="vtable">
				<select name='sched'>

<option value="" >none</option>
				</select>
				Leave as 'none' to leave the rule enabled all the time.
				<strong>NOTE:  schedule logic can be a bit different.  Click 
				<a target="_new" href="firewall_rules_schedule_logic.php">here</a> for more information.</strong>
			</td>
		</tr>

		<tr>
			<td width="22%" valign="top" class="vncell">Gateway</td>
			<td width="78%" class="vtable">
				<select name='gateway'>
<option value="" >default</option>
<option value="71.184.118.1" >71.184.118.1</option>
<option value="HTTP">HTTP</option>
<option value="IMAP">IMAP</option>

				</select>
				<strong>Leave as 'default' to use the system routing table. 
				Or choose a gateway to utilize policy based routing.</strong>
			</td>
		</tr>
		<tr>
			<td width="22%" valign="top" class="vncell">Description</td>
			<td width="78%" class="vtable">
				<input name="descr" type="text" class="formfld" id="descr" size="52" maxlength="52" value="ICMP"/>

				<br />
				<span class="vexpl">You may enter a description here for your reference (not parsed).</span>
			</td>
		</tr>
		<tr>
			<td width="22%" valign="top">&#160;</td>
			<td width="78%">
				<input name="Submit" type="submit" class="formbtn" value="Save"/>
				<input type="button" class="formbtn" value="Cancel" onclick="history.back()"/>

					<input name="id" type="hidden" value="14"/>
				<input name="after" type="hidden" value=""/>
			</td>
		</tr>
	</table>
</form>
  </xsl:template>
</xsl:stylesheet>
