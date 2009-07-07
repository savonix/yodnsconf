=pod
Program: YoDNSConf
Component: parse_csv.pl
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
=cut

use Text::CSV_XS;

my $csv = Text::CSV_XS->new ({ binary => 1 });
open my $fh, "<", "file.csv" or die "file.csv: $!";

while (my $row = $csv->getline ($fh)) {
    my @fields = @$row;
    $fields[0] =~ tr/A-Z/a-z/;
    printf '"%s","%s"',$fields[0],$fields[2];
    print "\n";
}
$csv->eof or $csv->error_diag;
close $fh or die "file.csv: $!";

1;
