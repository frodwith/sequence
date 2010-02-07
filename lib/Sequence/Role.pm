package Sequence::Role;

use Moose::Role;

requires qw(first succ rest cons);

use namespace::clean -except => 'meta';

sub seq {
    return shift;
}

no namespace::clean;

1;
