use Log::Log4perl;
Log::Log4perl->init("../conf/log.conf");
my $logger = Log::Log4perl::get_logger('sml.application');

use lib "../../SML/lib";

use SML;

use Time::Duration;

my $begin = time();

my $renditiion = 'html';
my $style      = 'default';

my $library = SML::Library->new(config_filename=>'library.conf');

$logger->info("publish library");

$library->get_all_entities;
$library->get_all_documents;
$library->store_sha_digest_file;

my $publisher = $library->get_publisher;

$publisher->publish_all_documents($rendition,$style);
$publisher->publish_html_library_special_pages($style);
$publisher->publish_html_library_index_page($style);
$publisher->publish_html_overall_index_page($style);

my $end = time();
my $duration = duration($end - $begin);

$logger->info("publish library $duration");

1;
