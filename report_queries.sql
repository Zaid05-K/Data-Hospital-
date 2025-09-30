-- نظام إدارة المستشفيات - استعلامات التقارير

-- الاستعلام 1: قائمة المرضى مع أطبائهم المعالجين وتواريخ مواعيدهم
-- هذا الاستعلام يوضح استخدام الربط (JOIN) بين عدة جداول
SELECT 
    p.PatientID,
    p.FirstName || ' ' || p.LastName AS PatientName,
    d.FirstName || ' ' || d.LastName AS DoctorName,
    d.Specialization,
    a.AppointmentDate,
    a.AppointmentTime,
    a.Status,
    a.AppointmentType
FROM 
    Patients p
JOIN 
    Appointments a ON p.PatientID = a.PatientID
JOIN 
    Doctors d ON a.DoctorID = d.DoctorID
ORDER BY 
    a.AppointmentDate, a.AppointmentTime;

-- الاستعلام 2: تقرير الإيرادات حسب القسم
-- هذا الاستعلام يوضح استخدام الدوال التجميعية (SUM) والتجميع (GROUP BY)
SELECT 
    d.DepartmentID,
    d.DepartmentName,
    COUNT(b.BillID) AS NumberOfBills,
    SUM(b.TotalAmount) AS TotalRevenue,
    AVG(b.TotalAmount) AS AverageRevenue,
    MIN(b.TotalAmount) AS MinimumBill,
    MAX(b.TotalAmount) AS MaximumBill
FROM 
    Departments d
JOIN 
    Doctors doc ON d.DepartmentID = doc.DepartmentID
JOIN 
    Appointments a ON doc.DoctorID = a.DoctorID
JOIN 
    Patients p ON a.PatientID = p.PatientID
JOIN 
    Bills b ON p.PatientID = b.PatientID
WHERE 
    b.PaymentStatus = 'مدفوعة'
GROUP BY 
    d.DepartmentID, d.DepartmentName
ORDER BY 
    TotalRevenue DESC;

-- الاستعلام 3: تقرير استخدام الأدوية
-- هذا الاستعلام يوضح استخدام الاستعلامات الفرعية (Subqueries)
SELECT 
    m.MedicationID,
    m.MedicationName,
    m.QuantityInStock,
    (SELECT COUNT(*) FROM PrescriptionDetails pd WHERE pd.MedicationID = m.MedicationID) AS TimesPrescibed,
    (SELECT SUM(pd.Quantity) FROM PrescriptionDetails pd WHERE pd.MedicationID = m.MedicationID) AS TotalQuantityPrescribed,
    (SELECT SUM(pd.Quantity * m.Price) FROM PrescriptionDetails pd WHERE pd.MedicationID = m.MedicationID) AS TotalValue
FROM 
    Medications m
ORDER BY 
    TimesPrescibed DESC;

-- الاستعلام 4: تقرير معدل إشغال الغرف
-- هذا الاستعلام يوضح استخدام الدوال التجميعية والتجميع والترتيب
SELECT 
    r.RoomID,
    r.RoomType,
    d.DepartmentName,
    r.DailyCost,
    COUNT(a.AdmissionID) AS NumberOfAdmissions,
    SUM(
        CASE 
            WHEN a.DischargeDate IS NOT NULL THEN 
                (a.DischargeDate - a.AdmissionDate)
            ELSE 
                (SYSDATE - a.AdmissionDate)
        END
    ) AS TotalDaysOccupied,
    SUM(
        CASE 
            WHEN a.DischargeDate IS NOT NULL THEN 
                (a.DischargeDate - a.AdmissionDate) * r.DailyCost
            ELSE 
                (SYSDATE - a.AdmissionDate) * r.DailyCost
        END
    ) AS TotalRevenue
FROM 
    Rooms r
LEFT JOIN 
    Admissions a ON r.RoomID = a.RoomID
JOIN 
    Departments d ON r.DepartmentID = d.DepartmentID
GROUP BY 
    r.RoomID, r.RoomType, d.DepartmentName, r.DailyCost
ORDER BY 
    TotalDaysOccupied DESC;

