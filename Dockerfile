# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS runtime
ARG APPLICATION=Default
ARG PUBLISH=Default
ENV HOSTED_APP = ${APPLICATION}
WORKDIR /app
COPY /${HOSTED_APP}/${PUBLISH} /app

CMD dotnet {HOSTED_APP}.dll