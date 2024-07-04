go
ALTER PROC spAccount
(
	@username nvarchar(255),
	@password nvarchar(255)
)
AS
BEGIN
	SELECT COUNT(*) FROM Account
	WHERE Username = @username AND Password = @password
END
go
Execute spAccount 'admin', '123456'
