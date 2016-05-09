use Test::More tests => 1;

`wp cli info`;
ok(
    $? == 0,
    'WP-CLI is installed'
);
