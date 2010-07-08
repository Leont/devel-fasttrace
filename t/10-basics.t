#!perl -T

package Foo;

use strict;
use warnings FATAL => 'all';
use Test::More tests => 2;

use Carp ();
use Devel::FastTrace ();
use YAML;

sub buz {
	my ($lcarp, $ldft) = (Carp::longmess("Error"), Devel::FastTrace::longmess("Error"));
	is($ldft, $lcarp, "Devel::FastTrace::longmess gives the same output as Carp::longmess");
	my ($scarp, $sdft) = (Carp::shortmess("Error"), Devel::FastTrace::shortmess("Error"));
	is($sdft, $scarp, "Devel::FastTrace::shortmess gives the same output as Carp::shortmess");
}

sub baz {
	buz();
}

package main;

sub bar {
	Foo::baz;
}
sub foo {
	bar;
}

foo;
