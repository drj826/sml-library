use Log::Log4perl;
Log::Log4perl->init("../conf/log.conf");
my $logger = Log::Log4perl::get_logger('sml.application');

use lib "../../SML/lib";

use SML::Library;
use Time::Duration;

my $begin = time();

my $library = SML::Library->new(config_filename=>'library.conf');

$logger->info("store SHA digest file");

$library->store_sha_digest_file;

my $end = time();
my $duration = duration($end - $begin);

$logger->info("store SHA digest file $duration");

1;
