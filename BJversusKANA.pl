#!/usr/bin/perl

#========================================================
# 20170521 version 0.1
# Windowsのメモ帳で記述できる環境依存のスーツ記号は動作不良の元なので諦めた
# Aは本来のブラックジャックでは1か11が選べるが未実装
# ジョーカー無し
# 今井加奈ちゃんの思考：片方のカードが8以上ならそれ以外のカードを交換するのみ
# はじめから　を選んだ時にいろいろバグあり
#========================================================

use Tk;
use utf8;
use Encode;
#use Jcode;
#my $enc_os = 'cp932';
my $enc_os = 'utf8';
binmode STDIN, ":encoding($enc_os)";
binmode STDOUT, ":encoding($enc_os)";
binmode STDERR, ":encoding($enc_os)";


#========================================================
#カード情報初期設定
#========================================================
my @suit=('h','s','c','d');
my @number=('01','02','03','04','05','06','07','08','09','10','11','12','13');
#my @number=(1,2,3,4,5,6,7,8,9,10,11,12,13);
my $suitselect=0;
my $numberselect=0;
my $usedcard="捨て札";#Heart1-Heart12-Clover3のように書き込まれていき既に使われたか確認
my $discard="Start";#捨てたカードのみ表示
my $discount=1;#捨てられた枚数
my $firstcard="";
my $secondcard="";
my $newcard="";
my $firstgazo="";
my $secondgazo="";
my $newgazo="";
my $duplicate="YES";
my $cardcount=

#1枚目設定
 $suitselect=rand(3);
 $numberselect=rand(12);
 $checkcard="@suit[$suitselect]"."@number[$numberselect]";
 $firstcard="$checkcard";
 $usedcard="$firstcard";

#2枚目設定
while ($duplicate eq "YES"){
 $suitselect=rand(3);
 $numberselect=rand(12);
 $checkcard="@suit[$suitselect]"."@number[$numberselect]";
 if ($checkcard =~/$usedcard/){
  $duplicate="YES";
 }else{
  $duplicate="NO";
 }
}
$secondcard=$checkcard;
$usedcard="$usedcard"."\-"."$secondcard";
$duplicate="YES";

#3枚目設定
while ($duplicate eq "YES"){
 $suitselect=rand(3);
 $numberselect=rand(12);
 $checkcard="@suit[$suitselect]"."@number[$numberselect]";
 if ($checkcard =~/$usedcard/){
  $duplicate="YES";
 }else{
  $duplicate="NO";
 }
}
$newcard=$checkcard;
$usedcard="$usedcard"."\-"."$secondcard";
$duplicate="YES";


#========================================================
#CPUカード初期設定
#========================================================
my $kana_firstcard="";
my $kana_secondcard="";
my $kana_newcard="";

#1枚目設定
while ($duplicate eq "YES"){
 $suitselect=rand(3);
 $numberselect=rand(12);
 $checkcard="@suit[$suitselect]"."@number[$numberselect]";
 if ($checkcard =~/$usedcard/){
  $duplicate="YES";
 }else{
  $duplicate="NO";
 }
}
$kana_firstcard=$checkcard;
$usedcard="$usedcard"."\-"."$kana_firstcard";
$duplicate="YES";

#2枚目設定
while ($duplicate eq "YES"){
 $suitselect=rand(3);
 $numberselect=rand(12);
 $checkcard="@suit[$suitselect]"."@number[$numberselect]";
 if ($checkcard =~/$usedcard/){
  $duplicate="YES";
 }else{
  $duplicate="NO";
 }
}
$kana_secondcard=$checkcard;
$usedcard="$usedcard"."\-"."$kana_secondcard";
$duplicate="YES";

#1枚目設定
while ($duplicate eq "YES"){
 $suitselect=rand(3);
 $numberselect=rand(12);
 $checkcard="@suit[$suitselect]"."@number[$numberselect]";
 if ($checkcard =~/$usedcard/){
  $duplicate="YES";
 }else{
  $duplicate="NO";
 }
}
$kana_newcard=$checkcard;
$usedcard="$usedcard"."\-"."$kana_newcard";
$duplicate="YES";


