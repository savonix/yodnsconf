use Text::CSV_XS;

my $csv = Text::CSV_XS->new ({ binary => 1 });
open my $fh, "<", "file.csv" or die "file.csv: $!";
while (my $row = $csv->getline ($fh)) {
    # do something with @$row
   my @fields = @$row;
    printf " %s\n",$fields[3];
}
$csv->eof or $csv->error_diag;
close $fh or die "file.csv: $!";

