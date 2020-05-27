package Regexp::Pattern::Float;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;
#use utf8;

our %RE;

$RE{float_decimal} = {
    summary => 'Floating number (decimal form, e.g. +12, -12.3, .4, -5.)',
    pat => qr/[+-]?(?:[0-9]+(?:\.[0-9]*)?|[0-9]*\.[0-9]+)/,
    examples => [
        {str=>'', anchor=>1, matches=>0},

        {str=>'123', anchor=>1, matches=>1},
        {str=>'+123', anchor=>1, matches=>1},
        {str=>'-123', anchor=>1, matches=>1},

        {str=>'123.', anchor=>1, matches=>1},
        {str=>'+123.', anchor=>1, matches=>1},
        {str=>'-123.', anchor=>1, matches=>1},

        {str=>'123.0', anchor=>1, matches=>1},
        {str=>'+123.0', anchor=>1, matches=>1},
        {str=>'-123.0', anchor=>1, matches=>1},

        {str=>'123.0456', anchor=>1, matches=>1},
        {str=>'+123.0456', anchor=>1, matches=>1},
        {str=>'-123.0456', anchor=>1, matches=>1},

        {str=>'.5', anchor=>1, matches=>1},
        {str=>'+.5', anchor=>1, matches=>1},
        {str=>'-.5', anchor=>1, matches=>1},

        {str=>'.', anchor=>1, matches=>0},
        {str=>'+.', anchor=>1, matches=>0},
        {str=>'-.', anchor=>1, matches=>0},

        {str=>'1e1', anchor=>1, matches=>0, summary=>'Exponent form'},
        {str=>'Inf', anchor=>1, matches=>0, summary=>'infinity'},
        {str=>'NaN', anchor=>1, matches=>0, summary=>'nan'},

        {str=>'abc', anchor=>1, matches=>0},
    ],
};

$RE{ufloat_decimal} = {
    summary => 'Unsigned floating number (decimal form, e.g. 12, +12.3, .4, 5.)',
    pat => qr/[+]?(?:[0-9]+(?:\.[0-9]*)?|[0-9]*\.[0-9]+)/,
    examples => [
        {str=>'', anchor=>1, matches=>0},

        {str=>'123', anchor=>1, matches=>1},
        {str=>'+123', anchor=>1, matches=>1},
        {str=>'-123', anchor=>1, matches=>0},

        {str=>'123.', anchor=>1, matches=>1},
        {str=>'+123.', anchor=>1, matches=>1},
        {str=>'-123.', anchor=>1, matches=>0},

        {str=>'123.0', anchor=>1, matches=>1},
        {str=>'+123.0', anchor=>1, matches=>1},
        {str=>'-123.0', anchor=>1, matches=>0},

        {str=>'123.0456', anchor=>1, matches=>1},
        {str=>'+123.0456', anchor=>1, matches=>1},
        {str=>'-123.0456', anchor=>1, matches=>0},

        {str=>'.5', anchor=>1, matches=>1},
        {str=>'+.5', anchor=>1, matches=>1},
        {str=>'-.5', anchor=>1, matches=>0},

        {str=>'.', anchor=>1, matches=>0},
        {str=>'+.', anchor=>1, matches=>0},
        {str=>'-.', anchor=>1, matches=>0},

        {str=>'1e1', anchor=>1, matches=>0, summary=>'Exponent form'},
        {str=>'Inf', anchor=>1, matches=>0, summary=>'infinity'},
        {str=>'NaN', anchor=>1, matches=>0, summary=>'nan'},
    ],
};

$RE{float_exp} = {
    summary => 'Floating number (exponent form, e.g. 1.2e+3, -1.2e-3)',
    pat => qr/[+-]?(?:[0-9]+(?:\.[0-9]*)?|[0-9]*\.[0-9]+)(?:[Ee][+-]?[0-9])/,
    examples => [
        {str=>'', anchor=>1, matches=>0},

        {str=>'123', anchor=>1, matches=>0, summary=>'Decimal form'},
        {str=>'+123', anchor=>1, matches=>0, summary=>'Decimal form'},
        {str=>'-123', anchor=>1, matches=>0, summary=>'Decimal form'},

        {str=>'123e1', anchor=>1, matches=>1},
        {str=>'12.3E2', anchor=>1, matches=>1},
        {str=>'-123.e+3', anchor=>1, matches=>1},
        {str=>'+.5e-3', anchor=>1, matches=>1},

        {str=>'Inf', anchor=>1, matches=>0, summary=>'infinity'},
        {str=>'NaN', anchor=>1, matches=>0, summary=>'nan'},
    ],
};

$RE{float_decimal_or_exp} = {
    summary => 'Floating number (decimal or exponent form)',
    pat => qr/[+-]?(?:[0-9]+(?:\.[0-9]*)?|[0-9]*\.[0-9]+)(?:[Ee][+-]?[0-9])?/,
    examples => [
        {str=>'', anchor=>1, matches=>0},

        {str=>'123', anchor=>1, matches=>1},
        {str=>'+123.', anchor=>1, matches=>1},
        {str=>'+12.3', anchor=>1, matches=>1},
        {str=>'-.123', anchor=>1, matches=>1},

        {str=>'123e1', anchor=>1, matches=>1},
        {str=>'123.e2', anchor=>1, matches=>1},
        {str=>'-1.23E+3', anchor=>1, matches=>1},
        {str=>'+.5e-3', anchor=>1, matches=>1},

        {str=>'Inf', anchor=>1, matches=>0, summary=>'infinity'},
        {str=>'NaN', anchor=>1, matches=>0, summary=>'nan'},
    ],
};

