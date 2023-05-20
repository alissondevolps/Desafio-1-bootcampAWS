#!/bin/bash

# Configurar as variáveis de ambiente
export AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="YOUR_SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="YOUR_AWS_REGION"

# Registrar um novo usuário
aws cognito-idp sign-up \
  --client-id YOUR_APP_CLIENT_ID \
  --username USER_USERNAME \
  --password USER_PASSWORD \
  --user-attributes Name=email,Value=user@example.com

# Confirmar o registro do usuário
aws cognito-idp admin-confirm-sign-up \
  --user-pool-id YOUR_USER_POOL_ID \
  --username USER_USERNAME

# Fazer login e obter tokens de autenticação
auth_result=$(aws cognito-idp initiate-auth \
  --client-id YOUR_APP_CLIENT_ID \
  --auth-flow USER_PASSWORD_AUTH \
  --auth-parameters USERNAME=USER_USERNAME,PASSWORD=USER_PASSWORD)

access_token=$(echo "$auth_result" | jq -r '.AuthenticationResult.AccessToken')
id_token=$(echo "$auth_result" | jq -r '.AuthenticationResult.IdToken')
refresh_token=$(echo "$auth_result" | jq -r '.AuthenticationResult.RefreshToken')

# Exibir os tokens de autenticação
echo "Token de acesso: $access_token"
echo "Token de identificação: $id_token"
echo "Token de atualização: $refresh_token"
