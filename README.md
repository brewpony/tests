# brewpony.com tests

These tests verify that brewpony.com doesn't look borked.

# Installing dependencies

You will need Perl and Test::WWW::Mechanize, with the optional SSL-related CPAN modules also installed.

With cpanm:

    cpanm --installdeps .

With Module::Build :

    perl Build.PL && ./Build installdeps

# Running the tests

    prove -lrv *.t
