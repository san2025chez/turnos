#!/bin/bash
case "$1" in
  "mysql")
    case "$2" in
      "build")
        docker build --tag vx-turnos-mysql -f docker/mysql/Dockerfile --no-cache "${@:3}" .
        ;;
      "run")
        docker run -d -p ${3:-3306}:3306 --name vx-turnos-mysql -e MYSQL_ROOT_PASSWORD=rootpass vx-turnos-mysql
        ;;
      "start")
        docker start vx-turnos-mysql
        ;;
      "stop")
        docker stop vx-turnos-mysql
        ;;
      "remove")
        docker rm vx-turnos-mysql
        ;;
      "logs")
        docker logs vx-turnos-mysql --follow
        ;;
      "workbench")
        docker run -d \
          --name vx-turnos-backend-phpmyadmin \
          --link vx-turnos-mysql:db \
          -p ${3:-80}:80 \
          phpmyadmin
        ;;
      *)
        echo "options:"
        echo "  build"
        echo "  run [:port]"
        echo "  start"
        echo "  stop"
        echo "  remove"
        echo "  logs"
        echo "  workbench [:port]"
        echo "connect command:"
        echo "  mysql -u dbuser -P 3306 -p -h 0.0.0.0 development"
        echo "  enter \"dbpass\""
        exit 0
        ;;
    esac
    ;;
  "artillery")
    case "$2" in
      "build")
        docker build --tag vx-turnos-artillery -f docker/artillery/Dockerfile --no-cache . 
        ;;
      "run")
        docker run -it --rm \
          --name vx-turnos-artillery \
          -v ${pwd}/dist:/dist \
          -e API_URL=${ARTILLERY_API_URL} \
          -p 3000:3000 \
          vx-turnos-artillery run artillery -- run -o ./dist/context-hooks-report.json ./context-hooks.yml
        ;;
      *)
        #TODO remove volume and print output in stdout in order to allow windows compatibility
        echo "options:"
        echo "  build"
        echo "  run"
        echo "  command run is ephemeral and api url must be provided"
        echo "    ARTILLERY_API_URL=http://localhost:3001 ./do artillery run"
        exit 0
        ;;
    esac
    ;;
  "dev")
    case "$2" in
      "build")
        docker build --tag vx-turnos-backend-dev -f docker/dev/Dockerfile . 
        ;;
      "run")
        docker run -d --name vx-turnos-backend-dev \
          -p ${3:-3000}:3000 \
          -e COOPENAE_API_URL="${COOPENAE_API_URL}" \
          -e REMOTE_MOCK_URL="${REMOTE_MOCK_URL}" \
          -e DB_HOST="${DB_HOST}" \
          -e DB_PORT="${DB_PORT}" \
          -e DB_USERNAME="${DB_USERNAME}" \
          -e DB_PASSWORD="${DB_PASSWORD}" \
          -e DB_NAME="${DB_NAME}" \
          -e VERSATEC_DB_HOST="${VERSATEC_DB_HOST}" \
          -e VERSATEC_DB_PORT="${VERSATEC_DB_PORT}" \
          -e VERSATEC_DB_USERNAME="${VERSATEC_DB_USERNAME}" \
          -e VERSATEC_DB_PASSWORD="${VERSATEC_DB_PASSWORD}" \
          -e VERSATEC_DB_NAME="${VERSATEC_DB_NAME}" \
          -e NODEMAILER_USERNAME="${NODEMAILER_USERNAME}" \
          -e NODEMAILER_PASSWORD="${NODEMAILER_PASSWORD}" \
          -e NODEMAILER_SENDER_ADDRESS="${NODEMAILER_SENDER_ADDRESS}" \
          -e FIREBASE_PROJECT_ID="${FIREBASE_PROJECT_ID}" \
          -e FIREBASE_CLIENT_ID="${FIREBASE_CLIENT_ID}" \
          -e FIREBASE_PRIVATE_KEY="${FIREBASE_PRIVATE_KEY}" \
          -e VERSATEC_API_URL="${VERSATEC_API_URL}" \
          -e VERSATEC_USERNAME="${VERSATEC_USERNAME}" \
          -e VERSATEC_PASSWORD="${VERSATEC_PASSWORD}" \
          -e VERSATEC_SCOPE="${VERSATEC_SCOPE}" \
          -e VERSATEC_HTTP_TIMEOUT="${VERSATEC_HTTP_TIMEOUT}" \
          -e COGNITO_DEFAULT_KID="${COGNITO_DEFAULT_KID}" \
          -e COGNITO_GROUP_ID="${COGNITO_GROUP_ID}" \
          -e COGNITO_IDP="${COGNITO_IDP}" \
          vx-turnos-backend-dev
        ;;
      "ephemeral")
        docker run -d --rm --name vx-turnos-backend-dev \
          -p ${3:-3000}:3000 \
          -e COOPENAE_API_URL="${COOPENAE_API_URL}" \
          -e REMOTE_MOCK_URL="${REMOTE_MOCK_URL}" \
          -e DB_HOST="${DB_HOST}" \
          -e DB_PORT="${DB_PORT}" \
          -e DB_USERNAME="${DB_USERNAME}" \
          -e DB_PASSWORD="${DB_PASSWORD}" \
          -e DB_NAME="${DB_NAME}" \
          -e VERSATEC_DB_HOST="${VERSATEC_DB_HOST}" \
          -e VERSATEC_DB_PORT="${VERSATEC_DB_PORT}" \
          -e VERSATEC_DB_USERNAME="${VERSATEC_DB_USERNAME}" \
          -e VERSATEC_DB_PASSWORD="${VERSATEC_DB_PASSWORD}" \
          -e VERSATEC_DB_NAME="${VERSATEC_DB_NAME}" \
          -e NODEMAILER_USERNAME="${NODEMAILER_USERNAME}" \
          -e NODEMAILER_PASSWORD="${NODEMAILER_PASSWORD}" \
          -e NODEMAILER_SENDER_ADDRESS="${NODEMAILER_SENDER_ADDRESS}" \
          -e FIREBASE_PROJECT_ID="${FIREBASE_PROJECT_ID}" \
          -e FIREBASE_CLIENT_ID="${FIREBASE_CLIENT_ID}" \
          -e FIREBASE_PRIVATE_KEY="${FIREBASE_PRIVATE_KEY}" \
          -e VERSATEC_API_URL="${VERSATEC_API_URL}" \
          -e VERSATEC_USERNAME="${VERSATEC_USERNAME}" \
          -e VERSATEC_PASSWORD="${VERSATEC_PASSWORD}" \
          -e VERSATEC_SCOPE="${VERSATEC_SCOPE}" \
          -e VERSATEC_HTTP_TIMEOUT="${VERSATEC_HTTP_TIMEOUT}" \
          -e COGNITO_DEFAULT_KID="${COGNITO_DEFAULT_KID}" \
          -e COGNITO_GROUP_ID="${COGNITO_GROUP_ID}" \
          -e COGNITO_IDP="${COGNITO_IDP}" \
          vx-turnos-backend-dev
        ;;
      "start")
        docker start vx-turnos-backend-dev
        ;;
      "stop")
        docker stop vx-turnos-backend-dev
        ;;
      "remove")
        docker rm vx-turnos-backend-dev
        ;;
      "logs")
        docker logs vx-turnos-backend-dev --follow
        ;;
      *)
        echo "options:"
        echo "  build"
        echo "  run [:port]"
        echo "  ephemeral [:port]"
        echo "  start"
        echo "  stop"
        echo "  remove"
        echo "  logs"
        echo "    for 'run' or 'ephemeral' it is posible to set env variables before execution"
        echo "    DB_HOST=\`hostname -I | awk '{print \$1}'\` ./do dev ephemeral"
        exit 0
        ;;
    esac
    ;;
  "app")
    case "$2" in
      "build")
        docker build --tag vx-turnos-backend -f docker/app/Dockerfile . 
        ;;
      "run")
        docker run -d --name vx-turnos-backend \
          -p ${3:-3000}:3000 \
          -e COOPENAE_API_URL="${COOPENAE_API_URL}" \
          -e REMOTE_MOCK_URL="${REMOTE_MOCK_URL}" \
          -e DB_WRITE_HOST="${DB_WRITE_HOST}" \
          -e DB_WRITE_PORT="${DB_WRITE_PORT}" \
          -e DB_WRITE_USERNAME="${DB_WRITE_USERNAME}" \
          -e DB_WRITE_PASSWORD="${DB_WRITE_PASSWORD}" \
          -e DB_WRITE_NAME="${DB_WRITE_NAME}" \
          -e DB_WRITE_RETRY_ATTEMPS="${DB_WRITE_RETRY_ATTEMPS}" \
          -e DB_WRITE_RETRY_ATTEMPS="${DB_WRITE_RETRY_DELAY}" \
          -e DB_READ_HOST="${DB_READ_HOST}" \
          -e DB_READ_PORT="${DB_READ_PORT}" \
          -e DB_READ_USERNAME="${DB_READ_USERNAME}" \
          -e DB_READ_PASSWORD="${DB_READ_PASSWORD}" \
          -e DB_READ_NAME="${DB_READ_NAME}" \
          -e DB_READ_RETRY_ATTEMPS="${DB_READ_RETRY_ATTEMPS}" \
          -e DB_READ_RETRY_ATTEMPS="${DB_READ_RETRY_DELAY}" \
          -e VERSATEC_DB_WRITE_HOST="${VERSATEC_DB_WRITE_HOST}" \
          -e VERSATEC_DB_WRITE_PORT="${VERSATEC_DB_WRITE_PORT}" \
          -e VERSATEC_DB_WRITE_USERNAME="${VERSATEC_DB_WRITE_USERNAME}" \
          -e VERSATEC_DB_WRITE_PASSWORD="${VERSATEC_DB_WRITE_PASSWORD}" \
          -e VERSATEC_DB_WRITE_NAME="${VERSATEC_DB_WRITE_NAME}" \
          -e VERSATEC_DB_WRITE_RETRY_ATTEMPS="${VERSATEC_DB_WRITE_RETRY_ATTEMPS}" \
          -e VERSATEC_DB_WRITE_RETRY_ATTEMPS="${VERSATEC_DB_WRITE_RETRY_DELAY}" \
          -e VERSATEC_DB_READ_HOST="${VERSATEC_DB_READ_HOST}" \
          -e VERSATEC_DB_READ_PORT="${VERSATEC_DB_READ_PORT}" \
          -e VERSATEC_DB_READ_USERNAME="${VERSATEC_DB_READ_USERNAME}" \
          -e VERSATEC_DB_READ_PASSWORD="${VERSATEC_DB_READ_PASSWORD}" \
          -e VERSATEC_DB_READ_NAME="${VERSATEC_DB_READ_NAME}" \
          -e VERSATEC_DB_READ_RETRY_ATTEMPS="${VERSATEC_DB_READ_RETRY_ATTEMPS}" \
          -e VERSATEC_DB_READ_RETRY_ATTEMPS="${VERSATEC_DB_READ_RETRY_DELAY}" \
          -e NODEMAILER_USERNAME="${NODEMAILER_USERNAME}" \
          -e NODEMAILER_PASSWORD="${NODEMAILER_PASSWORD}" \
          -e NODEMAILER_SENDER_ADDRESS="${NODEMAILER_SENDER_ADDRESS}" \
          -e FIREBASE_PROJECT_ID="${FIREBASE_PROJECT_ID}" \
          -e FIREBASE_CLIENT_ID="${FIREBASE_CLIENT_ID}" \
          -e FIREBASE_PRIVATE_KEY="${FIREBASE_PRIVATE_KEY}" \
          -e VERSATEC_API_URL="${VERSATEC_API_URL}" \
          -e VERSATEC_USERNAME="${VERSATEC_USERNAME}" \
          -e VERSATEC_PASSWORD="${VERSATEC_PASSWORD}" \
          -e VERSATEC_SCOPE="${VERSATEC_SCOPE}" \
          -e VERSATEC_HTTP_TIMEOUT="${VERSATEC_HTTP_TIMEOUT}" \
          -e COGNITO_DEFAULT_KID="${COGNITO_DEFAULT_KID}" \
          -e COGNITO_GROUP_ID="${COGNITO_GROUP_ID}" \
          -e COGNITO_IDP="${COGNITO_IDP}" \
          vx-turnos-backend
        ;;
      "ephemeral")
        docker run --rm --name vx-turnos-backend \
          -p ${3:-3000}:3000 \
          -e COOPENAE_API_URL="${COOPENAE_API_URL}" \
          -e REMOTE_MOCK_URL="${REMOTE_MOCK_URL}" \
          -e DB_WRITE_HOST="${DB_WRITE_HOST}" \
          -e DB_WRITE_PORT="${DB_WRITE_PORT}" \
          -e DB_WRITE_USERNAME="${DB_WRITE_USERNAME}" \
          -e DB_WRITE_PASSWORD="${DB_WRITE_PASSWORD}" \
          -e DB_WRITE_NAME="${DB_WRITE_NAME}" \
          -e DB_WRITE_RETRY_ATTEMPS="${DB_WRITE_RETRY_ATTEMPS}" \
          -e DB_WRITE_RETRY_ATTEMPS="${DB_WRITE_RETRY_DELAY}" \
          -e DB_READ_HOST="${DB_READ_HOST}" \
          -e DB_READ_PORT="${DB_READ_PORT}" \
          -e DB_READ_USERNAME="${DB_READ_USERNAME}" \
          -e DB_READ_PASSWORD="${DB_READ_PASSWORD}" \
          -e DB_READ_NAME="${DB_READ_NAME}" \
          -e DB_READ_RETRY_ATTEMPS="${DB_READ_RETRY_ATTEMPS}" \
          -e DB_READ_RETRY_ATTEMPS="${DB_READ_RETRY_DELAY}" \
          -e VERSATEC_DB_WRITE_HOST="${VERSATEC_DB_WRITE_HOST}" \
          -e VERSATEC_DB_WRITE_PORT="${VERSATEC_DB_WRITE_PORT}" \
          -e VERSATEC_DB_WRITE_USERNAME="${VERSATEC_DB_WRITE_USERNAME}" \
          -e VERSATEC_DB_WRITE_PASSWORD="${VERSATEC_DB_WRITE_PASSWORD}" \
          -e VERSATEC_DB_WRITE_NAME="${VERSATEC_DB_WRITE_NAME}" \
          -e VERSATEC_DB_WRITE_RETRY_ATTEMPS="${VERSATEC_DB_WRITE_RETRY_ATTEMPS}" \
          -e VERSATEC_DB_WRITE_RETRY_ATTEMPS="${VERSATEC_DB_WRITE_RETRY_DELAY}" \
          -e VERSATEC_DB_READ_HOST="${VERSATEC_DB_READ_HOST}" \
          -e VERSATEC_DB_READ_PORT="${VERSATEC_DB_READ_PORT}" \
          -e VERSATEC_DB_READ_USERNAME="${VERSATEC_DB_READ_USERNAME}" \
          -e VERSATEC_DB_READ_PASSWORD="${VERSATEC_DB_READ_PASSWORD}" \
          -e VERSATEC_DB_READ_NAME="${VERSATEC_DB_READ_NAME}" \
          -e VERSATEC_DB_READ_RETRY_ATTEMPS="${VERSATEC_DB_READ_RETRY_ATTEMPS}" \
          -e VERSATEC_DB_READ_RETRY_ATTEMPS="${VERSATEC_DB_READ_RETRY_DELAY}" \
          -e NODEMAILER_USERNAME="${NODEMAILER_USERNAME}" \
          -e NODEMAILER_PASSWORD="${NODEMAILER_PASSWORD}" \
          -e NODEMAILER_SENDER_ADDRESS="${NODEMAILER_SENDER_ADDRESS}" \
          -e FIREBASE_PROJECT_ID="${FIREBASE_PROJECT_ID}" \
          -e FIREBASE_CLIENT_ID="${FIREBASE_CLIENT_ID}" \
          -e FIREBASE_PRIVATE_KEY="${FIREBASE_PRIVATE_KEY}" \
          -e VERSATEC_API_URL="${VERSATEC_API_URL}" \
          -e VERSATEC_USERNAME="${VERSATEC_USERNAME}" \
          -e VERSATEC_PASSWORD="${VERSATEC_PASSWORD}" \
          -e VERSATEC_SCOPE="${VERSATEC_SCOPE}" \
          -e VERSATEC_HTTP_TIMEOUT="${VERSATEC_HTTP_TIMEOUT}" \
          -e COGNITO_DEFAULT_KID="${COGNITO_DEFAULT_KID}" \
          -e COGNITO_GROUP_ID="${COGNITO_GROUP_ID}" \
          -e COGNITO_IDP="${COGNITO_IDP}" \
          vx-turnos-backend
        ;;
      "start")
        docker start vx-turnos-backend
        ;;
      "stop")
        docker stop vx-turnos-backend
        ;;
      "remove")
        docker rm vx-turnos-backend
        ;;
      "logs")
        docker logs vx-turnos-backend --follow
        ;;
      *)
        echo "options:"
        echo "  build"
        echo "  run [:port]"
        echo "  ephemeral [:port]"
        echo "  start"
        echo "  stop"
        echo "  remove"
        echo "  logs"
        echo "    for 'run' or 'ephemeral' must set corresponding env variables before execution"
        echo "    DB_WRITE_HOST=\`hostname -I | awk '{print \$1}'\` \\"
        echo "    DB_WRITE_USERNAME=dbuser \\"
        echo "    DB_WRITE_PASSWORD=dbpass \\"
        echo "    DB_WRITE_NAME=development \\"
        echo "    DB_READ_HOST=\`hostname -I | awk '{print \$1}'\` \\"
        echo "    DB_READ_USERNAME=dbuser \\"
        echo "    DB_READ_PASSWORD=dbpass \\"
        echo "    DB_READ_NAME=development \\"
        echo "    VERSATEC_DB_WRITE_HOST=\`hostname -I | awk '{print \$1}'\` \\"
        echo "    VERSATEC_DB_WRITE_USERNAME=dbuser \\"
        echo "    VERSATEC_DB_WRITE_PASSWORD=dbpass \\"
        echo "    VERSATEC_DB_WRITE_NAME=development \\"
        echo "    VERSATEC_DB_READ_HOST=\`hostname -I | awk '{print \$1}'\` \\"
        echo "    VERSATEC_DB_READ_USERNAME=dbuser \\"
        echo "    VERSATEC_DB_READ_PASSWORD=dbpass \\"
        echo "    VERSATEC_DB_READ_NAME=development \\"
        echo "    NODEMAILER_USERNAME=- \\"
        echo "    NODEMAILER_PASSWORD=- \\"
        echo "    NODEMAILER_SENDER_ADDRESS=- \\"
        echo "    FIREBASE_PROJECT_ID=<firebase-project-id> \\"
        echo "    FIREBASE_CLIENT_ID=<firebase-client-id> \\"
        echo "    FIREBASE_PRIVATE_KEY=<firebase-private-key> \\"
        echo "    VERSATEC_API_URL=<versatec-api-url> \\"
        echo "    VERSATEC_USERNAME=<versatec-username> \\"
        echo "    VERSATEC_PASSWORD=<versatec-password> \\"
        echo "    VERSATEC_SCOPE=<versatec-scope> \\"
        echo "      ./do app ephemeral"
        exit 0
        ;;
    esac
    ;;
  *)
    echo "options:"
    echo "  mysql"
    echo "  artillery (no Windows compatibility)"
    echo "  dev"
    echo "  app"
    echo "  mochintosh"
esac

