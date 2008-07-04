=pod
Program: YoDNSConf
Component: runtime.pl
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
=cut

use XML::Simple;

my $parser = XML::LibXML->new();
my $flow = Apache2::Aortica::Kernel::Flow->instance();

my $config  = Apache2::Aortica::Kernel::Config->instance();

my $defaults = $config->{ CONFIG }->{ defaults };


my $xml_str = XMLout($defaults, 'RootName' => 'defaults', 'NoAttr' => 1 );

my $xml = $parser->parse_string( $xml_str );

my $node = $flow->{ DOC }->importNode($xml->documentElement());
$flow->{ ROOT }->appendChild($node);






my $auth = Apache2::Aortica::Kernel::Auth->new();

$auth_info = $auth->check_status();
$username = $auth_info->{username};
my $runtime;
my $link_prefix = '/yodnsconf?nid=';
my $path_prefix = '/a/dev/yodnsconf/';

#print(Dumper($auth_info));
if ($username) {
    $runtime = "
    <runtime>
        <link_prefix>$link_prefix</link_prefix>
        <path_prefix>$path_prefix</path_prefix>
        <user_id>1</user_id>
        <group_id>1</group_id>
        <username>$username</username>
    </runtime>";
} else {
    $runtime = "
    <runtime>
        <link_prefix>$link_prefix</link_prefix>
        <path_prefix>$path_prefix</path_prefix>
    </runtime>";
}

my $xml2 = $parser->parse_string( $runtime );

my $node2 = $flow->{ DOC }->importNode($xml2->documentElement());
$flow->{ ROOT }->appendChild($node2);