#========================================================
#メインルーチン(動的に変数などが変わる範囲)
#========================================================
 # トップウィンドウを作る
 $top = MainWindow->new();
 $top->minsize( 400, 400 );
 $top->maxsize( 400, 400 );

 # メニューバーを作る
 $menu = $top->Menu(-type => "menubar");
 $top->configure(-menu => $menu, -width => 400, -height => 100);
 # [File]メニューを作る
 $menu1 = $menu->cascade(-label => 'めにゅー', -under => 0, -tearoff => 0);
 $menu1->command(-label => 'はじめから', -under => 0, -command => \&goinit );
 $menu1->command(-label => 'へるぷ', -under => 0, -command => \&help);
 $menu1->separator;
 $menu1->command(-label => 'おわりっ！', -under => 0, -command => \&exit);

 #画像表示
 $image = $top->Photo( -file => 'gif/image.gif' );
 $top->Label ( -image => $image )->place(-height => 100,-width => 128, -x => 0, -y=> 0);

 # 上部に表示する文字
 $top->optionAdd( '*font' => 'ＭＳゴシック 10' );
 $buffer = "「プロデューサーさん！\nカードを交換しますか？」";#これは初期値
 $top->Label( -textvariable => \$buffer )->pack();

 # テスト用CPU表示
# $top->optionAdd( '*font' => 'ＭＳゴシック 10' );#★テスト用
# $bufferk = "$kana_firstcard$kana_secondcard$kana_newcard";#★テスト用
# $top->Label( -textvariable => \$bufferk )->pack();#★テスト用

 $buffer1 = "手札一枚目";#これは初期値
 $top->Label( -textvariable => \$buffer1 )->place(-height => 100,-width => 100, -x => 0, -y=> 125);
 $top->Label( -textvariable => \$firstcard )->place(-height => 100,-width => 100, -x => 0, -y=> 200);
# $firstgazo = $top->Photo( -file => $firstpath );
 $firstgazo = $top->Photo( -file => "gif\/$firstcard\.gif" );
 $top->Label ( -image => $firstgazo )->place(-height => 150,-width => 100, -x => 0, -y=> 200);

 $buffer2 = "手札二枚目";#これは初期値
 $top->Label( -textvariable => \$buffer2 )->place(-height => 100,-width => 100, -x => 100, -y=> 125);
 $top->Label( -textvariable => \$secondcard )->place(-height => 100,-width => 100, -x => 100, -y=> 200);
 $secondgazo = $top->Photo( -file => "gif\/$secondcard\.gif" );
 $top->Label ( -image => $secondgazo )->place(-height => 150,-width => 100, -x => 100, -y=> 200);

 $buffer3 = "交換カード";#これは初期値
 $top->Label( -textvariable => \$buffer3 )->place(-height => 100,-width => 100, -x => 200, -y=> 125);
 $top->Label( -textvariable => \$newcard )->place(-height => 100,-width => 100, -x => 200, -y=> 200);
 $newgazo = $top->Photo( -file => "gif\/$newcard\.gif" );
 $top->Label ( -image => $newgazo )->place(-height => 150,-width => 100, -x => 200, -y=> 200);

 $buffer4 = "使用済カード";#これは初期値
 $top->Label( -textvariable => \$buffer4 )->place(-height => 100,-width => 100, -x => 300, -y=> 125);
 $top->Label( -textvariable => \$discard )->place(-height => 100,-width => 100, -x => 300, -y=> 200);


 $versionbutton1 = $top->Button( -text => '一枚目を交換する', -command => \&firstchange ); 
 $versionbutton1->place(-height => 50,-width => 100, -x => 0, -y=> 350);

 $versionbutton2 = $top->Button( -text => '二枚目を交換する', -command => \&secondchange ); 
 $versionbutton2->place(-height => 50,-width => 100, -x => 100, -y=> 350);

 $versionbutton3 = $top->Button( -text => '交換しない', -command => \&nochange ); 
 $versionbutton3->place(-height => 50,-width => 100, -x => 200, -y=> 350);

 $versionbutton4 = $top->Button( -text => "一枚目と二枚目で\n勝負！", -command => \&result ); 
 $versionbutton4->place(-height => 50,-width => 100, -x => 300, -y=> 350);

 # Exitボタン
# $button = $top->Button( -text => 'やっぱりやめる', -command => \&exit ); 
# $button->pack();

 # ウィンドウを表示する
 MainLoop();


