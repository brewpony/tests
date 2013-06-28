# brewpony.com tests

These tests verify that brewpony.com doesn't have broken links, broken images and non-standards-compliant HTML/CSS.
It could do more in the future, but that is what it does now.


[![Build Status](https://secure.travis-ci.org/brewpony/tests.png)](http://travis-ci.org/brewpony/tests)

# Installing dependencies

You will need Perl and Test::WWW::Mechanize, with the optional SSL-related CPAN modules also installed.

With cpanm:

    cpanm --installdeps .

With Module::Build :

    perl Build.PL && ./Build installdeps

# Running the tests

You can use prove:

    prove -lrv t/

or Module::Build

    ./Build test

which has less verbose output by default.
