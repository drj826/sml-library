#!/usr/bin/perl

package BuildAllocationTitles;

use Moose;

use version; our $VERSION = qv('2.0.0');

use namespace::autoclean;

use Log::Log4perl qw(:easy);
with 'MooseX::Log::Log4perl';
my $logger = Log::Log4perl::get_logger('sml.plugin');

######################################################################
######################################################################
##
## Public Attributes
##
######################################################################
######################################################################

# NONE.

######################################################################
######################################################################
##
## Public Methods
##
######################################################################
######################################################################

sub render {

  # Actually, don't render anything.  This plugin does not add any SML
  # text to the document that invokes it.  All it does is builds
  # a title for each allocation in the library.

  my $self = shift;

  my $library  = $self->_get_library;
  my $ontology = $library->get_ontology;

  unless ( $ontology->allows_division_name('allocation') )
    {
      $logger->fatal("ONTOLOGY DOES NOT ALLOW allocations");
      return [];
    }

  $self->_build_allocation_titles;

  return [];                            # return an empty list
}

######################################################################
######################################################################
##
## Private Attributes
##
######################################################################
######################################################################

has library =>
  (
   is        => 'ro',
   isa       => 'SML::Library',
   reader    => '_get_library',
   required  => 1,
  );

######################################################################
######################################################################
##
## Private Methods
##
######################################################################
######################################################################

sub _build_allocation_titles {

  my $self = shift;

  my $library = $self->_get_library;
  my $parser  = $library->get_parser;
  my $ps      = $library->get_property_store;

  foreach my $id (@{ $library->get_division_id_list_by_name('allocation') })
    {
      my $ci_id = $ps->get_property_text($id,'configuration_item');
      my $rq_id = $ps->get_property_text($id,'requirement');
      my $ts_id = $ps->get_property_text($id,'test');

      my $title = "The [title:$ci_id] shall [title:$rq_id] - Verified by: [title:$ts_id]";

      $ps->add_property_value($id,'title',$title);

      $logger->info("$id $title");
    }

  return 1;
}

######################################################################

no Moose;
__PACKAGE__->meta->make_immutable;
1;
