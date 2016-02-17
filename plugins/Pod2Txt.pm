#!/usr/bin/perl

package Pod2Txt;

use Moose;

use version; our $VERSION = qv('2.0.0');

use namespace::autoclean;

use Pod::Text;

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

######################################################################
######################################################################
##
## Public Methods
##
######################################################################
######################################################################

sub render {

  my $self = shift;

  my $library = $self->_get_library;
  my $ps      = $library->get_property_store;

  unless ( $self->_has_args )
    {
      $logger->fatal("FATAL Pod2Txt.pm NO PERL FILESPEC PROVIDED");
      return [];
    }

  my $arg_list = [ split(/\s+/,$self->_get_args) ];

  my $published_dir = $library->get_published_dir;
  my $library_dir   = $library->get_directory_path;
  my $filespec      = $arg_list->[0];

  unless ( -f "$library_dir/$filespec" )
    {
      $logger->fatal("FATAL Pod2Txt.pm NO FILE $library_dir/$filespec");
      return [];
    }

  $logger->info("Pod2Txt $filespec");

  unless (-d "$published_dir" )
    {
      mkdir "$published_dir", 0755;
      $logger->debug("made directory $published_dir");
    }

  unless (-d "$published_dir/tmp" )
    {
      mkdir "$published_dir/tmp", 0755;
      $logger->debug("made directory $published_dir/tmp");
    }

  my $podparser = Pod::Text->new();

  my $tmpfile = "$published_dir/tmp/pod2txt.txt";

  my $output_line_list = [];

  open my $outfh, ">", $tmpfile or die "Can't open $tmpfile: $!\n";
  $podparser->parse_from_file("$published_dir/$filespec",$outfh);
  close $outfh;

  open my $infh, "<", $tmpfile or die "Can't open $tmpfile: $!\n";
  while (<$infh>) { push @{$output_line_list}, $_ };
  close $infh;

  unlink $tmpfile;

  return $output_line_list;
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

has args =>
  (
   is        => 'ro',
   isa       => 'Maybe[Str]',
   reader    => '_get_args',
   predicate => '_has_args',
  );

######################################################################
######################################################################
##
## Private Methods
##
######################################################################
######################################################################

# NONE

######################################################################

no Moose;
__PACKAGE__->meta->make_immutable;
1;
