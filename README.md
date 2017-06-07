今井加奈ちゃんとブラックジャックをプレイするスクリプト  

# 実行ファイル
　https://t.co/GAUbiv1AGA  
　からダウンロードするとexe化された実行ファイルとコンポーネントが入手できます。  

# Perlインタプリタでの実行  
* Perl/Tkの導入が厄介です。  
* スクリプトはUTF8Nで保存する必要があります  

# 制作環境  
Windows 7 HOME Premium SP1 32bit  

$ perl -v  
This is perl 5, version 16, subversion 1 (v5.16.1) built for MSWin32-x86-multi-thread  

$ ppm  
ppm version 4.17  
> install win32::Exe  
win32::Exe version 0.17  

$ cpan  
Set up gcc environment - 3.4.5 (mingw-vista special r3)  
$ cpan > install PAR::Packer  
INST_FILE    C:\Perl\site\lib\PAR\Packer.pm  
INST_VERSION 1.036  

