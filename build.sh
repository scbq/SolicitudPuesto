
echo "Instalando dependencias..."
bundle install
yarn install

echo "Migrando base de datos..."
bundle exec rails db:migrate

echo "Precompilando assets..."
bundle exec rails assets:precompile
