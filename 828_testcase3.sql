/*L?i Lost Update: 
K?ch b?n: T2 v� T1 c�ng c?p nh?t ?i?m th�nh vi�n c�ng l�c
v� d? ?i?m t�ch lu? ???c m?c 500 tri?u l� ???c qu� 
kh�ch h�ng c� m� 110 t�ch lu? ???c 500 tri?u c?p nh?t b?i giao t�c T1
 nh?ng mua h�ng ngay sau ?� n�n ch?a k?p nh?n qu� th� ?i?m t�ch lu? b? 
 T2 gi?m d?n t?i kh�ng ?? ?i?u ki?n nh?n qu�: 
C�ch gi?i quy?t: set m?c ?? c� l?p c?a d? li?u l�n SERIALIZABLE*/

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






