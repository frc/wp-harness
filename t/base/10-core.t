use Test::More tests => 4;

`wp core version`;
ok(
    $? == 0,
    'WordPress is installed and can be found by wp-cli'
);

like(
    `wp core check-update`, qr/WordPress is at the latest version/,
    'WordPress is at the latest version'
);

like(
    `wp core verify-checksums`, qr/WordPress install verifies against checksums/,
    'WordPress install verifies against checksums'
);

`wp core is-installed`;
ok(
    $? == 0,
    'WordPress tables are installed'
);

