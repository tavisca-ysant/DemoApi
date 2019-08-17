# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:latest AS runtime
WORKDIR app
COPY publish .
ENTRYPOINT ["dotnet", "*.dll"]