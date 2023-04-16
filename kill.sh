#!/bin/bash

pid=$(ps aux | grep ffmpeg | grep video21 | awk '{print $2}')
kill $pid

pid=$(ps aux | grep ffmpeg | grep video22 | awk '{print $2}')
kill $pid

pid=$(ps aux | grep ffmpeg | grep video23 | awk '{print $2}')
kill $pid
