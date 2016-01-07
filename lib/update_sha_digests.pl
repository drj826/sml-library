use Log::Log4perl;
Log::Log4perl->init("../conf/log.conf");

use lib "../../SML/lib";

use SML::Library;

my $library = SML::Library->new(config_filename=>'library.conf');

$library->store_sha_digest_file;

1;
