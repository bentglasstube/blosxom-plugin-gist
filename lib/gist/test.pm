package gist::test;

use strict;
use warnings;

use Exporter::Easy EXPORT => [qw'process script_ok link_ok'];
use Test::More;
use gist;

sub process {
  my ($input) = @_;

  my $output = $input;
  gist::story(undef, undef, undef, undef, undef, \$output);
  
  return $output;
}

sub script_ok {
  my ($input, $expected, $message) = @_;

  $message ||= "$input sources $expected";
  my $output = process($input);
  like($output, qr{<script src="https://gist.github.com/\Q$expected\E">}, $message) or diag $output;
} 

sub link_ok {
  my ($input, $expected, $message) = @_;

  $message ||= "$input links to $expected";
  my $output = process($input);
  like($output, qr{<a href="https://gist.github.com/\Q$expected\E">}, $message) or diag $output;
}

1;
