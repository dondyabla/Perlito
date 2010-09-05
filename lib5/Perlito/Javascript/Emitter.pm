# Do not edit this file - Generated by Perlito 6.0
use v5;
use utf8;
use strict;
use warnings;
no warnings ('redefine', 'once', 'void', 'uninitialized', 'misc', 'recursion');
use Perlito::Perl5::Runtime;
our $MATCH = Perlito::Match->new();
{
package GLOBAL;
sub new { shift; bless { @_ }, "GLOBAL" }

# use v6 
;
{
package Perlito::Javascript::LexicalBlock;
sub new { shift; bless { @_ }, "Perlito::Javascript::LexicalBlock" }
sub block { $_[0]->{block} };
sub needs_return { $_[0]->{needs_return} };
sub top_level { $_[0]->{top_level} };
sub emit_javascript { my $self = $_[0]; if (Main::bool(($self->{block} ? 0 : 1))) { return('null') } ; (my  $str = ''); for my $decl ( @{$self->{block} || []} ) { if (Main::bool((Main::isa($decl, 'Decl') && ($decl->decl() eq 'my')))) { ($str = $str . $decl->emit_javascript_init()) } ; if (Main::bool((Main::isa($decl, 'Apply') && ($decl->code() eq 'infix:<=>')))) { (my  $var = $decl->arguments()->[0]); if (Main::bool((Main::isa($var, 'Decl') && ($var->decl() eq 'my')))) { ($str = $str . $var->emit_javascript_init()) }  }  }; my  $last_statement; if (Main::bool($self->{needs_return})) { ($last_statement = pop( @{$self->{block}} )) } ; for my $decl ( @{$self->{block} || []} ) { if (Main::bool((((Main::isa($decl, 'Decl') && ($decl->decl() eq 'my'))) ? 0 : 1))) { ($str = $str . $decl->emit_javascript() . ';') }  }; if (Main::bool(($self->{needs_return} && $last_statement))) { if (Main::bool(Main::isa($last_statement, 'If'))) { (my  $cond = $last_statement->cond()); (my  $body = $last_statement->body()); (my  $otherwise = $last_statement->otherwise()); if (Main::bool((Main::isa($cond, 'Var') && ($cond->sigil() eq '@')))) { ($cond = Apply->new(('code' => 'prefix:<@>'), ('arguments' => [$cond]))) } ; ($body = Perlito::Javascript::LexicalBlock->new(('block' => $body->stmts()), ('needs_return' => 1))); ($str = $str . 'if ( f_bool(' . $cond->emit_javascript() . ') ) { ' . 'return (function () { ' . $body->emit_javascript() . ' })() }'); if (Main::bool($otherwise)) { ($otherwise = Perlito::Javascript::LexicalBlock->new(('block' => $otherwise->stmts()), ('needs_return' => 1))); ($str = $str . ' else { ' . 'return (function () { ' . $otherwise->emit_javascript() . ' })() }') }  } else { if (Main::bool(((Main::isa($last_statement, 'Apply') && ($last_statement->code() eq 'return')) || Main::isa($last_statement, 'For')))) { ($str = $str . $last_statement->emit_javascript()) } else { ($str = $str . 'return(' . $last_statement->emit_javascript() . ')') } } } ; if (Main::bool($self->{top_level})) { ($str = 'try { ' . $str . ' } catch(err) { ' . 'if ( err instanceof Error ) { ' . 'throw(err) ' . '} ' . 'else { ' . 'return(err) ' . '} ' . '} ') } ; return($str) }
}

;
{
package CompUnit;
sub new { shift; bless { @_ }, "CompUnit" }
sub name { $_[0]->{name} };
sub attributes { $_[0]->{attributes} };
sub methods { $_[0]->{methods} };
sub body { $_[0]->{body} };
sub emit_javascript { my $self = $_[0]; (my  $class_name = Main::to_javascript_namespace($self->{name})); (my  $str = '// class ' . $self->{name} . '
' . 'if (typeof ' . $class_name . ' != \'object\') {' . '
' . '  ' . $class_name . ' = function() {};' . '
' . '  ' . $class_name . ' = new ' . $class_name . ';' . '
' . '  ' . $class_name . '.f_isa = function (s) { return s == \'' . $self->{name} . '\' };' . '
' . '  ' . $class_name . '.f_perl = function () { return \'' . $self->{name} . '.new(\' + Main._dump(this) + \')\' };' . '
' . '}' . '
' . '(function () {' . '
' . '  var v__NAMESPACE = ' . $class_name . ';' . '
'); for my $decl ( @{$self->{body} || []} ) { if (Main::bool((Main::isa($decl, 'Decl') && (($decl->decl() eq 'my'))))) { ($str = $str . $decl->emit_javascript_init()) } ; if (Main::bool((Main::isa($decl, 'Apply') && ($decl->code() eq 'infix:<=>')))) { (my  $var = $decl->arguments()->[0]); if (Main::bool((Main::isa($var, 'Decl') && ($var->decl() eq 'my')))) { ($str = $str . $var->emit_javascript_init()) }  }  }; for my $decl ( @{$self->{body} || []} ) { if (Main::bool((Main::isa($decl, 'Decl') && (($decl->decl() eq 'has'))))) { ($str = $str . '  // accessor ' . $decl->var()->name() . '
' . '  ' . $class_name . '.v_' . $decl->var()->name() . ' = null;' . '
' . '  ' . $class_name . '.f_' . $decl->var()->name() . ' = function () { return this.v_' . $decl->var()->name() . ' }' . '
') } ; if (Main::bool(Main::isa($decl, 'Method'))) { (my  $sig = $decl->sig()); (my  $pos = $sig->positional()); (my  $invocant = $sig->invocant()); (my  $block = Perlito::Javascript::LexicalBlock->new(('block' => $decl->block()), ('needs_return' => 1), ('top_level' => 1))); ($str = $str . '  // method ' . $decl->name() . '
' . '  ' . $class_name . '.f_' . $decl->name() . ' = function (' . Main::join(([ map { $_->emit_javascript() } @{ $pos } ]), ', ') . ') {' . '
' . '    var ' . $invocant->emit_javascript() . ' = this;' . '
' . '    ' . $block->emit_javascript() . '
' . '  }' . '
' . '  ' . $class_name . '.f_' . $decl->name() . ';  // v8 bug workaround' . '
') } ; if (Main::bool(Main::isa($decl, 'Sub'))) { (my  $sig = $decl->sig()); (my  $pos = $sig->positional()); (my  $block = Perlito::Javascript::LexicalBlock->new(('block' => $decl->block()), ('needs_return' => 1), ('top_level' => 1))); ($str = $str . '  // sub ' . $decl->name() . '
' . '  ' . $class_name . '.f_' . $decl->name() . ' = function (' . Main::join(([ map { $_->emit_javascript() } @{ $pos } ]), ', ') . ') {' . '
' . '    ' . $block->emit_javascript() . '
' . '  }' . '
') }  }; for my $decl ( @{$self->{body} || []} ) { if (Main::bool(((((((Main::isa($decl, 'Decl') && (((($decl->decl() eq 'has')) || (($decl->decl() eq 'my')))))) ? 0 : 1)) && (((Main::isa($decl, 'Method')) ? 0 : 1))) && (((Main::isa($decl, 'Sub')) ? 0 : 1))))) { ($str = $str . ($decl)->emit_javascript() . ';') }  }; ($str = $str . '}' . ')();' . '
') }
}

;
{
package Val::Int;
sub new { shift; bless { @_ }, "Val::Int" }
sub int { $_[0]->{int} };
sub emit_javascript { my $self = $_[0]; $self->{int} }
}

;
{
package Val::Bit;
sub new { shift; bless { @_ }, "Val::Bit" }
sub bit { $_[0]->{bit} };
sub emit_javascript { my $self = $_[0]; (Main::bool($self->{bit}) ? 'true' : 'false') }
}

;
{
package Val::Num;
sub new { shift; bless { @_ }, "Val::Num" }
sub num { $_[0]->{num} };
sub emit_javascript { my $self = $_[0]; $self->{num} }
}

;
{
package Val::Buf;
sub new { shift; bless { @_ }, "Val::Buf" }
sub buf { $_[0]->{buf} };
sub emit_javascript { my $self = $_[0]; '"' . Main::javascript_escape_string($self->{buf}) . '"' }
}

;
{
package Lit::Block;
sub new { shift; bless { @_ }, "Lit::Block" }
sub sig { $_[0]->{sig} };
sub stmts { $_[0]->{stmts} };
sub emit_javascript { my $self = $_[0]; Main::join(([ map { $_->emit_javascript() } @{ $self->{stmts} } ]), '; ') }
}

;
{
package Lit::Array;
sub new { shift; bless { @_ }, "Lit::Array" }
sub array1 { $_[0]->{array1} };
sub emit_javascript { my $self = $_[0]; (my  $needs_interpolation = 0); my  $List_items; for my $item ( @{$self->{array1} || []} ) { if (Main::bool((Main::isa($item, 'Apply') && ((($item->code() eq 'circumfix:<( )>') || ($item->code() eq 'list:<,>')))))) { for my $arg ( @{[@{(($item->arguments()) || []) || []}] || []} ) { push( @{$List_items}, $arg ) } } else { push( @{$List_items}, $item ) } }; for my $item ( @{$List_items || []} ) { if (Main::bool(((Main::isa($item, 'Var') && ($item->sigil() eq '@')) || (Main::isa($item, 'Apply') && ((($item->code() eq 'prefix:<@>') || ($item->code() eq 'infix:<..>'))))))) { ($needs_interpolation = 1) }  }; if (Main::bool($needs_interpolation)) { (my  $s = ''); for my $item ( @{$List_items || []} ) { if (Main::bool(((Main::isa($item, 'Var') && ($item->sigil() eq '@')) || (Main::isa($item, 'Apply') && ((($item->code() eq 'prefix:<@>') || ($item->code() eq 'infix:<..>'))))))) { ($s = $s . '(function(a_) { ' . 'for (var i_ = 0; i_ < a_.length ; i_++) { a.push(a_[i_]) }' . '})(' . $item->emit_javascript() . '); ') } else { ($s = $s . 'a.push(' . $item->emit_javascript() . '); ') } }; '(function () { var a = []; ' . $s . ' return a })()' } else { '[' . Main::join(([ map { $_->emit_javascript() } @{ $List_items } ]), ', ') . ']' } }
}

;
{
package Lit::Hash;
sub new { shift; bless { @_ }, "Lit::Hash" }
sub hash1 { $_[0]->{hash1} };
sub emit_javascript { my $self = $_[0]; my  $List_s; my  $List_items; for my $item ( @{$self->{hash1} || []} ) { if (Main::bool((Main::isa($item, 'Apply') && ((($item->code() eq 'circumfix:<( )>') || ($item->code() eq 'list:<,>')))))) { for my $arg ( @{[@{(($item->arguments()) || []) || []}] || []} ) { push( @{$List_items}, $arg ) } } else { push( @{$List_items}, $item ) } }; for my $item ( @{$List_items || []} ) { if (Main::bool((Main::isa($item, 'Apply') && ($item->code() eq 'infix:<=>>')))) { push( @{$List_s}, 'a[' . $item->arguments()->[0]->emit_javascript() . '] = ' . $item->arguments()->[1]->emit_javascript() ) } else { if (Main::bool(((Main::isa($item, 'Var') && ($item->sigil() eq '%')) || (Main::isa($item, 'Apply') && ($item->code() eq 'prefix:<%>'))))) { push( @{$List_s}, '(function (o) { ' . 'for(var i in o) { ' . 'a[i] = o[i] ' . '} ' . '})(' . $item->emit_javascript() . ');' ) } else { die('Error in hash composer: ', Main::perl($item, )) } } }; return('(function () { var a = {}; ' . Main::join($List_s, '; ') . '; ' . 'return a ' . '})()') }
}

;
{
package Index;
sub new { shift; bless { @_ }, "Index" }
sub obj { $_[0]->{obj} };
sub index_exp { $_[0]->{index_exp} };
sub emit_javascript { my $self = $_[0]; $self->{obj}->emit_javascript() . '[' . $self->{index_exp}->emit_javascript() . ']' }
}

;
{
package Lookup;
sub new { shift; bless { @_ }, "Lookup" }
sub obj { $_[0]->{obj} };
sub index_exp { $_[0]->{index_exp} };
sub emit_javascript { my $self = $_[0]; (my  $str = ''); (my  $var = $self->{obj}); my  $var_js; if (Main::bool(Main::isa($var, 'Lookup'))) { (my  $var1 = $var->obj()); (my  $var1_js = $var1->emit_javascript()); ($str = $str . 'if (' . $var1_js . ' == null) { ' . $var1_js . ' = {} }; '); ($var_js = $var1_js . '[' . $var->index_exp()->emit_javascript() . ']') } else { ($var_js = $var->emit_javascript()) }; ($str = $str . 'if (' . $var_js . ' == null) { ' . $var_js . ' = {} }; '); (my  $index_js = $self->{index_exp}->emit_javascript()); ($str = $str . 'return (' . $var_js . '[' . $index_js . '] ' . '); '); return('(function () { ' . $str . '})()') }
}

;
{
package Var;
sub new { shift; bless { @_ }, "Var" }
sub sigil { $_[0]->{sigil} };
sub twigil { $_[0]->{twigil} };
sub namespace { $_[0]->{namespace} };
sub name { $_[0]->{name} };
sub emit_javascript { my $self = $_[0]; (my  $table = { ('$' => 'v_'), ('@' => 'List_'), ('%' => 'Hash_'), ('&' => 'Code_') }); (my  $ns = ''); if (Main::bool($self->{namespace})) { ($ns = Main::to_javascript_namespace($self->{namespace}) . '.') } ; (Main::bool((($self->{twigil} eq '.'))) ? ('v_self.v_' . $self->{name} . '') : ((Main::bool((($self->{name} eq '/'))) ? ($table->{$self->{sigil}} . 'MATCH') : ($table->{$self->{sigil}} . $ns . $self->{name})))) };
sub plain_name { my $self = $_[0]; if (Main::bool($self->{namespace})) { return($self->{namespace} . '.' . $self->{name}) } ; return($self->{name}) }
}

;
{
package Proto;
sub new { shift; bless { @_ }, "Proto" }
sub name { $_[0]->{name} };
sub emit_javascript { my $self = $_[0]; Main::to_javascript_namespace($self->{name}) }
}

;
{
package Call;
sub new { shift; bless { @_ }, "Call" }
sub invocant { $_[0]->{invocant} };
sub hyper { $_[0]->{hyper} };
sub method { $_[0]->{method} };
sub arguments { $_[0]->{arguments} };
sub emit_javascript { my $self = $_[0]; (my  $invocant = $self->{invocant}->emit_javascript()); if (Main::bool(($invocant eq 'self'))) { ($invocant = 'v_self') } ; if (Main::bool(($self->{method} eq 'new'))) { (my  $str = []); for my $field ( @{$self->{arguments} || []} ) { if (Main::bool((Main::isa($field, 'Apply') && ($field->code() eq 'infix:<=>>')))) { push( @{$str}, 'v_' . $field->arguments()->[0]->buf() . ': ' . $field->arguments()->[1]->emit_javascript() ) } else { die('Error in constructor, field: ', Main::perl($field, )) } }; return('(function () { ' . 'var tmp = {' . Main::join($str, ',') . '}; ' . 'tmp.__proto__ = ' . Main::to_javascript_namespace($invocant) . '; ' . 'return tmp ' . '})()') } ; if (Main::bool(((((((((($self->{method} eq 'perl')) || (($self->{method} eq 'isa'))) || (($self->{method} eq 'scalar'))) || (($self->{method} eq 'keys'))) || (($self->{method} eq 'values'))) || (($self->{method} eq 'elems'))) || (($self->{method} eq 'say'))) || (($self->{method} eq 'chars'))))) { if (Main::bool(($self->{hyper}))) { return('(function (a_) { ' . 'var out = []; ' . 'if ( a_ == null ) { return out }; ' . 'for(var i = 0; i < a_.length; i++) { ' . 'out.push( f_' . $self->{method} . '(a_[i]) ) } return out;' . ' })(' . $invocant . ')') } ; return('f_' . $self->{method} . '(' . $invocant . ((Main::bool(($self->{arguments} || [])) ? ', ' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ', ') : '')) . ')') } ; if (Main::bool((((((($self->{method} eq 'join')) || (($self->{method} eq 'shift'))) || (($self->{method} eq 'unshift'))) || (($self->{method} eq 'push'))) || (($self->{method} eq 'pop'))))) { return($invocant . '.' . $self->{method} . '(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ', ') . ')') } ; (my  $meth = $self->{method}); if (Main::bool(($self->{hyper}))) { return('(function (a_) { ' . 'var out = []; ' . 'if ( a_ == null ) { return out }; ' . 'for(var i = 0; i < a_.length; i++) { ' . 'out.push( a_[i].f_' . $meth . '(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ', ') . ') ) ' . '}; ' . 'return out;' . ' })(' . $invocant . ')') } ; if (Main::bool(($meth eq 'postcircumfix:<( )>'))) { return('(' . $invocant . ')(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ', ') . ')') } ; return($invocant . '.f_' . $meth . '(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ', ') . ')') }
}

;
{
package Apply;
sub new { shift; bless { @_ }, "Apply" }
sub code { $_[0]->{code} };
sub arguments { $_[0]->{arguments} };
sub namespace { $_[0]->{namespace} };
sub emit_javascript { my $self = $_[0]; (my  $code = $self->{code}); if (Main::bool(Main::isa($code, 'Str'))) {  } else { return('(' . $self->{code}->emit_javascript() . ')->(' . Main::join(([ map { $_->emit() } @{ $self->{arguments} } ]), ', ') . ')') }; if (Main::bool(($code eq 'self'))) { return('v_self') } ; if (Main::bool(($code eq 'Mu'))) { return('null') } ; if (Main::bool(($code eq 'make'))) { return('(v_MATCH.v_capture = ' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ', ') . ')') } ; if (Main::bool(($code eq 'defined'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' ') . ' != null)') } ; if (Main::bool(($code eq 'substr'))) { return('(' . ($self->{arguments}->[0])->emit_javascript() . ' || "").substr(' . ($self->{arguments}->[1])->emit_javascript() . ', ' . ($self->{arguments}->[2])->emit_javascript() . ')') } ; if (Main::bool(($code eq 'Int'))) { return('parseInt(' . ($self->{arguments}->[0])->emit_javascript() . ')') } ; if (Main::bool(($code eq 'Num'))) { return('parseFloat(' . ($self->{arguments}->[0])->emit_javascript() . ')') } ; if (Main::bool(($code eq 'prefix:<~>'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' ') . ').f_string()') } ; if (Main::bool(($code eq 'prefix:<!>'))) { return('( f_bool(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' ') . ') ? false : true)') } ; if (Main::bool(($code eq 'prefix:<?>'))) { return('( f_bool(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' ') . ') ? true : false)') } ; if (Main::bool(($code eq 'prefix:<$>'))) { return('f_scalar(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' ') . ')') } ; if (Main::bool(($code eq 'prefix:<@>'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' ') . ')') } ; if (Main::bool(($code eq 'prefix:<%>'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' ') . ').f_hash()') } ; if (Main::bool(($code eq 'postfix:<++>'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' ') . ')++') } ; if (Main::bool(($code eq 'postfix:<-->'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' ') . ')--') } ; if (Main::bool(($code eq 'prefix:<++>'))) { return('++(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' ') . ')') } ; if (Main::bool(($code eq 'prefix:<-->'))) { return('--(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' ') . ')') } ; if (Main::bool(($code eq 'list:<~>'))) { return('(f_string(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ') + f_string(') . '))') } ; if (Main::bool(($code eq 'infix:<+>'))) { return('f_add(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ', ') . ')') } ; if (Main::bool(($code eq 'infix:<->'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' - ') . ')') } ; if (Main::bool(($code eq 'infix:<*>'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' * ') . ')') } ; if (Main::bool(($code eq 'infix:</>'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' / ') . ')') } ; if (Main::bool(($code eq 'infix:<>>'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' > ') . ')') } ; if (Main::bool(($code eq 'infix:<<>'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' < ') . ')') } ; if (Main::bool(($code eq 'infix:<>=>'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' >= ') . ')') } ; if (Main::bool(($code eq 'infix:<<=>'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' <= ') . ')') } ; if (Main::bool(($code eq 'infix:<=>>'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ', ') . ')') } ; if (Main::bool(($code eq 'infix:<..>'))) { return('(function (a) { ' . 'for (var i=' . $self->{arguments}->[0]->emit_javascript() . ', l=' . $self->{arguments}->[1]->emit_javascript() . '; ' . 'i<=l; ++i)' . '{ ' . 'a.push(i) ' . '}; ' . 'return a ' . '})([])') } ; if (Main::bool(($code eq 'infix:<&&>'))) { return('f_and(' . $self->{arguments}->[0]->emit_javascript() . ', ' . 'function () { return ' . $self->{arguments}->[1]->emit_javascript() . '})') } ; if (Main::bool(($code eq 'infix:<||>'))) { return('f_or(' . $self->{arguments}->[0]->emit_javascript() . ', ' . 'function () { return ' . $self->{arguments}->[1]->emit_javascript() . '})') } ; if (Main::bool(($code eq 'infix:<//>'))) { return('f_defined_or(' . $self->{arguments}->[0]->emit_javascript() . ', ' . 'function () { return ' . $self->{arguments}->[1]->emit_javascript() . '})') } ; if (Main::bool(($code eq 'infix:<eq>'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' == ') . ')') } ; if (Main::bool(($code eq 'infix:<ne>'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' != ') . ')') } ; if (Main::bool(($code eq 'infix:<ge>'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' >= ') . ')') } ; if (Main::bool(($code eq 'infix:<le>'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' <= ') . ')') } ; if (Main::bool(($code eq 'infix:<==>'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' == ') . ')') } ; if (Main::bool(($code eq 'infix:<!=>'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ' != ') . ')') } ; if (Main::bool(($code eq 'exists'))) { (my  $arg = $self->{arguments}->[0]); if (Main::bool(Main::isa($arg, 'Lookup'))) { return('(' . ($arg->obj())->emit_javascript() . ').hasOwnProperty(' . ($arg->index_exp())->emit_javascript() . ')') }  } ; if (Main::bool(($code eq 'ternary:<?? !!>'))) { return('( f_bool(' . ($self->{arguments}->[0])->emit_javascript() . ')' . ' ? ' . ($self->{arguments}->[1])->emit_javascript() . ' : ' . ($self->{arguments}->[2])->emit_javascript() . ')') } ; if (Main::bool(($code eq 'circumfix:<( )>'))) { return('(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ', ') . ')') } ; if (Main::bool(($code eq 'infix:<=>'))) { return(emit_bind($self->{arguments}->[0], $self->{arguments}->[1])) } ; if (Main::bool(($code eq 'return'))) { return('throw(' . ((Main::bool(($self->{arguments} || [])) ? $self->{arguments}->[0]->emit_javascript() : 'null')) . ')') } ; ($code = 'f_' . $self->{code}); if (Main::bool($self->{namespace})) { ($code = Main::to_javascript_namespace($self->{namespace}) . '.' . $code) } else { if (Main::bool(((((((((((($code ne 'f_index')) && (($code ne 'f_die'))) && (($code ne 'f_shift'))) && (($code ne 'f_unshift'))) && (($code ne 'f_push'))) && (($code ne 'f_pop'))) && (($code ne 'f_chr'))) && (($code ne 'f_say'))) && (($code ne 'f_print'))) && (($code ne 'f_warn'))))) { ($code = 'v__NAMESPACE.' . $code) }  }; $code . '(' . Main::join(([ map { $_->emit_javascript() } @{ $self->{arguments} } ]), ', ') . ')' };
sub emit_bind { my $parameters = $_[0]; my $arguments = $_[1]; if (Main::bool(Main::isa($parameters, 'Lit::Array'))) { (my  $a = $parameters->array1()); (my  $str = 'do { '); (my  $i = 0); for my $var ( @{[@{($a || []) || []}] || []} ) { ($str = $str . ' ' . emit_bind($var, Index->new(('obj' => $arguments), ('index_exp' => Val::Int->new(('int' => $i))))) . '; '); ($i = ($i + 1)) }; return($str . $parameters->emit_javascript() . ' }') } ; if (Main::bool(Main::isa($parameters, 'Lit::Hash'))) { (my  $a = $parameters->hash1()); (my  $b = $arguments->hash1()); (my  $str = 'do { '); (my  $i = 0); my  $arg; for my $var ( @{[@{($a || []) || []}] || []} ) { ($arg = Apply->new(('code' => 'Mu'))); for my $var2 ( @{[@{($b || []) || []}] || []} ) { if (Main::bool((($var2->[0])->buf() eq ($var->[0])->buf()))) { ($arg = $var2->[1]) }  }; ($str = $str . ' ' . emit_bind($var->[1], $arg) . '; '); ($i = ($i + 1)) }; return($str . $parameters->emit_javascript() . ' }') } ; if (Main::bool(Main::isa($parameters, 'Call'))) { return('(' . ($parameters->invocant())->emit_javascript() . '.v_' . $parameters->method() . ' = ' . $arguments->emit_javascript() . ')') } ; if (Main::bool(Main::isa($parameters, 'Lookup'))) { (my  $str = ''); (my  $var = $parameters->obj()); my  $var_js; if (Main::bool(Main::isa($var, 'Lookup'))) { (my  $var1 = $var->obj()); (my  $var1_js = $var1->emit_javascript()); ($str = $str . 'if (' . $var1_js . ' == null) { ' . $var1_js . ' = {} }; '); ($var_js = $var1_js . '[' . $var->index_exp()->emit_javascript() . ']') } else { ($var_js = $var->emit_javascript()) }; ($str = $str . 'if (' . $var_js . ' == null) { ' . $var_js . ' = {} }; '); (my  $index_js = $parameters->index_exp()->emit_javascript()); ($str = $str . 'return (' . $var_js . '[' . $index_js . '] ' . ' = ' . $arguments->emit_javascript() . '); '); return('(function () { ' . $str . '})()') } ; if (Main::bool(((Main::isa($parameters, 'Var') && ($parameters->sigil() eq '@')) || (Main::isa($parameters, 'Decl') && ($parameters->var()->sigil() eq '@'))))) { ($arguments = Lit::Array->new(('array1' => [$arguments]))) } else { if (Main::bool(((Main::isa($parameters, 'Var') && ($parameters->sigil() eq '%')) || (Main::isa($parameters, 'Decl') && ($parameters->var()->sigil() eq '%'))))) { ($arguments = Lit::Hash->new(('hash1' => [$arguments]))) }  }; '(' . $parameters->emit_javascript() . ' = ' . $arguments->emit_javascript() . ')' }
}

