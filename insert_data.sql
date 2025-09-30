-- نظام إدارة المستشفيات - نصوص إدخال البيانات (DML)

-- إدخال بيانات المرضى
INSERT INTO Patients (FirstName, LastName, DateOfBirth, Gender, Address, PhoneNumber, Email, BloodType, RegistrationDate)
VALUES ('أحمد', 'محمد', TO_DATE('1980-05-15', 'YYYY-MM-DD'), 'ذكر', 'شارع الملك فهد، الرياض', '0501234567', 'ahmed.m@example.com', 'O+', TO_DATE('2023-01-10', 'YYYY-MM-DD'));

INSERT INTO Patients (FirstName, LastName, DateOfBirth, Gender, Address, PhoneNumber, Email, BloodType, RegistrationDate)
VALUES ('فاطمة', 'علي', TO_DATE('1992-08-20', 'YYYY-MM-DD'), 'أنثى', 'شارع التحلية، جدة', '0567891234', 'fatima.a@example.com', 'A+', TO_DATE('2023-02-15', 'YYYY-MM-DD'));

INSERT INTO Patients (FirstName, LastName, DateOfBirth, Gender, Address, PhoneNumber, Email, BloodType, RegistrationDate)
VALUES ('محمد', 'عبدالله', TO_DATE('1975-11-03', 'YYYY-MM-DD'), 'ذكر', 'شارع الأمير سلطان، الدمام', '0512345678', 'mohammed.a@example.com', 'B-', TO_DATE('2023-03-05', 'YYYY-MM-DD'));

INSERT INTO Patients (FirstName, LastName, DateOfBirth, Gender, Address, PhoneNumber, Email, BloodType, RegistrationDate)
VALUES ('نورة', 'سعيد', TO_DATE('1988-04-25', 'YYYY-MM-DD'), 'أنثى', 'شارع الجامعة، الرياض', '0598765432', 'noura.s@example.com', 'AB+', TO_DATE('2023-03-20', 'YYYY-MM-DD'));

INSERT INTO Patients (FirstName, LastName, DateOfBirth, Gender, Address, PhoneNumber, Email, BloodType, RegistrationDate)
VALUES ('خالد', 'عمر', TO_DATE('1965-09-12', 'YYYY-MM-DD'), 'ذكر', 'شارع الملك عبدالعزيز، مكة', '0554321987', 'khaled.o@example.com', 'O-', TO_DATE('2023-04-01', 'YYYY-MM-DD'));

-- إدخال بيانات الأقسام (بدون رئيس قسم في البداية، سيتم تحديثه لاحقاً)
INSERT INTO Departments (DepartmentName, Description, Location, HeadDoctorID)
VALUES ('قسم الطوارئ', 'يقدم رعاية طبية فورية للحالات الحرجة والطارئة', 'الطابق الأرضي، المبنى الرئيسي', NULL);

INSERT INTO Departments (DepartmentName, Description, Location, HeadDoctorID)
VALUES ('قسم الباطنية', 'يقدم رعاية طبية للأمراض الداخلية والمزمنة', 'الطابق الثاني، المبنى الرئيسي', NULL);

INSERT INTO Departments (DepartmentName, Description, Location, HeadDoctorID)
VALUES ('قسم الجراحة', 'يقدم خدمات جراحية متنوعة', 'الطابق الثالث، المبنى الرئيسي', NULL);

INSERT INTO Departments (DepartmentName, Description, Location, HeadDoctorID)
VALUES ('قسم النساء والولادة', 'يقدم رعاية صحية للنساء والأمهات والأطفال حديثي الولادة', 'الطابق الرابع، المبنى الرئيسي', NULL);

INSERT INTO Departments (DepartmentName, Description, Location, HeadDoctorID)
VALUES ('قسم الأطفال', 'يقدم رعاية طبية للأطفال والرضع', 'الطابق الخامس، المبنى الرئيسي', NULL);

-- إدخال بيانات الأطباء
INSERT INTO Doctors (FirstName, LastName, Specialization, Qualifications, PhoneNumber, Email, HireDate, Salary, DepartmentID)
VALUES ('سعد', 'الأحمد', 'طب الطوارئ', 'دكتوراه في الطب، تخصص طب الطوارئ', '0501122334', 'saad.a@hospital.com', TO_DATE('2018-06-01', 'YYYY-MM-DD'), 25000, 1);

