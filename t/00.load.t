use Test::More tests => 8;

BEGIN {
use_ok( 'Versionify::Dispatch' );
}

diag( "Testing Versionify::Dispatch $Versionify::Dispatch::VERSION" );

my $default_version = 2.3;
my $dispatcher = Versionify::Dispatch->new(default_version => $default_version);

isa_ok($dispatcher, 'Versionify::Dispatch', 'Create Versionify::Dispatch object');

diag("Testing default_version adjustment");

is($dispatcher->get_default_version, $default_version, 'Get default_version (set in constructor)');

$dispatcher = Versionify::Dispatch->new();
is($dispatcher->get_default_version, undef, 'Get default_version (no version set)');

is($dispatcher->set_default_version($default_version), $default_version, 'Set default_version');
is($dispatcher->get_default_version, $default_version, 'Get default_version (set by setter method)');

$default_version = 1.4;
is($dispatcher->set_default_version($default_version), $default_version, 'Change default_version');
is($dispatcher->get_default_version, $default_version, 'Get default_version (changed by setter method)');

