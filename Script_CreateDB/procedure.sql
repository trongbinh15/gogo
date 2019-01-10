use GoGo
GO
CREATE OR ALTER PROCEDURE SP_TRIPINFORMATION_SEARCH
	@originCity int,
	@destinationCity int,
	@datePicked date
AS
BEGIN
	SELECT
		T.Id AS [tripId],
		A.AgentName AS [agentName],
		A.Rate AS [agentRate],
		CO.CityName AS [origin],
		CD.CityName AS [destination],
		CAST(T.EstStartTime as time) AS [startTime],
		CAST(T.EstEndTime as time) AS [endTime],
		CONCAT(V.VehicleBrand,' ',VT.VehicleName) AS [vehicleTypeName],
		VT.Seat AS [seat],
		TK.Date AS [date],
		COUNT(TK.Status) AS [ticketFree]
	FROM Trip T
		LEFT JOIN Vehicle V on V.Id = T.VehicleId
		LEFT JOIN VehicleType VT on VT.Id = V.VehicleTypeId
		LEFT JOIN City CO on CO.Id = T.OriginCity
		LEFT JOIN City CD on CD.Id = T.DestinationCity
		LEFT JOIN Agent A on A.Id = V.AgentId
		LEFT JOIN Ticket TK on TK.TripId = T.Id AND TK.Status = 0
	WHERE
		(@originCity IS NULL OR T.OriginCity = @originCity)
		AND (@destinationCity IS NULL OR T.DestinationCity = @destinationCity)
		AND (@datePicked IS NULL OR DATEDIFF(d,@datePicked,TK.Date)=0)
	GROUP BY 
		T.Id,
		A.AgentName,
		A.Rate,
		CO.CityName,
		CD.CityName,
		T.EstStartTime,
		T.EstEndTime,
		CONCAT(V.VehicleBrand,' ',VT.VehicleName),
		VT.Seat,
		TK.Date,
		TK.Status
END

exec SP_TRIPINFORMATION_SEARCH null,null,null

update Ticket
set Status = 1
where TripId=2 and Id > 25

update Ticket
set Status = 1 
where TripId=3 and Id > 33

select *
from Ticket



GO
CREATE OR ALTER PROCEDURE SP_GetLatLngOrigin(
	@tripID int
)
AS
BEGIN
	SELECT
		Latitude AS [lat],
		Longitude AS [lng]
	FROM
		TripStation
		INNER JOIN Station ON TripStation.StationId = Station.Id
	WHERE 
		TripId = @tripID
		AND TripStation.Priority = (SELECT MIN(T.Priority)
		FROM TripStation T
		WHERE T.TripId = @tripID)
END

GO
CREATE OR ALTER PROCEDURE SP_GetLatLngDestination(
	@tripID int
)
AS
BEGIN
	SELECT
		Latitude AS [lat],
		Longitude AS [lng]
	FROM
		TripStation
		INNER JOIN Station ON TripStation.StationId = Station.Id
	WHERE 
		TripId = @tripID
		AND TripStation.Priority = (SELECT MAX(T.Priority)
		FROM TripStation T
		WHERE T.TripId = @tripID)
END

GO
CREATE OR ALTER PROCEDURE SP_TrackPosition(
	@latitude float,
	@longitude float
)
AS
BEGIN
	INSERT INTO PositionEvent
		(Latitude,Longitude,Date)
	values(@latitude, @longitude, GETDATE())
END

GO
CREATE OR ALTER PROCEDURE UpdateTicket
	@List AS TicketList READONLY
AS
BEGIN
	UPDATE Ticket
	SET Status = 1
	WHERE Id IN (SELECT TicketId
	FROM @List)
END


--------Report
go
CREATE PROC INIT_BAOCAOLUULUONGNAM_DATA
AS
BEGIN
	DELETE BAOCAOLUULUONGNAM_DATA
END

go
CREATE PROC INIT_BAOCAODOANHTHUNAM_DATA
AS
BEGIN
	DELETE BAOCAODOANHTHUNAM_DATA
END

GO
ALTER PROC [dbo].[Generate_BaoCaoLuuLuongNam]
	@agentid int
