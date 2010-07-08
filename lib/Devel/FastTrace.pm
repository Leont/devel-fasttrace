package Devel::FastTrace;

use 5.006;
use strict;
use warnings;
our $VERSION = '0.001';

use XSLoader;
use Exporter 5.57 'import';
our @EXPORT_OK = qw/stack_info succumb all_trace/;
XSLoader::load(__PACKAGE__, $VERSION);

use Devel::FastTrace::Info;
use Devel::FastTrace::Row;

#These are just proofs of concept

sub shortmess {
	my $message = shift;
	my $info    = stack_info(1);
	return $info->shortmess($message);
}

sub longmess {
	my $message = shift;
	my $info    = stack_info(1);
	return $info->longmess($message);
}

1;    # End of Devel::FastTrace

=head1 NAME

Devel::FastTrace - The great new Devel::FastTrace!

=head1 VERSION

Version 0.001

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Devel::FastTrace;

=head1 SUBROUTINES

=head2 stack_info

=head2 succumb

=head2 all_trace

=head2 previous_error

=head1 AUTHOR

Leon Timmermans, C<< <leont at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-devel-fasttrace at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Devel-FastTrace>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Devel::FastTrace


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Devel-FastTrace>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Devel-FastTrace>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Devel-FastTrace>

=item * Search CPAN

L<http://search.cpan.org/dist/Devel-FastTrace/>

=back

=head1 ACKNOWLEDGEMENTS

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Leon Timmermans.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
