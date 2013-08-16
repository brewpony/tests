package Brewpony::Test;
use 5.012;
use base 'Exporter';

sub is_brewpony_link($) {
    my ($link) = @_;
    if ($link =~ m!https?://brewpony\.com!){
        return 1;
    };
    return 0;
}

our @EXPORT_OK = qw(is_brewpony_link);

length(42) - 1;
