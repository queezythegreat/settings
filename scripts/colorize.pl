#!/usr/bin/env perl
use strict;
use warnings;

use Getopt::Long;
use Term::ANSIColor::Markup;

my %options;
GetOptions(
    'flush' => \$options{flush},
    map { $_ . '=s' => \$options{$_} } keys %Term::ANSIColor::Markup::Parser::TAGS,
);

$| = 1 if delete $options{flush};
!defined $options{$_} && delete $options{$_}
    for keys %Term::ANSIColor::Markup::Parser::TAGS;

my $parser = Term::ANSIColor::Markup->new;
while (<STDIN>) {
    my $line = $_ ne '' ? $_ : next;
    for my $key (keys %options) {
        $line =~ s!($options{$key})!<$key>$1</$key>!g;
    }
    $parser->parse($line);
    print $parser->text;
    $parser->parser->result = '';
}

=pod
