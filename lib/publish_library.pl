use Log::Log4perl;
Log::Log4perl->init("../conf/log.conf");

use lib "../../SML/lib";

use SML::Library;

my $library = SML::Library->new(config_filename=>'library.conf');

$library->get_all_entities;

$library->publish('sml-ug',  'html','default');
$library->publish('sml-brd', 'html','default');
$library->publish('sml-dfrd','html','default');
$library->publish('sml-srd', 'html','default');
$library->publish('sml-sdd', 'html','default');
$library->publish('sml-ted', 'html','default');

$library->publish_library_pages;
$library->publish_index;

$library->store_sha_digest_file;

1;
