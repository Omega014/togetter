#!/bin/env perl
use strict;
use warnings;
use utf8;
binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';
use LWP::UserAgent;
use HTML::TreeBuilder;
 
my $url = shift or die;

#Web�f�[�^�擾�̂��߂̂��܂��Ȃ� 
my $ua = new LWP::UserAgent;

#�v���L�V���܂���ua�ɑ�����Ă��ƁH�f�R�[�h����content�ɑ��
$ua->env_proxy;
my $res = $ua->get($url) or die;
my $content = $res->decoded_content or die;

my $tree = new HTML::TreeBuilder;
$tree->parse($content) or die;


foreach my $item_tree ($tree->look_down('class' => 'list_item')) {
	my $tweet = $item_tree->look_down('class', 'tweet')->as_text;
	my $date_usuer = $item_tree->look_down('class', 'status_right')->look_down('_tag', 'div')->as_text;
#�������Ēu������Perl�łb�r�u������java�ł�����ق����y�ȋC�����邯��Perl�y�������炢����
#���K�\���ł����Ƃ��������`����͗ǂ��񂾂낤���ǁCtogetter�^�O�̖��Ŏ��ԂƓ��t�����؂�ɏo�Ă���̂�����������
#���s����Ƃ��߂�ǂ��������ǒǋL�ł����i�v���O�����Ń��[�v������C�����j�@>>
print join("\t", $date_usuer,",",$tweet,","), "\n";
}

