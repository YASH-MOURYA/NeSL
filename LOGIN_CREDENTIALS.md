# NeSL Login Credentials

This project now includes a CRUD user management application.

## App routes

- `/login` — Sign in page
- `/users` — User list and management dashboard
- `/users/new` — Create a new user
- `/users/edit/{id}` — Edit an existing user
- `/users/delete/{id}` — Delete a user

## Role Credentials

Use the following role-based credentials for the login page.

## Role Credentials

- **Entity User**
  - loginType: `ENTITY`
  - userId: `entity1`
  - password: `entity123`
  - sample PAN: `ABCDE1234P`

- **IRP / RP / Liquidator**
  - loginType: `IRP`
  - userId: `irp1`
  - password: `irp123`
  - sample PAN: `ABCDE1234P`

- **Individual User**
  - loginType: `INDIVIDUAL`
  - userId: `individual1`
  - password: `individual123`

- **Statutory / Govt Entity**
  - loginType: `GOVT`
  - userId: `govt1`
  - password: `govt123`
  - sample PAN: `ABCDE1234G`

- **Association of Persons**
  - loginType: `AOP`
  - userId: `aop1`
  - password: `aop123`
  - sample PAN: `ABCDE1234A`

## PAN validation rules

For PAN-based login categories (`ENTITY`, `IRP`, `GOVT`, `AOP`), the UIN/PAN field must follow the pattern:

- 5 letters
- 4 digits
- 1 final letter

The 4th letter indicates the tax status holder and must be one of:

- `P` — Person / Individual
- `C` — Company
- `H` — Hindu Undivided Family (HUF)
- `F` — Firm / Limited Liability Partnership (LLP)
- `A` — Association of Persons (AOP)
- `T` — Trust
- `B` — Body of Individuals (BOI)
- `L` — Local Authority
- `J` — Artificial Juridical Person
- `G` — Government

Any other 4th letter is not accepted for PAN validation.

## H2 Database Credentials

- JDBC URL: `jdbc:h2:mem:nesldb`
- Username: `sa`
- Password: (empty)
- H2 Console URL: `/h2-console`
- Driver class name: `org.h2.Driver`

The application uses an in-memory H2 database and loads the initial user records from `src/main/resources/data.sql` at startup.
