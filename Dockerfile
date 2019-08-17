# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS runtime
WORKDIR app
COPY publish .
ENTRYPOINT ["dotnet", "*.dll"]