;
{
package If;
sub new { shift; bless { @_ }, "If" }
sub cond { $_[0]->{cond} };
sub body { $_[0]->{body} };
sub otherwise { $_[0]->{otherwise} };
sub emit_javascript { my $self = $_[0]; (my  $cond = $self->{cond}); if (Main::bool((Main::isa($cond, 'Var') && ($cond->sigil() eq '@')))) { ($cond = Apply->new(('code' => 'prefix:<@>'), ('arguments' => [$cond]))) } ; (my  $body = Perlito::Javascript::LexicalBlock->new(('block' => $self->{body}->stmts()), ('needs_return' => 0))); (my  $s = 'if ( f_bool(' . $cond->emit_javascript() . ') ) { ' . '(function () { ' . $body->emit_javascript() . ' })() }'); if (Main::bool($self->{otherwise})) { (my  $otherwise = Perlito::Javascript::LexicalBlock->new(('block' => $self->{otherwise}->stmts()), ('needs_return' => 0))); ($s = $s . ' else { ' . '(function () { ' . $otherwise->emit_javascript() . ' })() }') } ; return($s) }
}

;
{
package While;
sub new { shift; bless { @_ }, "While" }
sub init { $_[0]->{init} };
sub cond { $_[0]->{cond} };
sub continue { $_[0]->{continue} };
sub body { $_[0]->{body} };
sub emit_javascript { my $self = $_[0]; (my  $body = Perlito::Javascript::LexicalBlock->new(('block' => $self->{body}->stmts()), ('needs_return' => 0))); return('for ( ' . ((Main::bool($self->{init}) ? $self->{init}->emit_javascript() . '; ' : '; ')) . ((Main::bool($self->{cond}) ? 'f_bool(' . $self->{cond}->emit_javascript() . '); ' : '; ')) . ((Main::bool($self->{continue}) ? $self->{continue}->emit_javascript() . ' ' : ' ')) . ') { ' . '(function () { ' . $body->emit_javascript() . ' })()' . ' }') }
}

