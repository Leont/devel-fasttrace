#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Devel::FastTrace' ) || print "Bail out!
";
}

diag( "Testing Devel::FastTrace $Devel::FastTrace::VERSION, Perl $], $^X" );
