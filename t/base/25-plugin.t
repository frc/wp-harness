use Test::More tests => 1;
use JSON qw/decode_json/;

my $plugins = `wp plugin list --format=json`;
$plugins = decode_json($plugins);
my @updates = map { ( $_->{update} eq 'available' && $_->{status} eq 'active' ) ? $_->{name} : () } @$plugins;
is(join(', ', @updates), '', 'No plugins to be updated');