INSERT INTO Doctors (FirstName, LastName, Specialization, Qualifications, PhoneNumber, Email, HireDate, Salary, DepartmentID)
VALUES ('منى', 'الزهراني', 'أمراض باطنية', 'دكتوراه في الطب، تخصص أمراض باطنية', '0567788990', 'mona.z@hospital.com', TO_DATE('2019-03-15', 'YYYY-MM-DD'), 23000, 2);

INSERT INTO Doctors (FirstName, LastName, Specialization, Qualifications, PhoneNumber, Email, HireDate, Salary, DepartmentID)
VALUES ('فهد', 'العتيبي', 'جراحة عامة', 'دكتوراه في الطب، تخصص جراحة عامة', '0512233445', 'fahad.o@hospital.com', TO_DATE('2017-09-10', 'YYYY-MM-DD'), 28000, 3);

INSERT INTO Doctors (FirstName, LastName, Specialization, Qualifications, PhoneNumber, Email, HireDate, Salary, DepartmentID)
VALUES ('سارة', 'القحطاني', 'نساء وولادة', 'دكتوراه في الطب، تخصص نساء وولادة', '0598877665', 'sara.q@hospital.com', TO_DATE('2020-01-20', 'YYYY-MM-DD'), 26000, 4);

INSERT INTO Doctors (FirstName, LastName, Specialization, Qualifications, PhoneNumber, Email, HireDate, Salary, DepartmentID)
VALUES ('عمر', 'السالم', 'طب أطفال', 'دكتوراه في الطب، تخصص طب أطفال', '0554433221', 'omar.s@hospital.com', TO_DATE('2019-11-05', 'YYYY-MM-DD'), 24000, 5);

-- تحديث رؤساء الأقسام
UPDATE Departments SET HeadDoctorID = 1 WHERE DepartmentID = 1;
UPDATE Departments SET HeadDoctorID = 2 WHERE DepartmentID = 2;
UPDATE Departments SET HeadDoctorID = 3 WHERE DepartmentID = 3;
UPDATE Departments SET HeadDoctorID = 4 WHERE DepartmentID = 4;
UPDATE Departments SET HeadDoctorID = 5 WHERE DepartmentID = 5;

-- إدخال بيانات الممرضين
INSERT INTO Nurses (FirstName, LastName, Qualifications, PhoneNumber, Email, HireDate, Salary, DepartmentID)
VALUES ('نوف', 'العنزي', 'بكالوريوس تمريض', '0501234987', 'nouf.a@hospital.com', TO_DATE('2020-05-10', 'YYYY-MM-DD'), 12000, 1);

INSERT INTO Nurses (FirstName, LastName, Qualifications, PhoneNumber, Email, HireDate, Salary, DepartmentID)
VALUES ('خالد', 'المالكي', 'بكالوريوس تمريض', '0567891234', 'khaled.m@hospital.com', TO_DATE('2021-02-15', 'YYYY-MM-DD'), 11500, 2);

INSERT INTO Nurses (FirstName, LastName, Qualifications, PhoneNumber, Email, HireDate, Salary, DepartmentID)
VALUES ('هند', 'الشمري', 'ماجستير تمريض', '0512345678', 'hind.s@hospital.com', TO_DATE('2019-08-20', 'YYYY-MM-DD'), 13000, 3);

INSERT INTO Nurses (FirstName, LastName, Qualifications, PhoneNumber, Email, HireDate, Salary, DepartmentID)
VALUES ('سلطان', 'الدوسري', 'بكالوريوس تمريض', '0598765432', 'sultan.d@hospital.com', TO_DATE('2022-01-05', 'YYYY-MM-DD'), 11000, 4);

INSERT INTO Nurses (FirstName, LastName, Qualifications, PhoneNumber, Email, HireDate, Salary, DepartmentID)
VALUES ('لمياء', 'الحربي', 'بكالوريوس تمريض', '0554321987', 'lamia.h@hospital.com', TO_DATE('2021-06-10', 'YYYY-MM-DD'), 11800, 5);

-- إدخال بيانات الغرف
INSERT INTO Rooms (RoomType, Status, DailyCost, DepartmentID)
VALUES ('عادية', 'متاحة', 500, 1);

INSERT INTO Rooms (RoomType, Status, DailyCost, DepartmentID)
VALUES ('خاصة', 'متاحة', 1200, 2);

INSERT INTO Rooms (RoomType, Status, DailyCost, DepartmentID)
VALUES ('عناية مركزة', 'متاحة', 2500, 3);

