/*testcase2
Unrepeatable data:
K?ch b?n: h? th?ng ?ang g?i proc Tinhphantramkhuyenmai ?? tính khuy?n mãi thì T1 c?p nh?t ?i?m b?ng proc capnhatdiemthanhvien d?n t?i lúc T2 tính xong thì cho ra k?t qu? sai 
h?ng ban ??u c?a maTV 112 là silver t?c là ph?n tr?m khuy?n mãi là 0
nh?ng do t1 c?p nh?t nên thành 10
Cách gi?i quy?t: Set m?c ?? cô l?p c?a T2 lên repeatable read
--SET TRAN ISOLATION LEVEL repeatable read
*/

CREATE PROC CapNhatDiemThanhVien @matv int, @diem int
AS 
BEGIN TRANSACTION
	BEGIN TRY 
	IF (@maTV IS NULL)
			BEGIN 
				PRINT ('Ma chi nhanh khong dc rong')
				ROLLBACK TRANSACTION
				RETURN 
			END 
	IF NOT EXISTS ( SELECT * FROM dbo.THANHVIEN 
					WHERE MATV = @maTV)
			BEGIN 
				PRINT ('Ma THANH VIEN KHONG TON TAI ')
				ROLLBACK TRANSACTION
				RETURN 
			END 
   END TRY 
   BEGIN CATCH 
		ROLLBACK TRANSACTION
   END CATCH
   
   -- IN RA HANG THANH VIEN 
   WAITFOR DELAY '00:00:10'
   UPDATE dbo.THANHVIEN
   SET DIEMTICHLUY = @diem
   WHERE MATV = @maTV
   
   COMMIT TRANSACTION 


create PROC TinhPhanTramKhuyenMai @maTV INT
AS
BEGIN TRANSACTION
BEGIN TRY 
	IF (@maTV IS NULL)
			BEGIN 
				PRINT ('Ma chi nhanh khong dc rong')
				ROLLBACK TRANSACTION
				RETURN 
			END 
 
	IF NOT EXISTS ( SELECT * FROM dbo.THANHVIEN 
					WHERE MATV = @maTV)
			BEGIN 
				PRINT ('Ma THANH VIEN KHONG TON TAI ')
				ROLLBACK TRANSACTION
				RETURN 
			END 
   END TRY 
   BEGIN CATCH 
		ROLLBACK TRANSACTION
   END CATCH
   DECLARE @hangkhuyenmai VARCHAR(30)
   SET @hangkhuyenmai=dbo.HangThanhVien(@matv)
   PRINT @hangkhuyenmai
   WAITFOR DELAY '00:00:02'
   DECLARE @tienkhuyenmai INT
   
   WAITFOR DELAY '00:00:10'
   SET @tienkhuyenmai= dbo.TinhKhuyenMaiTV(@maTV)
   PRINT @tienkhuyenmai
   
   COMMIT TRANSACTION 