posgre接続

docker exec -it gender-gap-db psql -U postgres


migrationのやり方

cd backend

docker exec -it rails_api bash

bundle exec rails db:migrate

# rspec実行方法

dockerがついている状態で

```
docker exec -it rails_api bash
```
```
bundle exec rspec spec/models/・・・
```

全体なら、

```
bundle exec rspec
```