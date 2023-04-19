@echo
forfiles /p "D:\oracle\oradata\OMNILAB\archive" /s /m *.* /d -1 /c "cmd /c del @path"