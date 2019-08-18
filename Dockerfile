# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS runtime
WORKDIR app
COPY ./DemoApi/publish ./
ARG APPLICATION=Default
ENV HOSTED_APP = ${APPLICATION}
CMD dotnet {HOSTED_APP}.dll