# shell

0. sudo find / -name StataSE -type f 2>/dev/null
1. cd /Applications/Stata/StataSE.app/Contents/MacOS/
2. export PATH=$PATH:/Applications/Stata/StataSE.app/Contents/MacOS/
3. stata-se -e "di c(current_date)"
4. cat stata.log
5. cd $PATH