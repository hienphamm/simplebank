postgres14:
	docker run --name postgres14 --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -e POSTGRES_DB=simple_bank -d postgres:14-alpine

startdocker:
	docker start postgres14

createdb:
	docker exec -it postgres14 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres14 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:Edward2602@simplebank.ces4igr6f2cy.ap-southeast-1.rds.amazonaws.com:5432/simplebank" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:Edward2602@simplebank.ces4igr6f2cy.ap-southeast-1.rds.amazonaws.com:5432/simplebank" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:Edward2602@simplebank.ces4igr6f2cy.ap-southeast-1.rds.amazonaws.com:5432/simplebank" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:Edward2602@simplebank.ces4igr6f2cy.ap-southeast-1.rds.amazonaws.com:5432/simplebank" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/hienphamm/simplebank/db/sqlc Store

.PHONY: postgres14 createdb dropdb migrateup migratedown migrateup1 migratedown1 sqlc startdocker server mock