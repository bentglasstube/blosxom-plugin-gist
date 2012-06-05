use Test::More tests => 4;
use gist::test;
use strict;
use warnings;

my $output = process('life <gist id=42> the universe <gist id=67> and everything');

like($output, qr/^life <script/, 'beginning intact');
like($output, qr/script> the universe <script/, 'middle intact');
like($output, qr/script> and everything$/, 'end intact');

unlike($output, qr/<gist/, 'all tags processed');
