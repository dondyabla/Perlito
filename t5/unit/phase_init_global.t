use feature 'say';

say '1..1';

print 'not ' unless $main::v == 123;
say "ok 1 - INIT initialized an our-var # $main::v";

INIT {
    $main::v = 123;
}

