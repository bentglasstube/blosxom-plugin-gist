#!/usr/bin/perl

# gist -- blosxom plugin to include gists
# 
# Author: Alan Berndt <alan@eatabrick.org>
# See LICENSE for license details.

package gist;

use strict;
use warnings;

our $VERSION = 1.0;

# --- configuration ---

our $TAG_NAME = 'gist';      # what is the tag name that should be replaced
our $INCLUDE_NOSCRIPT = 1;   # include <noscript> tags

# ---------------------

use URI::Encode 'uri_encode';

my $qr_tag       = qr{<$TAG_NAME ([^>]+)/?>};
my $qr_attr_id   = qr{id=(?:'([^']+)'|"([^"]+)"|(\S+))};
my $qr_attr_file = qr{file=(?:'([^']+)'|"([^"]+)"|(\S+))};

sub start { 1; }
sub story {
  my ($pkg, $path, $filename, $story_ref, $title_ref, $body_ref) = @_;

  my $body = $$body_ref;

  while ($body =~ $qr_tag) {
    my $before = substr($body, 0, $-[0]);
    my $after  = substr($body, $+[0]);
    my $attrs  = $1;

    my $id   = (grep $_, $attrs =~ $qr_attr_id)[0];
    my $file = (grep $_, $attrs =~ $qr_attr_file)[0];
    my $file_encode;

    if ($file) {
      ($file_encode = uri_encode($file)) =~ s/%20/+/g;
    }

    my $gist = qq{<script src="https://gist.github.com/$id.js};
    if ($file) {
      $gist .= qq{?file=$file_encode};
    }
    $gist .= qq{"></script>};

    if ($INCLUDE_NOSCRIPT) {
      $gist .= qq{<noscript><p><a href="https://gist.github.com/$id};
      if ($file) {
        (my $file_hash = $file_encode) =~ y/-/_/;
        $gist .= qq{#file_$file_hash">$file};
      } else {
        $gist .= qq{">View on github:gist};
      }
      
      $gist .= qq{</a></p></noscript>};
    }

    $body = $before . $gist . $after;
  }

  $$body_ref = $body;
}

1;
