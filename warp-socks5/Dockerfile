FROM alpine:3.21 AS builder

WORKDIR /app

COPY install.sh /app/install.sh

RUN apk add --no-cache curl \
	&& chmod a+x install.sh \
	&& sh install.sh

FROM alpine:3.21

ENV PORT=40000

COPY --from=builder /app/wgcf /usr/bin/wgcf
COPY --from=builder /app/wireproxy /usr/bin/wireproxy

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY warp-health-check.sh /usr/local/bin/warp-health-check.sh

RUN apk add --no-cache curl \
  && chmod +x /usr/local/bin/entrypoint.sh /usr/local/bin/warp-health-check.sh

EXPOSE ${PORT}/tcp 

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD []

HEALTHCHECK --interval=120s --timeout=30s --start-period=5s --retries=3 CMD [ "/usr/local/bin/warp-health-check.sh" ]
