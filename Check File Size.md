find a biggest files in /
sudo du -a / 2>/dev/null | sort -n -r | head -n 20

#Finding largest file recursively
sudo find / -type f -printf "%s\t%p\n" | sort -n | tail -1
