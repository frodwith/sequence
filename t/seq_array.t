use Test::More;
use Test::Sequence;
use Data::Dumper;
use Sequence qw(:all);

my $seq = seq [1, 2, 3];

for (1..3) {
    seq_ok $seq;
    is first($seq), $_
        or diag Dumper $seq;
    $seq = rest($seq);
}

ok !defined first($seq);
is $seq, Sequence->empty;

ok !defined seq [];

done_testing;
