/*testcase2
Unrepeatable data:
K?ch b?n: h? th?ng ?ang g?i proc Tinhphantramkhuyenmai ?? t�nh khuy?n m�i th� T1 c?p nh?t ?i?m b?ng proc capnhatdiemthanhvien d?n t?i l�c T2 t�nh xong th� cho ra k?t qu? sai 
h?ng ban ??u c?a maTV 112 l� silver t?c l� ph?n tr?m khuy?n m�i l� 0
nh?ng do t1 c?p nh?t n�n th�nh 10
C�ch gi?i quy?t: Set m?c ?? c� l?p c?a T2 l�n repeatable read
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