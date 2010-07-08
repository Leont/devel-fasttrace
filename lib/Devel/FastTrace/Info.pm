package Devel::FastTrace::Info;

use strict;
use warnings FATAL => 'all';

sub shortmess {
	my ($info, $message) = @_;
	my $package = $info->[0][0];
	for my $row (@{$info}) {
		return "$message at $row->[2] line $row->[3]\n" if $row->[0] ne $package;
	}
	return $info->longmess($message);
}

sub longmess {
	my ($info, $message) = @_;
	my $start   = shift @{$info};
	my $ret     = "$message at $start->[2] line $start->[3]\n";
	for my $row (@{$info}) {
		my ($package, $sub, $file, $line) = @{$row};
		$ret .= "\t$sub() called at $file line $line\n";
	}
	return $ret;
}

1;
