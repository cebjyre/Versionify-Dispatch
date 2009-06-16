use Test::More tests => 8;

BEGIN {
use_ok( 'Versionify::Dispatch' );
}

diag('Setting up and using a single dispatcher');

use Readonly;

Readonly my $RETURN_VAL_1 => 'Hello world';
Readonly my $RETURN_VAL_2 => 'hi';

sub func {
	return $RETURN_VAL_1;
}

my $func_ref = sub {
	return $RETURN_VAL_2;
};

is(func(), $RETURN_VAL_1, 'Sample subroutine works');
is($func_ref->(), $RETURN_VAL_2, 'Sample subref works');

my $dispatcher = Versionify::Dispatch->new(function => {
    1.11 => \&func,
    1.5 => $func_ref,
});

is($dispatcher->get_function()->(), $RETURN_VAL_1, 'Dispatcher returns the highest version function by default');
$dispatcher->set_default_version(1.5);
is($dispatcher->get_function()->(), $RETURN_VAL_2, 'Dispatcher uses the default version (if set) when no version is provided');
is($dispatcher->get_function(1.11)->(), $RETURN_VAL_1, 'Dispatcher ignores the default version when a version number is provided');
is($dispatcher->get_function(1.6)->(), $RETURN_VAL_2, 'Dispatcher returns the highest version function less than the provided one if not an exact match');

$dispatcher->set_function({1.1 => \&func});
is($dispatcher->get_function(1.6)->(), $RETURN_VAL_1, 'set_function has completely replaced the previously stored lookups');

