#!/bin/env perl
use strict;
use warnings;
use utf8;
binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';
use LWP::UserAgent;
use HTML::TreeBuilder;
 
my $url = shift or die;

#Webデータ取得のためのおまじない 
my $ua = new LWP::UserAgent;

#プロキシかましてuaに代入ってこと？デコードしてcontentに代入
$ua->env_proxy;
my $res = $ua->get($url) or die;
my $content = $res->decoded_content or die;

my $tree = new HTML::TreeBuilder;
$tree->parse($content) or die;


foreach my $item_tree ($tree->look_down('class' => 'list_item')) {
  my $tweet = $item_tree->look_down('class', 'tweet')->as_text;
  my $date_usuer = $item_tree->look_down('class', 'status_right')->look_down('_tag', 'div')->as_text;
#これやって置換してPerlでＣＳＶつくるよりjavaでやったほうが楽な気もするけどPerl楽しいからいいや
#正規表現でもっときっちり定義すれは良いんだろうけど，togetterタグの問題で時間と日付いっぺんに出てくるのが腹立たしい
#実行するときめんどくさいけど追記でおｋ（プログラムでループさせる気無し）　>>
print join("\t", $date_usuer,",",$tweet,","), "\n";
}

