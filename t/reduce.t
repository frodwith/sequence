use Test::More;
use Sequence qw(reduce);
use Modern::Perl;

sub sum {
    reduce { $_[0] + $_[1] } \@_, 0;
}

is sum(1,2,3), 6;

done_testing;
