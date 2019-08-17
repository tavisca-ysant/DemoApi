# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS runtime
WORKDIR /app
COPY ./DemoApi/publish ./
ENTRYPOINT ["dotnet", "*.dll"]