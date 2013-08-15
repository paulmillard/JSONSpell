package JSONSpell::Controller::SpellCheck;
use Moose;
use namespace::autoclean;

use Text::Aspell;
use String::Trim;

BEGIN {extends 'Catalyst::Controller::REST'; }

sub check : Local : ActionClass('REST') { }

sub check_GET {
    my ( $self, $c ) = @_;  
    
    my $word = $c->req->param('word');
    
    #trim it
    if ( $word =~ /^\s/ || $word =~ /\s$/ ) {
        trim($word);
    }
    
    #we're not doing multiple words, just one
    my $entity = { correct => 0, suggestions => [] };  
    if ( $word =~ /\s/ ) {
        $entity->{errorstring} = "'$word' cannot be multiple words";
    }
    
    unless ( defined $entity->{errorstring} ) {
        #check the actual word now
        $self->checkWord($word,$entity);
    }

    $self->status_ok(
        $c,
        entity => $entity,
    );
}

sub checkWord: Local: {
    my ($self, $word, $entity) = @_;
    
    my $speller = Text::Aspell->new;
    
    unless ($speller) {
        $entity->{errorstring} = "Error with Speller - $!";
        return;
    }
    
    $speller->set_option('lang','en_US');
    $speller->set_option('sug-mode','fast');
    
    if ( $speller->check($word) ) {
        $entity->{correct} = 1;
    }
    else {
        my @suggestions = $speller->suggest($word);
        $entity->{suggestions} = \@suggestions;
    }
    
    return $entity;
}

=head1 AUTHOR

Paul Millard

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
