package Catmandu::Fix::wdata_retain_language;
#ABSTRACT: Limit string values to a selected language
our $VERSION = '0.03'; #VERSION
use Catmandu::Sane;
use Moo;

has language => (is => 'ro', required => 1);

has force => (is => 'ro');

around BUILDARGS => sub {
    my ($orig, $class, $language) = @_;
    $orig->($class, { language => $language });
};

sub fix {
    my ($self, $data) = @_;
    my $language = $self->language;

    $data->{description} = eval { 
            $data->{descriptions}->{$language}->{value} 
        };
    $data->{label} = eval { 
            $data->{labels}->{$language}->{value} 
        };
    $data->{alias} = [ eval { 
            map { $_->{value} } @{$data->{aliases}->{$language}} 
        } ]; # TODO: how to express this as normal fix with move_field?

    # TODO: only delete of string of requested language was found (or force)
    delete $data->{$_} for qw(aliases labels descriptions);

    $data;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Catmandu::Fix::wdata_retain_language - Limit string values to a selected language

=head1 VERSION

version 0.03

=head1 DESCRIPTION

This L<Catmandu::Fix> modifies a Wikidata entity record, as imported by
L<Catmandu::Importer::Wikidata>, by deleting all language tagged strings (in
C<aliases>, C<labels>, and C<descriptions>) expect a selected language.  The
fix

    wdata_retain_language('fr');

is roughly equivalent to

    move_field('labels.fr.value','label');
    move_field('descriptions.fr.value','description');
    move_field('aliases.fr.*.value','alias.$append');

Modification of additional fields may be added in a future release of this
module.

=head1 AUTHOR

Jakob Voß

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Jakob Voß.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
