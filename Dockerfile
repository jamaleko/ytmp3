FROM golang:1.22

WORKDIR /app

# install tools
RUN apt-get update && \
    apt-get install -y curl xz-utils ffmpeg python3 python3-pip

# install yt-dlp
RUN pip3 install --break-system-packages yt-dlp

COPY . .

RUN go build -o app

EXPOSE 10000

CMD ["./app"]
