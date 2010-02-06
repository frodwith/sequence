package Sequence::Cons;
use Moose;

extends 'Sequence::Base';
with    'Sequence::Role';

sub new {
    my ($class, $car, $cdr) = @_;

    return bless [$car, $cdr], $class;
}

sub first {
    return shift->[0];
}

sub rest {
    return shift->[1];
}

sub empty {
    return 0;
}

1;
