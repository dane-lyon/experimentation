find /home -maxdepth 12 -type d -iregex '/home/.?/[^/]*/perso/\(.Config\|config_eole\)/Application\ Data/(com.makeblock.Scratch)((?!3.4.0).)*$' > test_find.txt
