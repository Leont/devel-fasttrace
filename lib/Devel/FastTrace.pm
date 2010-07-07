package Devel::FastTrace;

use strict;
use warnings;
our $VERSION = '0.001';

use XSLoader;
use Exporter 5.57 'import';
our @EXPORT_OK = qw/stack_trace/;

XSLoader::load(__PACKAGE__, $VERSION);

1;    # End of Devel::FastTrace

=head1 NAME

Devel::FastTrace - The great new Devel::FastTrace!

=head1 VERSION

Version 0.001

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Devel::FastTrace;

    my $foo = Devel::FastTrace->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 shortmess

=head2 longmess

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