#========================================================
# 初期化ルーチン
#========================================================
sub goinit {

$usedcard="";
$discard="Start";
$firstcard="";
$secondcard="";
$newcard="";

#1枚目設定
 $suitselect=rand(3);
 $numberselect=rand(12);
 $checkcard="@suit[$suitselect]"."@number[$numberselect]";
 $firstcard="$checkcard";
 $usedcard="$firstcard";

#2枚目設定
while ($duplicate eq "YES"){
 $suitselect=rand(3);
 $numberselect=rand(12);
 $checkcard="@suit[$suitselect]"."@number[$numberselect]";
 if ($checkcard =~/$usedcard/){
  $duplicate="YES";
 }else{
  $duplicate="NO";
 }
}
$secondcard=$checkcard;
$usedcard="$usedcard"."\-"."$secondcard";
$duplicate="YES";

#3枚目設定
while ($duplicate eq "YES"){
 $suitselect=rand(3);
 $numberselect=rand(12);
 $checkcard="@suit[$suitselect]"."@number[$numberselect]";
 if ($checkcard =~/$usedcard/){
  $duplicate="YES";
 }else{
  $duplicate="NO";
 }
}
$newcard=$checkcard;
$usedcard="$usedcard"."\-"."$secondcard"."\n";
$duplicate="YES";

#CPU1枚目設定
while ($duplicate eq "YES"){
 $suitselect=rand(3);
 $numberselect=rand(12);
 $checkcard="@suit[$suitselect]"."@number[$numberselect]";
 if ($checkcard =~/$usedcard/){
  $duplicate="YES";
 }else{
  $duplicate="NO";
 }
}
$kana_firstcard=$checkcard;
$usedcard="$usedcard"."\-"."$kana_firstcard";
$duplicate="YES";

#CPU2枚目設定
while ($duplicate eq "YES"){
 $suitselect=rand(3);
 $numberselect=rand(12);
 $checkcard="@suit[$suitselect]"."@number[$numberselect]";
 if ($checkcard =~/$usedcard/){
  $duplicate="YES";
 }else{
  $duplicate="NO";
 }
}
$kana_secondcard=$checkcard;
$usedcard="$usedcard"."\-"."$kana_secondcard";
$duplicate="YES";

#CPU3枚目設定
while ($duplicate eq "YES"){
 $suitselect=rand(3);
 $numberselect=rand(12);
 $checkcard="@suit[$suitselect]"."@number[$numberselect]";
 if ($checkcard =~/$usedcard/){
  $duplicate="YES";
 }else{
  $duplicate="NO";
 }
}
$kana_newcard=$checkcard;
$usedcard="$usedcard"."\-"."$kana_newcard";
$duplicate="YES";

$buffer = "「プロデューサーさん！\nカードを交換しますか？」";#これは初期値
$bufferk = "$kana_firstcard$kana_secondcard$kana_newcard";
$buffer1 = "手札一枚目";#これは初期値
 $top->Label( -textvariable => \$buffer1 )->place(-height => 100,-width => 100, -x => 0, -y=> 125);
 $top->Label( -textvariable => \$firstcard )->place(-height => 100,-width => 100, -x => 0, -y=> 200);
 $firstgazo = $top->Photo( -file => "gif\/$firstcard\.gif" );
 $top->Label ( -image => $firstgazo )->place(-height => 150,-width => 100, -x => 0, -y=> 200);
$buffer2 = "手札二枚目";#これは初期値
 $top->Label( -textvariable => \$buffer2 )->place(-height => 100,-width => 100, -x => 100, -y=> 125);
 $top->Label( -textvariable => \$secondcard )->place(-height => 100,-width => 100, -x => 100, -y=> 200);
 $secondgazo = $top->Photo( -file => "gif\/$secondcard\.gif" );
 $top->Label ( -image => $secondgazo )->place(-height => 150,-width => 100, -x => 100, -y=> 200);
$buffer3 = "交換カード";#これは初期値
 $top->Label( -textvariable => \$buffer3 )->place(-height => 100,-width => 100, -x => 200, -y=> 125);
 $top->Label( -textvariable => \$newcard )->place(-height => 100,-width => 100, -x => 200, -y=> 200);
 $newgazo = $top->Photo( -file => "gif\/$newcard\.gif" );
 $top->Label ( -image => $newgazo )->place(-height => 150,-width => 100, -x => 200, -y=> 200);
$buffer4 = "使用済カード";#これは初期値
 $top->Label( -textvariable => \$buffer4 )->place(-height => 100,-width => 100, -x => 300, -y=> 125);
 $top->Label( -textvariable => \$discard )->place(-height => 100,-width => 100, -x => 300, -y=> 200);
$versionbutton1 = $top->Button( -text => '一枚目を交換する', -command => \&firstchange ); 
$versionbutton1->place(-height => 50,-width => 100, -x => 0, -y=> 350);
$versionbutton2 = $top->Button( -text => '二枚目を交換する', -command => \&secondchange ); 
$versionbutton2->place(-height => 50,-width => 100, -x => 100, -y=> 350);
$versionbutton3 = $top->Button( -text => '交換しない', -command => \&nochange ); 
$versionbutton3->place(-height => 50,-width => 100, -x => 200, -y=> 350);
$versionbutton4 = $top->Button( -text => "一枚目と二枚目で\n勝負！", -command => \&result ); 
$versionbutton4->place(-height => 50,-width => 100, -x => 300, -y=> 350);
$image = $top->Photo( -file => 'gif/image.gif' );
$top->Label ( -image => $image )->place(-height => 100,-width => 128, -x => 0, -y=> 0);
}


