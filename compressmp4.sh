 ffmpeg -i input.mkv -c copy output.mp4
ffmpeg -i input.mp4 -s 640x480 -b:v 512k -vcodec mpeg1video -acodec copy output.mp4 
ffmpeg -i input.mp4 -b 10000 output.mp4
ffmpeg -i input.mp4 -vcodec h264 -acodec ouput.mp4
