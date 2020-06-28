#!/bin/bash

apt-get update
apt-get install git -y
apt-get install tree -y
apt-get install terminator -y

# snap window left 
# qdbus com.deepin.wm /com/deepin/wm com.deepin.wm.TileActiveWindow 1
# snap window right 
# qdbus com.deepin.wm /com/deepin/wm com.deepin.wm.TileActiveWindow 2
