# Do not edit this file - Generated by MiniPerl6 5.0
use v5;
use strict;
use MiniPerl6::Perl5::Runtime;
our $MATCH = MiniPerl6::Match->new();
{
package Ruby;
sub new { shift; bless { @_ }, "Ruby" }
sub to_str { my $op = $_[0]; my $args = $_[1]; my  $List_s; for my $cond ( @{$args || []} ) { if (Main::bool(Main::isa($cond, 'Val::Buf'))) { push( @{$List_s}, $cond->emit_ruby() ) } else { push( @{$List_s}, '(' . $cond->emit_ruby() . ').to_s' ) } }; return('(' . Main::join($List_s, $op) . ')') };
sub to_num { my $op = $_[0]; my $args = $_[1]; my  $List_s; for my $cond ( @{$args || []} ) { if (Main::bool((Main::isa($cond, 'Val::Int') || Main::isa($cond, 'Val::Num')))) { push( @{$List_s}, $cond->emit_ruby() ) } else { push( @{$List_s}, 'mp6_to_num(' . $cond->emit_ruby() . ')' ) } }; return('(' . Main::join($List_s, $op) . ')') };
sub to_bool { my $op = $_[0]; my $args = $_[1]; my  $List_s; for my $cond ( @{$args || []} ) { if (Main::bool((Main::isa($cond, 'Val::Int') || (Main::isa($cond, 'Val::Num') || Main::isa($cond, 'Val::Bit'))))) { push( @{$List_s}, '(' . $cond->emit_ruby() . ' != 0 )' ) } else { if (Main::bool(((Main::isa($cond, 'Apply') && ($cond->code() eq 'infix:<||>')) || ((Main::isa($cond, 'Apply') && ($cond->code() eq 'infix:<&&>')) || ((Main::isa($cond, 'Apply') && ($cond->code() eq 'prefix:<!>')) || (Main::isa($cond, 'Apply') && ($cond->code() eq 'prefix:<?>'))))))) { push( @{$List_s}, $cond->emit_ruby() ) } else { push( @{$List_s}, 'mp6_to_bool(' . $cond->emit_ruby() . ')' ) } } }; return('(' . Main::join($List_s, $op) . ')') };
sub tab { my $level = $_[0]; (my  $s = ''); (my  $count = $level); for ( ; ($count > 0);  ) { ($s = $s . '    '); ($count = ($count - 1)) }; return($s) }
}

