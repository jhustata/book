# shell

0. sudo find / -name StataSE -type f 2>/dev/null
1. cd /Applications/Stata/StataSE.app/Contents/MacOS/
2. export PATH=$PATH:/Applications/Stata/StataSE.app/Contents/MacOS/
3. stata-se -e "di c(current_date)"
4. cat stata.log
5. cd $PATH
6. shift/control/+
7. shift/+
8. app management: allows terminal, vscode, and xterm to control other apps
9. ls -ld /Applications/Stata/StataSE.app
10.chmod u+rwx /Applications/Stata/StataSE.app
11.This command gives the current user (u) read, write, and execute (+rwx) permissions for the directory.
12.sudo /Applications/Stata/StataSE.app/Contents/MacOS/StataSE


