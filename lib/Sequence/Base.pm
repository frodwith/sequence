package Sequence::Base;
use Sequence::Empty;

use Moose;

use namespace::clean -except => 'meta';

sub cons {
    my ($self, $value) = @_;
    return Sequence::Cons->new($value, $self);
}

sub rest {
    my $seq = shift->succ;
    return $seq || Sequence::Empty->new;
}

no namespace::clean;

1;
