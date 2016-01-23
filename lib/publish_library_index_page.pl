use Log::Log4perl;
Log::Log4perl->init("../conf/log.conf");
my $logger = Log::Log4perl::get_logger('sml.application');

use lib "../../SML/lib";

use SML;

use Time::Duration;

my $begin = time();

my $library = SML::Library->new(config_filename=>'library.conf');

$logger->info("publish library index page");

my $publisher = $library->get_publisher;

$publisher->publish_html_library_index_page;

my $end = time();
my $duration = duration($end - $begin);

$logger->info("publish library index page $duration");

1;
