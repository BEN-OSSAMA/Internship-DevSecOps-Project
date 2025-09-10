# PowerShell script to create .env files for all services

# Common environment variables for all services
$commonEnvVars = @"
NODE_ENV=dev
PROTOCOL=http
HOST=localhost
URL=mongodb://mongo:27017/
DBNAME=inventorymanagementsystem
MSG_QUEUE_URL=amqp://rabbitmq
REDIS_URL=redis://redis:6379
REDIS_TTL=3600
ALLOWED_SOURCES=localhost
EXCHANGE_NAME=INVENTORYMANAGEMENTSYSTEM
TOKEN_KEY=[Rdk,](M7VKc>:XLA[=i
TOKEN_FIELD_NAME=jwt
TOKEN_EXPIRATION_DURATION_IN_MILLISECOND=14400000
LANGUAGE_FIELD_NAME=lang
DEFAULT_LANGUAGE_FIELD_NAME=defaultLang
UPLOAD_DESTINATION=.
DELAY=1000
RETRIES=3
TZ=UTC
"@

# Service-specific configurations
$services = @(
    @{Name="APIGateway"; Port="4000"},
    @{Name="AccountManagementService"; Port="4001"},
    @{Name="CurrencyManagementService"; Port="4002"},
    @{Name="CustomerManagementService"; Port="4003"},
    @{Name="InventoryManagementService"; Port="4004"},
    @{Name="ProductManagementService"; Port="4005"},
    @{Name="SupplierManagementService"; Port="4006"},
    @{Name="TaxonomyManagementService"; Port="4007"},
    @{Name="TechnicalConfigurationService"; Port="4008"},
    @{Name="TransactionManagementService"; Port="4009"}
)


# Create .env files for each service
foreach ($service in $services) {
    $serviceName = $service.Name
    $port = $service.Port
    $gateway = "http://localhost:4000"
    
    $envContent = @"
SERVICENAME=$serviceName
PORT=$port
GATEWAY=$gateway
$commonEnvVars
"@
    
    if ($serviceName -eq "APIGateway") {
        $envContent | Out-File -FilePath "APIGateway/.env" -Encoding UTF8
        Write-Host "Created APIGateway/.env"
    } else {
        $envContent | Out-File -FilePath "backend/$serviceName/.env" -Encoding UTF8
        Write-Host "Created backend/$serviceName/.env"
    }
}

Write-Host "All .env files created successfully!" 