package Sequence::Empty;

use Moose;
with 'Sequence::Role' => { excludes => 'seq' };

use namespace::clean -except => 'meta';

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
    return Sequence::Cons->new($_[1], $self);
}

sub seq {
    return undef;
}

no namespace::clean;

1;
