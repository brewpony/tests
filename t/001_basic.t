#!/usr/bin/env perl
use strict;
use warnings;
use Test::Most;
use Test::WWW::Mechanize;
use Data::Dumper;

my $base = $ENV{BREWPONY_TEST_URL} || 'http://brewpony.com';
my $mech = Test::WWW::Mechanize->new;

my @urls = qw{/ /pricing /checkout /faq /contact /how-it-works /gift };

my %checked = ();

sub is_brewpony_link($) {
    my ($link) = @_;
    if ($link =~ m!https?://brewpony\.com!){
        return 1;
    };
    return 0;
}

# Basic tests that verify the above URLs all exist and have non-broken links
for my $url (@urls) {
    $mech->get_ok("$base$url");

    my @links = map { $_->url } $mech->followable_links;
    my @brewpony_links = grep { is_brewpony_link($_) } grep { $_ !~ m!/r/! } @links;

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
        my @images = $mech->find_all_images();

        for my $image ( map { $_->url } @images ) {
            next if $checked{$image};

            # make sure each image actually exists!
            $mech->get_ok($image);
        }
    }
    my @non_brewpony_links = grep { $_ !~ m!^https?://brewpony\.com! } @links;

    my $staging_regex = qr{^https:?://staging\.brewpony};
    my $test_regex    = qr{^https:?://test.*\.brewpony};

    warn Dumper [ 'non BP links', @non_brewpony_links ];
}

done_testing;
