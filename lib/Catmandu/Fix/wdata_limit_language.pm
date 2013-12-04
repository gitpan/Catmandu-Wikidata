package Catmandu::Fix::wdata_limit_language;
#ABSTRACT: Limit string values to a selected language
our $VERSION = '0.01'; #VERSION
use Catmandu::Sane;
use Moo;

has language => (is => 'ro', required => 1);

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

    delete $data->{$_} for qw(aliases labels descriptions);

    $data;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Catmandu::Fix::wdata_limit_language - Limit string values to a selected language

=head1 VERSION

version 0.01

=head1 DESCRIPTION

This L<Catmandu::Fix> modifies a Wikidata entity record by limiting the values of
C<aliases>, C<labels>, and C<descriptions> to a selected language. The fix

    wdata_limit_language('fr');

is roughly equivalent to

    move_field('labels.fr.value','label');
    move_field('descriptions.fr.value','description');
    move_field('aliases.fr.*.value','alias.$append');     # FIXME

=head1 AUTHOR

Jakob Voß

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Jakob Voß.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