$RE{float_inf} = {
    summary => 'Infinity',
    pat => qr/[+-]?(?:infinity|inf)/i,
    examples => [
        {str=>'', anchor=>1, matches=>0},
        {str=>'123', anchor=>1, matches=>0},
        {str=>'Inf', anchor=>1, matches=>1},
        {str=>'-Inf', anchor=>1, matches=>1},
        {str=>'+infinity', anchor=>1, matches=>1},
        {str=>'infini', anchor=>1, matches=>0},
        {str=>'NaN', anchor=>1, matches=>0, summary=>'nan'},
    ],
};

$RE{float_nan} = {
    summary => 'NaN',
    pat => qr/nan/i,
    examples => [
        {str=>'', anchor=>1, matches=>0},
        {str=>'123', anchor=>1, matches=>0},
        {str=>'Inf', anchor=>1, matches=>0, summary=>'infinity'},
        {str=>'NaN', anchor=>1, matches=>1, summary=>'nan'},
        {str=>'nan', anchor=>1, matches=>1, summary=>'nan'},
        {str=>'+NaN', anchor=>1, matches=>0, summary=>'nan does not recognize sign'},
        {str=>'-NaN', anchor=>1, matches=>0, summary=>'nan does not recognize sign'},
    ],
};

$RE{float} = {
    summary => 'Floating number (decimal or exponent form, or Inf/NaN)',
    pat => qr/(?:[+-]?(?:[0-9]+(?:\.[0-9]*)?|[0-9]*\.[0-9]+)(?:[Ee][+-]?[0-9])?|[+-]?(?:infinity|inf)|nan)/i, # XXX only set inf/nan parts as case-insensitive
    examples => [
        {str=>'', anchor=>1, matches=>0},

        # decimal
        {str=>'123', anchor=>1, matches=>1},
        {str=>'+123.', anchor=>1, matches=>1},
        {str=>'+12.3', anchor=>1, matches=>1},
        {str=>'-.123', anchor=>1, matches=>1},

        # exp
        {str=>'123e1', anchor=>1, matches=>1},
        {str=>'123.e2', anchor=>1, matches=>1},
        {str=>'-1.23E+3', anchor=>1, matches=>1},
        {str=>'+.5e-3', anchor=>1, matches=>1},

        # inf
        {str=>'Inf', anchor=>1, matches=>1},
        {str=>'-Inf', anchor=>1, matches=>1},
        {str=>'+infinity', anchor=>1, matches=>1},
        {str=>'infini', anchor=>1, matches=>0},

        # nan
        {str=>'NaN', anchor=>1, matches=>1, summary=>'nan'},
        {str=>'nan', anchor=>1, matches=>1, summary=>'nan'},
        {str=>'+NaN', anchor=>1, matches=>0, summary=>'nan does not recognize sign'},
        {str=>'-NaN', anchor=>1, matches=>0, summary=>'nan does not recognize sign'},

        {str=>'abc', anchor=>1, matches=>0},
    ],
};

$RE{ufloat} = {
    summary => 'Unsigned floating number (decimal or exponent form, or Inf/NaN)',
    pat => qr/(?:[+]?(?:[0-9]+(?:\.[0-9]*)?|[0-9]*\.[0-9]+)(?:[Ee][+-]?[0-9])?|[+]?(?:infinity|inf)|nan)/i, # XXX only set inf/nan parts as case-insensitive
    examples => [
        {str=>'', anchor=>1, matches=>0},

        # decimal
        {str=>'123', anchor=>1, matches=>1},
        {str=>'+123.', anchor=>1, matches=>1},
        {str=>'+12.3', anchor=>1, matches=>1},
        {str=>'-.123', anchor=>1, matches=>0},

        # exp
        {str=>'123e1', anchor=>1, matches=>1},
        {str=>'123.e2', anchor=>1, matches=>1},
        {str=>'-1.23E+3', anchor=>1, matches=>0},
        {str=>'+.5e-3', anchor=>1, matches=>1},

        # inf
        {str=>'Inf', anchor=>1, matches=>1},
        {str=>'-Inf', anchor=>1, matches=>0},
        {str=>'+infinity', anchor=>1, matches=>1},
        {str=>'infini', anchor=>1, matches=>0},

        # nan
        {str=>'NaN', anchor=>1, matches=>1, summary=>'nan'},
        {str=>'nan', anchor=>1, matches=>1, summary=>'nan'},
        {str=>'+NaN', anchor=>1, matches=>0, summary=>'nan does not recognize sign'},
        {str=>'-NaN', anchor=>1, matches=>0, summary=>'nan does not recognize sign'},

        {str=>'abc', anchor=>1, matches=>0},
    ],
};

1;
# ABSTRACT: Regexp patterns related to floating (decimal) numbers

=head1 SEE ALSO

L<Regexp::Pattern::Int>