;
{
package For;
sub new { shift; bless { @_ }, "For" }
sub cond { $_[0]->{cond} };
sub body { $_[0]->{body} };
sub emit_javascript { my $self = $_[0]; (my  $cond = $self->{cond}); if (Main::bool((((Main::isa($cond, 'Var') && ($cond->sigil() eq '@'))) ? 0 : 1))) { ($cond = Lit::Array->new(('array1' => [$cond]))) } ; (my  $body = Perlito::Javascript::LexicalBlock->new(('block' => $self->{body}->stmts()), ('needs_return' => 0))); (my  $sig = 'v__'); if (Main::bool($self->{body}->sig())) { ($sig = $self->{body}->sig()->emit_javascript()) } ; '(function (a_) { for (var i_ = 0; i_ < a_.length ; i_++) { ' . '(function (' . $sig . ') ' . '{' . ' ' . $body->emit_javascript() . ' })(a_[i_]) } })' . '(' . $cond->emit_javascript() . ')' }
}

;
{
package Decl;
sub new { shift; bless { @_ }, "Decl" }
sub decl { $_[0]->{decl} };
sub type { $_[0]->{type} };
sub var { $_[0]->{var} };
sub emit_javascript { my $self = $_[0]; $self->{var}->emit_javascript() };
sub emit_javascript_init { my $self = $_[0]; if (Main::bool(($self->{decl} eq 'my'))) { (my  $str = ''); ($str = $str . 'var ' . ($self->{var})->emit_javascript() . ' = '); if (Main::bool((($self->{var})->sigil() eq '%'))) { ($str = $str . '{};' . '
') } else { if (Main::bool((($self->{var})->sigil() eq '@'))) { ($str = $str . '[];' . '
') } else { ($str = $str . 'null;' . '
') } }; return($str) } else { die('not implemented: Decl \'' . $self->{decl} . '\'') } }
}

;
{
package Sig;
sub new { shift; bless { @_ }, "Sig" }
sub invocant { $_[0]->{invocant} };
sub positional { $_[0]->{positional} };
sub named { $_[0]->{named} }
}

;
{
package Method;
sub new { shift; bless { @_ }, "Method" }
sub name { $_[0]->{name} };
sub sig { $_[0]->{sig} };
sub block { $_[0]->{block} };
sub emit_javascript { my $self = $_[0]; (my  $sig = $self->{sig}); (my  $invocant = $sig->invocant()); (my  $pos = $sig->positional()); (my  $str = Main::join([ map { $_->emit_javascript() } @{ $pos } ], ', ')); 'function ' . $self->{name} . '(' . $str . ') { ' . (Perlito::Javascript::LexicalBlock->new(('block' => $self->{block}), ('needs_return' => 1), ('top_level' => 1)))->emit_javascript() . ' }' }
}

;
{
package Sub;
sub new { shift; bless { @_ }, "Sub" }
sub name { $_[0]->{name} };
sub sig { $_[0]->{sig} };
sub block { $_[0]->{block} };
sub emit_javascript { my $self = $_[0]; (my  $sig = $self->{sig}); (my  $pos = $sig->positional()); (my  $str = Main::join([ map { $_->emit_javascript() } @{ $pos } ], ', ')); 'function ' . $self->{name} . '(' . $str . ') { ' . (Perlito::Javascript::LexicalBlock->new(('block' => $self->{block}), ('needs_return' => 1), ('top_level' => 1)))->emit_javascript() . ' }' }
}

;
{
package Do;
sub new { shift; bless { @_ }, "Do" }
sub block { $_[0]->{block} };
sub emit_javascript { my $self = $_[0]; if (Main::bool(Main::isa($self->{block}, 'Do'))) { return($self->{block}->emit_javascript()) } ; if (Main::bool(Main::isa($self->{block}, 'Lit::Block'))) { return('(function () { ' . (Perlito::Javascript::LexicalBlock->new(('block' => $self->{block}->stmts()), ('needs_return' => 1)))->emit_javascript() . ' })()') } ; return('(function () { ' . (Perlito::Javascript::LexicalBlock->new(('block' => $self->{block}), ('needs_return' => 1)))->emit_javascript() . ' })()') }
}

;
{
package Use;
sub new { shift; bless { @_ }, "Use" }
sub mod { $_[0]->{mod} };
sub emit_javascript { my $self = $_[0]; '// use ' . $self->{mod} . '
' }
}


}

1;
