# Do not edit this file - Generated by Perlito5 9.0
use v5;
use Perlito5::Perl5::Runtime;
package main;
package Perlito5::Precedence;
sub Perlito5::Precedence::new {
    ((my  $class) = shift());
    bless({@_}, $class)
};
((my  $Operator) = {});
((my  $Precedence) = {});
((my  $Assoc) = {});
sub Perlito5::Precedence::is_assoc_type {
    ((my  $assoc_type) = shift());
    ((my  $op_name) = shift());
    return ($Assoc->{$assoc_type}->{$op_name})
};
sub Perlito5::Precedence::is_fixity_type {
    ((my  $fixity_type) = shift());
    ((my  $op_name) = shift());
    return ($Operator->{$fixity_type}->{$op_name})
};
sub Perlito5::Precedence::is_term {
    ((my  $token) = shift());
    ((($token->[0] eq 'term')) || (($token->[0] eq 'postfix_or_term')))
};
sub Perlito5::Precedence::is_ident_middle {
    ((my  $c) = shift());
    ((((($c ge 'a') && ($c le 'z'))) || ((($c ge '0') && ($c le '9')))) || (($c eq '_')))
};
((my  @Parsed_op_chars) = (2, 1));
((my  %Parsed_op) = ('?', sub {
    Perlito5::Expression->term_ternary($_[0], $_[1])
}, '(', sub {
    Perlito5::Expression->term_paren($_[0], $_[1])
}, '[', sub {
    Perlito5::Expression->term_square($_[0], $_[1])
}, '{', sub {
    Perlito5::Expression->term_curly($_[0], $_[1])
}, '->', sub {
    Perlito5::Expression->term_arrow($_[0], $_[1])
}));
((my  @Term_chars) = (7, 6, 5, 4, 3, 2, 1));
((my  %Term) = ('$', sub {
    Perlito5::Expression->term_sigil($_[0], $_[1])
}, '@', sub {
    Perlito5::Expression->term_sigil($_[0], $_[1])
}, '%', sub {
    Perlito5::Expression->term_sigil($_[0], $_[1])
}, '&', sub {
    Perlito5::Expression->term_sigil($_[0], $_[1])
}, '*', sub {
    Perlito5::Expression->term_sigil($_[0], $_[1])
}, '.', sub {
    Perlito5::Expression->term_digit($_[0], $_[1])
}, '0', sub {
    Perlito5::Expression->term_digit($_[0], $_[1])
}, '1', sub {
    Perlito5::Expression->term_digit($_[0], $_[1])
}, '2', sub {
    Perlito5::Expression->term_digit($_[0], $_[1])
}, '3', sub {
    Perlito5::Expression->term_digit($_[0], $_[1])
}, '4', sub {
    Perlito5::Expression->term_digit($_[0], $_[1])
}, '5', sub {
    Perlito5::Expression->term_digit($_[0], $_[1])
}, '6', sub {
    Perlito5::Expression->term_digit($_[0], $_[1])
}, '7', sub {
    Perlito5::Expression->term_digit($_[0], $_[1])
}, '8', sub {
    Perlito5::Expression->term_digit($_[0], $_[1])
}, '9', sub {
    Perlito5::Expression->term_digit($_[0], $_[1])
}, 'my', sub {
    Perlito5::Expression->term_declarator($_[0], $_[1])
}, 'do', sub {
    Perlito5::Expression->term_do($_[0], $_[1])
}, 'our', sub {
    Perlito5::Expression->term_declarator($_[0], $_[1])
}, 'sub', sub {
    Perlito5::Expression->term_anon_sub($_[0], $_[1])
}, 'map', sub {
    Perlito5::Expression->term_map_or_sort($_[0], $_[1])
}, 'eval', sub {
    Perlito5::Expression->term_eval($_[0], $_[1])
}, 'sort', sub {
    Perlito5::Expression->term_map_or_sort($_[0], $_[1])
}, 'grep', sub {
    Perlito5::Expression->term_map_or_sort($_[0], $_[1])
}, 'state', sub {
    Perlito5::Expression->term_declarator($_[0], $_[1])
}, 'local', sub {
    Perlito5::Expression->term_declarator($_[0], $_[1])
}, 'return', sub {
    Perlito5::Expression->term_return($_[0], $_[1])
}, 'package', sub {
    Perlito5::Expression->term_package($_[0], $_[1])
}));
sub Perlito5::Precedence::add_term {
    ((my  $name) = shift());
    ((my  $param) = shift());
    ($Term{$name} = $param)
};
(my  $End_token);
(my  $End_token_chars);
(my  %Op);
((my  @Op_chars) = (3, 2, 1));
sub Perlito5::Precedence::op_parse {
    ((my  $self) = shift());
    ((my  $str) = shift());
    ((my  $pos) = shift());
    ((my  $last_is_term) = shift());
    for my $len (@{$End_token_chars}) {
        ((my  $term) = substr($str, $pos, $len));
        if (exists($End_token->{$term})) {
            ((my  $c1) = substr($str, (($pos + length($term)) - 1), 1));
            ((my  $c2) = substr($str, ($pos + length($term)), 1));
            if (!(((is_ident_middle($c1) && is_ident_middle($c2))))) {
                return ({'str', $str, 'from', $pos, 'to', $pos, 'capture', ['end', $term]})
            }
        }
    };
    if (!($last_is_term)) {
        for my $len (@Term_chars) {
            ((my  $term) = substr($str, $pos, $len));
            if (exists($Term{$term})) {
                ((my  $m) = $Term{$term}->($str, $pos));
                if ($m) {
                    return ($m)
                }
            }
        }
    };
    for my $len (@Parsed_op_chars) {
        ((my  $op) = substr($str, $pos, $len));
        if (exists($Parsed_op{$op})) {
            ((my  $m) = $Parsed_op{$op}->($str, $pos));
            if ($m) {
                return ($m)
            }
        }
    };
    for my $len (@Op_chars) {
        ((my  $op) = substr($str, $pos, $len));
        if (exists($Op{$op})) {
            ((my  $c1) = substr($str, (($pos + length($op)) - 1), 1));
            ((my  $c2) = substr($str, ($pos + length($op)), 1));
            if ((!(((is_ident_middle($c1) && ((is_ident_middle($c2) || ($c2 eq '(')))))) && !(((($c1 eq '&') && ($c2 eq '&')))))) {
                if (((exists($Operator->{'infix'}->{$op}) && !(exists($Operator->{'prefix'}->{$op}))) && !($last_is_term))) {

                }
                else {
                    return ({'str', $str, 'from', $pos, 'to', ($pos + $len), 'capture', ['op', $op]})
                }
            }
        }
    };
    return (Perlito5::Grammar::Bareword->term_bareword($str, $pos))
};
sub Perlito5::Precedence::add_op {
    ((my  $fixity) = shift());
    ((my  $name) = shift());
    ((my  $precedence) = shift());
    ((my  $param) = shift());
    if (!((defined($param)))) {
        ($param = {})
    };
    ((my  $assoc) = ($param->{'assoc'} || 'left'));
    ($Operator->{$fixity}->{$name} = 1);
    ($Precedence->{$name} = $precedence);
    ($Assoc->{$assoc}->{$name} = 1);
    ($Op{$name} = 1)
};
((my  $prec) = 100);
add_op('postfix', '.( )', $prec);
add_op('postfix', '.[ ]', $prec);
add_op('postfix', '.{ }', $prec);
add_op('postfix', '( )', $prec);
add_op('postfix', '[ ]', $prec);
add_op('postfix', 'funcall', $prec);
add_op('postfix', 'funcall_no_params', $prec);
add_op('postfix', 'methcall', $prec);
add_op('postfix', 'methcall_no_params', $prec);
add_op('postfix', 'block', $prec);
add_op('postfix', 'hash', $prec);
for (('$', '$#', '&', '*', '@', '%', '-r', '-w', '-x', '-o', '-R', '-W', '-X', '-O', '-e', '-z', '-s', '-f', '-d', '-l', '-p', '-S', '-b', '-c', '-t', '-u', '-g', '-k', '-T', '-B', '-M', '-A', '-C')) {
    add_op('prefix', $_, $prec)
};
($prec = ($prec - 1));
add_op('prefix', '++', $prec);
add_op('prefix', '--', $prec);
add_op('postfix', '++', $prec);
add_op('postfix', '--', $prec);
($prec = ($prec - 1));
add_op('infix', '**', $prec, {'assoc', 'right'});
($prec = ($prec - 1));
add_op('prefix', chr(92), $prec);
add_op('prefix', '+', $prec);
add_op('prefix', '-', $prec);
add_op('prefix', '~', $prec);
add_op('prefix', '!', $prec);
($prec = ($prec - 1));
add_op('infix', '=~', $prec);
add_op('infix', '!~', $prec);
($prec = ($prec - 1));
add_op('infix', '*', $prec);
add_op('infix', '/', $prec);
add_op('infix', '%', $prec);
add_op('infix', 'x', $prec);
($prec = ($prec - 1));
add_op('infix', '+', $prec);
add_op('infix', '-', $prec);
add_op('infix', '.', $prec, {'assoc', 'list'});
($prec = ($prec - 1));
add_op('infix', '<<', $prec);
add_op('infix', '>>', $prec);
($prec = ($prec - 1));
add_op('infix', 'lt', $prec, {'assoc', 'chain'});
add_op('infix', 'le', $prec, {'assoc', 'chain'});
add_op('infix', 'gt', $prec, {'assoc', 'chain'});
add_op('infix', 'ge', $prec, {'assoc', 'chain'});
add_op('infix', '<=', $prec, {'assoc', 'chain'});
add_op('infix', '>=', $prec, {'assoc', 'chain'});
add_op('infix', '<', $prec, {'assoc', 'chain'});
add_op('infix', '>', $prec, {'assoc', 'chain'});
($prec = ($prec - 1));
add_op('infix', '<=>', $prec);
add_op('infix', 'cmp', $prec);
add_op('infix', '==', $prec, {'assoc', 'chain'});
add_op('infix', '!=', $prec, {'assoc', 'chain'});
add_op('infix', 'ne', $prec, {'assoc', 'chain'});
add_op('infix', 'eq', $prec, {'assoc', 'chain'});
($prec = ($prec - 1));
add_op('infix', '&', $prec);
($prec = ($prec - 1));
add_op('infix', '|', $prec);
add_op('infix', '^', $prec);
($prec = ($prec - 1));
add_op('infix', '..', $prec);
add_op('infix', '...', $prec);
add_op('infix', '~~', $prec, {'assoc', 'chain'});
($prec = ($prec - 1));
add_op('infix', '&&', $prec);
($prec = ($prec - 1));
add_op('infix', '||', $prec);
add_op('infix', '//', $prec);
($prec = ($prec - 1));
add_op('ternary', '? :', $prec, {'assoc', 'right'});
($prec = ($prec - 1));
add_op('infix', '=', $prec, {'assoc', 'right'});
add_op('infix', '**=', $prec, {'assoc', 'right'});
add_op('infix', '+=', $prec, {'assoc', 'right'});
add_op('infix', '-=', $prec, {'assoc', 'right'});
add_op('infix', '*=', $prec, {'assoc', 'right'});
add_op('infix', '/=', $prec, {'assoc', 'right'});
add_op('infix', 'x=', $prec, {'assoc', 'right'});
add_op('infix', '|=', $prec, {'assoc', 'right'});
add_op('infix', '&=', $prec, {'assoc', 'right'});
add_op('infix', '.=', $prec, {'assoc', 'right'});
add_op('infix', '<<=', $prec, {'assoc', 'right'});
add_op('infix', '>>=', $prec, {'assoc', 'right'});
add_op('infix', '%=', $prec, {'assoc', 'right'});
add_op('infix', '||=', $prec, {'assoc', 'right'});
add_op('infix', '&&=', $prec, {'assoc', 'right'});
add_op('infix', '^=', $prec, {'assoc', 'right'});
add_op('infix', '//=', $prec, {'assoc', 'right'});
($prec = ($prec - 1));
add_op('infix', '=>', $prec);
($prec = ($prec - 1));
add_op('list', ',', $prec, {'assoc', 'list'});
($prec = ($prec - 1));
add_op('prefix', 'not', $prec);
($prec = ($prec - 1));
add_op('infix', 'and', $prec);
($prec = ($prec - 1));
add_op('infix', 'or', $prec);
add_op('infix', 'xor', $prec);
($prec = ($prec - 1));
add_op('infix', '*start*', $prec);
sub Perlito5::Precedence::precedence_parse {
    ((my  $self) = shift());
    ((my  $get_token) = $self->{'get_token'});
    ((my  $reduce) = $self->{'reduce'});
    ((my  $last_end_token) = $End_token);
    ((my  $last_end_token_chars) = $End_token_chars);
    ($End_token = $self->{'end_token'});
    ($End_token_chars = $self->{'end_token_chars'});
    ((my  $op_stack) = []);
    ((my  $num_stack) = []);
    ((my  $last) = ['op', '*start*']);
    ((my  $token) = $get_token->());
    if (($token->[0] eq 'space')) {
        ($token = $get_token->())
    };
    for ( ; ((defined($token)) && (($token->[0] ne 'end'))); do { for ($_) {

}} ) {
        if (((($token->[1] eq ',')) && (((($last->[1] eq '*start*')) || (($last->[1] eq ',')))))) {
            push(@{$num_stack}, ['term', undef()] )
        };
        if (($Operator->{'prefix'}->{$token->[1]} && (((($last->[1] eq '*start*')) || !((is_term($last))))))) {
            ($token->[0] = 'prefix');
            unshift(@{$op_stack}, $token)
        }
        else {
            if ((($Operator->{'postfix'})->{$token->[1]} && is_term($last))) {
                ((my  $pr) = $Precedence->{$token->[1]});
                for ( ; (scalar(@{$op_stack}) && (($pr <= $Precedence->{($op_stack->[0])->[1]}))); do { for ($_) {

}} ) {
                    $reduce->($op_stack, $num_stack)
                };
                if (($token->[0] ne 'postfix_or_term')) {
                    ($token->[0] = 'postfix')
                };
                unshift(@{$op_stack}, $token)
            }
            else {
                if (is_term($token)) {
                    if (is_term($last)) {
                        Perlito5::Runtime::say('#      last:  ', Perlito5::Dumper::Dumper($last));
                        Perlito5::Runtime::say('#      token: ', Perlito5::Dumper::Dumper($token));
                        die('Value tokens must be separated by an operator')
                    };
                    ($token->[0] = 'term');
                    push(@{$num_stack}, $token )
                }
                else {
                    if ($Precedence->{$token->[1]}) {
                        ((my  $pr) = $Precedence->{$token->[1]});
                        if ($Assoc->{'right'}->{$token->[1]}) {
                            for ( ; (scalar(@{$op_stack}) && (($pr < $Precedence->{($op_stack->[0])->[1]}))); do { for ($_) {

}} ) {
                                $reduce->($op_stack, $num_stack)
                            }
                        }
                        else {
                            for ( ; (scalar(@{$op_stack}) && (($pr <= $Precedence->{($op_stack->[0])->[1]}))); do { for ($_) {

}} ) {
                                $reduce->($op_stack, $num_stack)
                            }
                        };
                        if ($Operator->{'ternary'}->{$token->[1]}) {
                            ($token->[0] = 'ternary')
                        }
                        else {
                            ($token->[0] = 'infix')
                        };
                        unshift(@{$op_stack}, $token)
                    }
                    else {
                        die('Unknown token: ' . chr(39), $token->[1], chr(39))
                    }
                }
            }
        };
        ($last = $token);
        ($token = $get_token->());
        if (($token->[0] eq 'space')) {
            ($token = $get_token->())
        }
    };
    if ((defined($token) && (($token->[0] ne 'end')))) {
        die('Unexpected end token: ', $token)
    };
    for ( ; scalar(@{$op_stack}); do { for ($_) {

}} ) {
        $reduce->($op_stack, $num_stack)
    };
    ($End_token = $last_end_token);
    ($End_token_chars = $last_end_token_chars);
    return ($num_stack)
};
1;

1;
