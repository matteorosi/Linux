1 Find a biggest files in /

- sudo du -a / 2>/dev/null | sort -n -r | head -n 20

2 Finding largest file recursively

- sudo find / -type f -printf "%s\t%p\n" | sort -n | tail -1

3 Displays top-20 biggest files in the current directory

- ls -1Rhs | sed -e "s/^ *//" | grep "^[0-9]" | sort -hr | head -n20
