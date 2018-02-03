use Test::More tests => 4;

my $ver = `wp core version`; chomp $ver;
ok(
    $? == 0,
    'WordPress is installed and can be found by wp-cli'
);
diag "WordPress version is $ver";

`wp core check-update`;
ok(
    $? == 0,
    'WordPress is at the latest version'
);

`wp core verify-checksums`;
ok(
    $? == 0,
    'WordPress installation verifies against checksums'
);

`wp core is-installed`;
ok(
    $? == 0,
    'WordPress tables are installed'
);
