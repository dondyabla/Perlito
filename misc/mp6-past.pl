package main;

use lib 'lib5';
use strict;

BEGIN {
    $::_V6_COMPILER_NAME    = 'Perlito';
    $::_V6_COMPILER_VERSION = '0.003';
}

use Perlito::Perl5::Runtime;
use Perlito::Perl5::Match;

package Main;
use Perlito::Grammar;
use Perlito::PAST::Emitter;
use Perlito::Grammar::Regex;
use Perlito::Emitter::Token;

my $source = join('', <> );
my $pos = 0;

say( "# Do not edit this file - Generated by Perlito" );
#say( "use v5;" );
#say( "use strict;" );
#say( "use Perlito::Perl5::Runtime;" );
#say( "use Perlito::Perl5::Match;" );

while ( $pos < length( $source ) ) {
    #say( "Source code:", $source );
    my $p = Perlito::Grammar->comp_unit($source, $pos);
    #say( Main::perl( $$p ) );
    say( join( '', (map { $_->emit() } ($$p) )));
    #say( $p->to, " -- ", length($source) );
    #say( Main::newline );
    $pos = $p->to;
}

#say( '.sub _ :main' );
#say( '.end' );