{
package MiniPerl6::Ruby::AnonSub;
sub new { shift; bless { @_ }, "MiniPerl6::Ruby::AnonSub" }
sub name { $_[0]->{name} };
sub sig { $_[0]->{sig} };
sub block { $_[0]->{block} };
sub handles_return_exception { $_[0]->{handles_return_exception} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; (my  $sig = $self->{sig}); (my  $pos = $sig->positional()); (my  $args = []); for my $field ( @{$pos || []} ) { push( @{$args}, $field->emit_ruby_name() ) }; (my  $block = MiniPerl6::Ruby::LexicalBlock->new( 'block' => $self->{block},'needs_return' => 1, )); my  $List_s; push( @{$List_s}, Ruby::tab($level) . (Main::bool($self->{name}) ? 'f_' . $self->{name} . ' = ' : '') . 'lambda{ |' . Main::join($args, ', ') . '| ' ); push( @{$List_s}, $block->emit_ruby_indented(($level + 1)) ); push( @{$List_s}, Ruby::tab($level) . '}' ); return(Main::join($List_s, '
')) }
}

{
package MiniPerl6::Ruby::LexicalBlock;
sub new { shift; bless { @_ }, "MiniPerl6::Ruby::LexicalBlock" }
sub block { $_[0]->{block} };
sub needs_return { $_[0]->{needs_return} };
sub top_level { $_[0]->{top_level} };
my  $ident;
my  $List_anon_block;
sub push_stmt_ruby { my $block = $_[0]; push( @{$List_anon_block}, $block ) };
sub get_ident_ruby { ($ident = ($ident + 1)); return($ident) };
sub has_my_decl { my $self = $_[0]; for my $decl ( @{$self->{block} || []} ) { if (Main::bool((Main::isa($decl, 'Decl') && ($decl->decl() eq 'my')))) { return(1) } else {  };if (Main::bool((Main::isa($decl, 'Bind') && (Main::isa($decl->parameters(), 'Decl') && ($decl->parameters()->decl() eq 'my'))))) { return(1) } else {  } }; return(0) };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; if (@{$self->{block} || []}) {  } else { push( @{$self->{block}}, Val::Undef->new(  ) ) }; my  $List_s; my  $List_tmp; for my $stmt ( @{$List_anon_block || []} ) { push( @{$List_tmp}, $stmt ) }; (my  $has_decl = []); (my  $block = []); for my $decl ( @{$self->{block} || []} ) { if (Main::bool((Main::isa($decl, 'Decl') && ($decl->decl() eq 'has')))) { push( @{$has_decl}, $decl ) } else { if (Main::bool((Main::isa($decl, 'Bind') && (Main::isa($decl->parameters(), 'Decl') && ($decl->parameters()->decl() eq 'has'))))) { push( @{$has_decl}, $decl ) } else { push( @{$block}, $decl ) } } }; if (Main::bool(@{$has_decl || []})) { for my $decl ( @{$has_decl || []} ) { if (Main::bool((Main::isa($decl, 'Decl') && ($decl->decl() eq 'has')))) { push( @{$List_s}, Ruby::tab($level) . 'attr_accessor :v_' . $decl->var()->name() );push( @{$List_s}, Ruby::tab($level) . 'def f_' . $decl->var()->name() . '()' );push( @{$List_s}, Ruby::tab(($level + 1)) . 'return self.v_' . $decl->var()->name() );push( @{$List_s}, Ruby::tab($level) . 'end' ) } else {  };if (Main::bool((Main::isa($decl, 'Bind') && (Main::isa($decl->parameters(), 'Decl') && ($decl->parameters()->decl() eq 'has'))))) { push( @{$List_s}, Ruby::tab($level) . 'attr_accessor :v_' . $decl->parameters()->var()->name() );push( @{$List_s}, Ruby::tab($level) . 'def f_' . $decl->parameters()->var()->name() . '()' );push( @{$List_s}, Ruby::tab(($level + 1)) . 'return self.v_' . $decl->parameters()->var()->name() );push( @{$List_s}, Ruby::tab($level) . 'end' ) } else {  } } } else {  }; (my  $has_my_decl = 0); my  $List_my_decl; my  $List_my_init; my  $Hash_my_seen; for my $decl ( @{$block || []} ) { if (Main::bool((Main::isa($decl, 'Decl') && ($decl->decl() eq 'my')))) { if (Main::bool($Hash_my_seen->{$decl->var()->name()})) {  } else { push( @{$List_my_decl}, $decl->var()->emit_ruby_name() );push( @{$List_my_init}, $decl->emit_ruby_init() );($has_my_decl = 1);($Hash_my_seen->{$decl->var()->name()} = 1) } } else {  };if (Main::bool((Main::isa($decl, 'Bind') && (Main::isa($decl->parameters(), 'Decl') && ($decl->parameters()->decl() eq 'my'))))) { if (Main::bool($Hash_my_seen->{$decl->parameters()->var()->name()})) {  } else { push( @{$List_my_decl}, $decl->parameters()->var()->emit_ruby_name() );push( @{$List_my_init}, $decl->parameters()->emit_ruby_init() );($has_my_decl = 1);($Hash_my_seen->{$decl->parameters()->var()->name()} = 1) } } else {  } }; if (Main::bool($has_my_decl)) { push( @{$List_s}, Ruby::tab($level) . 'Proc.new{ |' . Main::join($List_my_decl, ', ') . '|' ) } else {  }; my  $last_statement; if (Main::bool($self->{needs_return})) { ($last_statement = pop( @{$block} )) } else {  }; for my $stmt ( @{$block || []} ) { ($List_anon_block = []);(my  $s2 = $stmt->emit_ruby_indented($level));for my $stmt ( @{$List_anon_block || []} ) { push( @{$List_s}, $stmt->emit_ruby_indented($level) ) };push( @{$List_s}, $s2 ) }; if (Main::bool(($self->{needs_return} && $last_statement))) { ($List_anon_block = []);my  $s2;if (Main::bool(Main::isa($last_statement, 'If'))) { (my  $cond = $last_statement->cond());(my  $has_otherwise = (Main::bool($last_statement->otherwise()) ? 1 : 0));(my  $body_block = MiniPerl6::Ruby::LexicalBlock->new( 'block' => $last_statement->body(),'needs_return' => 1, ));(my  $otherwise_block = MiniPerl6::Ruby::LexicalBlock->new( 'block' => $last_statement->otherwise(),'needs_return' => 1, ));if (Main::bool($body_block->has_my_decl())) { ($body_block = Return->new( 'result' => Do->new( 'block' => $last_statement->body(), ), )) } else {  };if (Main::bool(($has_otherwise && $otherwise_block->has_my_decl()))) { ($otherwise_block = Return->new( 'result' => Do->new( 'block' => $last_statement->otherwise(), ), )) } else {  };($s2 = Ruby::tab($level) . 'if ' . Ruby::to_bool(' && ', [$cond]) . '
' . $body_block->emit_ruby_indented(($level + 1)));if (Main::bool($has_otherwise)) { ($s2 = $s2 . '
' . Ruby::tab($level) . 'else
' . $otherwise_block->emit_ruby_indented(($level + 1)) . '
' . Ruby::tab($level) . 'end') } else { ($s2 = $s2 . '
' . Ruby::tab($level) . 'end') } } else { if (Main::bool(Main::isa($last_statement, 'Bind'))) { ($s2 = $last_statement->emit_ruby_indented($level));($s2 = $s2 . '
' . Ruby::tab($level) . 'return ' . $last_statement->parameters()->emit_ruby()) } else { if (Main::bool((Main::isa($last_statement, 'Return') || Main::isa($last_statement, 'For')))) { ($s2 = $last_statement->emit_ruby_indented($level)) } else { ($s2 = Ruby::tab($level) . 'return ' . $last_statement->emit_ruby()) } } };for my $stmt ( @{$List_anon_block || []} ) { push( @{$List_s}, $stmt->emit_ruby_indented($level) ) };push( @{$List_s}, $s2 ) } else {  }; if (Main::bool($has_my_decl)) { push( @{$List_s}, Ruby::tab($level) . '}.call(' . Main::join($List_my_init, ', ') . ')' ) } else {  }; ($List_anon_block = $List_tmp); return(Main::join($List_s, '
')) }
}

{
package CompUnit;
sub new { shift; bless { @_ }, "CompUnit" }
sub name { $_[0]->{name} };
sub attributes { $_[0]->{attributes} };
sub methods { $_[0]->{methods} };
sub body { $_[0]->{body} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; my  $List_s; (my  $block = MiniPerl6::Ruby::LexicalBlock->new( 'block' => $self->{body}, )); (my  $label = '_anon_' . MiniPerl6::Ruby::LexicalBlock::get_ident_ruby()); (my  $name = Main::to_go_namespace($self->{name})); for my $decl ( @{$self->{body} || []} ) { if (Main::bool(Main::isa($decl, 'Use'))) { push( @{$List_s}, Ruby::tab($level) . 'require \'' . Main::to_go_namespace($decl->mod()) . '.rb\'' ) } else {  } }; push( @{$List_s}, Ruby::tab($level) . 'class C_' . $name ); push( @{$List_s}, Ruby::tab(($level + 1)) . '$' . $name . ' = C_' . $name . '.new()' ); push( @{$List_s}, Ruby::tab(($level + 1)) . 'namespace = $' . $name ); push( @{$List_s}, $block->emit_ruby_indented(($level + 1)) ); push( @{$List_s}, Ruby::tab($level) . 'end' ); return(Main::join($List_s, '
')) }
}

{
package Val::Int;
sub new { shift; bless { @_ }, "Val::Int" }
sub int { $_[0]->{int} };
sub emit_ruby { my $self = $_[0]; $self->{int} };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; Ruby::tab($level) . $self->{int} }
}

{
package Val::Bit;
sub new { shift; bless { @_ }, "Val::Bit" }
sub bit { $_[0]->{bit} };
sub emit_ruby { my $self = $_[0]; $self->{bit} };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; Ruby::tab($level) . $self->{bit} }
}

{
package Val::Num;
sub new { shift; bless { @_ }, "Val::Num" }
sub num { $_[0]->{num} };
sub emit_ruby { my $self = $_[0]; $self->{num} };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; Ruby::tab($level) . $self->{num} }
}

{
package Val::Buf;
sub new { shift; bless { @_ }, "Val::Buf" }
sub buf { $_[0]->{buf} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; Ruby::tab($level) . '"' . Main::javascript_escape_string($self->{buf}) . '"' }
}

{
package Val::Undef;
sub new { shift; bless { @_ }, "Val::Undef" }
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; Ruby::tab($level) . 'nil' }
}

{
package Val::Object;
sub new { shift; bless { @_ }, "Val::Object" }
sub class { $_[0]->{class} };
sub fields { $_[0]->{fields} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; Ruby::tab($level) . $self->{class}->emit_ruby() . '(' . $self->{fields}->emit_ruby() . ')' }
}

{
package Lit::Array;
sub new { shift; bless { @_ }, "Lit::Array" }
sub array1 { $_[0]->{array1} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; (my  $needs_interpolation = 0); for my $item ( @{$self->{array1} || []} ) { if (Main::bool(((Main::isa($item, 'Var') && ($item->sigil() eq '@')) || (Main::isa($item, 'Apply') && ($item->code() eq 'prefix:<@>'))))) { ($needs_interpolation = 1) } else {  } }; if (Main::bool($needs_interpolation)) { my  $List_block;(my  $temp_array = Var->new( 'name' => 'a','namespace' => '','sigil' => '@','twigil' => '', ));for my $item ( @{$self->{array1} || []} ) { if (Main::bool(((Main::isa($item, 'Var') && ($item->sigil() eq '@')) || (Main::isa($item, 'Apply') && ($item->code() eq 'prefix:<@>'))))) { push( @{$List_block}, Call->new( 'method' => 'concat','arguments' => [$item],'hyper' => '','invocant' => $temp_array, ) ) } else { push( @{$List_block}, Call->new( 'method' => 'push','arguments' => [$item],'hyper' => '','invocant' => $temp_array, ) ) } };push( @{$List_block}, $temp_array );(my  $body_block = MiniPerl6::Ruby::LexicalBlock->new( 'block' => $List_block, ));return(Ruby::tab($level) . 'Proc.new { |list_a| ' . '
' . $body_block->emit_ruby_indented(($level + 1)) . '
' . Ruby::tab($level) . '}.call(C_Array.new())') } else { Ruby::tab($level) . 'C_Array.new([' . Main::join([ map { $_->emit_ruby() } @{ $self->{array1} } ], ', ') . '])' } }
}

{
package Lit::Hash;
sub new { shift; bless { @_ }, "Lit::Hash" }
sub hash1 { $_[0]->{hash1} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; (my  $fields = $self->{hash1}); my  $List_dict; for my $field ( @{$fields || []} ) { push( @{$List_dict}, $field->[0]->emit_ruby() . ' => ' . $field->[1]->emit_ruby() ) }; Ruby::tab($level) . '{' . Main::join($List_dict, ', ') . '}' }
}

{
package Lit::Code;
sub new { shift; bless { @_ }, "Lit::Code" }
1
}

{
package Lit::Object;
sub new { shift; bless { @_ }, "Lit::Object" }
sub class { $_[0]->{class} };
sub fields { $_[0]->{fields} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; (my  $fields = $self->{fields}); my  $List_str; for my $field ( @{$fields || []} ) { push( @{$List_str}, 'o.v_' . $field->[0]->buf() . '=' . $field->[1]->emit_ruby() . '; ' ) }; Ruby::tab($level) . 'Proc.new { |o| ' . Main::join($List_str, ' ') . 'o }.call(C_' . Main::to_go_namespace($self->{class}) . '.new)' }
}

{
package Index;
sub new { shift; bless { @_ }, "Index" }
sub obj { $_[0]->{obj} };
sub index_exp { $_[0]->{index_exp} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; Ruby::tab($level) . $self->{obj}->emit_ruby() . '[' . $self->{index_exp}->emit_ruby() . ']' }
}

{
package Lookup;
sub new { shift; bless { @_ }, "Lookup" }
sub obj { $_[0]->{obj} };
sub index_exp { $_[0]->{index_exp} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; Ruby::tab($level) . $self->{obj}->emit_ruby() . '[' . $self->{index_exp}->emit_ruby() . ']' }
}

{
package Var;
sub new { shift; bless { @_ }, "Var" }
sub sigil { $_[0]->{sigil} };
sub twigil { $_[0]->{twigil} };
sub name { $_[0]->{name} };
(my  $table = { '$' => 'v_','@' => 'list_','%' => 'hash_','&' => 'code_', });
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; return(Ruby::tab($level) . (Main::bool(($self->{twigil} eq '.')) ? 'self.v_' . $self->{name} . '' : (Main::bool(($self->{name} eq '/')) ? $table->{$self->{sigil}} . 'MATCH' : $table->{$self->{sigil}} . $self->{name} . ''))) };
sub emit_ruby_name { my $self = $_[0]; return((Main::bool(($self->{twigil} eq '.')) ? 'self.v_' . $self->{name} : (Main::bool(($self->{name} eq '/')) ? $table->{$self->{sigil}} . 'MATCH' : $table->{$self->{sigil}} . $self->{name}))) };
sub name { my $self = $_[0]; $self->{name} }
}

{
package Bind;
sub new { shift; bless { @_ }, "Bind" }
sub parameters { $_[0]->{parameters} };
sub arguments { $_[0]->{arguments} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; if (Main::bool(Main::isa($self->{parameters}, 'Index'))) { return(Ruby::tab($level) . $self->{parameters}->obj()->emit_ruby() . '[' . $self->{parameters}->index_exp()->emit_ruby() . '] = ' . $self->{arguments}->emit_ruby()) } else {  }; if (Main::bool(Main::isa($self->{parameters}, 'Lookup'))) { return(Ruby::tab($level) . $self->{parameters}->obj()->emit_ruby() . '[' . $self->{parameters}->index_exp()->emit_ruby() . '] = ' . $self->{arguments}->emit_ruby()) } else {  }; if (Main::bool(Main::isa($self->{parameters}, 'Call'))) { return(Ruby::tab($level) . $self->{parameters}->invocant()->emit_ruby() . '.v_' . $self->{parameters}->method() . ' = ' . $self->{arguments}->emit_ruby() . '') } else {  }; Ruby::tab($level) . $self->{parameters}->emit_ruby() . ' = ' . $self->{arguments}->emit_ruby() }
}

{
package Proto;
sub new { shift; bless { @_ }, "Proto" }
sub name { $_[0]->{name} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; Ruby::tab($level) . '$' . Main::to_go_namespace($self->{name}) }
}

{
package Call;
sub new { shift; bless { @_ }, "Call" }
sub invocant { $_[0]->{invocant} };
sub hyper { $_[0]->{hyper} };
sub method { $_[0]->{method} };
sub arguments { $_[0]->{arguments} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; (my  $invocant = $self->{invocant}->emit_ruby()); if (Main::bool((($self->{method} eq 'perl') || (($self->{method} eq 'yaml') || (($self->{method} eq 'say') || (($self->{method} eq 'join') || ($self->{method} eq 'isa'))))))) { if (Main::bool($self->{hyper})) { return($invocant . '.map {|x| x.' . $self->{method} . '(' . Main::join([ map { $_->emit_ruby() } @{ $self->{arguments} } ], ', ') . ')}') } else { return('mp6_' . $self->{method} . '(' . Main::join([ map { $_->emit_ruby() } @{ [$self->{invocant}, @{$self->{arguments}}] } ], ', ') . ')') } } else {  }; (my  $meth = $self->{method}); if (Main::bool(($meth eq 'postcircumfix:<( )>'))) { return(Ruby::tab($level) . $invocant . '.call(' . Main::join([ map { $_->emit_ruby() } @{ $self->{arguments} } ], ', ') . ')') } else {  }; if (Main::bool((($meth eq 'values') || (($meth eq 'keys') || (($meth eq 'push') || ($meth eq 'concat')))))) { return(Ruby::tab($level) . $invocant . '.' . $meth . '(' . Main::join([ map { $_->emit_ruby() } @{ $self->{arguments} } ], ', ') . ')') } else {  }; if (Main::bool(($meth eq 'chars'))) { return(Ruby::tab($level) . 'len(' . $invocant . ')') } else {  }; (my  $call = 'f_' . $meth . '(' . Main::join([ map { $_->emit_ruby() } @{ $self->{arguments} } ], ', ') . ')'); if (Main::bool($self->{hyper})) { Ruby::tab($level) . $invocant . '.map {|x| x.' . $call . '}' } else { Ruby::tab($level) . $invocant . '.' . $call } }
}

{
package Apply;
sub new { shift; bless { @_ }, "Apply" }
sub code { $_[0]->{code} };
sub arguments { $_[0]->{arguments} };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; Ruby::tab($level) . $self->emit_ruby() };
sub emit_ruby { my $self = $_[0]; (my  $code = $self->{code}); if (Main::bool(Main::isa($code, 'Str'))) {  } else { return('(' . $self->{code}->emit_ruby() . ').(' . Main::join([ map { $_->emit_ruby() } @{ $self->{arguments} } ], ', ') . ')') }; if (Main::bool(($code eq 'self'))) { return('self') } else {  }; if (Main::bool(($code eq 'make'))) { return('v_MATCH.v_capture = ' . $self->{arguments}->[0]->emit_ruby() . '') } else {  }; if (Main::bool(($code eq 'false'))) { return('false') } else {  }; if (Main::bool(($code eq 'true'))) { return('true') } else {  }; if (Main::bool(($code eq 'say'))) { return('puts' . Ruby::to_str(' + ', $self->{arguments})) } else {  }; if (Main::bool(($code eq 'print'))) { return('print' . Ruby::to_str(' + ', $self->{arguments})) } else {  }; if (Main::bool(($code eq 'warn'))) { return('mp6_warn(' . Main::join([ map { $_->emit_ruby() } @{ $self->{arguments} } ], ', ') . ')') } else {  }; if (Main::bool(($code eq 'array'))) { return('[' . Main::join([ map { $_->emit_ruby() } @{ $self->{arguments} } ], ' ') . ']') } else {  }; if (Main::bool(($code eq 'Int'))) { return('(' . $self->{arguments}->[0]->emit_ruby() . ').to_i') } else {  }; if (Main::bool(($code eq 'Num'))) { return('(' . $self->{arguments}->[0]->emit_ruby() . ').to_f') } else {  }; if (Main::bool(($code eq 'prefix:<~>'))) { return(Ruby::to_str(' + ', $self->{arguments})) } else {  }; if (Main::bool(($code eq 'prefix:<!>'))) { return('!' . Ruby::to_bool(' && ', $self->{arguments})) } else {  }; if (Main::bool(($code eq 'prefix:<?>'))) { return('!(!' . Ruby::to_bool(' && ', $self->{arguments}) . ')') } else {  }; if (Main::bool(($code eq 'prefix:<$>'))) { return('mp6_to_scalar(' . Main::join([ map { $_->emit_ruby() } @{ $self->{arguments} } ], ' ') . ')') } else {  }; if (Main::bool(($code eq 'prefix:<@>'))) { return('(' . Main::join([ map { $_->emit_ruby() } @{ $self->{arguments} } ], ' ') . ')') } else {  }; if (Main::bool(($code eq 'prefix:<%>'))) { return('%{' . Main::join([ map { $_->emit_ruby() } @{ $self->{arguments} } ], ' ') . '}') } else {  }; if (Main::bool(($code eq 'infix:<~>'))) { return(Ruby::to_str(' + ', $self->{arguments})) } else {  }; if (Main::bool(($code eq 'infix:<+>'))) { return(Ruby::to_num(' + ', $self->{arguments})) } else {  }; if (Main::bool(($code eq 'infix:<->'))) { return(Ruby::to_num(' - ', $self->{arguments})) } else {  }; if (Main::bool(($code eq 'infix:<*>'))) { return(Ruby::to_num(' * ', $self->{arguments})) } else {  }; if (Main::bool(($code eq 'infix:</>'))) { return(Ruby::to_num(' / ', $self->{arguments})) } else {  }; if (Main::bool(($code eq 'infix:<&&>'))) { return(Ruby::to_bool(' && ', $self->{arguments})) } else {  }; if (Main::bool(($code eq 'infix:<||>'))) { return(Ruby::to_bool(' || ', $self->{arguments})) } else {  }; if (Main::bool(($code eq 'infix:<eq>'))) { return(Ruby::to_str(' == ', $self->{arguments})) } else {  }; if (Main::bool(($code eq 'infix:<ne>'))) { return(Ruby::to_str(' != ', $self->{arguments})) } else {  }; if (Main::bool(($code eq 'infix:<==>'))) { return(Ruby::to_num(' == ', $self->{arguments})) } else {  }; if (Main::bool(($code eq 'infix:<!=>'))) { return(Ruby::to_num(' != ', $self->{arguments})) } else {  }; if (Main::bool(($code eq 'infix:<<>'))) { return(Ruby::to_num(' < ', $self->{arguments})) } else {  }; if (Main::bool(($code eq 'infix:<>>'))) { return(Ruby::to_num(' > ', $self->{arguments})) } else {  }; if (Main::bool(($code eq 'exists'))) { (my  $arg = $self->{arguments}->[0]);if (Main::bool(Main::isa($arg, 'Lookup'))) { return('(' . $arg->obj()->emit_ruby() . ').has_key?(' . $arg->index_exp()->emit_ruby() . ')') } else {  } } else {  }; if (Main::bool(($code eq 'ternary:<?? !!>'))) { return('(' . Ruby::to_bool(' && ', [$self->{arguments}->[0]]) . ' ? ' . $self->{arguments}->[1]->emit_ruby() . ' : ' . $self->{arguments}->[2]->emit_ruby() . ')') } else {  }; if (Main::bool(($code eq 'substr'))) { return($self->{arguments}->[0]->emit_ruby() . '[' . $self->{arguments}->[1]->emit_ruby() . ', ' . $self->{arguments}->[2]->emit_ruby() . ']') } else {  }; if (Main::bool(($code eq 'index'))) { return('(' . $self->{arguments}->[0]->emit_ruby() . ').index(' . $self->{arguments}->[1]->emit_ruby() . ')') } else {  }; if (Main::bool(($code eq 'shift'))) { return($self->{arguments}->[0]->emit_ruby() . '.shift()') } else {  }; if (Main::bool(($code eq 'pop'))) { return($self->{arguments}->[0]->emit_ruby() . '.pop()') } else {  }; if (Main::bool(($code eq 'push'))) { return($self->{arguments}->[0]->emit_ruby() . '.push(' . $self->{arguments}->[1]->emit_ruby() . ')') } else {  }; if (Main::bool(($code eq 'unshift'))) { return($self->{arguments}->[0]->emit_ruby() . '.unshift(' . $self->{arguments}->[1]->emit_ruby() . ')') } else {  }; if (Main::bool($self->{namespace})) { return('$' . Main::to_go_namespace($self->{namespace}) . '.f_' . $self->{code} . '(' . Main::join([ map { $_->emit_ruby() } @{ $self->{arguments} } ], ', ') . ')') } else {  }; 'namespace.f_' . $self->{code} . '(' . Main::join([ map { $_->emit_ruby() } @{ $self->{arguments} } ], ', ') . ')' };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; Ruby::tab($level) . $self->emit_ruby() }
}

{
package Return;
sub new { shift; bless { @_ }, "Return" }
sub result { $_[0]->{result} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; Ruby::tab($level) . 'return ' . $self->{result}->emit_ruby() . '' }
}

{
package If;
sub new { shift; bless { @_ }, "If" }
sub cond { $_[0]->{cond} };
sub body { $_[0]->{body} };
sub otherwise { $_[0]->{otherwise} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; (my  $has_body = (Main::bool(@{$self->{body} || []}) ? 1 : 0)); (my  $has_otherwise = (Main::bool(@{$self->{otherwise} || []}) ? 1 : 0)); (my  $body_block = MiniPerl6::Ruby::LexicalBlock->new( 'block' => $self->{body}, )); (my  $otherwise_block = MiniPerl6::Ruby::LexicalBlock->new( 'block' => $self->{otherwise}, )); if (Main::bool($body_block->has_my_decl())) { ($body_block = Do->new( 'block' => $self->{body}, )) } else {  }; if (Main::bool(($has_otherwise && $otherwise_block->has_my_decl()))) { ($otherwise_block = Do->new( 'block' => $self->{otherwise}, )) } else {  }; (my  $s = Ruby::tab($level) . 'if ' . Ruby::to_bool(' && ', [$self->{cond}]) . '
' . $body_block->emit_ruby_indented(($level + 1))); if (Main::bool($has_otherwise)) { ($s = $s . '
' . Ruby::tab($level) . 'else
' . $otherwise_block->emit_ruby_indented(($level + 1)) . '
' . Ruby::tab($level) . 'end') } else { ($s = $s . '
' . Ruby::tab($level) . 'end') }; return($s) }
}

{
package While;
sub new { shift; bless { @_ }, "While" }
sub init { $_[0]->{init} };
sub cond { $_[0]->{cond} };
sub continue { $_[0]->{continue} };
sub body { $_[0]->{body} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; (my  $body_block = MiniPerl6::Ruby::LexicalBlock->new( 'block' => $self->{body}, )); if (Main::bool($body_block->has_my_decl())) { ($body_block = Do->new( 'block' => $self->{body}, )) } else {  }; if (Main::bool(($self->{init} && $self->{continue}))) { die('not implemented (While)') } else {  }; Ruby::tab($level) . 'while ' . Ruby::to_bool(' && ', [$self->{cond}]) . '
' . $body_block->emit_ruby_indented(($level + 1)) . '
' . Ruby::tab($level) . 'end' }
}

{
package For;
sub new { shift; bless { @_ }, "For" }
sub cond { $_[0]->{cond} };
sub body { $_[0]->{body} };
sub topic { $_[0]->{topic} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; (my  $body_block = MiniPerl6::Ruby::LexicalBlock->new( 'block' => $self->{body}, )); Ruby::tab($level) . 'for ' . $self->{topic}->emit_ruby_name() . ' in ' . $self->{cond}->emit_ruby() . '
' . $body_block->emit_ruby_indented(($level + 1)) . '
' . Ruby::tab($level) . 'end' }
}

{
package Decl;
sub new { shift; bless { @_ }, "Decl" }
sub decl { $_[0]->{decl} };
sub type { $_[0]->{type} };
sub var { $_[0]->{var} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; (my  $decl = $self->{decl}); (my  $name = $self->{var}->name()); Ruby::tab($level) . (Main::bool(($decl eq 'has')) ? '' : $self->{var}->emit_ruby()) };
sub emit_ruby_init { my $self = $_[0]; if (Main::bool(($self->{var}->sigil() eq '%'))) { return('{}') } else { if (Main::bool(($self->{var}->sigil() eq '@'))) { return('C_Array.new()') } else { return('nil') } }; return('') }
}

{
package Sig;
sub new { shift; bless { @_ }, "Sig" }
sub invocant { $_[0]->{invocant} };
sub positional { $_[0]->{positional} };
sub named { $_[0]->{named} };
sub emit_ruby { my $self = $_[0]; ' print \'Signature - TODO\'; die \'Signature - TODO\'; ' };
sub invocant { my $self = $_[0]; $self->{invocant} };
sub positional { my $self = $_[0]; $self->{positional} }
}

{
package Method;
sub new { shift; bless { @_ }, "Method" }
sub name { $_[0]->{name} };
sub sig { $_[0]->{sig} };
sub block { $_[0]->{block} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; (my  $sig = $self->{sig}); (my  $invocant = $sig->invocant()); (my  $pos = $sig->positional()); (my  $args = []); (my  $default_args = []); (my  $meth_args = []); for my $field ( @{$pos || []} ) { (my  $arg = $field->emit_ruby_name());push( @{$args}, $arg );push( @{$default_args}, $arg . '=nil' );push( @{$meth_args}, $arg . '=nil' ) }; (my  $block = MiniPerl6::Ruby::LexicalBlock->new( 'block' => $self->{block},'needs_return' => 1, )); my  $List_s; push( @{$List_s}, Ruby::tab($level) . 'def f_' . $self->{name} . '(' . Main::join($meth_args, ', ') . ')' ); push( @{$List_s}, Ruby::tab(($level + 1)) . $invocant->emit_ruby_name() . ' = self' ); push( @{$List_s}, $block->emit_ruby_indented(($level + 1)) ); push( @{$List_s}, Ruby::tab($level) . 'end' ); return(Main::join($List_s, '
')) }
}

{
package Sub;
sub new { shift; bless { @_ }, "Sub" }
sub name { $_[0]->{name} };
sub sig { $_[0]->{sig} };
sub block { $_[0]->{block} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; (my  $label = '_anon_' . MiniPerl6::Ruby::LexicalBlock::get_ident_ruby()); if (Main::bool(($self->{name} eq ''))) { MiniPerl6::Ruby::LexicalBlock::push_stmt_ruby(MiniPerl6::Ruby::AnonSub->new( 'name' => $label,'block' => $self->{block},'sig' => $self->{sig},'handles_return_exception' => 1, ));return(Ruby::tab($level) . 'f_' . $label) } else {  }; (my  $sig = $self->{sig}); (my  $pos = $sig->positional()); (my  $args = []); (my  $default_args = []); (my  $meth_args = ['self']); for my $field ( @{$pos || []} ) { (my  $arg = $field->emit_ruby_name());push( @{$args}, $arg );push( @{$default_args}, $arg . '=nil' );push( @{$meth_args}, $arg . '=nil' ) }; (my  $block = MiniPerl6::Ruby::LexicalBlock->new( 'block' => $self->{block},'needs_return' => 1, )); (my  $label2 = '_anon_' . MiniPerl6::Ruby::LexicalBlock::get_ident_ruby()); my  $List_s; push( @{$List_s}, Ruby::tab($level) . 'def f_' . $self->{name} . '(' . Main::join($default_args, ', ') . ')' ); push( @{$List_s}, $block->emit_ruby_indented(($level + 1)) ); push( @{$List_s}, Ruby::tab($level) . 'end' ); return(Main::join($List_s, '
')) }
}

{
package Do;
sub new { shift; bless { @_ }, "Do" }
sub block { $_[0]->{block} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; my  $List_s; push( @{$List_s}, Ruby::tab($level) . 'Proc.new{ || ' ); push( @{$List_s}, MiniPerl6::Ruby::LexicalBlock->new( 'block' => $self->{block},'needs_return' => 0, )->emit_ruby_indented(($level + 1)) ); push( @{$List_s}, Ruby::tab($level) . '}.call()' ); return(Main::join($List_s, '
')) }
}

{
package Use;
sub new { shift; bless { @_ }, "Use" }
sub mod { $_[0]->{mod} };
sub emit_ruby { my $self = $_[0]; $self->emit_ruby_indented(0) };
sub emit_ruby_indented { my $self = $_[0]; my $level = $_[1]; return('') }
}

1;