#========================================================
# へるぷ
#========================================================
sub help {
    # メッセージボックスを表示
    $top->messageBox(
        -type => "ok",
        -icon => "info",
        -title => "へるぷ",
        -message => "今井加奈ちゃんとブラックジャックを楽しみましょう！\n１（A）から１３（K）までの2枚の手札の合計点が21に近ければ勝利です。\n
手札を山札と交換して相手より先に21に近い数にして上がりましょう\n使用済カードの欄には捨てたカードの情報が記録されています。\n例）h:ハート、c:クローバー、d:ダイヤ、s:スペード\n
　2017/05/21 Version0.1　Producted by Meteor (twitter:\@cometwave)"
    );
}


#========================================================
# 一枚目と交換ボタンが押されたときに呼ばれる
#========================================================
sub firstchange {
 $discard="$discard"."\-"."$firstcard";
 $discount++;
 if ($discount%3==0){
  $discard="$discard"."\n";
 }
 $firstcard=$newcard;
 while ($duplicate eq "YES"){
  $suitselect=rand(3);
  $numberselect=rand(12);
  $checkcard="@suit[$suitselect]"."@number[$numberselect]";
  if ($checkcard =~/$usedcard/){
   $duplicate="YES";
  }else{
   $duplicate="NO";
  }
 }
 $newcard=$checkcard;
 $usedcard="$usedcard"."\-"."$secondcard";
# $firstpath = "gif\/$firstcard\.gif";
 $firstgazo = $top->Photo( -file => "gif\/$firstcard\.gif" );
 $newgazo = $top->Photo( -file => "gif\/$newcard\.gif" );
 $top->Label ( -image => $firstgazo )->place(-height => 150,-width => 100, -x => 0, -y=> 200);
 $top->Label ( -image => $newgazo )->place(-height => 150,-width => 100, -x => 200, -y=> 200);
 $duplicate="YES";
 &KANA;
}


#========================================================
# 二枚目と交換ボタンが押されたときに呼ばれる
#========================================================
sub secondchange {
 $discard="$discard"."\-"."$secondcard";
 $discount++;
 if ($discount%3==0){
  $discard="$discard"."\n";
 }
 $secondcard=$newcard;
 while ($duplicate eq "YES"){
  $suitselect=rand(3);
  $numberselect=rand(12);
  $checkcard="@suit[$suitselect]"."@number[$numberselect]";
  if ($checkcard =~/$usedcard/){
   $duplicate="YES";
  }else{
   $duplicate="NO";
  }
 }
 $newcard=$checkcard;
 $usedcard="$usedcard"."\-"."$secondcard";
 $secondgazo = $top->Photo( -file => "gif\/$secondcard\.gif" );
 $newgazo = $top->Photo( -file => "gif\/$newcard\.gif" );
 $top->Label ( -image => $secondgazo )->place(-height => 150,-width => 100, -x => 100, -y=> 200);
 $top->Label ( -image => $newgazo )->place(-height => 150,-width => 100, -x => 200, -y=> 200);
 $duplicate="YES";
 &KANA;
}


#========================================================
# 交換しないボタンが押されたときに呼ばれる
#========================================================
sub nochange {
 $discard="$discard"."\-"."$newcard";
 $discount++;
 if ($discount%3==0){
  $discard="$discard"."\n";
 }
 while ($duplicate eq "YES"){
  $suitselect=rand(3);
  $numberselect=rand(12);
  $checkcard="@suit[$suitselect]"."@number[$numberselect]";
  if ($checkcard =~/$usedcard/){
   $duplicate="YES";
  }else{
   $duplicate="NO";
  }
 }
 $newcard=$checkcard;
 $newgazo = $top->Photo( -file => "gif\/$newcard\.gif" );
 $top->Label ( -image => $newgazo )->place(-height => 150,-width => 100, -x => 200, -y=> 200);
 $usedcard="$usedcard"."\-"."$secondcard";
 $duplicate="YES";
 &KANA;
}


