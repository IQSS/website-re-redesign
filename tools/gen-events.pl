#!/usr/bin/perl
# Build content/events/<slug>.md from a crawl of live event pages.
# Usage: perl tools/gen-events.pl iqss-live-events.json OUTDIR REPORT.tsv
# The crawl JSON (Downloads/iqss-live-events.json, 2026-11-16) was made in
# Chrome on www.iq.harvard.edu; curl is refused by the site firewall.
use strict; use warnings; use utf8;
use JSON::PP; use Time::Local;
binmode STDOUT, ':utf8';

my ($in, $outdir, $report) = @ARGV;
open my $F, '<:raw', $in or die $!; local $/; my $r = decode_json(<$F>); close $F;

my %MON = map { $_ => 0 } ();
my @M = qw(January February March April May June July August September October November December);
@MON{@M} = (1..12);

# Scope: everything from the original scrape (2026-05-26) on, plus the three
# earlier May events the scrape captured as raw pages but never turned into
# event files, plus every event that already had a Hugo file.
my %EXTRA = map { $_ => 1 } qw(
  flourishing-schools-project-virtual-launch university-holiday-memorial-day-4
  dataverse-office-hours-30);
my %LEGACY = map { $_ => 1 } qw(
  geocoding-arcgis getting-started-ai-spatial-data getting-started-making-maps-qgis-and-arcgis
  getting-started-spatial-analysis-r gis-humanities-and-social-sciences
  intermediate-curation-dataverse-platform introduction-data-handling-dataverse-platform
  introduction-dataverse-apis introduction-gis introduction-metadata-dataverse-platform
  large-data-support-harvard-dataverse satellite-imagery-analysis-google-earth-engine
  visual-programming-gis-using-knime dataverse-office-hours
  better-research-vi-data-sharing-harvard-dataverse gis-institute-summer-2026
  jake-green-aprw andrea-galeotti-alesina-seminar souhardya-sengupta-applied-stats-workshop);
# Live's "sam-fuller-aprw" is a November 2024 talk; our file was the 2026 one,
# which live keeps at sam-fuller-aprw-2. Not legacy, picked up by date.

sub qs { my $s = shift; $s =~ s/\\/\\\\/g; $s =~ s/"/\\"/g; return "\"$s\""; }
sub ymd { sprintf '%04d-%02d-%02d', @_ }
sub hm {   # "02:00PM" -> "2:00 PM"
  my $t = shift; $t =~ /^0?(\d{1,2}):(\d{2})\s*([AP]M)$/i or die "time? $t";
  return "$1:$2 " . uc $3;
}

