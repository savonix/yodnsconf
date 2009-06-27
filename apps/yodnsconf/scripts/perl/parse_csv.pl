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

