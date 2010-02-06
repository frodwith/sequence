package Sequence;

use Modern::Perl;
use Sub::Exporter;

use Scalar::Util qw(blessed);
use Carp qw(croak);

use Sequence::Empty;

use namespace::clean;

Sub::Exporter::setup_exporter(
    {   exports => [
            qw(
                seq 
                first
                rest
                succ
                reduce
            )
        ]
    }
);

our %adapters = (
    ARRAY => 'Sequence::Array',
    #HASH  => 'Sequence::Hash',
);

foreach my $a (values %adapters) {
    eval "require $a" or croak $@;
}

sub empty {
    return Sequence::Empty->new;
}

sub seq {
    my $coll = shift;

    return empty unless defined $coll;

    if (my $ref = ref $coll) {
        if (my $a = $adapters{$ref}) {
            return $a->new($coll);
        }
        if (blessed($coll)) {
            return $coll->seq if $coll->can('seq');
        }

        croak "Unknown reftype: $ref";
    }

    croak 'Can only make seqs from reftypes';
}

sub first {
    seq(shift)->first;
}

sub rest {
    seq(shift)->rest;
}

sub succ {
    seq(shift)->succ;
}

sub reduce(&$$) {
    my ($fn, $coll, $val) = @_;
    for (my $seq = seq $coll; $seq; $seq = succ $seq) {
        $val = $fn->($val, first $seq);
    }
    return $val;
}

no namespace::clean;

1;
