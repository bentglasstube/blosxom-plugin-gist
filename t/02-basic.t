use Test::More tests => 4;
use gist::test;
use strict;
use warnings;

script_ok('<gist id=42>',     '42.js', 'unquoted id');
script_ok('<gist id="42">',   '42.js', 'double quoted id');
script_ok("<gist id='42'>",   '42.js', 'single quoted id');

link_ok('<gist id=42>', '42', 'noscript link');
