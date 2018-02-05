use Test::More tests => 1;

my $plugins = `wp plugin list`;
my @plugin;
for (split /\n/, $plugins) {
    next if /^name\tstatus/; # title line
    my ($name, $status, $updates, $version) = split /\s+/;
    push @plugin, [split /\s+/];
}

subtest 'all active plugins are up to date' => sub {
    plan skip_all => 'no plugins found' unless @plugin;
    plan tests => scalar @plugin;

    for (@plugin) {
        my ($name,$status,$update,$version) = @$_;
        SKIP: {
            skip "Plugin $name is not active", 1
                if $status ne 'active';

            ok(
                $update eq 'none',
                "Plugin $name is up to date"
            );
        }
    }
};
