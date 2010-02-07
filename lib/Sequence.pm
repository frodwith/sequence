package Sequence;

use Modern::Perl;
use Scalar::Util qw(blessed);
use Carp qw(confess);
use Sequence::Empty;
use Sequence::Lazy;
use Sequence::Cons;

use Sub::Exporter -setup => {
    exports => [ qw(seq first rest succ cons reduce smap) ],
};

use namespace::clean -except => 'import';

our %adapters = (
    ARRAY => 'Sequence::Array',
    HASH  => 'Sequence::Hash',
);

foreach my $a (values %adapters) {
    eval "require $a" or croak $@;
}

sub empty {
    return Sequence::Empty->new;
}

sub seq {
    my $coll = shift;

    return undef unless defined $coll;

    if (my $ref = ref $coll) {
        if (my $a = $adapters{$ref}) {
            return $a->new($coll);
        }
        if (blessed($coll)) {
            return $coll->seq if $coll->can('seq');
        }

        confess "Cannot make seq out of $ref";
    }

    confess 'Cannot make seq out of argument';
}

sub first {
    my $seq = seq(shift)
        or return undef;

    return $seq->first;
}

sub rest {
    seq(shift)->rest;
}

sub succ {
    seq(shift)->succ;
}

sub cons {
    Sequence::Cons->new(@_);
}

sub reduce(&$$) {
    my ($f, $coll, $val) = @_;
    for (my $seq = seq $coll; $seq; $seq = succ $seq) {
        $val = $f->($val, first($seq));
    }
    return $val;
}

sub lazy_seq(&) {
    return Sequence::Lazy->new(shift);
}

sub smap(&$) {
    my ($f, $coll) = @_;
    return lazy_seq {
        my $s = seq $coll or return;
        cons $f->(first($s)), smap($f, rest($s));
    };
}

no namespace::clean;

1;
