use Test::More tests => 4;
use gist::test;
use strict;
use warnings;

script_ok('<gist id=42   file=towel>',   '42.js?file=towel', 'unquoted file');
script_ok('<gist id="42" file="towel">', '42.js?file=towel', 'double quoted file');
script_ok("<gist id='42' file='towel'>", '42.js?file=towel', 'single quoted file');

link_ok('<gist id=42 file=towel>', '42#file_towel', 'noscript link with hash');
