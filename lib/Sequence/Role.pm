package Sequence::Role;

use Moose::Role;

requires qw(first succ rest cons);

sub seq {
    return shift;
}

1;
