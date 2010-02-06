package Sequence::Array;

use Moose;
extends 'Sequence::Base';
with    'Sequence::Role';

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

sub BUILDARGS {
    my $class = shift;
    @_ = (array => shift) if @_ == 1;
    return $class->SUPER::BUILDARGS(@_);
}

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

1;
