use Test::More tests => 3;

is(
    `wp eval 'echo "OK";'`, 'OK',
    'Can eval code in WordPress context'
);

is(
    `WP_ENV='$$' wp eval 'echo WP_ENV;'`, "$$",
    'WordPress define WP_ENV mirrors env WP_ENV'
);

subtest 'bedrock configuration' => sub {
    plan tests => 2;

    is(
        `WP_ENV='production' wp eval 'echo defined("WP_DEBUG") && WP_DEBUG ? "YES" : "NO";'`,
        'NO',
        'WordPress in WP_ENV production has WP_DEBUG disabled'
    );

    is(
        `WP_ENV='development' wp eval 'echo defined("WP_DEBUG") && WP_DEBUG ? "YES" : "NO";'`,
        'YES',
        'WordPress in WP_ENV development has WP_DEBUG enabled'
    );
};