INSERT INTO Rooms (RoomType, Status, DailyCost, DepartmentID)
VALUES ('غرفة عمليات', 'متاحة', 3000, 3);

INSERT INTO Rooms (RoomType, Status, DailyCost, DepartmentID)
VALUES ('خاصة', 'متاحة', 1500, 4);

INSERT INTO Rooms (RoomType, Status, DailyCost, DepartmentID)
VALUES ('عادية', 'متاحة', 600, 5);

-- إدخال بيانات المواعيد
INSERT INTO Appointments (AppointmentDate, AppointmentTime, Status, AppointmentType, PatientID, DoctorID)
VALUES (TO_DATE('2023-05-20', 'YYYY-MM-DD'), '09:00 AM', 'مجدول', 'استشارة', 1, 2);

INSERT INTO Appointments (AppointmentDate, AppointmentTime, Status, AppointmentType, PatientID, DoctorID)
VALUES (TO_DATE('2023-05-21', 'YYYY-MM-DD'), '10:30 AM', 'مجدول', 'متابعة', 2, 4);

INSERT INTO Appointments (AppointmentDate, AppointmentTime, Status, AppointmentType, PatientID, DoctorID)
VALUES (TO_DATE('2023-05-19', 'YYYY-MM-DD'), '02:00 PM', 'مكتمل', 'طوارئ', 3, 1);

INSERT INTO Appointments (AppointmentDate, AppointmentTime, Status, AppointmentType, PatientID, DoctorID)
VALUES (TO_DATE('2023-05-22', 'YYYY-MM-DD'), '11:15 AM', 'مجدول', 'استشارة', 4, 5);

INSERT INTO Appointments (AppointmentDate, AppointmentTime, Status, AppointmentType, PatientID, DoctorID)
VALUES (TO_DATE('2023-05-18', 'YYYY-MM-DD'), '03:45 PM', 'ملغى', 'متابعة', 5, 3);

-- إدخال بيانات الإقامة في المستشفى
INSERT INTO Admissions (AdmissionDate, DischargeDate, AdmissionReason, PatientID, RoomID, AttendingDoctorID)
VALUES (TO_DATE('2023-04-15', 'YYYY-MM-DD'), TO_DATE('2023-04-20', 'YYYY-MM-DD'), 'التهاب رئوي', 1, 2, 2);

INSERT INTO Admissions (AdmissionDate, DischargeDate, AdmissionReason, PatientID, RoomID, AttendingDoctorID)
VALUES (TO_DATE('2023-04-18', 'YYYY-MM-DD'), TO_DATE('2023-04-25', 'YYYY-MM-DD'), 'عملية استئصال الزائدة الدودية', 3, 4, 3);

INSERT INTO Admissions (AdmissionDate, DischargeDate, AdmissionReason, PatientID, RoomID, AttendingDoctorID)
VALUES (TO_DATE('2023-05-01', 'YYYY-MM-DD'), TO_DATE('2023-05-03', 'YYYY-MM-DD'), 'ولادة طبيعية', 2, 5, 4);

INSERT INTO Admissions (AdmissionDate, DischargeDate, AdmissionReason, PatientID, RoomID, AttendingDoctorID)
VALUES (TO_DATE('2023-05-10', 'YYYY-MM-DD'), NULL, 'فشل كلوي', 5, 3, 2);

INSERT INTO Admissions (AdmissionDate, DischargeDate, AdmissionReason, PatientID, RoomID, AttendingDoctorID)
VALUES (TO_DATE('2023-05-12', 'YYYY-MM-DD'), TO_DATE('2023-05-15', 'YYYY-MM-DD'), 'حمى شديدة', 4, 6, 5);

-- إدخال بيانات الأدوية
INSERT INTO Medications (MedicationName, Description, RecommendedDosage, Instructions, Price, QuantityInStock)
VALUES ('باراسيتامول', 'مسكن للألم وخافض للحرارة', '500-1000 ملغ كل 6 ساعات', 'يؤخذ بعد الطعام', 15.50, 1000);

INSERT INTO Medications (MedicationName, Description, RecommendedDosage, Instructions, Price, QuantityInStock)
VALUES ('أموكسيسيلين', 'مضاد حيوي واسع الطيف', '500 ملغ ثلاث مرات يومياً', 'يؤخذ قبل الطعام بساعة أو بعده بساعتين', 25.75, 800);