my (%occ, @rows);
for my $href (sort keys %$r) {
  my $e = $r->{$href};
  next unless ($e->{status} // '') eq '200';
  (my $slug = $href) =~ s{^/event/}{};
  my $occ = ($slug =~ s/\?occ_id=(\d+)$//) ? $1 : undef;

  my $db = $e->{dateBlock} // ''; $db =~ s/^.*?Date and Time\s*//;
  my $recur = ($db =~ s/\s*Recurring event expand_more\s*(.*)$//) ? $1 : '';
  my ($y, $m1, $d1, $m2, $d2, $time);
  if ($db =~ /^(\w+)\.? (\d+) - (\w+)\.? (\d+), (\d{4})\s*(.*)$/) { ($m1,$d1,$m2,$d2,$y,$time) = ($1,$2,$3,$4,$5,$6); }
  elsif ($db =~ /^(\w+) (\d+), (\d{4})\s*(.*)$/) { ($m1,$d1,$y,$time) = ($1,$2,$3,$4); }
  else { die "date? $href: $db" }
  my $date = ymd($y, $MON{$m1} // die("mon $m1"), $d1);
  my $end  = $m2 ? ymd($y, $MON{$m2} // die("mon $m2"), $d2) : '';
  my $etime = '';
  if ($time =~ /^All day/i) { $etime = '' }
  elsif ($time =~ /^(\d+:\d+[AP]M) - (\d+:\d+[AP]M) (E[SD]T)$/i) { $etime = hm($1) . " – " . hm($2) . " $3" }
  elsif ($time =~ /^(\d+:\d+[AP]M) (E[SD]T)$/i) { $etime = hm($1) . " $2" }
  else { die "time? $href: $time" }

  my $inscope = $date ge '2026-05-26' || $EXTRA{$slug} || $LEGACY{$slug};
  if (defined $occ) { push @{ $occ{$slug} }, { date => $date, e => $e, recur => $recur, time => $etime }; next; }
  next unless $inscope;
  push @rows, { slug => $slug, e => $e, date => $date, end => $end, time => $etime, recur => $recur };
}
# Recurring events served as ?occ_id=N become one page carrying every date.
for my $slug (sort keys %occ) {
  my @o = sort { $a->{date} cmp $b->{date} } @{ $occ{$slug} };
  next unless grep { $_->{date} ge '2026-05-26' } @o;
  push @rows, { slug => $slug, e => $o[0]{e}, date => $o[0]{date}, end => '', time => $o[0]{time},
                recur => $o[0]{recur}, occurrences => [ map { $_->{date} } @o ],
                source => "https://www.iq.harvard.edu/event/$slug" };
}

sub clean_body {
  my $h = shift // return '';
  $h =~ s/\r//g;
  # The body field sits inside two wrapper divs.
  $h =~ s{^\s*<div[^>]*field--name-field-hwp-body[^>]*>\s*<div class="tex2jax_process">}{}s;
  $h =~ s{</div>\s*</div>\s*$}{}s;
  $h =~ s{</?span[^>]*>}{}g;                         # spans carry no meaning here
  $h =~ s{\s(?:class|style|dir|data-[\w-]+)="[^"]*"}{}g;
  $h =~ s{\sid=""}{}g;
  $h =~ s{<(p|h[1-6]|li)>\s*</\1>}{}g;               # empty blocks only
  # One block per line, blank line between blocks, so Goldmark keeps them raw.
  $h =~ s{\s*(<(?:p|h[1-6]|ul|ol|div|blockquote|table)\b)}{\n\n$1}g;
  $h =~ s{(</(?:p|h[1-6]|ul|ol|div|blockquote|table)>)\s*}{$1\n\n}g;
  # Keep a list together: no blank lines inside <ul>/<ol>.
  $h =~ s{(<(ul|ol)\b.*?</\2>)}{ my $x = $1; $x =~ s/\n\s*\n/\n/g; $x }gse;
  $h =~ s/\n{3,}/\n\n/g; $h =~ s/^\s+|\s+$//g;
  return $h;
}

my $SERIES = {
  'APRW' => 'American Politics Research Workshop',
  'Applied Stats Workshop' => 'Applied Statistics Workshop',
  'Alesina Seminar' => 'Alesina Seminar',
};
my %TAX = ('event-type' => 'event-type', 'program' => 'program', 'research-technology' => 'research-technology', 'service' => 'service');

open my $R, '>:utf8', $report or die $!;
print $R join("\t", qw(slug date end time location format tags series links body_chars source)), "\n";
for my $row (sort { $a->{date} cmp $b->{date} || $a->{slug} cmp $b->{slug} } @rows) {
  my $e = $row->{e}; my $slug = $row->{slug};
  my %tax;
  for my $t (@{ $e->{tags} || [] }) {
    my ($voc) = $t->{h} =~ m{^/([^/]+)/} or die "tag $t->{h}";
    die "vocab $voc" unless $TAX{$voc};
    my $name = $t->{t};
    $name = 'China Biographical Database (CBDB)' if $name =~ /Biograhical/;   # Liz's correction
    push @{ $tax{$voc} }, $name;
  }
  my ($series) = map { $SERIES->{$_} } grep { $e->{title} =~ /\(\Q$_\E\)\s*$/ } keys %$SERIES;
  $series = undef unless $series && $e->{addlHTML};   # only where live prints the boilerplate

  my ($map, @links);
  for my $l (@{ $e->{heroLinks} || [] }) {
    if (($l->{h} // '') =~ m{google\.com/maps}) { $map = $l->{h}; next }
    (my $t = $l->{t}) =~ s/\s*arrow_circle_right\s*$//; $t =~ s/^\s+|\s+$//g;
    push @links, { label => $t, url => $l->{h} };
  }
  my @addr;
  if (my $a = $e->{address}) {
    my %p = map { /^(.*?)=(.*)$/ ? ($1, $2) : () } split /; /, $a;
    push @addr, $p{'address-line1'} if $p{'address-line1'};
    push @addr, $p{'address-line2'} if $p{'address-line2'};
    push @addr, sprintf('%s, %s %s', $p{locality} // '', $p{'administrative-area'} // '', $p{'postal-code'} // '') if $p{locality};
    push @addr, $p{country} if $p{country};
  }
  my @format;
  if (my $c = $e->{cardHTML}) {
    if ($c =~ m{event-card__metadata[^>]*>(.*?)</div>}s) { my $x = $1; push @format, ($1 =~ s/^\s+|\s+$//gr) =~ s/&amp;/&/gr while $x =~ m{<span>(.*?)</span>}gs; }
  }
  my $body = clean_body($e->{descHTML} =~ s{^\s*<div class="hwp-text-block[^>]*field--name-field-hwp-body}{<div class="x field--name-field-hwp-body}r) if $e->{descHTML};
  $body //= '';
  # Additional content that is not a series boilerplate (one event: the
  # Human Flourishing Program block) is kept with the event itself.
  my ($about_h, $about_t, @about_l);
  if ($e->{addlHTML} && !$series) {
    my $a = $e->{addlHTML};
    ($about_h) = $a =~ m{<h3[^>]*>\s*(.*?)\s*</h3>}s;
    ($about_t) = $a =~ m{(<p>.*</p>)}s;
    for my $l (@{ $e->{addlLinks} || [] }) { (my $t = $l->{t}) =~ s/\s*chevron_right\s*$//; push @about_l, { label => $t, url => $l->{h} } }
  }

  # A weekly rule on live ("Weekly on Wednesday, starting from March 26, 2025,
  # until September 17, 2025") is expanded into its dates so the calendar can
  # show each one. The rule text itself is kept verbatim for the page.
  if (!$row->{occurrences} && $row->{recur} =~ /^Weekly on \w+, starting from (\w+) (\d+), (\d{4}), until (\w+) (\d+), (\d{4})/) {
    my $t = timegm(0,0,12,$2,$MON{$1}-1,$3); my $u = timegm(0,0,12,$5,$MON{$4}-1,$6); my @o;
    for (; $t <= $u; $t += 7*86400) { my @g = gmtime $t; push @o, ymd($g[5]+1900, $g[4]+1, $g[3]) }
    die "rule start" unless $o[0] eq $row->{date};
    $row->{occurrences} = \@o;
  }
  my $src = $row->{source} // "https://www.iq.harvard.edu/event/$slug";
  my @fm = ('---', 'title: ' . qs($e->{title}), 'date: 2026-11-16', 'draft: false', 'type: "page"', 'layout: "event"',
            'source_url: ' . qs($src), 'event_date: ' . $row->{date});
  push @fm, 'event_end_date: ' . $row->{end} if $row->{end};
  push @fm, 'event_time: ' . qs($row->{time}) if $row->{time};
  if ($row->{occurrences}) { push @fm, 'event_occurrences: [' . join(', ', @{ $row->{occurrences} }) . ']' }
  push @fm, 'event_recurrence: ' . qs($row->{recur}) if $row->{recur};
  push @fm, 'event_location: ' . qs($e->{locationTitle}) if $e->{locationTitle};
  if (@addr) { push @fm, 'event_address:'; push @fm, map { '  - ' . qs($_) } @addr }
  push @fm, 'event_map_url: ' . qs($map) if $map;
  push @fm, 'event_location_details: ' . qs($e->{locationDetails}) if $e->{locationDetails};
  push @fm, 'event_format: [' . join(', ', map { qs($_) } @format) . ']' if @format;
  if (@links) { push @fm, 'event_links:'; push @fm, map { ('  - label: ' . qs($_->{label}), '    url: ' . qs($_->{url})) } @links }
  push @fm, 'series: [' . qs($series) . ']' if $series;
  for my $v (qw(event-type program research-technology service)) {
    push @fm, "$v: [" . join(', ', map { qs($_) } @{ $tax{$v} }) . ']' if $tax{$v};
  }
  if ($about_t) {
    push @fm, 'event_about:';
    push @fm, '  heading: ' . qs($about_h) if $about_h;
    push @fm, '  text: ' . qs($about_t);
    if (@about_l) { push @fm, '  links:'; push @fm, map { ('    - label: ' . qs($_->{label}), '      url: ' . qs($_->{url})) } @about_l }
  }
  push @fm, '---';
  my $file = "$outdir/$slug.md";
  open my $O, '>:raw:encoding(UTF-8)', $file or die "$file: $!";
  my $text = join("\n", @fm) . "\n" . ($body ne '' ? "$body\n" : '');
  $text =~ s/\n/\r\n/g;     # repo files use CRLF
  print $O $text; close $O;
  print $R join("\t", $slug, $row->{date}, $row->{end}, $row->{time}, $e->{locationTitle} // '', join('/', @format),
     join('; ', map { my $v = $_; map { "$v:$_" } @{ $tax{$v} } } sort keys %tax), $series // '',
     join('; ', map { $_->{label} } @links), length($body), $src), "\n";
}
close $R;
printf "%d event files written\n", scalar @rows;
