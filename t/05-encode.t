use Test::More tests => 4;
use gist::test;
use utf8;
use strict;
use warnings;

script_ok('<gist id=42 file="dont panic">', '42.js?file=dont+panic', 'script file with spaces');
link_ok(  '<gist id=42 file="dont panic">', '42#file_dont+panic',    'link file with spaces');

script_ok('<gist id=42 file="úñí©óðé">',    '42.js?file=%C3%BA%C3%B1%C3%AD%C2%A9%C3%B3%C3%B0%C3%A9', 'script unicode');
link_ok(  '<gist id=42 file="úñí©óðé">',    '42#file_%C3%BA%C3%B1%C3%AD%C2%A9%C3%B3%C3%B0%C3%A9',    'link unicode');
