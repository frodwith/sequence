package Sequence::Array;

use Moose;
extends 'Sequence::Base';
with    'Sequence::Role';

use namespace::clean -except => 'meta';

has array => (
    is       => 'ro',
    isa      => 'ArrayRef',
    required => 1,
);

has index => (
    is      => 'ro',
    isa     => 'Int',
    default => 0,
);

around new => sub {
    my $super = shift;
    my $class = shift;

    if (@_ == 1) {
        my $a = shift;
        return undef if @$a < 1;
        @_ = (array => $a);
    }

    return $class->$super(@_);
};

sub first {
    my $self = shift;
    return $self->array->[$self->index];
}

sub succ {
    my $self = shift;
    my $a    = $self->array;
    my $i    = $self->index;

    return undef unless $i+1 < @$a;

    return Sequence::Array->new(
        array => $self->array, 
        index => $self->index + 1
    );
}

no namespace::clean;

1;