INSERT INTO Medications (MedicationName, Description, RecommendedDosage, Instructions, Price, QuantityInStock)
VALUES ('أومبيرازول', 'مثبط مضخة البروتون لعلاج قرحة المعدة', '20 ملغ مرة واحدة يومياً', 'يؤخذ قبل الإفطار', 30.00, 600);

INSERT INTO Medications (MedicationName, Description, RecommendedDosage, Instructions, Price, QuantityInStock)
VALUES ('لوراتادين', 'مضاد للهيستامين لعلاج الحساسية', '10 ملغ مرة واحدة يومياً', 'يمكن أخذه بدون طعام', 18.25, 750);

INSERT INTO Medications (MedicationName, Description, RecommendedDosage, Instructions, Price, QuantityInStock)
VALUES ('إنسولين', 'هرمون لخفض مستوى السكر في الدم', 'حسب مستوى السكر في الدم', 'يحقن تحت الجلد', 120.00, 300);

-- إدخال بيانات الوصفات الطبية
INSERT INTO Prescriptions (PrescriptionDate, PatientID, DoctorID)
VALUES (TO_DATE('2023-04-20', 'YYYY-MM-DD'), 1, 2);

INSERT INTO Prescriptions (PrescriptionDate, PatientID, DoctorID)
VALUES (TO_DATE('2023-04-25', 'YYYY-MM-DD'), 3, 3);

INSERT INTO Prescriptions (PrescriptionDate, PatientID, DoctorID)
VALUES (TO_DATE('2023-05-03', 'YYYY-MM-DD'), 2, 4);

INSERT INTO Prescriptions (PrescriptionDate, PatientID, DoctorID)
VALUES (TO_DATE('2023-05-15', 'YYYY-MM-DD'), 4, 5);

INSERT INTO Prescriptions (PrescriptionDate, PatientID, DoctorID)
VALUES (TO_DATE('2023-05-16', 'YYYY-MM-DD'), 5, 2);

-- إدخال بيانات تفاصيل الوصفة
INSERT INTO PrescriptionDetails (PrescriptionID, MedicationID, Dosage, Frequency, Duration, Quantity)
VALUES (1, 1, '500 ملغ', 'كل 6 ساعات', '5 أيام', 20);

INSERT INTO PrescriptionDetails (PrescriptionID, MedicationID, Dosage, Frequency, Duration, Quantity)
VALUES (1, 2, '500 ملغ', '3 مرات يومياً', '7 أيام', 21);

INSERT INTO PrescriptionDetails (PrescriptionID, MedicationID, Dosage, Frequency, Duration, Quantity)
VALUES (2, 2, '500 ملغ', '3 مرات يومياً', '10 أيام', 30);

INSERT INTO PrescriptionDetails (PrescriptionID, MedicationID, Dosage, Frequency, Duration, Quantity)
VALUES (3, 4, '10 ملغ', 'مرة واحدة يومياً', '14 يوم', 14);

INSERT INTO PrescriptionDetails (PrescriptionID, MedicationID, Dosage, Frequency, Duration, Quantity)
VALUES (4, 3, '20 ملغ', 'مرة واحدة يومياً', '30 يوم', 30);

INSERT INTO PrescriptionDetails (PrescriptionID, MedicationID, Dosage, Frequency, Duration, Quantity)
VALUES (5, 5, '10 وحدات', 'قبل كل وجبة', '30 يوم', 90);

-- إدخال بيانات الفحوصات المخبرية
INSERT INTO LabTests (TestName, Description, Cost)
VALUES ('تحليل الدم الكامل (CBC)', 'فحص شامل لخلايا الدم', 150.00);

INSERT INTO LabTests (TestName, Description, Cost)
VALUES ('وظائف الكبد', 'فحص لتقييم وظائف الكبد', 200.00);

INSERT INTO LabTests (TestName, Description, Cost)
VALUES ('وظائف الكلى', 'فحص لتقييم وظائف الكلى', 180.00);

INSERT INTO LabTests (TestName, Description, Cost)
VALUES ('فحص السكر التراكمي', 'فحص لقياس متوسط مستوى السكر في الدم خلال 3 أشهر', 250.00);

INSERT INTO LabTests (TestName, Description, Cost)
VALUES ('فحص الغدة الدرقية', 'فحص لتقييم وظائف الغدة الدرقية', 220.00);

