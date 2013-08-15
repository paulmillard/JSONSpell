package JSONSpell::View::Web;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
);

=head1 NAME

JSONSpell::View::Web - TT View for JSONSpell

=head1 DESCRIPTION

TT View for JSONSpell.

=head1 SEE ALSO

L<JSONSpell>

=head1 AUTHOR

Paul Millard

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
