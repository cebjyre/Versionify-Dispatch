use Test::More tests => 3;

BEGIN {
use_ok( 'Versionify::Dispatch' );
}

diag('Setting up and using a single dispatcher');

use Readonly;

Readonly my $RETURN_VAL_1 => 'Hello world';
Readonly my $RETURN_VAL_2 => '';

sub func {
	return $RETURN_VAL_1;
}

my $func_ref = sub {
	return $RETURN_VAL_2;
};

is(func(), $RETURN_VAL_1, 'Sample subroutine works');
is($func_ref->(), $RETURN_VAL_2, 'Sample subref works');

my $dispatcher = Versionify::Dispatch->new(function => {
    1.0 => \&func,
    1.5 => $func_ref,
});