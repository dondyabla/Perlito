use v6;

class Main {

    sub to_lisp_identifier ( $ident ) {
        return 'sv-' ~ $ident;
    }

}

=begin

=head1 NAME 

MiniPerl6::Python::Prelude - Runtime for MiniPerl6-in-Python

=head1 SYNOPSIS

=head1 DESCRIPTION

This module contains MiniPerl6 code for the MiniPerl6-in-Python runtime.

=head1 AUTHORS

Flavio Soibelmann Glock <fglock@gmail.com>.
The Pugs Team E<lt>perl6-compiler@perl.orgE<gt>.

=head1 SEE ALSO

The Perl 6 homepage at L<http://dev.perl.org/perl6>.

The Pugs homepage at L<http://pugscode.org/>.

=head1 COPYRIGHT

Copyright 2010 by Flavio Soibelmann Glock.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=end
