use Test::More tests => 1;

`wp core check-update`;
ok(
    $? == 0,
    'WordPress is at the latest version'
);
