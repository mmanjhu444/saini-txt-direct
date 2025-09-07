FROM python:3.12-alpine3.20

WORKDIR /app
COPY . .

RUN apk add --no-cache \
    bash \
    unzip \
    aria2 \
    wget \
    ca-certificates \
    libstdc++ \
    ffmpeg \
    && update-ca-certificates

# Agar apk ffmpeg install na kare properly, toh yeh static version use karein:
RUN wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-i686-static.tar.xz && \
    tar -xf ffmpeg-release-i686-static.tar.xz && \
    cp ffmpeg-*-static/ffmpeg /usr/local/bin/ && \
    cp ffmpeg-*-static/ffprobe /usr/local/bin/ && \
    chmod +x /usr/local/bin/ffmpeg /usr/local/bin/ffprobe && \
    rm -rf ffmpeg-release-i686-static.tar.xz ffmpeg-*-static

RUN pip install --upgrade pip && pip install -r requirements.txt && pip install yt-dlp

CMD ["python3", "modules/main.py"]
