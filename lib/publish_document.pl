use Log::Log4perl;
Log::Log4perl->init("../conf/log.conf");
my $logger = Log::Log4perl::get_logger('sml.application');

use lib "../../SML/lib";

use SML;

use Time::Duration;

my $document_id = shift;

my $begin = time();

my $library   = SML::Library->new(config_filename=>'library.conf');
my $publisher = $library->get_publisher;

$logger->info("publish document $document_id");

$publisher->publish($document_id,'html','default');

my $end = time();
my $duration = duration($end - $begin);

$logger->info("publish document $document_id $duration");

1;
