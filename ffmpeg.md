# 推流


## rtmp
`ffmpeg -re -i IMG_2194.mov -c copy -f flv rtmp://localhost/live/film
`
## hls
`ffmpeg -re -i IMG_2194.mov -c copy -f flv rtmp://localhost/hls_alic/film`

## 编译ffmpeg
### 依赖
nasm/yasm ``