AS

    BEGIN
	DECLARE @SLT1 INT
	DECLARE @SLT2 INT
	DECLARE @SLT3 INT
	DECLARE @SLT4 INT
	DECLARE @SLT5 INT
	DECLARE @SLT6 INT
	DECLARE @SLT7 INT
	DECLARE @SLT8 INT
	DECLARE @SLT9 INT
	DECLARE @SLT10 INT
	DECLARE @SLT11 INT
	DECLARE @SLT12 INT

	DECLARE @year INT = 2015;

	WHILE @year <= 2019

            BEGIN

		set @SLT1=(select COALESCE (COUNT(*),0) as SL
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=1 and YEAR(sa.LastCreatedDate)=@year)

		set @SLT2=(select COALESCE (COUNT(*),0) as SL
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=2 and YEAR(sa.LastCreatedDate)=@year)

		set @SLT3=(select COALESCE (COUNT(*),0) as SL
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=3 and YEAR(sa.LastCreatedDate)=@year)

		set @SLT4=(select COALESCE (COUNT(*),0) as SL
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=4 and YEAR(sa.LastCreatedDate)=@year)

		set @SLT5=(select COALESCE (COUNT(*),0) as SL
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=5 and YEAR(sa.LastCreatedDate)=@year)

		set @SLT6=(select COALESCE (COUNT(*),0) as SL
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=6 and YEAR(sa.LastCreatedDate)=@year)

		set @SLT7=(select COALESCE (COUNT(*),0) as SL
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=7 and YEAR(sa.LastCreatedDate)=@year)

		set @SLT8=(select COALESCE (COUNT(*),0) as SL
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=8 and YEAR(sa.LastCreatedDate)=@year)
		set @SLT9=(select COALESCE (COUNT(*),0) as SL
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=9 and YEAR(sa.LastCreatedDate)=@year)

		set @SLT10=(select COALESCE (COUNT(*),0) as SL
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=10 and YEAR(sa.LastCreatedDate)=@year)

		set @SLT11=(select COALESCE (COUNT(*),0) as SL
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=11 and YEAR(sa.LastCreatedDate)=@year)

		set @SLT12=(select COALESCE (COUNT(*),0) as SL
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=12 and YEAR(sa.LastCreatedDate)=@year)


		INSERT INTO BAOCAOLUULUONGNAM_DATA
		VALUES
			(@year, @SLT1, @SLT2, @SLT3, @SLT4, @SLT5, @SLT6, @SLT7, @SLT8, @SLT9, @SLT10, @SLT11, @SLT12);
		SET @year = @year + 1;
	END;
END


GO
ALTER PROC [dbo].[Generate_BaoCaoDoanhThuNam]
	@agentid int
AS

    BEGIN
	DECLARE @DTT1 INT
	DECLARE @DTT2 INT
	DECLARE @DTT3 INT
	DECLARE @DTT4 INT
	DECLARE @DTT5 INT
	DECLARE @DTT6 INT
	DECLARE @DTT7 INT
	DECLARE @DTT8 INT
	DECLARE @DTT9 INT
	DECLARE @DTT10 INT
	DECLARE @DTT11 INT
	DECLARE @DTT12 INT

	DECLARE @year INT = 2015;

	WHILE @year <= 2019

            BEGIN

		set @DTT1=(select COALESCE (SUM(sa.Cost),0) as DT
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=1 and YEAR(sa.LastCreatedDate)=@year)

		set @DTT2=(select COALESCE (SUM(sa.Cost),0) as DT
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=2 and YEAR(sa.LastCreatedDate)=@year)

		set @DTT3=(select COALESCE (SUM(sa.Cost),0) as DT
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=3 and YEAR(sa.LastCreatedDate)=@year)

		set @DTT4=(select COALESCE (SUM(sa.Cost),0) as DT
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=4 and YEAR(sa.LastCreatedDate)=@year)

		set @DTT5=(select COALESCE (SUM(sa.Cost),0) as DT
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=5 and YEAR(sa.LastCreatedDate)=@year)

		set @DTT6=(select COALESCE (SUM(sa.Cost),0) as DT
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=6 and YEAR(sa.LastCreatedDate)=@year)

		set @DTT7=(select COALESCE (SUM(sa.Cost),0) as DT
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=7 and YEAR(sa.LastCreatedDate)=@year)

		set @DTT8=(select COALESCE (SUM(sa.Cost),0) as DT
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=8 and YEAR(sa.LastCreatedDate)=@year)
		set @DTT9=(select COALESCE (SUM(sa.Cost),0) as DT
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=9 and YEAR(sa.LastCreatedDate)=@year)

		set @DTT10=(select COALESCE (SUM(sa.Cost),0) as DT
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=10 and YEAR(sa.LastCreatedDate)=@year)

		set @DTT11=(select COALESCE (SUM(sa.Cost),0) as DT
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=11 and YEAR(sa.LastCreatedDate)=@year)

		set @DTT12=(select COALESCE (SUM(sa.Cost),0) as DT
		FROM ((Sales sa JOIN Ticket ti on ti.Id=sa.TicketId)
			JOIN Trip tri on tri.Id=ti.TripId)
			JOIN Vehicle ve on ve.Id=tri.VehicleId
		WHERE ve.AgentId =@agentid and MONTH(sa.LastCreatedDate)=12 and YEAR(sa.LastCreatedDate)=@year)


		INSERT INTO BAOCAODOANHTHUNAM_DATA
		VALUES
			(@year, @DTT1, @DTT2, @DTT3, @DTT4, @DTT5, @DTT6, @DTT7, @DTT8, @DTT9, @DTT10, @DTT11, @DTT12);
		SET @year = @year + 1;
	END;
END
GO