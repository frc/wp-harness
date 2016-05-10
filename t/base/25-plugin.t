use Test::More tests => 1;
use JSON qw/decode_json/;

my $plugins = `wp plugin list --format=json`;
$plugins = decode_json($plugins);

subtest 'all plugins are up to date' => sub {
    plan skip_all => 'no plugins found' unless @$plugins;
    plan tests => scalar @$plugins;

    foreach (@$plugins) {
        ok(
            $_->{update} eq 'none',
            'Plugin ' . $_->{name} . ' is up to date'
        );
    }
};
