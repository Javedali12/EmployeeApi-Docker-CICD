# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build

WORKDIR /src

COPY ["EmployeeApi.csproj", "./"]

RUN dotnet restore "EmployeeApi.csproj"

COPY . .

RUN dotnet publish "EmployeeApi.csproj" -c Release -o /app/publish /p:UseAppHost=false


# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final

WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 8080

ENTRYPOINT ["dotnet", "EmployeeApi.dll"]