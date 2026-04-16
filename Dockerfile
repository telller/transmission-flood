FROM jesec/flood:latest

RUN apt update && apt install -y mediainfo && rm -rf /var/lib/apt/lists/*