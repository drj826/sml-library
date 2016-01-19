use Log::Log4perl;
Log::Log4perl->init("../conf/log.conf");
my $logger = Log::Log4perl::get_logger('sml.application');

use lib "../../SML/lib";

use SML::Library;
use Time::Duration;

my $begin = time();

my $library = SML::Library->new(config_filename=>'library.conf');

$logger->info("publish overall index page");

my $publisher = $library->get_publisher;

$publisher->publish_html_overall_index_page;

my $end = time();
my $duration = duration($end - $begin);

$logger->info("publish overall index page $duration");

1;
