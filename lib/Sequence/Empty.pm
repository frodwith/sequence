package Sequence::Empty;

use Moose;
with 'Sequence::Role';

my $self = bless do { \my $scalar };

sub new {
    return $self;
}

sub first {
    return undef;
}

sub succ {
    return undef;
}

sub rest {
    return $self;
}

sub cons {
    return Sequence::Cons->new(shift, $self);
}

1;