-- الاستعلام 5: تقرير أداء الأطباء
-- هذا الاستعلام يوضح استخدام الربط المتعدد والدوال التجميعية والتجميع
SELECT 
    d.DoctorID,
    d.FirstName || ' ' || d.LastName AS DoctorName,
    d.Specialization,
    dept.DepartmentName,
    COUNT(DISTINCT a.AppointmentID) AS NumberOfAppointments,
    COUNT(DISTINCT adm.AdmissionID) AS NumberOfAdmissions,
    COUNT(DISTINCT p.PrescriptionID) AS NumberOfPrescriptions,
    COUNT(DISTINCT tr.ResultID) AS NumberOfTestsRequested,
    (
        SELECT COUNT(*) 
        FROM Appointments app 
        WHERE app.DoctorID = d.DoctorID AND app.Status = 'مكتمل'
    ) AS CompletedAppointments,
    (
        SELECT COUNT(*) 
        FROM Appointments app 
        WHERE app.DoctorID = d.DoctorID AND app.Status = 'ملغى'
    ) AS CancelledAppointments
FROM 
    Doctors d
JOIN 
    Departments dept ON d.DepartmentID = dept.DepartmentID
LEFT JOIN 
    Appointments a ON d.DoctorID = a.DoctorID
LEFT JOIN 
    Admissions adm ON d.DoctorID = adm.AttendingDoctorID
LEFT JOIN 
    Prescriptions p ON d.DoctorID = p.DoctorID
LEFT JOIN 
    TestResults tr ON d.DoctorID = tr.RequestingDoctorID
GROUP BY 
    d.DoctorID, d.FirstName || ' ' || d.LastName, d.Specialization, dept.DepartmentName
ORDER BY 
    NumberOfAppointments DESC;

-- الاستعلام 6 (إضافي): تقرير المرضى الأكثر زيارة للمستشفى
-- هذا الاستعلام يوضح استخدام الدوال التجميعية والتجميع والترتيب
SELECT 
    p.PatientID,
    p.FirstName || ' ' || p.LastName AS PatientName,
    p.Gender,
    TRUNC(MONTHS_BETWEEN(SYSDATE, p.DateOfBirth) / 12) AS Age,
    COUNT(DISTINCT a.AppointmentID) AS NumberOfAppointments,
    COUNT(DISTINCT adm.AdmissionID) AS NumberOfAdmissions,
    COUNT(DISTINCT pr.PrescriptionID) AS NumberOfPrescriptions,
    COUNT(DISTINCT tr.ResultID) AS NumberOfTests,
    SUM(b.TotalAmount) AS TotalBilledAmount
FROM 
    Patients p
LEFT JOIN 
    Appointments a ON p.PatientID = a.PatientID
LEFT JOIN 
    Admissions adm ON p.PatientID = adm.PatientID
LEFT JOIN 
    Prescriptions pr ON p.PatientID = pr.PatientID
LEFT JOIN 
    TestResults tr ON p.PatientID = tr.PatientID
LEFT JOIN 
    Bills b ON p.PatientID = b.PatientID
GROUP BY 
    p.PatientID, p.FirstName || ' ' || p.LastName, p.Gender, p.DateOfBirth
ORDER BY 
    NumberOfAppointments + NumberOfAdmissions DESC;

-- الاستعلام 7 (إضافي): تقرير الفواتير غير المدفوعة
-- هذا الاستعلام يوضح استخدام الربط والتصفية
SELECT 
    b.BillID,
    b.BillDate,
    p.PatientID,
    p.FirstName || ' ' || p.LastName AS PatientName,
    p.PhoneNumber,
    b.TotalAmount,
    b.PaymentStatus,
    a.AdmissionID,
    a.AdmissionDate,
    a.DischargeDate,
    d.FirstName || ' ' || d.LastName AS AttendingDoctor
FROM 
    Bills b
JOIN 
    Patients p ON b.PatientID = p.PatientID
LEFT JOIN 
    Admissions a ON b.AdmissionID = a.AdmissionID
LEFT JOIN 
    Doctors d ON a.AttendingDoctorID = d.DoctorID
WHERE 
    b.PaymentStatus = 'غير مدفوعة'
ORDER BY 
    b.BillDate;
