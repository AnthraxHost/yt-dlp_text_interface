@echo off
setlocal enabledelayedexpansion

Rem Change desired output Directory
set "output_dir=D:/Users/starp/Downloads/"

:start
REM Display menu for format selection
echo Select the desired format:
echo 1. MP4
echo 2. MP3
set /p format_choice="Enter 1 or 2: "

REM Validate format choice
if "%format_choice%"=="1" (
:start1
    REM Display menu for quality selection
    echo Select the desired quality:
    echo 1. 1080P
    echo 2. 720P
    echo 3. 480P
    echo 4. 360P
    set /p quality_choice="Enter 1, 2, 3, or 4: "
    
    REM Validate quality choice and set the quality label
    if "!quality_choice!"=="1" (
        set "format=bestvideo[ext=mp4][height<=1080]+bestaudio[ext=m4a]/best"
        set "extension=mp4"
        set "quality_label=1080P"
    ) else if "!quality_choice!"=="2" (
        set "format=bestvideo[ext=mp4][height<=720]+bestaudio[ext=m4a]/best"
        set "extension=mp4"
        set "quality_label=720P"
    ) else if "!quality_choice!"=="3" (
        set "format=bestvideo[ext=mp4][height<=480]+bestaudio[ext=m4a]/best"
        set "extension=mp4"
        set "quality_label=480P"
    ) else if "!quality_choice!"=="4" (
	        set "format=bestvideo[ext=mp4][height<=360]+bestaudio[ext=m4a]/best"
        set "extension=mp4"
        set "quality_label=360P"
    ) else (
        echo Invalid choice. Please enter 1, 2, 3, or 4 for quality.
        goto start1
    )
) else if "%format_choice%"=="2" (
    set "format=bestaudio[ext=m4a]/best"
    set "extension=mp3"
) else (
    echo Invalid choice. Please enter 1 or 2 for format.
    goto start
)

:start2
REM Prompt for video URL
set /p video_url="Enter the video URL: "

REM Strip any text after "&" in the URL
for /f "tokens=1 delims=&" %%a in ("!video_url!") do (
    set "video_url=%%a"
)

REM Validate the URL by checking for "http://" or "https://"
echo !video_url! | findstr /I "http:// https://" > nul
if errorlevel 1 (
    echo Invalid URL. Please enter a valid URL.
    goto start2
)

REM Use yt-dlp to download the file and capture the entire video title
for /f "delims=" %%i in ('yt-dlp --get-title --skip-download --format "!format!" !video_url!') do (
    set "video_title=%%i"
)

REM Sanitize the video title by removing invalid characters, spaces, and double quotes
set "video_title=!video_title:_=-!"
set "video_title=!video_title:/=-!"
set "video_title=!video_title:+=-!"
set "video_title=!video_title:[=-!"
set "video_title=!video_title:]=-!"
set "video_title=!video_title:^=-!"
set "video_title=!video_title:&=-!"
set "video_title=!video_title:|=!"
set "video_title=!video_title:<=-!"
set "video_title=!video_title:>=-!"
set "video_title=!video_title:(=-!"
set "video_title=!video_title:)-=-!"
set "video_title=!video_title:,-=-!"
set "video_title=!video_title:.=-!"
set "video_title=!video_title:"=!"

REM Trim the video title to a maximum length of 100 characters
set "video_title=!video_title:~0,100!"

REM Execute yt-dlp with the chosen format and URL, using the sanitized and trimmed filename
if "%extension%"=="mp3" (
    yt-dlp --config "%UserProfile%\yt-dlp.conf" --extract-audio --audio-format mp3 --output "%output_dir%/!video_title!_%quality_label%.mp3" --format "!format!" --windows-filenames "!video_url!"
) else (
    yt-dlp --config "%UserProfile%\yt-dlp.conf" --output "%output_dir%/!video_title!_%quality_label%.mp4" --format "!format!" --windows-filenames "!video_url!"
)

echo Download completed. The file has been saved as: "!video_title!" in: 
pause
