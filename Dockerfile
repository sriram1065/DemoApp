# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:6.0 as build-env
WORKDIR /app
COPY ./ .
RUN dotnet restore
RUN dotnet publish -c Release -o /out
FROM mcr.microsoft.com/dotnet/aspnet:6.0 as runtime
WORKDIR /app
COPY --from=build-env /out .
EXPOSE 80
ENTRYPOINT ["dotnet", "DemoApp.dll"]
