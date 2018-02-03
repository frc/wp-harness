use Test::More tests => 3;

is(
    `wp eval 'echo "OK";'`, 'OK',
    'Can eval code in WordPress context'
);

is(
    `WP_ENV='$$' wp eval 'echo WP_ENV;'`, "$$",
    'WordPress define WP_ENV mirrors env WP_ENV'
);

my $running_on_heroku = $ENV{HOME} eq '/app' ? 1 : 0;

subtest 'heroku configuration' => sub {
    plan skip_all => 'not running in Heroku' if not $running_on_heroku;
    plan tests => 4;

    is(
        $ENV{FORCE_SSL_ADMIN}, 'true',
        'Env is configured to force SSL for admin sessions'
    );

    is(
        $ENV{WP_CACHE}, 'true',
        'Env is configured to enable advanced cache'
    );

    is(
        $ENV{DISABLE_WP_CRON}, 'true',
        'Env is configured to disable WP cron'
    );

    is(
        $ENV{WP_ENV}, 'production',
        'Env is configured for production'
    );
};