#========================================================
# 今井加奈ちゃんの思考
#========================================================
sub KANA {
 $kana_firstnum=$kana_firstcard;
 $kana_secondnum=$kana_secondcard;
 $kana_newnum=$kana_newcard;
 $kana_firstnum=~s/[hscd]//g;
 $kana_secondnum=~s/[hscd]//g;
 $kana_newnum=~s/[hscd]//g;

 $kana_sum1=$kana_firstnum+$kana_secondnum;
 $kana_sum2=$kana_firstnum+$kana_newnum;
 $kana_sum3=$kana_secondnum+$kana_newnum;

@kana_serihu=(
"「えへへっ！行きます！」",
"「あっ、メモ\n取っておこうかな…」 ",
"「プロデューサーさん、\n手札を教えて下さい！」",
"「（メモがないと\n心配だなぁ…）」",
"「私だって頑張ります！」");
$kana_count=rand(5);
$buffer=@kana_serihu[$kana_count];
#$bufferk = "$kana_firstcard$kana_secondcard$kana_newcard";#テスト用★

 if ($kana_sum1==21){#CPUvictory処理
  &result;
 }elsif ($kana_sum2==21){
  $kana_secondcard=$kana_newcard;
  &result;
 }elsif ($kana_sum3==21){
  $kana_firstcard=$kana_newcard;
  &result;
 }

 if ($kana_firstnum>=8){#new捨てる
  $discard="$discard"."\-"."$kana_newcard";
  $discount++;
  if ($discount%3==0){
   $discard="$discard"."\n";
  }
  while ($duplicate eq "YES"){
   $suitselect=rand(3);
   $numberselect=rand(12);
   $checkcard="@suit[$suitselect]"."@number[$numberselect]";
   if ($checkcard =~/$usedcard/){
    $duplicate="YES";
   }else{
    $duplicate="NO";
   }
  }
  $kana_newcard=$checkcard;
  $usedcard="$usedcard"."\-"."$kana_newcard";
  $duplicate="YES";
 }else{#1番目を捨てる
  $discard="$discard"."\-"."$kana_firstcard";
  $discount++;
  if ($discount%3==0){
   $discard="$discard"."\n";
  }
  while ($duplicate eq "YES"){
   $suitselect=rand(3);
   $numberselect=rand(12);
   $checkcard="@suit[$suitselect]"."@number[$numberselect]";
   if ($checkcard =~/$usedcard/){
    $duplicate="YES";
   }else{
    $duplicate="NO";
   }
  }
  $kana_firstcard=$checkcard;
  $usedcard="$usedcard"."\-"."$kana_firstcard";
  $duplicate="YES";
 }
}


#========================================================
# 結果ボタンが押されたときに呼ばれる
#========================================================
sub result {

 $firstcard=~s/[hscd]//g;
 $secondcard=~s/[hscd]//g;
 $goukei=$firstcard+$secondcard;
 $tensu=abs(21-$goukei);

 $kana_firstcard=~s/[hscd]//g;
 $kana_secondcard=~s/[hscd]//g;
 $kana_goukei=$kana_firstcard+$kana_secondcard;
 $kana_tensu=abs(21-$kana_goukei);

 if ($tensu==$kana_tensu){
  $buffer="「プロデューサーさんの\n合計は $goukei(±$tensu)\n私の合計は $kana_goukei(±$kana_tensu)\n引き分け！」";
 $image = $top->Photo( -file => 'gif/image_lose.gif' );
 $top->Label ( -image => $image )->place(-height => 100,-width => 128, -x => 0, -y=> 0);
 }
 elsif($tensu<$kana_tensu){
  $buffer="「プロデューサーさんの\n合計は $goukei(±$tensu)\n私の合計は $kana_goukei(±$kana_tensu)\n負けちゃいました・・・\nでも次は負けません！」";
 $image = $top->Photo( -file => 'gif/image_lose.gif' );
 $top->Label ( -image => $image )->place(-height => 100,-width => 128, -x => 0, -y=> 0);
 }else{
  $buffer="「プロデューサーさんの\n合計は $goukei(±$tensu)\n私の合計は $kana_goukei(±$kana_tensu)\n私の勝ち！嬉しいです♪」";
 $image = $top->Photo( -file => 'gif/image_win.gif' );
 $top->Label ( -image => $image )->place(-height => 100,-width => 128, -x => 0, -y=> 0);
 }
 $buffer1="";
 $buffer2="";
 $buffer3="";
 $buffer4="";
 $firstcard="";
 $secondcard="";
 $newcard="";
 $versionbutton1->place(-height => 1,-width => 1, -x => 0, -y=> 350);
 $versionbutton2->place(-height => 1,-width => 1, -x => 100, -y=> 350);
 $versionbutton3->place(-height => 1,-width => 1, -x => 200, -y=> 350);
 $versionbutton4->place(-height => 1,-width => 1, -x => 300, -y=> 350);
}
