use Test::More tests => 2;

stat "web/app/uploads";
ok(
    -e _ && -d _ && -w _,
    'Upload directory exists and is writable'
);

my $running_on_heroku = $ENV{HOME} eq '/app' ? 1 : 0;

subtest 'heroku filesystem' => sub {
    plan skip_all => 'not running in Heroku' if not $running_on_heroku;
    plan tests => 5;

    stat "/app/web/app/uploads";
    ok(
        -e _ && -d _ && -w _,
        'Upload directory is writable'
    );

    stat "/app/web";
    ok(
        -e _ && -d _ && !-w _,
        'Document root directory is read-only'
    );

    `echo >/app/web/index.php 2>/dev/null`;
    ok(
        $? != 0,
        'Write to document root fails'
    );

    `echo >/app/web/wp/index.php 2>/dev/null`;
    ok(
        $? != 0,
        'Write to wordpress installation directory fails'
    );

    `touch /app/web/app/uploads/test-write-perm-$$`;
    ok(
        $? == 0,
        'Can create files to wordpress upload directory'
    );
}
