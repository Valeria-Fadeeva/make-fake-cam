#!/bin/bash

sudo modprobe --remove v4l2loopback
sudo modprobe v4l2loopback devices=1 video_nr=21 exclusive_caps=1 card_label="Virtual Webcam"

if [[ -n "$1" ]] && [[ -f "$1" ]]; then
    ext=$(echo $1 | rev | cut -d'.' -f 1 | rev)
    loop=""

    if [[ $ext = "mp4" ]] || [[ $ext = "mkv" ]]; then
        loop="-stream_loop -1"

    elif [[ $ext = "jpg" ]] || [[ $ext = "png" ]]; then
        loop="-loop 1"

    fi

    if [[ -n $loop ]]; then
        ffmpeg $loop -re -i $1 -vcodec rawvideo -threads 0 -vf "hflip,format=yuv420p" -f v4l2 /dev/video21
        #ffmpeg $loop -re -i $1 -vcodec rawvideo -threads 0 -vf "hflip" -pix_fmt yuv420p -f v4l2 /dev/video21
    fi
else
    ffmpeg -framerate 30 -video_size 1280x720 -input_format mjpeg -i /dev/video0 -vcodec rawvideo -threads 0 -vf "fspp=4:10,hflip,format=yuv420p" -f v4l2 /dev/video21
fi

read -p 'Remove cam. y/N? ' rmc
if [[ "${rmc,,}" == "y" ]]; then
    sudo modprobe --remove v4l2loopback
fi
