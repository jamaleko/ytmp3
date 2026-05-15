FROM golang:1.22

WORKDIR /app

# Download yt-dlp binary
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp && \
    chmod +x /usr/local/bin/yt-dlp

# Download static ffmpeg binary
RUN curl -L https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-i686-static.tar.xz -o ffmpeg.tar.xz && \
    tar -xJf ffmpeg.tar.xz --strip-components=1 -C /usr/local/bin

COPY . .

RUN go build -o app

EXPOSE 10000

CMD ["./app"]
