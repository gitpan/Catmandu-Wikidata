use strict;
use warnings;
package Catmandu::Wikidata;
#ABSTRACT: Import from Wikidata for processing with Catmandu
our $VERSION = '0.04'; #VERSION


1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Catmandu::Wikidata - Import from Wikidata for processing with Catmandu

=head1 VERSION

version 0.04

=head1 SYNOPSIS

    catmandu convert Wikidata --items Q42,P19 to JSON --pretty
    catmandu convert Wikidata --site enwiki --title "Emma Goldman" to JSON --pretty
    catmandu convert Wkidata --title dewiki:Metadaten to JSON --pretty

    catmandu convert Wikidata --title "Emma Goldman" \
        --fix "wd_language('en')" to JSON --pretty

=head1 DESCRIPTION

Catmandu::Wikidata provides modules to process data from L<http://www.wikidata.org/> 
within the L<Catmandu> framework.

=head1 MODULES

=over

=item L<Catmandu::Importer::Wikidata>

Import entities from L<http://www.wikidata.org/>.

=item L<Catmandu::Fix::wd_language>

Provides the fix C<wd_language($language)> to limit the values of aliases,
labels, and descriptions to a selected language. 

=item L<Catmandu::Fix::wd_simple_strings>

Simplifies labels, descriptions, and aliases of Wikidata entity record.

=item L<Catmandu::Fix::wd_simple_claims>

Simplifies claims of a Wikidata entity record.

=item L<Catmandu::Fix::wd_simple>

Applies L<Catmandu::Fix::wd_simple_strings> and
L<Catmandu::Fix::wd_simple_claims>.

=back

=head1 SEE ALSO

Background information on Catmandu can be found at <http://librecat.org/>.

Background information on Wikidata can be found at
<http://www.wikidata.org/wiki/Wikidata:Introduction>.

=head1 AUTHOR

Jakob Voß

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Jakob Voß.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
