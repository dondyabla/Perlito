Perlito6 TODO list
======================

CPAN distribution
-----------------

- split into 2: v6, Perlito6

- create Markdown files for github documentation;
- example: http://www.unexpected-vortices.com/sw/rippledoc/quick-markdown-example.html
- in CPAN, convert all the documentation to POD using one of these:

    $ perl -e ' use Markdown::To::POD "markdown_to_pod"; my @text = <>; my $pod = markdown_to_pod(join "", @text); print $pod; ' README

    $ perl -e ' use Markdown::Pod;my $m2p = Markdown::Pod->new; my @text = <>; my $pod = $m2p->markdown_to_pod(markdown => join "", @text); print $pod; ' README


Perlito6
--------------

- move all internal packages inside Perlito6 namespace


Eval.pm module
--------------

- add exceptions

- complete ast nodes implementation


Command line compiler (src6/util/perlito6.pl)
--------------

- build Ast cache using JSON (we currently use Perl5 Data::Dumper) or XML (Go has XML and JSON input)

- option to build binaries (Lisp, Java, Go) or modules (Perl, Lisp, Javascript)

- add "make" capabilities (test file dates, etc)

- does it need a config file? (lib location, make details)

- add '-B' option (execute)


Perlito6 in Javascript
--------------

- reuse the good parts of Perlito5 data model

- add node.js features
-- properly implement die(); this should avoid some infinite-loops when we keep compiling after an error is found


Perlito6 in Rakudo/Niecza/Pugs
--------------

- any Perl6 should be able to execute Perlito6 directly. What do we need to fix?

-- rakudo:

    =begin must be followed by an identifier; (did you mean "=begin pod"?)
    at src6/lib/Perlito6/Emitter/Token.pm:331

-- rakudo: use "augment" to add new methods to classes

    [13:20] <jnthn> r: use MONKEY_TYPING; class Foo { ... }; augment class Foo { }


Perlito6 in Lisp
--------------

- test other Lisp implementations


Perlito6 in Go
--------------

- document which release of Go to use


Perlito6 in Perl5
--------------

(no issues at the moment)


Perlito6 in Parrot
--------------

- finish OO, class variables

- fix die() parameter handling


Perlito6 in Python
--------------

- module loading uses mangled filenames (with underlines); it should use dot-separated names instead.


Perlito6 in Ruby
--------------

- module loading uses mangled filenames (with underlines); it should use dot-separated names instead.


Missing Backends
--------------

- Haskell

- Clojure


Missing Features
--------------

- detailed syntax errors

- type annotations - FIXED

- 'use v5' is not supported
  (maybe not needed for Perlito)

- no 'state', 'constant', 'local'

- debugger

- chain operators - supported by the grammar, but no AST representation

- "loop(;;)"

- "when"


Missing Features of the Token sub-compiler
--------------

- no quantifiers - FIXED

- no variable interpolation

- use the new precedence parser


Nice to Have
--------------

- 'perlito-format' script (see gofmt and perltidy)


Tests
--------------

- run some tests from the standard test suite

- use Test.pm - FIXED


Grammar
--------------

- item-assignment precedence is different from list-assignment

- captures like: / <a> <a>* / - the first capture must share storage with the second capture

- modify the grammar to return multi-line strings as multiple strings
  (this makes it easier to write a beautifier script)

- parse Namespaces as array of string (we are going to split them anyway)

- double quote variable interpolation - FIXED (without method calls)

- and expression interpolation 

- the grammar should be aware of function arity


Semantics
--------------

- @a.values and %a.keys return Array
  These should return a List 

- Not implemented: %a = (list) 
