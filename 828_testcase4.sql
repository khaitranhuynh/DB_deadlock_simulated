/* L?i PHANTOM: 
T2 ?ang th?ng kê s? thành viên có ?i?m tích lu? trên 5 tri?u  thì T1 c?p nh?t, d?n ??n s? l??ng thành viên sau khi th?ng  kê b? sai.
Cách gi?i quy?t: Set m?c ?? cô l?p lên serializable 
--SET TRAN ISOLATION LEVEL serializable 

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

-----

CREATE PROC TK_TV_diemtrennamtrieu
 AS
 BEGIN TRAN
	SELECT COUNT(MATV)
	FROM dbo.THANHVIEN 
	WHERE DIEMTICHLUY > 5000000

	WAITFOR DELAY '00:00:12'

	SELECT COUNT(MATV)
	FROM dbo.THANHVIEN 
	WHERE DIEMTICHLUY > 5000000

	 
 COMMIT 