-- إدخال بيانات نتائج الفحوصات
INSERT INTO TestResults (TestDate, Result, Comments, PatientID, TestID, RequestingDoctorID)
VALUES (TO_DATE('2023-04-16', 'YYYY-MM-DD'), 'طبيعي مع ارتفاع طفيف في كريات الدم البيضاء', 'يشير إلى وجود التهاب', 1, 1, 2);

INSERT INTO TestResults (TestDate, Result, Comments, PatientID, TestID, RequestingDoctorID)
VALUES (TO_DATE('2023-04-19', 'YYYY-MM-DD'), 'طبيعي', 'لا توجد مشاكل في وظائف الكبد', 3, 2, 3);

INSERT INTO TestResults (TestDate, Result, Comments, PatientID, TestID, RequestingDoctorID)
VALUES (TO_DATE('2023-05-02', 'YYYY-MM-DD'), 'طبيعي', 'وظائف الكلى سليمة', 2, 3, 4);

INSERT INTO TestResults (TestDate, Result, Comments, PatientID, TestID, RequestingDoctorID)
VALUES (TO_DATE('2023-05-11', 'YYYY-MM-DD'), 'مرتفع (8.5%)', 'يشير إلى عدم السيطرة على مستوى السكر في الدم', 5, 4, 2);

INSERT INTO TestResults (TestDate, Result, Comments, PatientID, TestID, RequestingDoctorID)
VALUES (TO_DATE('2023-05-14', 'YYYY-MM-DD'), 'طبيعي', 'وظائف الغدة الدرقية طبيعية', 4, 5, 5);

-- إدخال بيانات الفواتير
INSERT INTO Bills (BillDate, TotalAmount, PaymentStatus, PaymentMethod, PatientID, AdmissionID)
VALUES (TO_DATE('2023-04-20', 'YYYY-MM-DD'), 6000.00, 'مدفوعة', 'بطاقة ائتمان', 1, 1);

INSERT INTO Bills (BillDate, TotalAmount, PaymentStatus, PaymentMethod, PatientID, AdmissionID)
VALUES (TO_DATE('2023-04-25', 'YYYY-MM-DD'), 15000.00, 'مدفوعة', 'تأمين', 3, 2);

INSERT INTO Bills (BillDate, TotalAmount, PaymentStatus, PaymentMethod, PatientID, AdmissionID)
VALUES (TO_DATE('2023-05-03', 'YYYY-MM-DD'), 4500.00, 'مدفوعة', 'نقداً', 2, 3);

INSERT INTO Bills (BillDate, TotalAmount, PaymentStatus, PaymentMethod, PatientID, AdmissionID)
VALUES (TO_DATE('2023-05-15', 'YYYY-MM-DD'), 1800.00, 'مدفوعة', 'بطاقة ائتمان', 4, 5);

INSERT INTO Bills (BillDate, TotalAmount, PaymentStatus, PaymentMethod, PatientID, AdmissionID)
VALUES (TO_DATE('2023-05-16', 'YYYY-MM-DD'), 12500.00, 'غير مدفوعة', NULL, 5, 4);

-- إدخال بيانات تفاصيل الفاتورة
INSERT INTO BillDetails (BillID, ItemID, ItemDescription, Quantity, UnitPrice)
VALUES (1, 1, 'رسوم الإقامة - غرفة خاصة', 5, 1200.00);

INSERT INTO BillDetails (BillID, ItemID, ItemDescription, Quantity, UnitPrice)
VALUES (2, 1, 'رسوم العملية الجراحية', 1, 10000.00);

INSERT INTO BillDetails (BillID, ItemID, ItemDescription, Quantity, UnitPrice)
VALUES (2, 2, 'رسوم الإقامة - غرفة عمليات', 1, 3000.00);

INSERT INTO BillDetails (BillID, ItemID, ItemDescription, Quantity, UnitPrice)
VALUES (2, 3, 'أدوية', 1, 2000.00);

INSERT INTO BillDetails (BillID, ItemID, ItemDescription, Quantity, UnitPrice)
VALUES (3, 1, 'رسوم الإقامة - غرفة خاصة', 3, 1500.00);

INSERT INTO BillDetails (BillID, ItemID, ItemDescription, Quantity, UnitPrice)
VALUES (4, 1, 'رسوم الإقامة - غرفة عادية', 3, 600.00);

INSERT INTO BillDetails (BillID, ItemID, ItemDescription, Quantity, UnitPrice)
VALUES (5, 1, 'رسوم الإقامة - غرفة عناية مركزة', 5, 2500.00);

COMMIT;
