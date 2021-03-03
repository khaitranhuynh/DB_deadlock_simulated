/*L?i Lost Update: 
K?ch b?n: T2 và T1 cùng c?p nh?t ?i?m thành viên cùng lúc
ví d? ?i?m tích lu? ???c m?c 500 tri?u là ???c quà 
khách hàng có mã 110 tích lu? ???c 500 tri?u c?p nh?t b?i giao tác T1
 nh?ng mua hàng ngay sau ?ó nên ch?a k?p nh?n quà thì ?i?m tích lu? b? 
 T2 gi?m d?n t?i không ?? ?i?u ki?n nh?n quà: 
Cách gi?i quy?t: set m?c ?? cô l?p c?a d? li?u lên SERIALIZABLE*/

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






