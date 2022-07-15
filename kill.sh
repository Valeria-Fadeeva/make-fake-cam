#!/bin/bash

pid=$(ps aux | grep ffmpeg | grep video21 | awk '{print $2}')
kill $pid
