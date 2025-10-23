# Sử dụng image .NET 8 để chạy web app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

# Build app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["CongTyCanhToan.csproj", "./"]
RUN dotnet restore "CongTyCanhToan.csproj"
COPY . .
RUN dotnet publish "CongTyCanhToan.csproj" -c Release -o /app/publish

# Chạy app
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "CongTyCanhToan.dll"]
