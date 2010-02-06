use Test::More;
use Sequence qw(:all);

sub seq_ok {
    my ($thing, $reason) = @_;
    my $ok = ok eval { $thing->does('Sequence::Role') };
    unless ($ok) {
        diag 'The thing is undefined' unless defined $thing;
        my $ref = ref $thing;
        diag "The thing is a $ref, which doesn't do Sequence::Role" if $ref;
        diag q(The thing isn't even a reference);
    }
    return $ok;
}

my $seq = seq [1, 2, 3];

for (1..3) {
    seq_ok $seq;
    is first($seq), $_;
    $seq = rest $seq;
}

ok !defined first $seq;
is $seq, Sequence->empty;

done_testing;
