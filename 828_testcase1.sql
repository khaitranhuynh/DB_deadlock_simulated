

--dirty read 
/*K?ch b?n: 
-	T2 ?ang xem h?ng thành viên thì T1 c?p nh?t làm T2 ??c h?ng thành viên b? sai
-	 Khách hàng mã 119 ?ang ? h?ng silver T1 c?p nh?t thì khách  hàng ?ã lên diamond nh?ng v?n nh?n l?i chúc lên h?ng silver  
Gi?i quy?t:  Set m?c ?? cô l?p c?a T2 lên read commited*/
-- proc duoc goi: capnhatdiemthanhvien va xemhangthanhvien

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

---------------------------------------
CREATE PROC XemHangThanhVien @matv int 
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
   DECLARE @HANG VARCHAR(30)
   SET @HANG = dbo.HangThanhVien(@maTV)
   PRINT @HANG
   
   COMMIT TRANSACTION 

 /*
==> cach giai quyet : Set m?c ?? cô l?p c?a T2 lên read commited
*/
