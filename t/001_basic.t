#!/usr/bin/env perl
use strict;
use warnings;
use Test::Most;
use Test::WWW::Mechanize;
use Data::Dumper;

my $base = $ENV{BREWPONY_TEST_URL} || 'http://brewpony.com';
my $mech = Test::WWW::Mechanize->new;

my @urls = qw{/ /faq /contact /featured-roasters /coming-soon /get-started /how-it-works /how-many-bags /gift};

my %checked = ();

# Basic tests that verify the above URLs all exist and have non-broken links
for my $url (@urls) {
    $mech->get_ok("$base$url");

    my @links = map { $_->url } $mech->followable_links;
    my @brewpony_links = grep { m!https?://brewpony\.com! } @links;

    diag("Checking all brewpony.com links on $url");
    for my $link (@brewpony_links) {

        next if $checked{$link};

        if ($link ~~ m/^http/) {
            $mech->get_ok($link);
            $checked{$link} = 1;
        } else {
            # relative link
            $mech->get_ok("$base$link");
            $checked{"$base$link"} = 1;
        }
    }
    my @non_brewpony_links = grep { $_ !~ m{^(https?://brewpony\.com|\.\..+|/.+)} } @links;
    warn Dumper [ 'non BP links', @non_brewpony_links ];
}

done_testing;
