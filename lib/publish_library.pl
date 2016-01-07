use Log::Log4perl;
Log::Log4perl->init("../conf/log.conf");
my $logger = Log::Log4perl::get_logger('sml.application');

use lib "../../SML/lib";

use SML::Library;
use Time::Duration;

my $begin = time();

my $library = SML::Library->new(config_filename=>'library.conf');

$logger->info("publish library");

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

my $end = time();
my $duration = duration($end - $begin);

$logger->info("publish library $duration");

1;
