use GoGo

delete Sales
delete Ticket
delete TripStation
delete Trip
delete Station
delete City
delete PaymentMethod
delete UserRole
delete Users
delete Roles
delete Agent
delete Vehicle
delete VehicleType


dbcc checkident('Ticket',reseed,0)
dbcc checkident('Users',reseed,0)
dbcc checkident('Agent',reseed,0)
dbcc checkident('VehicleType',reseed,0)
dbcc checkident('Vehicle',reseed,0)
dbcc checkident('Station',reseed,0)
dbcc checkident('City',reseed,0)
dbcc checkident('Trip',reseed,0)
dbcc checkident('PaymentMethod',reseed,0)

dbcc checkident('Roles',reseed,0)

