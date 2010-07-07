use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
	module_name         => 'Devel::FastTrace',
	license             => 'perl',
	dist_author         => q{Leon Timmermans <leont@cpan.org>},
	dist_version_from   => 'lib/Devel/FastTrace.pm',
	configure_requires  => {
		'Module::Build' => 0,
	},
	build_requires => {
		'Module::Build' => 0,
		'Test::More'    => 0,
	},
	requires            => {
		perl            => 5.006,
	},
	add_to_cleanup      => [ 'Devel-FastTrace-*' ],
	create_makefile_pl => 'small',
);

$builder->create_build_script();
