package Sequence::Cons;
use Moose;

extends 'Sequence::Base';
with    'Sequence::Role';

use namespace::clean -except => 'meta';

sub new {
    my ($class, $car, $cdr) = @_;

    return bless [$car, $cdr], $class;
}

sub first {
    return shift->[0];
}

sub succ {
    return shift->[1];
}

no namespace::clean;

1;
