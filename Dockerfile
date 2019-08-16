FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.sln ./
COPY DemoApi/DemoApi.csproj ./DemoApi/
COPY DemoApi.Tests/DemoApi.Tests.csproj ./DemoApi.Tests/
RUN dotnet restore
#RUN dotnet build -c Release --no-restore

#WORKDIR /app/DemoApi.Tests
#RUN dotnet test DemoApi.Tests.csproj

# Copy everything else and build
COPY . ./
WORKDIR /app/DemoApi
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS runtime
WORKDIR /app
COPY --from=build-env /app/DemoApi/out ./
ENTRYPOINT ["dotnet", "DemoApi.dll"]