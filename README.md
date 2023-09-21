# yt-dlp_text_interface
A small batch program to download mp3 and mp4 files using an existing install of yt-dlp in your system.

## Functionality
When executed, a console window will prompt you to:
1. decide if you want to download an mp3 or mp4
2. if mp4, choose between 4 levels of quality, from 360p to 1080p

**You NEED to install both yt-dlp and ffmpeg and register them to the PATH environment variable on your system.**  

# Instructions
## VideoDownloader.bat
This file can be executed from anywhere, as long as the environment variables to yt-dlp and ffmpeg are correctly set.  
I recommend you to leave it somewhere it won't be messed with accidentally, and then pin a shortcut to it on your start menu for quick access.  

### IMPORTANT
After you download this file, open it with a text editor of your choice.  
On line 5, there will be a variable called output_dir. If you want your media to be downloaded anywhere other than the default downloads folder on Windows, change this to where you want.

## yt-dlp.conf
This is a configuration file for yt-dlp.  
Paste it at the current user directory. You can use Win+R and type **%USERPROFILE%** to get there quicker.  
If the file is not on the correct directory, the batch file may not work as intended.

### IMPORTANT 2
There's also something you will have to edit here.  
The first line containing the --cookies-from-browser argument points to the folder where Opera GX stores their cookies. This is needed because Elon Musk decided that you cannot see content on Twitter without logging in first, so the program needs your session cookies to be able to access Twitter. Without this, you can't download stuff from there.  

[yt-dlp's repository](https://github.com/yt-dlp/yt-dlp#filesystem-options) has *some* browser cookie directories pre-configured in their arguments (not Opera GX, the one I use), so if you use a different browser, please refer to their documentation and update *yt-dlp.conf*.


Thanks for using our script!  
Made with love from me, @StarPAnims and with the help of ChatGPT
