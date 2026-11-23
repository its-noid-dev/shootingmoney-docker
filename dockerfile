FROM debian:bookworm-slim
ENV DEBIAN_FRONTEND=noninteractive SERVER_PORT=27840
RUN apt-get update && apt-get install -y --no-install-recommends libstdc++6 libgcc-s1 libatomic1 ca-certificates procps && rm -rf /var/lib/apt/lists/*
WORKDIR /opt/shooting-money
COPY ShootingMoneyServer.x86_64 ./ShootingMoneyServer.x86_64
COPY start-server.sh ./start-server.sh
RUN chmod 0555 ./ShootingMoneyServer.x86_64 ./start-server.sh
EXPOSE 27840/udp
HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 CMD pgrep -f '[S]hootingMoneyServer.x86_64' >/dev/null || exit 1
ENTRYPOINT ["./start-server.sh"]
