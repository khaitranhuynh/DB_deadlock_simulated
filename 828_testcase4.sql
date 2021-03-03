/* L?i PHANTOM: 
T2 ?ang th?ng k� s? th�nh vi�n c� ?i?m t�ch lu? tr�n 5 tri?u  th� T1 c?p nh?t, d?n ??n s? l??ng th�nh vi�n sau khi th?ng  k� b? sai.
C�ch gi?i quy?t: Set m?c ?? c� l?p l�n serializable 
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



