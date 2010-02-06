package Sequence::Base;
use Sequence::Empty;

use Moose;

sub cons {
    my ($self, $value) = @_;
    return Sequence::Cons->new($value, $self);
}

sub rest {
    my $seq = shift->succ;
    return $seq || Sequence::Empty->new;
}

1;
